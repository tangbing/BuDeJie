//
//  XMGAddTagViewController.h
//  01-百思不得姐
//
//  Created by Tb on 16/9/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGAddTagViewController : UIViewController
@property (nonatomic,copy)void(^doneBlock)(NSArray *);
@property (nonatomic,strong)NSMutableArray *tags;
@end
