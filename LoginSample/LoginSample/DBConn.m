//
//  DBConn.m
//  LoginSample
//
//  Created by roger on 13-8-31.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import "DBConn.h"

@implementation DBConn

@synthesize _database, _databaseName, _databasePath, _tablename, DATA;

- (BOOL)openWithDataBaseName:(NSString *)databaseName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documents = [paths objectAtIndex:0];
    _databaseName = databaseName;
    _databasePath = [documents stringByAppendingPathComponent:_databaseName];

    if (sqlite3_open([_databasePath UTF8String], &_database) != SQLITE_OK) {
        return NO;
    }
    
    return YES;
}

- (void)createWithSQL:(NSString *)sql
{
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK) {
        if (stmt) {
            sqlite3_finalize(stmt);
        }
        sqlite3_close(_database);
    }
    
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        sqlite3_finalize(stmt);
        sqlite3_close(_database);
    }
}

- (void)selectWithSQL:(NSString *)sql
{
    sqlite3_stmt    *stmt;
    NSString        *result;
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            result = [[NSString alloc]
                                initWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
        }
    }
    if (!result) {
        result = @"";
    }
    DATA = [[NSMutableDictionary alloc] initWithCapacity:1];
    [DATA setObject:result forKey:@"result"];
}

- (void)updateWithSQL:(NSString *)sql nPassWord:(NSString *)nPassword
{
    sqlite3_stmt    *stmt;
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_text(stmt, 2, [nPassword UTF8String], -1, NULL);
    }
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        NSLog(@"更新数据失败");
    }
    sqlite3_finalize(stmt);
    sqlite3_close(_database);
}

- (void)insertWithSQL:(NSString *)sql UserName:(NSString *)username PassWord:(NSString *)password
{
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [username UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [password UTF8String], -1, NULL);
    }
    if (sqlite3_step(stmt) != SQLITE_DONE) {
        NSLog(@"插入数据失败");
    }
    sqlite3_finalize(stmt);
    sqlite3_close(_database);
}

@end
