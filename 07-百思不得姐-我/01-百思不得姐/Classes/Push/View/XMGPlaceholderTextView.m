
//
//  XMGPlaceholderTextView.m
//  01-百思不得姐
//
//  Created by Tb on 16/8/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlaceholderTextView.h"

@implementation XMGPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor darkGrayColor];
        [XMGNoteCenter addObserver:self selector:@selector(textViewChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
//    if (self.text.length|| self.attributedText.length) {
//        return;
//    }
    if (self.hasText) return;
    
    rect.origin.x = 3;
    rect.origin.y =7;
    rect.size.width -= 2 * rect.origin.x;
    [_placeholder drawInRect:rect withAttributes:@{NSFontAttributeName : self.font,
                                                           NSForegroundColorAttributeName: self.placeholderColor                                                  }];
   
   }

- (void)textViewChange
{
    [self setNeedsDisplay];
}


- (void)setPlaceHolder:(NSString *)placeholder
{
    _placeholder= [placeholder copy];
    
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

@end
