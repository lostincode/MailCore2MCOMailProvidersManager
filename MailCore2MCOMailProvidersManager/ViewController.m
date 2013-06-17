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
- (IBAction)sendMailAction:(id)sender {

    MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc] init];
    smtpSession.hostname = @"";
    smtpSession.port = 587;
    smtpSession.username = @"";
    smtpSession.password = @"";
    smtpSession.authType = (MCOAuthTypeSASLPlain | MCOAuthTypeSASLLogin);
    smtpSession.connectionType = MCOConnectionTypeClear;
    
    //build the message
    MCOMessageBuilder * builder = [[MCOMessageBuilder alloc] init];

    //set from
    [[builder header] setFrom:[MCOAddress addressWithDisplayName:@"Test" mailbox:@""]];
    
    //set to: recipients
    [[builder header] setTo:@[[MCOAddress addressWithMailbox:@""]]];
    
    //set subject
    [[builder header] setSubject:@"SUBJECT HERE"];
    
    //crashes if you send @""
    NSString *body = @"This is a test";
    NSString *htmlBody = [NSString stringWithFormat:@"<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\"></head><body>%@</body></html>", body];
    [builder setHTMLBody:htmlBody];
    
    
    NSData * rfc822Data = [builder data];
    MCOSMTPSendOperation *sendOperation = [smtpSession sendOperationWithData:rfc822Data];
    
    //start the operation
    [sendOperation start:^(NSError *error) {
        NSLog(@"error:%@", [error localizedDescription]);
    }];
}


- (IBAction)buttonPressed:(id)sender {
    MCOMailProvider *accountProvider = [[MCOMailProvidersManager sharedManager] providerForEmail:self.emailTextField.text];
    NSArray *smtpServicesArray = accountProvider.smtpServices;
    NSLog(@"smtpServicesArray:%@",smtpServicesArray);
}


@end
