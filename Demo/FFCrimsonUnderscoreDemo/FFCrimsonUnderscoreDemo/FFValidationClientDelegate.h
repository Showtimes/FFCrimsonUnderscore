//
//  FFValidationClientDelegate.h
//  FFCrimsonUnderscore
//
//  Created by Igor Matyushkin on 17.11.14.
//  Copyright (c) 2014 FindandForm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FFValidationClient;

@protocol FFValidationClientDelegate <NSObject>

@required

@optional

- (void)validationClientDidStart:(FFValidationClient *)validationClient;

- (BOOL)validationClient:(FFValidationClient *)validationClient isViewValid:(UIView *)view errorAttributedText:(NSAttributedString **)errorAttributedText;

- (void)validationClient:(FFValidationClient *)validationClient viewDidPass:(UIView *)view;

- (void)validationClient:(FFValidationClient *)validationClient viewDidFail:(UIView *)view withAlertLabel:(UILabel *)alertLabel;

- (void)validationClient:(FFValidationClient *)validationClient didFinishWithPassedViews:(NSArray *)passedViews failedViews:(NSArray *)failedViews;

@end
