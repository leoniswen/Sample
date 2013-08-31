//
//  LEOViewController.h
//  LoginSample
//
//  Created by roger on 13-7-31.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

#import "AppDelegate.h"
#import "CommonFunc.h"
#import "RegisterView.h"
#import "InfoView.h"
#import "DBConn.h"

@interface LoginView : UIViewController<UITableViewDataSource, UITableViewDelegate,
UITextFieldDelegate>
{
    UITableView *_tableView;
    UITextField *_userName;
    UITextField *_passWord;
    UIButton    *_signInBtn;
    UIButton    *_registerBtn;
    NSArray     *_listArray;
    NSArray     *_imageArray;
    sqlite3     *_dbconn;
    NSString    *_dbpath;
}



@end
