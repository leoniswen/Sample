//
//  DBConn.h
//  LoginSample
//
//  Created by roger on 13-8-31.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBConn : NSObject
{
    sqlite3  *_database;
    NSString *_databaseName;
    NSString *_databasePath;
    NSString *_tablename;
    NSMutableDictionary *DATA;
}

@property(nonatomic) sqlite3 *_database;
@property(nonatomic, strong) NSString *_databaseName;
@property(nonatomic, strong) NSString *_databasePath;
@property(nonatomic, strong) NSString *_tablename;
@property(nonatomic, strong) NSMutableDictionary *DATA;

- (BOOL)openWithDataBaseName:(NSString *)databaseName;
- (void)createWithSQL:(NSString *)sql;
- (void)selectWithSQL:(NSString *)sql;
- (void)updateWithSQL:(NSString *)sql nPassWord:(NSString *)nPassword;
- (void)insertWithSQL:(NSString *)sql UserName:(NSString *)username PassWord:(NSString *)password;

@end
