//
//  TXGoogleAPIReqManager.h
//  taxiLib
//
//  Created by Irakli Vashakidze on 3/19/14.
//  Copyright (c) 2014 99S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXHttpRequestManager.h"

@interface TXGoogleAPIReqManager : NSObject

-(id)initWithListener:(id<TXHttpRequestListener>) listener_;
-(BOOL) sendPlaceNearbySearchRequest:(NSString *) location radius:(NSString *)radius sensor:(BOOL) sensor rankBy:(NSString *)rankBy optional:(NSString *) parameters;
-(BOOL) sendPlaceTextSearchRequest:(NSString *) query sensor:(BOOL) sensor optional:(NSString *) parameters;
-(BOOL) sendPlaceAutocompleteRequest:(NSString *) input sensor:(BOOL) sensor optional:(NSString *) parameters;
-(BOOL) sendPlaceRadarSearchRequest:(NSString *) location radius:(NSString *)radius sensor:(BOOL) sensor optional:(NSString *) parameters;

@end