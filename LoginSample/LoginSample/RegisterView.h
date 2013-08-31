//
//  LEORegisterViewController.h
//  LoginSample
//
//  Created by roger on 13-8-10.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

#import "CommonFunc.h"
#import "LoginView.h"

@interface RegisterView : UIViewController<UITableViewDataSource, UITableViewDelegate,
UITextFieldDelegate>
{
    UITableView *_tableView;
    UITextField *_userName;
    UITextField *_passWord;
    UITextField *_passWord2;
    UILabel     *_label;
    UIButton    *_registerBtn;
    UIButton    *_backBtn;
    
    NSArray     *_listArray;
    NSArray     *_imageArray;
    
    sqlite3     *_dbconn;
    NSString    *_dbpath;
}

@end
