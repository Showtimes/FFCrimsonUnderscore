//
//  FFValidationClient.m
//  FFCrimsonUnderscore
//
//  Created by Igor Matyushkin on 17.11.14.
//  Copyright (c) 2014 FindandForm. All rights reserved.
//

#import "FFValidationClient.h"
#import "UIView+Decorations.h"

@interface FFValidationClient ()

@property (strong, nonatomic) NSMutableArray *alertLabels;

@end

@implementation FFValidationClient

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
    }
    
    return self;
}

- (instancetype)initWithViews:(NSArray *)views
{
    self = [self init];
    
    if(self)
    {
        _views = [NSArray arrayWithArray:views];
        
        _alertLabels = [NSMutableArray arrayWithCapacity:views.count];
        
        for(NSInteger i = 0; i < views.count; i++)
        {
            UILabel *label = [[UILabel alloc] init];
            [_alertLabels addObject:label];
        }
    }
    
    return self;
}

#pragma mark Property accessors

#pragma mark Public methods

- (void)startValidationWithIndex:(NSInteger)index reverseOrder:(BOOL)reverseOrder
{
    if([_delegate respondsToSelector:@selector(validationClientDidStart:)])
    {
        [_delegate validationClientDidStart:self];
    }
    
    NSMutableArray *passedViews = [NSMutableArray array];
    NSMutableArray *failedViews = [NSMutableArray array];
    
    void (^blockForStep)(NSInteger stepIndex) = ^(NSInteger stepIndex)
    {
        UIView *view = _views[stepIndex];
        
        NSAttributedString *errorAttributedText = nil;
        
        BOOL isViewValid = YES;
        
        if([_delegate respondsToSelector:@selector(validationClient:isViewValid:errorAttributedText:)])
        {
            isViewValid = [_delegate validationClient:self
                                          isViewValid:view
                                  errorAttributedText:&errorAttributedText];
        }
        
        if(isViewValid)
        {
            UILabel *alertLabel = _alertLabels[stepIndex];
            [alertLabel removeFromSuperview];
            
            [passedViews addObject:view];
            
            if([_delegate respondsToSelector:@selector(validationClient:viewDidPass:)])
            {
                [_delegate validationClient:self
                                viewDidPass:view];
            }
        }
        else
        {
            UILabel *alertLabel = _alertLabels[stepIndex];
            
            [view FF_setValidationAlertWithAttributedText:errorAttributedText
                                                withLabel:alertLabel];
            
            [failedViews addObject:view];
            
            if([_delegate respondsToSelector:@selector(validationClient:viewDidFail:withAlertLabel:)])
            {
                [_delegate validationClient:self
                                viewDidFail:view
                             withAlertLabel:alertLabel];
            }
        }
    };
    
    if(reverseOrder)
    {
        for(NSInteger i = index; i >= 0; i--)
        {
            blockForStep(i);
        }
    }
    else
    {
        for(NSInteger i = index; i < _views.count; i++)
        {
            blockForStep(i);
        }
    }
    
    if([_delegate respondsToSelector:@selector(validationClient:didFinishWithPassedViews:failedViews:)])
    {
        [_delegate validationClient:self
           didFinishWithPassedViews:passedViews
                        failedViews:failedViews];
    }
}

- (void)removeValidationAlerts
{
    for(UILabel *alertLabel in _alertLabels)
    {
        [alertLabel removeFromSuperview];
    }
}

#pragma mark Private methods

#pragma mark Delegate methods

@end
