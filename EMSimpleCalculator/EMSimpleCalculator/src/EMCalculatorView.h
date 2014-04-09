//
//  EMCalculatorView.h
//  EMSimpleCalculator
//
//  Created by Eric McConkie on 4/8/14.
//  Copyright (c) 2014 Eric McConkie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OperandTypeEquals = 10,
    OperandTypePlus = 11,
    OperandTypeMinus = 12,
    OperandTypeTimes =13,
    OperandTypeDivide = 14
}OperandType;

typedef enum {
    FunctionTypeGeneral = 200,
    FunctionTypeClear = 225,
    FunctionTypeBackspace =226,
    FunctionTypeTogglePlusMinus=227
}FunctionType;

@interface EMCalculatorView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblDisplay;
@property (weak, nonatomic) IBOutlet UILabel *lblOperand;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIButton *btn8;
@property (weak, nonatomic) IBOutlet UIButton *btn9;
@property (weak, nonatomic) IBOutlet UIButton *btn0;

@property (weak, nonatomic) IBOutlet UIButton *btnPlus;
@property (weak, nonatomic) IBOutlet UIButton *btnMinus;
@property (weak, nonatomic) IBOutlet UIButton *btnTimes;
@property (weak, nonatomic) IBOutlet UIButton *btnDivide;

@property (weak, nonatomic) IBOutlet UIButton *btnDecimal;
@property (weak, nonatomic) IBOutlet UIButton *btnEquals;
@property (weak, nonatomic) IBOutlet UIButton *btnClear;
@property (weak, nonatomic) IBOutlet UIButton *btnBackspace;
@property (weak, nonatomic) IBOutlet UIButton *btnTogglePlusMinus;


@end
