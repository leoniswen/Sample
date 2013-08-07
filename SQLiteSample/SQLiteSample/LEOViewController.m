//
//  LEOViewController.m
//  SQLiteSample
//
//  Created by roger on 13-8-5.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import "LEOViewController.h"

#define DBNAME      @"personinfo.sqlite"
#define NAME        @"name"
#define AGE         @"age"
#define ADDRESS     @"address"
#define TABLENAME   @"PERSONINFO"

@interface LEOViewController ()

@end

@implementation LEOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 获取路径打开数据库
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    NSLog(@"%@", database_path);
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(@"数据库打开失败", 0);
    }
    
    // 创建数据库表
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS PERSONINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, address TEXT)";
    [self execSql:sqlCreateTable];
    
    // 插入数据
    NSString *sqlInsert1 = [NSString stringWithFormat:
                            @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                            TABLENAME, NAME, AGE, ADDRESS, @"ZHANGSAN", @"23", @"SHANGHAI"];
    NSString *sqlInsert2 = [NSString stringWithFormat:
                            @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                            TABLENAME, NAME, AGE, ADDRESS, @"LISI", @"29", @"BEIJING"];
    [self execSql:sqlInsert1];
    [self execSql:sqlInsert2];
    
    // 查询数据
    NSString *sqlQuery = @"SELECT * FROM PERSONINFO";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char *)sqlite3_column_text(statement, 1);
            NSString *rsName = [[NSString alloc] initWithUTF8String:name];
            
            int rsAge = sqlite3_column_int(statement, 2);
            
            char *address = (char *)sqlite3_column_text(statement, 3);
            
            NSString *rsAddress = [[NSString alloc] initWithUTF8String:address];
            
            NSLog(@"name:%@ age:%d address:%@", rsName, rsAge, rsAddress);
        }
    }
    
    sqlite3_close(db);
}

- (void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作失败！");
    }
}























































- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
