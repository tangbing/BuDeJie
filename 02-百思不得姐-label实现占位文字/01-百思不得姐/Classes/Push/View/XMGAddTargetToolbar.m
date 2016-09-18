
//
//  XMGAddTargetToolbar.m
//  01-百思不得姐
//
//  Created by Tb on 16/9/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAddTargetToolbar.h"
#import "XMGAddTagViewController.h"

@interface XMGAddTargetToolbar()
@property (nonatomic,strong)NSMutableArray *tagLabels;
@property (nonatomic,weak)UIButton *addButton;

@end

@implementation XMGAddTargetToolbar

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
   return _tagLabels;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 添加一个加号按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
   // addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    //addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.x = XMGTopicCellMargin;
    addButton.size = addButton.currentImage.size;
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    
    [self  createTags:@[@"吐槽",@"糗事"]];
}
- (void)add
{
   // [a pushViewController:b animated:Yes]
   // a presentedViewController -> b
   // b presentingViewController - a
    
    __weak typeof(self) weakSelf = self;
    XMGAddTagViewController *addTag = [[XMGAddTagViewController alloc] init];
    [addTag setDoneBlock:^(NSArray *titleArray) {
        [weakSelf createTags:titleArray];
    }];
    addTag.tags = [self.tagLabels valueForKey:@"text"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *Nav = (UINavigationController *) root.presentedViewController;
    [Nav pushViewController:addTag animated:YES];

}
- (void)createTags:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
        for (NSInteger i = 0; i<[tags count];i++) {
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.backgroundColor = XMGTagBg;
            titleLabel.text = tags[i];
            [titleLabel sizeToFit];
            titleLabel.width += 2 *XMGTagMargin;
            titleLabel.height = 25;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont systemFontOfSize:14];
            [self.topView addSubview:titleLabel];
            [self.tagLabels addObject:titleLabel];
            
            
            if (i == 0) {// 最前面的标签按钮
                titleLabel.x = 0;
                titleLabel.y = 0;
            } else {// 其他的标签按钮
                UILabel *lastLabel = self.tagLabels[i -1];
                CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + XMGTagMargin;
                if (self.topView.width - leftWidth >= titleLabel.width) {
                    titleLabel.x = leftWidth;
                    titleLabel.y = lastLabel.y;
                } else {// 按钮放在下一行
                    titleLabel.x = 0;
                    titleLabel.y =  CGRectGetMaxY(lastLabel.frame) + XMGTagMargin;
                }
            }

        }
    UILabel *lastLabel = self.tagLabels.lastObject;
    CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + XMGTagMargin;
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.x = leftWidth;
        self.addButton.y = lastLabel.y;
    } else {
        CGFloat leftY = CGRectGetMaxY(lastLabel.frame) + XMGTagMargin;
        self.addButton.x = 0;
        self.addButton.y =leftY;
    }
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) +  59;
    self.y -= self.height - oldH;
}

@end
