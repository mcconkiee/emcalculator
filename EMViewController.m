//
//  EMViewController.m
//  EMSimpleCalculator
//
//  Created by Eric McConkie on 4/8/14.
//  Copyright (c) 2014 Eric McConkie. All rights reserved.
//

#import "EMViewController.h"
#import "EMCalculatorView.h"
#import "EMStyles.h"
@interface EMViewController ()

@end

@implementation EMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    EMCalculatorView *calc = [[[NSBundle mainBundle]loadNibNamed:@"EMCalculatorView" owner:self options:nil] objectAtIndex:0];
    [self.view addSubview:calc];
    
    NSArray *subviews = [calc subviews];
    NSMutableArray *digits = [NSMutableArray array];
    NSMutableArray *operators = [NSMutableArray array];
    NSMutableArray *functions = [NSMutableArray array];
    for (UIView *w in subviews) {
        if (w == calc.lblDisplay) {
            [w setBackgroundColor:[UIColor darkGrayColor]];
            [(UILabel*)w setTextColor:[UIColor whiteColor]];
        }
        if ([w isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)w;
            [btn setClipsToBounds:YES];
            if (btn.tag > FunctionTypeGeneral) {//function buttons (clear, backspace, etc)
                [btn setBackgroundColor:[UIColor lightGrayColor]];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [functions addObject:btn];
                CALayer *left = [EMStyles borderFor:BorderTypeLeft frame:btn.frame color:[UIColor darkGrayColor]];
                [btn.layer addSublayer:left];
                CALayer *bottom = [EMStyles borderFor:BorderTypeBottom frame:btn.frame color:[UIColor darkGrayColor]];
                [btn.layer addSublayer:bottom];
            }
            if (btn.tag < FunctionTypeGeneral) { //operands
                [btn setBackgroundColor:[UIColor blueColor]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [operators addObject:btn];
                CALayer *bottom = [EMStyles borderFor:BorderTypeBottom frame:btn.frame color:[UIColor whiteColor]];
                
                if (btn == calc.btnEquals) {
                    bottom = [EMStyles borderFor:BorderTypeBottom frame:btn.frame color:[UIColor darkGrayColor]];
                }
                [btn.layer addSublayer:bottom];
                
            }
            if (btn.tag < OperandTypeEquals) { //these are the digit buttons
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [digits addObject:btn];
                
                CALayer *left = [EMStyles borderFor:BorderTypeLeft frame:btn.frame color:[UIColor darkGrayColor]];
                [btn.layer addSublayer:left];
                
                CALayer *bottom = [EMStyles borderFor:BorderTypeBottom frame:btn.frame color:[UIColor darkGrayColor]];
                [btn.layer addSublayer:bottom];
                
            }
            
            switch (btn.tag) {
                case OperandTypeDivide:
                    [btn setTitle:@"\u00F7" forState:UIControlStateNormal];
                    break;
                case OperandTypeMinus:
                    [btn setTitle:@"-" forState:UIControlStateNormal];
                    break;
                case OperandTypePlus:
                    [btn setTitle:@"+" forState:UIControlStateNormal];
                    break;
                case OperandTypeTimes:
                    [btn setTitle:@"\u00D7" forState:UIControlStateNormal];
                    break;
                    
                case FunctionTypeBackspace:
                    [btn setTitle:@"\u232B" forState:UIControlStateNormal];
                    break;
                    
                case FunctionTypeTogglePlusMinus:
                    [btn setTitle:@"\u00B1" forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
        }
    }    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
