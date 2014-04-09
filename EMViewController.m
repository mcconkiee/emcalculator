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
    [EMStyles styleCalculator:calc];
       
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
