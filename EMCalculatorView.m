//
//  EMCalculatorView.m
//  EMSimpleCalculator
//
//  Created by Eric McConkie on 4/8/14.
//  Copyright (c) 2014 Eric McConkie. All rights reserved.
//

typedef enum {
    OperandTypeEquals,
    OperandTypePlus,
    OperandTypeMinus,
    OperandTypeTimes,
    OperandTypeDivide
}OperandType;
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
        [self setup];
    }
    return self;
}



#pragma mark -------------->>actions
-(void)onDigitTap:(UIButton*)sender{
    
    [self addnumber:sender.tag];
}

-(void)onDecimalTap:(id)sender{
    if (self.hasDecimal)
        return;
    self.hasDecimal = YES;

    [self.lblDisplay setText:[NSString stringWithFormat:@"%g",[self.stack doubleValue]]];
}
-(void)onFunctionTap:(id)sender{
    if (sender == self.btnClear) {
        [self cancel:sender];
    }
}
-(void)onOperatorTap:(UIButton*)sender{
    if (self.stack == nil || [self.stack isEqualToString:@"0"] || self.stack.length<=0)
        return;
    
    [sender setSelected:YES];
    self.currentOperatorButton = sender;
    [self operand:sender.tag];
}



- (void)cancel:(id)sender {
    self.stack = @"";
    self.postOperatorStack = @"";
    [self.currentOperatorButton setSelected:NO];
    self.currentOperatorButton = nil;
    self.hasDecimal = NO;
    [self.lblDisplay setText:[NSString stringWithFormat:@"%g",[self.stack doubleValue]]];
    
    
}


-(void)operand:(int)type{
    [self equals];
    self.currentOperand = type;
    if (type == OperandTypeEquals) {
        [self.currentOperatorButton setSelected:NO];
    }
    
    [self.lblDisplay setText:[NSString stringWithFormat:@"%g",[self.stack doubleValue]]];
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
-(void)setup{
    
    [self cancel:nil];
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
    
    [self.btnBackspace addTarget:self action:@selector(onFunctionTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnClear addTarget:self action:@selector(onFunctionTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnTogglePlusMinus addTarget:self action:@selector(onFunctionTap:) forControlEvents:UIControlEventTouchUpInside];
    
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
