//
//  EMCalculatorView.m
//  EMSimpleCalculator
//
//  Created by Eric McConkie on 4/8/14.
//  Copyright (c) 2014 Eric McConkie. All rights reserved.
//


#import "EMCalculatorView.h"

@interface EMCalculatorView()
@property(nonatomic)BOOL hasDecimal;
@property(nonatomic,copy)NSString *stack; //generally the left side fo the operator
@property(nonatomic,copy)NSString *postOperatorStack; //numbers to show after user taps +,-,/ etc (right side of operator)
@property (nonatomic,weak)UIButton *currentOperatorButton;//+,-,/ etc
@property (nonatomic)int currentOperand;

@end

@implementation EMCalculatorView

#pragma mark -------------->>init
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
   [self setup];
}

#pragma mark -------------->>actions
-(void)onDigitTap:(UIButton*)sender{
    
    [self addnumber:(int)sender.tag];
}
-(void)onDecimalTap:(id)sender{
    if (self.hasDecimal)
        return;
    self.hasDecimal = YES;

    NSString *curString = nil;
    if (self.currentOperand> OperandTypeEquals) {
        self.postOperatorStack = [self.postOperatorStack stringByAppendingString:@"."];
        curString = self.postOperatorStack;
    }else{
        self.stack = [self.stack stringByAppendingString:@"."];
        curString = self.stack;
    }
    
    
    [self.lblDisplay setText:[NSString stringWithFormat:@"%@",curString]];
}
-(void)onFunctionTap:(id)sender{
    if (sender == self.btnClear) {
        [self cancel:sender];
    }
    if (sender == self.btnBackspace) {
        [self backone];
    }
    
    if (sender == self.btnTogglePlusMinus) {
        [self togglePlusMinus];
    }
}
-(void)onOperatorTap:(UIButton*)sender{
    [self.currentOperatorButton setSelected:NO];
    [sender setSelected:YES];
    self.currentOperatorButton = sender;
    [self operand:(int)sender.tag];
    self.hasDecimal = NO;
}

#pragma mark -------------->>functions

-(void)togglePlusMinus{
    double cur = [[self currentString] doubleValue];
    cur = -cur;
    if (self.currentOperand > -1) {
        self.postOperatorStack = [NSString stringWithFormat:@"%g",cur];
    }
        self.stack = [NSString stringWithFormat:@"%g",cur];
    [self.lblDisplay setText:[NSString stringWithFormat:@"%g",[[self currentString] doubleValue]]];
}
-(void)backone{
    NSString *curString = [self currentString];
    if (curString.length<=0)
        return;
    
    curString = [curString substringToIndex:curString.length - 1];
    if (self.currentOperand>-1) {
        self.postOperatorStack = curString;
    }else
        self.stack = curString;
    [self.lblDisplay setText:[NSString stringWithFormat:@"%g",[curString doubleValue]]];
}

- (void)cancel:(id)sender {
    self.stack = @"";
    self.postOperatorStack = @"";
    self.currentOperand = -1;
    [self.currentOperatorButton setSelected:NO];
    self.currentOperatorButton = nil;
    self.hasDecimal = NO;
    [self.lblDisplay setText:[NSString stringWithFormat:@"%g",[self.stack doubleValue]]];
    
    
}

