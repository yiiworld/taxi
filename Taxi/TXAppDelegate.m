//
//  TXAppDelegate.m
//  Taxi
//
//  Created by Irakli Vashakidze on 1/19/14.
//  Copyright (c) 2014 99S. All rights reserved.
//

#import "TXAppDelegate.h"
#import "TXHttpRequestManager.h"
#import "utils.h"
#import "TXUserModel.h"
#import "TXFileManager.h"
#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GooglePlus.h>
#import "MenuViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "TXCode2MsgTranslator.h"
#import "TXApp.h"
#import "TXSignInVC.h"
#import "NSData+StringBytes.h"
#import "TXMapVC.h"
#import "TXUserModel.h"
#import "TXApp.h"
#import "SVProgressHUD.h"
#import "TXMainVC.h"

@implementation TXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self registerForRemoteNotifications:application];
    [GMSServices provideAPIKey:@"AIzaSyA-mIDdBQDMjxoQ59UOpYnyqa0ogk9m7-M"];
    TXSettings  *settings  = [[TXApp instance] getSettings];
    TXBaseViewController    *firstVC   = nil;
    
    NSString *userToken = [settings getUserToken];
    if(![userToken isEqual:[NSNull null]] && [userToken length] > 0) {
        
        firstVC = [[TXMainVC alloc] initWithToken:userToken];
        
    } else {
        
        firstVC = [[TXSignInVC alloc] initWithNibName:@"TXSignInVC" bundle:nil];
        
    }
    
    self.window.rootViewController = firstVC;
    
    return YES;
}

-(void) registerForRemoteNotifications:(UIApplication *) application {
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
}

#pragma mark - Parse installation

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[[TXApp instance] getSettings] setNotificationsToken:[deviceToken stringRepresentation]];
}


// Gets called when a remote notification is received while app is in the foreground.
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
   // [[PushAppsManager sharedInstance] handlePushMessageOnForeground:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Google oauth callback

- (BOOL)application: (UIApplication *)application openURL: (NSURL *)url sourceApplication: (NSString *)sourceApplication annotation: (id)annotation
{
    return [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(void) registerListeners {
    
}

-(void)onEvent:(TXEvent *)event eventParams:(id)subscriptionParams {
    
    TXResponseDescriptor *descriptor = [event getEventProperty:TXEvents.Params.DESCRIPTOR];
    
    if(descriptor.success) {
        
        NSDictionary* source = (NSDictionary*)descriptor.source;
        TXUser *user  = [[TXUser alloc] init];
        [user setProperties:source];
        
        TXBaseViewController *firstVC = [[TXMapVC alloc] initWithNibName:@"TXMapVC" bundle:nil];
        
    } else {
        TXBaseViewController *firstVC = [[TXSignInVC alloc] initWithNibName:@"TXSignInVC" bundle:nil];
    }
    
}

-(void) onTokenValidateSucceeded:(TXEvent *) event {
    
}

-(void) onTokenValidateFailed:(TXEvent *) event {
    
}

@end
