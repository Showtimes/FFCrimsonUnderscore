
# FFCrimsonUnderscore

This library helps to handle validation process for large input forms containing UITextFields, UITextViews and any other UI elements which you want to validate.

---------------

#Installation Process
1. Copy `FFCrimsonUnderscore` to your project
2. Add
```objective-c
#import "FFCrimsonUnderscore.h" file
```

---------------

#Usage

All that you need is to initialize `FFValidationClient` and implement `FFValidationClientDelegate` protocol.

Example:

```objective-c
NSArray *viewsToValidate = @[
    _textFieldEmail,
    _textFieldPassword
];

FFValidationClient *validationClient = [[FFValidationClient alloc] initWithViews:viewsToValidate];
validationClient.delegate = self;

[validationClient startValidationWithIndex:0
                              reverseOrder:NO];
```

Delegate implementation:

```objective-c
- (BOOL)validationClient:(FFValidationClient *)validationClient isViewValid:(UIView *)view errorAttributedText:(NSAttributedString **)errorAttributedText
{
    NSDictionary *attributesForValidationErrorText = {
        NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12.0f],
        NSForegroundColorAttributeName: [UIColor redColor]
    };

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
```

`FFValidationClientDelegate` protocol provides few other methods which you could use to get more information about validation process. But in most cases it's enough to only implement the method above.