#pragma mark -------------->>MATH!
-(void)operand:(int)type{
    [self equals];
    NSString *displayText= self.stack;
    if (type == OperandTypeEquals) {
        [self.lblOperand setText:@""];
        self.postOperatorStack = @"";
        self.stack = @"";
        [self.btnEquals setSelected:NO];
    }else
    {
        self.currentOperand = type;
    }
    [self.lblDisplay setText:[NSString stringWithFormat:@"%g",[displayText doubleValue]]];
}
-(void)equals{
    switch (self.currentOperand) {
        case OperandTypePlus:
            self.stack = [NSString stringWithFormat:@"%f", [self.stack doubleValue] + [self.postOperatorStack doubleValue]];
            break;
        case OperandTypeMinus:
            self.stack = [NSString stringWithFormat:@"%f", [self.stack doubleValue] - [self.postOperatorStack doubleValue]];
            break;
            
        case OperandTypeTimes:
            self.stack = [NSString stringWithFormat:@"%f", [self.stack doubleValue] * [self.postOperatorStack doubleValue]];
            break;
            
        case OperandTypeDivide:
        {
            if ([self.postOperatorStack isEqualToString:@"0"]) {
                return;
            }
            self.stack = [NSString stringWithFormat:@"%f", [self.stack doubleValue] / [self.postOperatorStack doubleValue]];
        }
            break;
        default:
            break;
    }
    self.postOperatorStack = @"";
}
-(void)addnumber:(int)number{
    [self.currentOperatorButton setSelected:NO];

    NSString *curString = self.stack;
    if (self.currentOperand > OperandTypeEquals) {
        curString = self.postOperatorStack;
    }
    
    if(curString == NULL){
        curString = @"0";
    }
    
    if(number > -1){
        curString = [NSString stringWithFormat:@"%1$@%2$d", curString, number];
    }else if([curString length] > 0){
        curString = [curString substringToIndex:[curString length]- number];
    }
    
    if([curString length] <= 0){
        curString = @"";
    }
    
    [self.lblDisplay setText:[NSString stringWithFormat:@"%g",[curString doubleValue]]];
    if (self.currentOperand > OperandTypeEquals) {
        self.postOperatorStack = curString;
    }else
        self.stack = curString;
}

#pragma mark -------------->>KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    switch (self.currentOperand) {
        case OperandTypeDivide:
            [self.lblOperand setText:@"/"];
            break;
            
        case OperandTypePlus:
            [self.lblOperand setText:@"+"];
            break;
            
        case OperandTypeMinus:
            [self.lblOperand setText:@"-"];
            break;
            
        case OperandTypeTimes:
            [self.lblOperand setText:@"*"];
            break;
            
        default:
            [self.lblOperand setText:@""];
            [self.btnEquals setSelected:NO];
            break;
    }
}

#pragma mark -------------->>helpers
-(NSString*)currentString{
    NSString *curString = self.stack;
    if (self.currentOperand > OperandTypeEquals) {
        curString = self.postOperatorStack;
    }
    return curString;
}
-(void)setup{

    [self addObserver:self forKeyPath:@"currentOperand" options:NSKeyValueObservingOptionNew context:nil];
    [self cancel:nil];
    
    //NUMBERS/DECIMAL
    [self.btn0 setTag:0];
    [self.btn1 setTag:1];
    [self.btn2 setTag:2];
    [self.btn3 setTag:3];
    [self.btn4 setTag:4];
    [self.btn5 setTag:5];
    [self.btn6 setTag:6];
    [self.btn7 setTag:7];
    [self.btn8 setTag:8];
    [self.btn9 setTag:9];
    
    [self.btn0 addTarget:self action:@selector(onDigitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn1 addTarget:self action:@selector(onDigitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(onDigitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(onDigitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn4 addTarget:self action:@selector(onDigitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn5 addTarget:self action:@selector(onDigitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn6 addTarget:self action:@selector(onDigitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn7 addTarget:self action:@selector(onDigitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn8 addTarget:self action:@selector(onDigitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn9 addTarget:self action:@selector(onDigitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnDecimal addTarget:self action:@selector(onDecimalTap:) forControlEvents:UIControlEventTouchUpInside];
    
    //FUNCTIONAL BUTTONS
    [self.btnBackspace addTarget:self action:@selector(onFunctionTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnClear addTarget:self action:@selector(onFunctionTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnTogglePlusMinus addTarget:self action:@selector(onFunctionTap:) forControlEvents:UIControlEventTouchUpInside];

    [self.btnBackspace setTag:FunctionTypeBackspace];
    [self.btnClear setTag:FunctionTypeClear];
    [self.btnTogglePlusMinus setTag:FunctionTypeTogglePlusMinus];
    
    //OPERATOR BUTTONS
    [self.btnEquals setTag:OperandTypeEquals];
    [self.btnPlus setTag:OperandTypePlus];
    [self.btnMinus setTag:OperandTypeMinus];
    [self.btnTimes setTag:OperandTypeTimes];
    [self.btnDivide setTag:OperandTypeDivide];
    
    [self.btnDivide addTarget:self action:@selector(onOperatorTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnMinus addTarget:self action:@selector(onOperatorTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnPlus addTarget:self action:@selector(onOperatorTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnTimes addTarget:self action:@selector(onOperatorTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnEquals addTarget:self action:@selector(onOperatorTap:) forControlEvents:UIControlEventTouchUpInside];
}

@end
