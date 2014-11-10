//
//  EMInputLabel.m
//  EMSimpleCalculator
//
//  Created by Eric McConkie on 11/10/14.
//  Copyright (c) 2014 Eric McConkie. All rights reserved.
//

#import "EMInputLabel.h"

@implementation EMInputLabel
- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 15, 0, 15};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end
