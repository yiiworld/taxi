//
//  TXRootVC.m
//  Taxi
//
//  Created by Irakli Vashakidze on 3/2/14.
//  Copyright (c) 2014 99S. All rights reserved.
//

#import "TXBaseViewController.h"
#import "TXUserModel.h"
#import "TXSharedObj.h"
#import "SVProgressHUD.h"

@interface TXBaseViewController () {
    UIView *backgroundView;
}

@end

@implementation TXBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.userInteractionEnabled = TRUE;
    [self configure];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configureStyles];
}

-(void) configure {
    
    self->x = self.view.frame.origin.x;
    self->y = self.view.frame.origin.y;
    self->width = self.view.frame.size.width;
    self->height = self.view.frame.size.height;
    
    self->backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultbg.jpg"]];
    //[self.view setBackgroundColor:colorFromRGB(255,229,204,1)];
    self->backgroundView.frame = self.view.bounds;
    [[self view] addSubview:self->backgroundView];
    [[self view] sendSubviewToBack:self->backgroundView];
}

-(UIView *)backroundView {
    return self->backgroundView;
}

-(void) configureStyles {
   
}

/*
 * By default all the view controllers disable auto rotation,
 * if any UI view wants to display UI controls in landscape orientation, view controller must override this function
 */
-(BOOL)shouldAutorotate {
    return NO;
}

/*
 * By default all the view controllers handle touchesBegan to hide keyboard when it is not necessary,
 * If any UI view wants to force keyboard to be displayed permanently, it's controller should override this function
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

- (IBAction)backgroundTouched:(id)sender {
    [self.view endEditing:YES];
}

-(void) pushViewController : (TXBaseViewController *) viewController {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [self.view.layer addAnimation:transition forKey:kCATransition];
    [self presentViewController:viewController animated:YES completion:nil];

}

-(TXBaseViewController *) vcFromName: (NSString *) name {
    return [[TXBaseViewController alloc] initWithNibName:name bundle:nil];
}

-(void) alertError : (NSString *) title message : (NSString *) message {
    
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    
}

-(void) setParameters:(NSDictionary *)params {
    self->parameters = params;
}

-(void) showBusyIndicator {
    [self showBusyIndicator:nil];
}

-(void) showBusyIndicator:(NSString *)title {
     [SVProgressHUD showWithStatus:title maskType:SVProgressHUDMaskTypeNone];
}

-(void)hideBusyIndicator {
    if ([SVProgressHUD isVisible])
        [SVProgressHUD dismiss];
}

/*
 * Subclasses should override this function
 */
-(void)onEvent:(TXEvent *)event eventParams:(id)subscriptionParams{
    NSLog(@"Function onEvent not implemented in TXRootVC !");
}


-(void)refreshInterfaceBasedOnSignIn {
    NSLog(@"Function refreshInterfaceBasedOnSignIn not implemented in TXRootVC !");
}

@end