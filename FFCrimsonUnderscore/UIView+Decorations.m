//
//  UIView+Decorations.m
//  FFCrimsonUnderscore
//
//  Created by Igor Matyushkin on 29.10.14.
//  Copyright (c) 2014 FindandForm. All rights reserved.
//

#import "UIView+Decorations.h"

@implementation UIView (Decorations)

#pragma mark Public methods

- (UIView *)FF_underlineSubviews:(NSArray *)subviews withLineHeight:(CGFloat)lineHeight color:(UIColor *)color
{
    CGRect frameForUnderlyingView = [self frameToUnderlineSubviews:subviews
                                                    withLineHeight:lineHeight];
    
    UIView *underlyingView = [[UIView alloc] initWithFrame:frameForUnderlyingView];
    underlyingView.backgroundColor = color;
    
    [self addSubview:underlyingView];
    
    return underlyingView;
}

- (UILabel *)FF_showValidationAlertWithAttributedText:(NSAttributedString *)attributedText
{
    UILabel *alertLabel = [[UILabel alloc] init];
    alertLabel.attributedText = attributedText;
    alertLabel.frame = [self frameForValidationAlertLabel:alertLabel];
    
    self.clipsToBounds = NO;
    
    [self addSubview:alertLabel];
    
    return alertLabel;
}

- (void)FF_setValidationAlertWithAttributedText:(NSAttributedString *)attributedText withLabel:(UILabel *)label
{
    label.attributedText = attributedText;
    label.frame = [self frameForValidationAlertLabel:label];
    
    self.clipsToBounds = NO;
    
    if(self != label.superview)
    {
        [self addSubview:label];
    }
}

- (UILabel *)FF_showValidationAlertWithBackgroundColor:(UIColor *)backgroundColor andText:(NSString *)text ofColor:(UIColor *)textColor withFont:(UIFont *)font
{
    UILabel *alertLabel = [[UILabel alloc] init];
    alertLabel.backgroundColor = backgroundColor;
    alertLabel.text = text;
    alertLabel.textColor = textColor;
    alertLabel.font = font;
    alertLabel.frame = [self frameForValidationAlertLabel:alertLabel];
    
    self.clipsToBounds = NO;
    
    [self addSubview:alertLabel];
    
    return alertLabel;
}

- (void)FF_setValidationAlertWithBackgroundColor:(UIColor *)backgroundColor andText:(NSString *)text ofColor:(UIColor *)textColor withFont:(UIFont *)font label:(UILabel *)label
{
    label.backgroundColor = backgroundColor;
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.frame = [self frameForValidationAlertLabel:label];
    
    self.clipsToBounds = NO;
    
    if(self != label.superview)
    {
        [self addSubview:label];
    }
}

- (UILabel *)FF_addPlaceholderWithAttributedText:(NSAttributedString *)attributedText
{
    UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
    placeholderLabel.attributedText = attributedText;
    
    [self addSubview:placeholderLabel];
    
    return placeholderLabel;
}

- (UILabel *)FF_addPlaceholderWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment
{
    UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
    placeholderLabel.text = text;
    placeholderLabel.font = font;
    placeholderLabel.textColor = color;
    placeholderLabel.textAlignment = alignment;
    
    [self addSubview:placeholderLabel];
    
    return placeholderLabel;
}

#pragma mark Private methods

- (CGRect)frameToUnderlineSubviews:(NSArray *)subviews withLineHeight:(CGFloat)lineHeight
{
    CGRect frame = CGRectZero;
    
    CGFloat minOriginX = ((UIView *)subviews.firstObject).frame.origin.x;
    CGFloat maxOriginX = minOriginX;
    CGFloat originY = ((UIView *)subviews.firstObject).frame.origin.y + ((UIView *)subviews.firstObject).frame.size.height;
    
    for(UIView *view in subviews)
    {
        if(minOriginX > view.frame.origin.x)
        {
            minOriginX = view.frame.origin.x;
        }
        
        if(maxOriginX < view.frame.origin.x + view.frame.size.width)
        {
            maxOriginX = view.frame.origin.x + view.frame.size.width;
        }
        
        if(originY < view.frame.origin.y + view.frame.size.height)
        {
            originY = view.frame.origin.y + view.frame.size.height;
        }
    }
    
    frame.origin.x = minOriginX;
    frame.origin.y = originY + 1;
    frame.size.width = maxOriginX - minOriginX;
    frame.size.height = lineHeight;
    
    return frame;
}

- (CGRect)frameForValidationAlertLabel:(UILabel *)label
{
    CGRect frameForLabel = label.frame;
    frameForLabel.size = [label sizeThatFits:self.bounds.size];
    frameForLabel.origin.x = 0.f;
    frameForLabel.origin.y = self.bounds.size.height + 4.0f;
    return frameForLabel;
}

@end
