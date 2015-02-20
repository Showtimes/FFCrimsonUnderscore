//
//  LaunchViewController.m
//  FFCrimsonUnderscore Demo
//
//  Created by Igor Matyushkin on 20.02.15.
//  Copyright (c) 2015 FindandForm. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;

@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;

@property (strong, nonatomic) FFValidationClient *validationClient;

@end

@implementation LaunchViewController

#pragma mark Class methods

+ (NSDictionary *)attributesForValidationErrorText
{
    return @{
             NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12.0f],
             NSForegroundColorAttributeName: [UIColor redColor]
             };
}


#pragma mark Initializers


#pragma mark Deinitializer

- (void)dealloc
{
}

#pragma mark Property accessors


#pragma mark Public methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Initialize email text field
    
    _textFieldEmail.delegate = self;
    
    
    // Initialize password text field
    
    _textFieldPassword.delegate = self;
    
    
    // Initialize validation client
    
    NSArray *viewsToValidate = @[
                                 _textFieldEmail,
                                 _textFieldPassword
                                 ];
    
    _validationClient = [[FFValidationClient alloc] initWithViews:viewsToValidate];
    _validationClient.delegate = self;
    
    [_validationClient startValidationWithIndex:0
                                   reverseOrder:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Private methods


#pragma mark Actions


#pragma mark Protocol methods

- (void)validationClientDidStart:(FFValidationClient *)validationClient
{
    NSLog(@"Did start validation");
}

- (BOOL)validationClient:(FFValidationClient *)validationClient isViewValid:(UIView *)view errorAttributedText:(NSAttributedString **)errorAttributedText
{
    NSDictionary *attributesForValidationErrorText = [[self class] attributesForValidationErrorText];
    
    if(view == _textFieldEmail)
    {
        NSString *textToValidate = _textFieldEmail.text;
        
        static NSString *emailRegularExpression = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        
        NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"self matches %@",
                                       emailRegularExpression];
        
        BOOL isValidEmail = [emailPredicate evaluateWithObject:textToValidate];
        
        if(!isValidEmail)
        {
            *errorAttributedText = [[NSAttributedString alloc] initWithString:@"Wrong email."
                                                                   attributes:attributesForValidationErrorText];
        }
        
        return isValidEmail;
    }
    else if(view == _textFieldPassword)
    {
        NSString *textToValidate = _textFieldPassword.text;
        
        static NSUInteger minLengthForPassword = 8;
        
        BOOL isValidPassword = textToValidate.length >= minLengthForPassword;
        
        if(!isValidPassword)
        {
            NSString *errorText = [NSString stringWithFormat:@"Password cannot be less than %d symbols.",
                                   minLengthForPassword];
            
            *errorAttributedText = [[NSAttributedString alloc] initWithString:errorText
                                                                   attributes:attributesForValidationErrorText];
        }
        
        return isValidPassword;
    }
    else
    {
        return YES;
    }
}

- (void)validationClient:(FFValidationClient *)validationClient viewDidPass:(UIView *)view
{
    NSLog(@"View %p did pass validation",
          view);
}

- (void)validationClient:(FFValidationClient *)validationClient viewDidFail:(UIView *)view withAlertLabel:(UILabel *)alertLabel
{
    NSLog(@"View %p did fail validation",
          view);
}

- (void)validationClient:(FFValidationClient *)validationClient didFinishWithPassedViews:(NSArray *)passedViews failedViews:(NSArray *)failedViews
{
    NSLog(@"Did finish validation with %d passed views and %d failed views.",
          passedViews.count,
          failedViews.count);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *currentText = textField.text;
    NSString *textAfterReplacement = [currentText stringByReplacingCharactersInRange:range withString:string];
    
    textField.text = textAfterReplacement;
    
    [_validationClient startValidationWithIndex:0
                                   reverseOrder:NO];
    
    return NO;
}

@end