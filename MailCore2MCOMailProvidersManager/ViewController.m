//
//  ViewController.m
//  MailCore2MCOMailProvidersManager
//
//  Created by Bill Richards on 6/1/13.
//  Copyright (c) 2013 companyname. All rights reserved.
//

#import "ViewController.h"
#import <MailCore/mailcore.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)buttonPressed:(id)sender {
    MCOMailProvider *accountProvider = [[MCOMailProvidersManager sharedManager] providerForEmail:self.emailTextField.text];
    NSArray *smtpServicesArray = accountProvider.smtpServices;
    NSLog(@"smtpServicesArray:%@",smtpServicesArray);
}


@end
