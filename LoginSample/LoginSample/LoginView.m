//
//  LEOViewController.m
//  LoginSample
//
//  Created by roger on 13-7-31.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import "QuartzCore/QuartzCore.h"

#import "LoginView.h"

@implementation LoginView

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 隐藏导航栏
    [self.navigationController.navigationBar setHidden:YES];
    
    // 设置背景色为白色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 获得屏幕全屏下宽高
    CGRect frame = [self.view bounds];
    
    // 数据库常量
    static NSString *kDataBaseName  = @"database.sqlite3";
    static NSString *kTableName     = @"db_user";
    static NSString *kField01       = @"user_name";
    static NSString *kField02       = @"pass_word";
    static NSString *kMessage       = @"数据库连接失败";
    // 数据库实例
    DBConn  *dbconn = [[DBConn alloc] init];
    CommonFunc *alert  = [[CommonFunc alloc] init];
    // 数据库连接
    if ([dbconn openWithDataBaseName:kDataBaseName] == NO) {
        [alert alertWithMessage:kMessage];
    }
    // 创建表的SQL语句
    NSString *create = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER\
                            PRIMARY KEY AUTOINCREMENT, %@ TEXT, %@ TEXT)",
                        kTableName, kField01, kField02];
    [dbconn createWithSQL:create];
    
    // 添加背景界面
    UIImageView *background = [[UIImageView alloc]
                               initWithImage:[UIImage imageNamed:@"logo.png"]];
    [self.view addSubview:background];
    
    // 添加界面主表格
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                              style:UITableViewStyleGrouped];
    _tableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    // 设置一个空白View，这样就可以设置UITableView的背景色为白色
    UIView *nilView = [[UIView alloc] init];
    [_tableView setBackgroundView:nilView];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    
    // 设置一个空白View，这样就可以通过调整headerView的高度来影响第一行数据的高度
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, 60)];
    [_tableView setTableHeaderView:headerView];
    [self.view addSubview:_tableView];
    
    // 添加账号输入框
    _userName = [[UITextField alloc] initWithFrame:CGRectMake(52, 12, 250, 30)];
    _userName.backgroundColor = [UIColor clearColor];
    _userName.font = [UIFont systemFontOfSize:16];
    _userName.returnKeyType = UIReturnKeyDone;
    _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userName.autocapitalizationType = NO;
    _userName.placeholder = @"请输入账号";
    _userName.delegate = self;
    
    // 添加密码输入框
    _passWord = [[UITextField alloc] initWithFrame:CGRectMake(52, 12, 250, 30)];
    _passWord.backgroundColor = [UIColor clearColor];
    _passWord.font = [UIFont systemFontOfSize:16];
    _passWord.returnKeyType = UIReturnKeyDone;
    _passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 密码输入时以黑色圆点显示
    _passWord.secureTextEntry = YES;
    _passWord.placeholder = @"请输入密码";
    _passWord.delegate = self;
    
    // 这里设置数据源，数据源为其上两个UITextField
    _listArray = [NSArray arrayWithObjects:_userName, _passWord, nil];
    
    // 这里添加图片源，用于在UITextField前显示
    _imageArray = [NSArray arrayWithObjects:@"username.png", @"password.png", nil];
    
    // 添加登录按钮
    _signInBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _signInBtn.frame = CGRectMake((frame.size.width - 85) / 2 - 85, 180, 85, 35);
    _signInBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_signInBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_signInBtn addTarget:self
                   action:@selector(pressSignInBtn)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_signInBtn];

    // 添加注册按钮
    _registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _registerBtn.frame = CGRectMake((frame.size.width - 85) / 2 + 85, 180, 85, 35);
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn addTarget:self
                     action:@selector(pressRegisterBtn)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
}

#pragma mark UITableViewDelegate
// UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 设置UITableView的列数
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 设置UITableView的行数为数据源的记录数
    return [_listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kCellIdentifier];
    }else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType  = UITableViewCellAccessoryNone;
    NSUInteger row = [indexPath row];
    
    // 将两个UITextField添加入UITableView
    [cell addSubview:[_listArray objectAtIndex:row]];
    // 将两个图片添加入UITableView
    UIImage *image = [UIImage imageNamed:[_imageArray objectAtIndex:row]];
    cell.imageView.image = image;
    return cell;
}

#pragma mark UITextFieldDelegate
// UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_userName resignFirstResponder];
    [_passWord resignFirstResponder];
    return YES;
}

#pragma mark pressSignInBtn
// 点击登录按钮后的事件处理
- (IBAction)pressSignInBtn
{
    CommonFunc *check = [[CommonFunc alloc] init];
    if ([check checkWithUserName:_userName.text PassWord:_passWord.text] == NO) {
        return;
    }
    
    // 所有验证通过，将登录的账号存入delegate.userData，以便InfoView读取
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.userData setObject:_userName.text forKey:@"kUserName"];
    InfoView *viewController = [[InfoView alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark pressRegisterBtn
// 点击注册按钮后的事件处理
- (void)pressRegisterBtn
{
    RegisterView *viewController = [[RegisterView alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end















