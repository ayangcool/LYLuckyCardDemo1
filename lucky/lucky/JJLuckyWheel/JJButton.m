//
//  JJButton.m
//  lucky
//
//  Created by zhoujjtech on 5/17/16.
//  Copyright © 2016 zhoujjtech. All rights reserved.
//

#import "JJButton.h"

@implementation JJButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 40;
    CGFloat imageH = 46;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
