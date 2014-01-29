//
//  TXModelBase.h
//  Taxi
//
//  Created by Irakli Vashakidze on 1/26/14.
//  Copyright (c) 2014 99S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "taxiLib/TXHttpRequestManager.h"
#import "taxiLib/TXApp.h"

@interface TXModelBase : NSObject <TXHttpRequestListener> {
    TXHttpRequestManager *httpMgr;
    TXApp                *application;
}

-(void)onRequestCompleted:(id)object;
-(void)onFail:(id)object error:(TXError *)error;

@end