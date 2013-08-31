//
//  InfoView.h
//  LoginSample
//
//  Created by roger on 13-8-11.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

#import "AppDelegate.h"
#import "CommonFunc.h"
#import "LoginView.h"
#import "DBConn.h"

@interface InfoView : UIViewController<UITableViewDataSource, UITableViewDelegate,
UITextFieldDelegate>
{
    UITableView *_tableView;
    UILabel     *_userName;
    UITextField *_passWord;
    UITextField *_nPassWord;
    UITextField *_nPassWord2;
    UIButton    *_updateBtn;
    UIButton    *_backBtn;
    
    NSArray     *_listArray;
    NSArray     *_imageArray;
    
}

@end
