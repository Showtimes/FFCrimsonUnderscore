//
//  FFValidationClient.h
//  FFCrimsonUnderscore
//
//  Created by Igor Matyushkin on 17.11.14.
//  Copyright (c) 2014 FindandForm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFValidationClientDelegate.h"

@interface FFValidationClient : NSObject

@property (strong, nonatomic, readonly) NSArray *views;

@property (assign, nonatomic) id<FFValidationClientDelegate> delegate;

- (instancetype)initWithViews:(NSArray *)views;

- (void)startValidationWithIndex:(NSInteger)index reverseOrder:(BOOL)reverseOrder;

- (void)removeValidationAlerts;

@end
