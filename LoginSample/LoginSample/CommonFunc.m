//
//  RuleCheck.m
//  LoginSample
//
//  Created by roger on 13-8-31.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import "CommonFunc.h"

@implementation CommonFunc

- (void)alertWithMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles: nil];
    [alert show];
}

// 账号是否符合规则
- (BOOL)regexUserName:(NSString *)username
{
    if (username == nil) {
        username = @"";
    }
    NSError *err;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^([a-zA-Z])([a-zA-Z0-9_]{2,9})$"
                                  options:0
                                  error:&err];
    NSUInteger match = [regex numberOfMatchesInString:username
                                              options:NSMatchingReportProgress
                                                range:NSMakeRange(0, username.length)];
    if (match == 0) {
        return NO;
    }
    return YES;
}

// 密码是否符合规则
- (BOOL)regexPassWord:(NSString *)password
{
    if (password == nil) {
        password = @"";
    }
    NSError *err;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^([a-zA-Z])([a-zA-Z0-9]{6,})$"
                                  options:0
                                  error:&err];
    NSUInteger match = [regex numberOfMatchesInString:password
                                              options:NSMatchingReportProgress
                                                range:NSMakeRange(0, password.length)];
    if (match == 0) {
        return NO;
    }
    return YES;
}

// 账号是否存在
- (BOOL)isExistUserName:(NSString *)username
{
    static NSString *kDataBaseName  = @"database.sqlite3";
    static NSString *kTableName     = @"db_user";
    static NSString *kField01       = @"user_name";
    static NSString *kMessage       = @"数据库连接失败";
    DBConn  *dbconn = [[DBConn alloc] init];
    CommonFunc *alert  = [[CommonFunc alloc] init];
    if ([dbconn openWithDataBaseName:kDataBaseName] == NO) {
        [alert alertWithMessage:kMessage];
    }
    NSString *select = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@ = '%@'",
                        kField01, kTableName, kField01, username];
    [dbconn selectWithSQL:select];
    if (![username isEqualToString:[dbconn.DATA objectForKey:@"result"]]){
        return NO;
    }
    return YES;
}

// 密码是否正确
- (BOOL)isCorrectUserName:(NSString *)username
                 PassWord:(NSString *)password
{
    static NSString *kDataBaseName  = @"database.sqlite3";
    static NSString *kTableName     = @"db_user";
    static NSString *kField01       = @"user_name";
    static NSString *kField02       = @"pass_word";
    static NSString *kMessage       = @"数据库连接失败";
    DBConn  *dbconn = [[DBConn alloc] init];
    CommonFunc *alert  = [[CommonFunc alloc] init];
    if ([dbconn openWithDataBaseName:kDataBaseName] == NO) {
        [alert alertWithMessage:kMessage];
    }
    NSString *select = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@ = '%@'",
                        kField02, kTableName, kField01, username];
    [dbconn selectWithSQL:select];
    if (![password isEqualToString:[dbconn.DATA objectForKey:@"result"]]){
        return NO;
    }
    return YES;
}

- (BOOL)checkWithUserName:(NSString *)username PassWord:(NSString *)password
{
    NSString *msg;
    if (username.length == 0) {
        msg = @"账号不能为空";
        [self alertWithMessage:msg];
        return NO;
    }
    if (password.length == 0) {
        msg = @"密码不能为空";
        [self alertWithMessage:msg];
        return NO;
    }
    if ([self regexUserName:username] == NO) {
        msg = @"账号不符合规则";
        [self alertWithMessage:msg];
        return NO;
    }
    if ([self regexPassWord:password] == NO) {
        msg = @"密码不符合规则";
        [self alertWithMessage:msg];
        return NO;
    }
    if ([self isExistUserName:username] == NO) {
        msg = @"账号不存在";
        [self alertWithMessage:msg];
        return NO;
    }
    if ([self isCorrectUserName:username PassWord:password] == NO) {
        msg = @"密码不正确";
        [self alertWithMessage:msg];
        return NO;
    }
    return YES;
}

- (BOOL)checkWithUserName:(NSString *)username
                 PassWord:(NSString *)password
                PassWord2:(NSString *)password2
{
    NSString *msg;
    if (username.length == 0) {
        msg = @"账号不能为空";
        [self alertWithMessage:msg];
        return NO;
    }
    if (password.length == 0) {
        msg = @"密码不能为空";
        [self alertWithMessage:msg];
        return NO;
    }
    if ([self regexUserName:username] == NO) {
        msg = @"账号不符合规则";
        [self alertWithMessage:msg];
        return NO;
    }
    if ([self regexPassWord:password] == NO) {
        msg = @"密码不符合规则";
        [self alertWithMessage:msg];
        return NO;
    }
    if (![password isEqualToString:password2]) {
        msg = @"两次输入的密码不相同";
        [self alertWithMessage:msg];
        return NO;
    }
    if ([self isExistUserName:username] == YES) {
        msg = @"账号已存在";
        [self alertWithMessage:msg];
        return NO;
    }
    return YES;
}

- (BOOL)updateWithUserName:(NSString *)username
                  PassWord:(NSString *)password
                 nPassWord:(NSString *)nPassword
                nPassWord2:(NSString *)nPassword2
{
    NSString *msg;
    if (password.length == 0) {
        msg = @"密码不能为空";
        [self alertWithMessage:msg];
        return NO;
    }
    if (nPassword.length == 0) {
        msg = @"新密码不能为空";
        [self alertWithMessage:msg];
        return NO;
    }
    if ([self regexPassWord:nPassword] == NO) {
        msg = @"新密码不符合规则";
        [self alertWithMessage:msg];
        return NO;
    }
    if (![nPassword isEqualToString:nPassword2]) {
        msg = @"两次输入的密码不相同";
        [self alertWithMessage:msg];
        return NO;
    }
    if ([self isCorrectUserName:username PassWord:password] == NO) {
        msg = @"原密码错误";
        [self alertWithMessage:msg];
        return NO;
    }
    return YES;
}

@end
































