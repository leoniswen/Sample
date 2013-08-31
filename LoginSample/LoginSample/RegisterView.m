//
//  LEORegisterViewController.m
//  LoginSample
//
//  Created by roger on 13-8-10.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 隐藏导航栏
    [self.navigationController.navigationBar setHidden:YES];
    
    // 设置背景色为白色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 获得屏幕全屏下宽高
    CGRect frame = [self.view bounds];
    
    // 获得项目路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    _dbpath = [documents stringByAppendingPathComponent:@"database.sqlite3"];
    
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
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, 10)];
    [_tableView setTableHeaderView:headerView];
    [self.view addSubview:_tableView];
    
    // 添加三个UITextField，分别用于输入用户名和密码
    _userName = [[UITextField alloc] initWithFrame:CGRectMake(52, 12, 250, 30)];
    _userName.backgroundColor = [UIColor clearColor];
    _userName.font = [UIFont systemFontOfSize:16];
    _userName.returnKeyType = UIReturnKeyDone;
    _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userName.autocapitalizationType = NO;
    _userName.placeholder = @"请输入账号";
    _userName.delegate = self;
    
    _passWord = [[UITextField alloc] initWithFrame:CGRectMake(52, 12, 250, 30)];
    _passWord.backgroundColor = [UIColor clearColor];
    _passWord.font = [UIFont systemFontOfSize:16];
    _passWord.returnKeyType = UIReturnKeyDone;
    _passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 密码输入时以黑色圆点显示
    _passWord.secureTextEntry = YES;
    _passWord.placeholder = @"请输入密码";
    _passWord.delegate = self;
    
    _passWord2 = [[UITextField alloc] initWithFrame:CGRectMake(52, 12, 250, 30)];
    _passWord2.backgroundColor = [UIColor clearColor];
    _passWord2.font = [UIFont systemFontOfSize:16];
    _passWord2.returnKeyType = UIReturnKeyDone;
    _passWord2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passWord2.secureTextEntry = YES;
    _passWord2.placeholder = @"再次输入密码";
    _passWord2.delegate = self;
    
    // 设置数据源，数据源为其上三个UITextField
    _listArray = [NSArray arrayWithObjects:_userName, _passWord, _passWord2, nil];
    
    // 添加图片源，用于在UITextField前显示
    _imageArray = [NSArray arrayWithObjects:@"username.png", @"password.png", @"password.png", nil];
    
    // 添加注册按钮
    _registerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _registerBtn.frame = CGRectMake((frame.size.width - 85) / 2 - 85, 180, 85, 35);
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn addTarget:self
                     action:@selector(pressRegisterBtn)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    // 添加返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _backBtn.frame = CGRectMake((frame.size.width - 85) / 2 + 85, 180, 85, 35);
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn addTarget:self
                 action:@selector(pressBackBtn)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
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
    // 向Cell中加入输入框和图片
    NSUInteger row = [indexPath row];
    [cell addSubview:[_listArray objectAtIndex:row]];
    UIImage *image = [UIImage imageNamed:[_imageArray objectAtIndex:row]];
    cell.imageView.image = image;
    return cell;
}

#pragma mark pressRegisterBtn
// 点击注册按钮后的事件处理
- (void)pressRegisterBtn
{
    CommonFunc *check = [[CommonFunc alloc] init];
    if ([check checkWithUserName:_userName.text
                        PassWord:_passWord.text
                       PassWord2:_passWord2.text] == NO) {
        return;
    }
    [self insertUserName:_userName.text PassWord:_passWord.text];
    
    CommonFunc *alert = [[CommonFunc alloc] init];
    NSString *msg = @"注册成功";
    [alert alertWithMessage:msg];
}

#pragma mark updateWithUserName
// 新账号写入数据库
- (void)insertUserName:(NSString *)username PassWord:(NSString *)password
{
    static NSString *kDataBaseName  = @"database.sqlite3";
    static NSString *kTableName     = @"db_user";
    static NSString *kField01       = @"user_name";
    static NSString *kField02       = @"pass_word";
    static NSString *kMessage       = @"数据库连接失败";
    
    DBConn *dbconn = [[DBConn alloc] init];
    CommonFunc *alert = [[CommonFunc alloc] init];
    
    if ([dbconn openWithDataBaseName:kDataBaseName] == NO) {
        [alert alertWithMessage:kMessage];
    }
    
    NSString *insert = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@) VALUES ('%@', '%@')",
                       kTableName, kField01, kField02, username, password];
    [dbconn insertWithSQL:insert UserName:username PassWord:password];
}

#pragma mark pressBackBtn
// 点击返回按钮后事件处理
- (void)pressBackBtn
{
    LoginView *viewController = [[LoginView alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
