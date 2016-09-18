//
//  XMGTagTextField.m
//  01-百思不得姐
//
//  Created by Tb on 16/9/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTagTextField.h"

@implementation XMGTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或者换行隔开";
        // 利用kvc修改占位文字的颜色，apple采用的是懒加载
        [self setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self
    ;
}

- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
       [super deleteBackward];
}

@end
