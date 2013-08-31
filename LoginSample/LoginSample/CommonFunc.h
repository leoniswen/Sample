//
//  RuleCheck.h
//  LoginSample
//
//  Created by roger on 13-8-31.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBConn.h"

@interface CommonFunc : NSObject

- (void)alertWithMessage:(NSString *)msg;

- (BOOL)checkWithUserName:(NSString *)username PassWord:(NSString *)password;

- (BOOL)checkWithUserName:(NSString *)username
                 PassWord:(NSString *)password
                PassWord2:(NSString *)password2;

- (BOOL)updateWithUserName:(NSString *)username
                  PassWord:(NSString *)password
                 nPassWord:(NSString *)nPassword
                nPassWord2:(NSString *)nPassword2;

@end
