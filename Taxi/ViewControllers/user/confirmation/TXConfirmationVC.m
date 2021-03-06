//
//  TXConfirmationVC.m
//  Taxi
//
//  Created by Irakli Vashakidze on 6/8/14.
//  Copyright (c) 2014 99S. All rights reserved.
//

#import "TXConfirmationVC.h"
#import "TXMapVC.h"
#import "TXAskPhoneNumberVC.h"

@interface TXConfirmationVC () {
    int userId;
}

-(IBAction)submit:(id)sender;
-(IBAction)resend:(id)sender;

@end

@implementation TXConfirmationVC

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    
    return self;
}

-(void)configure {
    [super configure];
    self->userId = [[[[self->model getApp] getSettings] getUserId] intValue];
    [self->model addEventListener:self forEvent:TXEvents.CONFIRM eventParams:nil];
}

-(void)submit:(id)sender {

    id code_ = self.txtCodeInput.text;
    if([code_ length] > 0) {
        [self showBusyIndicator];
        [self->model confirm:self->userId code:[code_ intValue]];
    }
}

-(void)resend:(id)sender {
    TXAskPhoneNumberVC *viewCtrl = [[TXAskPhoneNumberVC alloc] initWithNibName:@"TXAskPhoneNumberVC" bundle:nil];
    [self pushViewController:viewCtrl];
}

-(void)onEvent:(TXEvent *)event eventParams:(id)subscriptionParams {
 
    [self hideBusyIndicator];
    if([event.name isEqualToString:TXEvents.CONFIRM]) {
        TXResponseDescriptor * descriptor = [event getEventProperty:TXEvents.Params.DESCRIPTOR];
        
        if(descriptor.success == true) {
            
            NSDictionary*source = (NSDictionary*)descriptor.source;
            [[[self->model getApp] getSettings] setUserToken:[source objectForKey:SettingsConst.CryptoKeys.USERTOKEN]];
            
            TXMapVC* mainVC = [[TXMapVC alloc] initWithNibName:@"TXMapVC" bundle:nil];
            [self pushViewController:mainVC];
            
        } else {
            
            [self alertError:@"Error" message:@"Failed to confirm user !"];
            
        }
    }
    
}

@end
