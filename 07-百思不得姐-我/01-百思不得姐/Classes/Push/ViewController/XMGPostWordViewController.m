

//
//  XMGPostWordViewController.m
//  01-百思不得姐
//
//  Created by Tb on 16/8/6.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPostWordViewController.h"
#import "XMGPlaceholderTextView.h"
@interface XMGPostWordViewController ()
@property (nonatomic,strong)XMGPlaceholderTextView *textView;

@end

@implementation XMGPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTextView];
}
- (void)setupNav
{
    self.title = @"发表文字";
    self.view.backgroundColor = XMGGlobalBg;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cacel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    //这里设置了enable为no,却没有Disable的状态,因为渲染问题，在viewDidAppear设置却可以，但界面出现两种颜色,要强制刷新
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)setupTextView
{
    XMGPlaceholderTextView *textView = [[XMGPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;

    textView.placeholder = @"ni bicccccc擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦擦车擦擦擦vvvbnjjjkkkkkccfgfghghhhjhj";
    textView.placeholderColor = [UIColor redColor];
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.navigationItem.rightBarButtonItem.enabled = NO;

}
- (void)post
{
    
}
- (void)cacel
{
    self.textView.text = @"hehe";
  //  self.textView.font = [UIFont systemFontOfSize:30];
    //self.textView.placeholder = @"tom i am is";
    // [self dismissViewControllerAnimated:YES completion:nil];
}
@end
