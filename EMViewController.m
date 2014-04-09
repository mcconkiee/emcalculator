//
//  EMViewController.m
//  EMSimpleCalculator
//
//  Created by Eric McConkie on 4/8/14.
//  Copyright (c) 2014 Eric McConkie. All rights reserved.
//

#import "EMViewController.h"
#import "EMCalculatorView.h"
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
        if ([w isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)w;
            if (btn.tag > FunctionTypeGeneral) {//function buttons (clear, backspace, etc)
                [btn setBackgroundColor:[UIColor lightGrayColor]];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [functions addObject:btn];
                [btn.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
                [btn.layer setBorderWidth:1];
            }
            if (btn.tag < FunctionTypeGeneral) { //operands
                [btn setBackgroundColor:[UIColor blueColor]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [operators addObject:btn];

            }
            if (btn.tag < OperandTypeEquals) { //these are the digit buttons
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [digits addObject:btn];
                [btn.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
                [btn.layer setBorderWidth:1];
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
    
    
//    //postions
//    CGFloat x,y;
//    x =0.0;
//    y = 0.0;
//    CGFloat wd = 74.0;
//    CGFloat ht = 45.0;
//    for (int b=0; b<functions.count; b++) {
//        UIButton *btn = [functions objectAtIndex:b];
//        CGRect rect = CGRectMake(x, y, wd, ht);
//        [btn setFrame:rect];
//        x += wd;
//        if (x > calc.frame.size.width - wd) {
//            x = 0.0;
//            y += ht;
//        }
//    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
