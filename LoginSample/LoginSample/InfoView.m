//
//  InfoView.m
//  LoginSample
//
//  Created by roger on 13-8-11.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView

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
    
    // 添加一个欢迎消息，添加3个输入框，分别为输入旧密码、新密码和再次输入新密码
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _userName                       = [[UILabel alloc] initWithFrame:CGRectMake(52, 12, 250, 30)];
    _userName.backgroundColor       = [UIColor clearColor];
    _userName.font                  = [UIFont systemFontOfSize:16];
    _userName.text                  = [delegate.userData objectForKey:@"kUserName"];
    
    _passWord                       = [[UITextField alloc] initWithFrame:CGRectMake(52, 12, 250, 30)];
    _passWord.backgroundColor       = [UIColor clearColor];
    _passWord.font                  = [UIFont systemFontOfSize:16];
    _passWord.returnKeyType         = UIReturnKeyDefault;
    _passWord.clearButtonMode       = UITextFieldViewModeWhileEditing;
    _passWord.secureTextEntry       = YES;
    _passWord.placeholder           = @"请输入旧密码";
    _passWord.delegate              = self;
    
    _nPassWord                      = [[UITextField alloc] initWithFrame:CGRectMake(52, 12, 250, 30)];
    _nPassWord.backgroundColor      = [UIColor clearColor];
    _nPassWord.font                 = [UIFont systemFontOfSize:16];
    _nPassWord.returnKeyType        = UIReturnKeyDefault;
    _nPassWord.clearButtonMode      = UITextFieldViewModeWhileEditing;
    _nPassWord.secureTextEntry      = YES;
    _nPassWord.placeholder          = @"请输入新密码";
    _nPassWord.delegate             = self;
    
    _nPassWord2                     = [[UITextField alloc] initWithFrame:CGRectMake(52, 12, 250, 30)];
    _nPassWord2.backgroundColor     = [UIColor clearColor];
    _nPassWord2.font                = [UIFont systemFontOfSize:16];
    _nPassWord2.returnKeyType       = UIReturnKeyDefault;
    _nPassWord2.clearButtonMode     = UITextFieldViewModeWhileEditing;
    _nPassWord2.secureTextEntry     = YES;
    _nPassWord2.placeholder         = @"请再次输入新密码";
    _nPassWord2.delegate            = self;

    // 这里设置数据源，数据源为其上四个控件
    _listArray = [NSArray arrayWithObjects:_userName, _passWord, _nPassWord, _nPassWord2, nil];
    
    // 这里添加图片源，用于在UITextField前显示
    _imageArray = [NSArray arrayWithObjects:
                   @"username.png", @"password.png", @"password.png", @"password.png", nil];
    [_tableView reloadData];
    
    // 添加更新按钮
    _updateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _updateBtn.frame = CGRectMake((frame.size.width - 85) / 2 - 85, 210, 85, 35);
    _updateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_updateBtn setTitle:@"更新" forState:UIControlStateNormal];
    [_updateBtn addTarget:self
                     action:@selector(pressUpdateBtn)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_updateBtn];
    
    // 添加返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _backBtn.frame = CGRectMake((frame.size.width - 85) / 2 + 85, 210, 85, 35);
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn addTarget:self
                 action:@selector(pressBackBtn:)
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
    // 将一个UILable和三个UITextField添加入表格
    [cell addSubview:[_listArray objectAtIndex:row]];
    // 将三个图片加入表格
    UIImage *image = [UIImage imageNamed:[_imageArray objectAtIndex:row]];
    cell.imageView.image = image;
    return cell;
}

#pragma mark pressUpdateBtn
// 点击更新按钮后事件处理
- (void)pressUpdateBtn
{
    CommonFunc *update = [[CommonFunc alloc] init];
    if ([update updateWithUserName:_userName.text
                          PassWord:_passWord.text
                         nPassWord:_nPassWord.text
                        nPassWord2:_nPassWord2.text] == NO) {
        return;
    }
    [self updateUserName:_userName.text nPassWord:_nPassWord.text];
    CommonFunc *alert = [[CommonFunc alloc] init];
    NSString *msg = @"更新成功";
    [alert alertWithMessage:msg];
}

- (void)updateUserName:(NSString *)username nPassWord:(NSString *)nPassword
{
    // 数据库常量
    static NSString *kDataBaseName  = @"database.sqlite3";
    static NSString *kTableName     = @"db_user";
    static NSString *kField01       = @"user_name";
    static NSString *kField02       = @"pass_word";
    static NSString *kMessage       = @"数据库连接失败";
    // 数据库实例
    DBConn *dbconn = [[DBConn alloc] init];
    CommonFunc *alert = [[CommonFunc alloc] init];
    // 数据库连接
    if ([dbconn openWithDataBaseName:kDataBaseName] == NO) {
        [alert alertWithMessage:kMessage];
    }
    // 更新密码语句
    NSString *update = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = '%@'",
                        kTableName, kField02, nPassword, kField01, username];
    [dbconn updateWithSQL:update nPassWord:nPassword];
}

#pragma mark pressBackBtn
// 点击返回按钮后事件处理
- (void)pressBackBtn:(UIButton *)btn
{
    LoginView *viewController = [[LoginView alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
