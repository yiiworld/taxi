//
//  TXAskPhoneNumberVC.m
//  Taxi
//
//  Created by Irakli Vashakidze on 4/9/14.
//  Copyright (c) 2014 99S. All rights reserved.
//

#import "TXAskPhoneNumberVC.h"
#import "TXAskUserInfoVC.h"
#import "TXConfirmationVC.h"
#import "TXUserModel.h"

@implementation CountryCodeItem
@synthesize name, code, image;
@end

@interface TXAskPhoneNumberVC () {
    NSMutableArray *items;
    CountryCodeItem *selectedItem;
}

-(IBAction)next:(id)sender;

@end

@implementation TXAskPhoneNumberVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self->items = [NSMutableArray arrayWithCapacity:3];
    
    CountryCodeItem *item = [[CountryCodeItem alloc] init];
    item.name = @"Georgia";
    item.code = @"995";
    [self->items addObject:item];
    
    item = [[CountryCodeItem alloc] init];
    item.name = @"Azerbaijan";
    item.code = @"996";
    [self->items addObject:item];
    
    item = [[CountryCodeItem alloc] init];
    item.name = @"Armenia";
    item.code = @"997";
    [self->items addObject:item];
    
    self->selectedItem = self->items[0];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
        return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self->items.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    CountryCodeItem *item = (CountryCodeItem*)self->items[row];
    
    return  [NSString stringWithFormat:@"%@ - %@", item.name, item.code];
}

-(void)next:(id)sender {
    
    if([self.txtPhoneNumber.text length] > 0) {
        
        id userId = [self->parameters objectForKey:API_JSON.OBJID];
        
        if(userId == nil) {
            
            TXUser *user = [[TXUser alloc] init];
            user.username = [self->parameters objectForKey:API_JSON.Authenticate.USERNAME];
            user.password = [self->parameters objectForKey:API_JSON.Authenticate.PASSWORD];
            user.mobile   = self.txtPhoneNumber.text;
            user.language = @"ka";
            
            [self showBusyIndicator];
            [self->model signUp:user];
            
        } else {
            
            [self showBusyIndicator];
            [self->model updateMobile:[userId intValue] mobile:self.txtPhoneNumber.text];
            
        }
    
    }
    
}

-(void) pushConfirmationVC:(TXResponseDescriptor *) descriptor {
    TXConfirmationVC *confirmationVC = [[TXConfirmationVC alloc] initWithNibName:@"TXConfirmationVC" bundle:nil];
    NSDictionary*source = (NSDictionary*)descriptor.source;
    [confirmationVC setParameters:@{ API_JSON.ID : [source objectForKey:API_JSON.ID] }];
    [self pushViewController:confirmationVC];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self->selectedItem = self->items[row];
}

-(void)onEvent:(TXEvent *)event eventParams:(id)subscriptionParams {
    [self hideBusyIndicator];
    TXResponseDescriptor *descriptor = [event getEventProperty:TXEvents.Params.DESCRIPTOR];
    
    if(!descriptor.success) {
    
        
        if([event.name isEqualToString:TXEvents.CREATEUSER]) {
        
            TXConfirmationVC *confirmationVC = [[TXConfirmationVC alloc] initWithNibName:@"TXConfirmationVC" bundle:nil];
            NSDictionary*source = (NSDictionary*)descriptor.source;
            [confirmationVC setParameters:@{ API_JSON.ID : [source objectForKey:API_JSON.ID] }];
            [self pushViewController:confirmationVC];
            
        } else if ([event.name isEqualToString:TXEvents.UPDATEUSERMOBILE]) {
            
        }
        
    } else {
        [self alertError:@"Error" message:@"Mobile number is blocked !"];
    }
}

@end
