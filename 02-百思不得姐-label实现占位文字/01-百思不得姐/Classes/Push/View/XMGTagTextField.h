//
//  XMGTagTextField.h
//  01-百思不得姐
//
//  Created by Tb on 16/9/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGTagTextField : UITextField

@property (nonatomic,copy)void(^deleteBlock)();
@end
