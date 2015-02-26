//
//  ViewController.m
//  FFCrimsonUnderscoreDemo
//
//  Created by James Graham on 2/26/15.
//  Copyright (c) 2015 Find & Form. All rights reserved.
//

#import "ViewController.h"
#import "FFCrimsonUnderscore.h"
@interface ViewController () <FFValidationClientDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) FFValidationClient *client;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *viewsNecessitatingValidation = @[self.firstName, self.lastName, self.email, self.password];
    _client = [[FFValidationClient alloc] initWithViews:viewsNecessitatingValidation];
    _client.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
