//
//  XMGAddTagViewController.m
//  01-百思不得姐
//
//  Created by Tb on 16/9/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#define XMGTagTextFont [UIFont systemFontOfSize:14];

#import "XMGAddTagViewController.h"
#import "XMGTagButton.h"
#import "XMGTagTextField.h"
#import <SVProgressHUD.h>
@interface XMGAddTagViewController ()<UITextFieldDelegate>
@property (nonatomic,weak)UIView *contentView;
@property (nonatomic,weak)XMGTagTextField *textField;
@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)NSMutableArray *tagButtonsAray;
@end

@implementation XMGAddTagViewController


#pragma mark - 懒加载
- (NSMutableArray *)tagButtonsAray
{
    if (_tagButtonsAray == nil) {
        _tagButtonsAray = [NSMutableArray array];
    }
    return _tagButtonsAray;
}
- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [[UIButton alloc]init];
        _addButton.width = self.contentView.width;
        _addButton.height = 35;
        _addButton.x = 0;
        _addButton.titleLabel.font = XMGTagTextFont;
        [_addButton setContentEdgeInsets:UIEdgeInsetsMake(0, XMGTagMargin, 0, XMGTagMargin)];
        _addButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;        [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents: UIControlEventTouchUpInside];
        
        _addButton.backgroundColor = XMGTagBg;
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_addButton];
    }
    return _addButton;
}
#pragma mark - 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupContentView];
    [self setupTextField];
    [self setupTags];
}

- (void)setupTags
{
    for (NSString *str in self.tags) {
        self.textField.text = str;
        [self addButtonClick];
    }
}
- (void)setupNav
{
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    self.view.backgroundColor = [UIColor whiteColor];

}
- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = XMGTagMargin;
    contentView.y = 64;
    contentView.width = XMGScreenW - 2 * contentView.x;
    contentView.height = XMGScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}
- (void)setupTextField
{
    __weak typeof(self) weakSelf = self;
    XMGTagTextField *textField = [[XMGTagTextField alloc] init];
    textField.font = XMGTagTextFont;
    [textField setDeleteBlock:^{
        if (!self.textField.hasText ) {
        [weakSelf delete:[weakSelf.tagButtonsAray lastObject]];
        }
  }];
   
    textField.width = self.contentView.width;
    textField.height = 25;
    textField.delegate = self;

    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    [textField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    self.textField = textField;
}

- (void)finish
{
    NSMutableArray *tags = [NSMutableArray array];
    for (XMGTagButton *button in self.tagButtonsAray) {
        [tags addObject:button.currentTitle];
    }
    !self.doneBlock ? : self.doneBlock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  监听文字改变

/**
 *  监听文字改变
 */
- (void)textChange
{
    // 更新标签的frame
    [self updateTextFieldFrame];
    
    if (self.textField.hasText) {// 有文字，就显示
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + XMGTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        
        // 得到最后一个字符
        NSUInteger len = self.textField.text.length;
        NSString *text = self.textField.text;
      NSString *lastStirng =  [text substringFromIndex:len -1];
        if (([lastStirng isEqualToString:@","] || [lastStirng isEqualToString:@"，"] )&& len >1) {
          self.textField.text=  [text substringToIndex:len - 1];
            [self addButtonClick];
        }
        
    } else {// 没有文字，就隐藏
        self.addButton.hidden = YES;
    }

}
#pragma mark - 监听按钮点击
- (void)addButtonClick
{
    if ([self.tagButtonsAray count] == 5) {
        [SVProgressHUD showErrorWithStatus:@"最大只能添加5个" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    XMGTagButton *tagButton = [XMGTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
  
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtonsAray addObject:tagButton];
    
    self.textField.text = nil;
    self.addButton.hidden = YES;
    
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
}

- (void)delete:(UIButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtonsAray removeObject:tagButton];
    // 重新更新所用的标签的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}

#pragma mark - 子控件frame的处理

- (void)updateTagButtonFrame
{
    for (int i = 0 ; i < self.tagButtonsAray.count; i++) {
        XMGTagButton *tagButton = self.tagButtonsAray[i];
        if (i == 0) {// 最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        } else {// 其他的标签按钮
            XMGTagButton *lastTagButton = self.tagButtonsAray[i -1];
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + XMGTagMargin;
            if (self.contentView.width - leftWidth >= tagButton.width) {
                tagButton.x = leftWidth;
                tagButton.y = lastTagButton.y;
            } else {// 按钮放在下一行
                tagButton.x = 0;
                tagButton.y =  CGRectGetMaxY(lastTagButton.frame) + XMGTagMargin;
            }
        }
    }
}
- (void)updateTextFieldFrame
{
    XMGTagButton *lastButton = self.tagButtonsAray.lastObject;
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + XMGTagMargin;
    if (self.contentView.width - leftWidth >= [self textFieldWidth]) {
        self.textField.x = leftWidth;
        self.textField.y = lastButton.y;
    } else {
        CGFloat leftY = CGRectGetMaxY(lastButton.frame) + XMGTagMargin;
        self.textField.x = 0;
        self.textField.y =leftY;
    }
}

- (CGFloat)textFieldWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, textW);
}

#pragma mark - UITextFieldDelegate
/**
 *  监听键盘最右下角的点击(return key，比如换行，完成)
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}

@end
