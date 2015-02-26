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

@end
