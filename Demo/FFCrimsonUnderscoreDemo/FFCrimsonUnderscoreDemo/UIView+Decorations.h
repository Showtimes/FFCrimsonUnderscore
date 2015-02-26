//
//  UIView+Decorations.h
//  FFCrimsonUnderscore
//
//  Created by Igor Matyushkin on 29.10.14.
//  Copyright (c) 2014 FindandForm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Decorations)

- (UIView *)FF_underlineSubviews:(NSArray *)subviews withLineHeight:(CGFloat)lineHeight color:(UIColor *)color;

- (UILabel *)FF_showValidationAlertWithAttributedText:(NSAttributedString *)attributedText;

- (void)FF_setValidationAlertWithAttributedText:(NSAttributedString *)attributedText withLabel:(UILabel *)label;

- (UILabel *)FF_showValidationAlertWithBackgroundColor:(UIColor *)backgroundColor andText:(NSString *)text ofColor:(UIColor *)textColor withFont:(UIFont *)font;

- (void)FF_setValidationAlertWithBackgroundColor:(UIColor *)backgroundColor andText:(NSString *)text ofColor:(UIColor *)textColor withFont:(UIFont *)font label:(UILabel *)label;

- (UILabel *)FF_addPlaceholderWithAttributedText:(NSAttributedString *)attributedText;

- (UILabel *)FF_addPlaceholderWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;

@end
