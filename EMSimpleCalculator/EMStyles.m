//
//  EMStyles.m
//  EMSimpleCalculator
//
//  Created by Eric McConkie on 4/9/14.
//  Copyright (c) 2014 Eric McConkie. All rights reserved.
//

#import "EMStyles.h"
#import "EMCalculatorView.h"
@implementation EMStyles
+(CALayer*)borderFor:(BorderType)type frame:(CGRect)frame color:(UIColor*)color{
    CALayer *border = [CALayer layer];
    border.borderColor = [color CGColor];
    border.borderWidth = 1;
    switch (type) {
        case BorderTypeBottom:
            border.frame = CGRectMake(0, CGRectGetHeight(frame)-1, CGRectGetWidth(frame), 1);
            break;
        case BorderTypeLeft:
            border.frame = CGRectMake(0, 0, 1, CGRectGetHeight(frame));
            break;
            
        case BorderTypeRight:
            border.frame = CGRectMake(CGRectGetWidth(frame)-1, 0, 1, CGRectGetHeight(frame));
            break;
            
        case BorderTypeTop:
            border.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 1);
            break;
            
        default:
            break;
    }
    return border;
}
+(void)styleCalculator:(EMCalculatorView*)calc
{
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
@end
