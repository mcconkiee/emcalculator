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
    // Delay execution of my block for N seconds.
    int delay = 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [calc setup];
    });
    
    NSArray *subviews = [calc subviews];
    for (UIView *w in subviews) {
        if ([w isKindOfClass:[UIButton class]]) {
            
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
