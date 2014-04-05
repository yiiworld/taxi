//
//  TXSignInVC.m
//  Taxi
//
//  Created by Irakli Vashakidze on 4/2/14.
//  Copyright (c) 2014 99S. All rights reserved.
//

#import "TXSignInVC.h"
#import "SlideNavigationController.h"

@interface TXSignInVC ()<GPPSignInDelegate>

@end

@implementation TXSignInVC

- (void)viewDidLoad
{
    self.view.userInteractionEnabled = TRUE;
    [super viewDidLoad];
    self.sharedObj.signIn.delegate = self;
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error {

    NSLog(@"%@", auth);
    
    if(error==nil) {
        
        GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
        plusService.retryEnabled = YES;
        [plusService setAuthorizer:self.sharedObj.signIn.authentication];
        
        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
        
        [plusService executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLPlusPerson *person, NSError *error) {
            
            if (error) {
            
                GTMLoggerError(@"Error: %@", error);
                
                
            } else {
            
                [self.sharedObj.settings setGoogleUserId:person.identifier];
                
            }
        }];
        
        
    } else {
        
        NSString *msg = [NSString stringWithFormat:@"Error: %@\nReason: %@\n%@", [error localizedDescription], [error localizedFailureReason], [error localizedRecoverySuggestion]];
        
        [self alertError:[error localizedDescription] message:msg];
    }
    
    [self refreshInterfaceBasedOnSignIn];
    
}

-(void)refreshInterfaceBasedOnSignIn {
   
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        self.googleSignInButton.hidden = YES;
        [self pushViewController:[[[TXSharedObj instance] currentStoryBoard] instantiateViewControllerWithIdentifier:NSStringFromClass([SlideNavigationController class])]];
        
    } else {
        self.googleSignInButton.hidden = NO;
        // Perform other actions here
    }
}

@end
