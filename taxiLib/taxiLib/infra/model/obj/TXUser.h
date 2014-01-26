//
//  TXUser.h
//  taxiLib
//
//  Created by Irakli Vashakidze on 1/26/14.
//  Copyright (c) 2014 99S. All rights reserved.
//

#import "TXBaseObj.h"

@interface TXUser : TXBaseObj

@property (nonatomic, assign) int       objId;
@property (nonatomic, retain) NSString* username;
@property (nonatomic, retain, getter=getPassword) NSString* password;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* surname;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* mobile;
@property (nonatomic, assign) int       statusId;
@property (nonatomic, retain) NSString* note;
@property (nonatomic, retain) NSDate  * createDate;
@property (nonatomic, retain) NSDate  * modificationDate;
@property (nonatomic, retain) NSString* language;
@property (nonatomic, retain) NSString* photoURL;

@end
