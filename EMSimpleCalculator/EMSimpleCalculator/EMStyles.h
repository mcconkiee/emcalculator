//
//  EMStyles.h
//  EMSimpleCalculator
//
//  Created by Eric McConkie on 4/9/14.
//  Copyright (c) 2014 Eric McConkie. All rights reserved.
//
typedef enum {
    BorderTypeTop,
    BorderTypeBottom,
    BorderTypeLeft,
    BorderTypeRight
}BorderType ;
#import <Foundation/Foundation.h>

@class  EMCalculatorView;
@interface EMStyles : NSObject
+(CALayer*)borderFor:(BorderType)type frame:(CGRect)frame color:(UIColor*)color;
+(void)styleCalculator:(EMCalculatorView*)calc;
@end
