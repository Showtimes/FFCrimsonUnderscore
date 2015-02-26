//
//  ViewController.m
//  FFCrimsonUnderscoreDemo
//
//  Created by James Graham on 2/26/15.
//  Copyright (c) 2015 Find & Form. All rights reserved.
//

#import "ViewController.h"
#import "FFCrimsonUnderscore.h"
@interface ViewController () <FFValidationClientDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) FFValidationClient *client;

//meta properties
@property (strong, nonatomic) NSArray *fields;
@end

@implementation ViewController

- (NSArray *)fields{
    if (!_fields) {
        _fields = [NSArray arrayWithObjects: self.firstName, self.lastName, self.email, self.password, nil];
    }
    return _fields;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //text field delegates set to this vc
    for (UITextField *arbitraryTF in self.fields) {
        arbitraryTF.delegate = self;
    }
    
    //create validation client
    _client = [[FFValidationClient alloc] initWithViews:self.fields];
    _client.delegate = self;
    
}

#pragma mark - Delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSUInteger index = [self.fields indexOfObject:textField];
    if (index + 1 == self.fields.count) {
        [self.view endEditing:YES];
    }
    else {
        [((UITextField *)[self.fields objectAtIndex:index + 1]) becomeFirstResponder];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *textAfterReplacement = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    textField.text = textAfterReplacement;
    
    [self.client startValidationWithIndex:[self.fields indexOfObject:textField] reverseOrder:YES];
    
    return NO;
}
#pragma mark - Validation Client Delegate methods

- (BOOL)validationClient:(FFValidationClient *)validationClient isViewValid:(UIView *)view errorAttributedText:(NSAttributedString *__autoreleasing *)errorAttributedText{
    if ([view isEqual:self.firstName]) {
        
        //conditions for first name
        
        if (self.firstName.text.length == 0) {
            *errorAttributedText = [[NSAttributedString alloc] initWithString:@"First name cannot be empty"
                                                                   attributes:@{
                                                                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:8.0f],
                                                                                NSForegroundColorAttributeName: [UIColor redColor]
                                                                                }];
            return NO;
        }
        
        if ([self.firstName.text isEqualToString:@"James"]){
            *errorAttributedText = [[NSAttributedString alloc] initWithString:@"Mine, too!"
                                                                   attributes:@{
                                                                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:8.0f],
                                                                                NSForegroundColorAttributeName: [UIColor blueColor]
                                                                                }];
            return NO;
        }
    }
    else if ([view isEqual:self.lastName]){
        //conditions for last name
        
        if (self.lastName.text == 0) {
            *errorAttributedText = [[NSAttributedString alloc] initWithString:@"Last name cannot be empty"
                                                                   attributes:@{
                                                                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:8.0f],
                                                                                NSForegroundColorAttributeName: [UIColor redColor]
                                                                                }];
            return NO;
        }
    }
    else if ([view isEqual:self.email] ){
        //conditions for email
        
        
        //email validity using a basic regex
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"self matches %@", emailRegEx];
        
        if(![emailPredicate evaluateWithObject:self.email.text]){
            *errorAttributedText = [[NSAttributedString alloc] initWithString:@"Incorrect email format"
                                                                   attributes:@{
                                                                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:8.0f],
                                                                                NSForegroundColorAttributeName: [UIColor redColor]
                                                                                }];
            return NO;
        }
        
        if([self.email.text isEqualToString:@"wittedhaddock@gmail.com"]){
            *errorAttributedText = [[NSAttributedString alloc] initWithString:@"No Way! Same here!"
                                                                   attributes:@{
                                                                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:8.0f],
                                                                                NSForegroundColorAttributeName: [UIColor blueColor]
                                                                                }];
            return NO;
        }
    }
    
    else if ([view isEqual:self.password]){
        if (self.password.text.length == 0) {
            *errorAttributedText = [[NSAttributedString alloc] initWithString:@"Password cannot be empty"
                                                                   attributes:@{
                                                                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:8.0f],
                                                                                NSForegroundColorAttributeName: [UIColor blueColor]
                                                                                }];
            
            return NO;
        }
        else if (self.password.text.length < 6) {
            *errorAttributedText = [[NSAttributedString alloc] initWithString:@"Password cannot be less than 6 characters"
                                                                   attributes:@{
                                                                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:8.0f],
                                                                                NSForegroundColorAttributeName: [UIColor blueColor]
                                                                                }];
            return NO;
        }
    }
    
    
    return YES;
}


@end
