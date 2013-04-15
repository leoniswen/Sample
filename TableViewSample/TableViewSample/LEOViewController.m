//
//  LEOViewController.m
//  TableViewSample
//
//  Created by roger on 13-4-14.
//
//

#import "LEOViewController.h"

@interface LEOViewController ()

@end

@implementation LEOViewController

@synthesize listData = _listData;
@synthesize listImage = _listImage;
@synthesize tableView = _tableView;
@synthesize tableViewCell = _tableViewCell;

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 实例化表格
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                                  style:UITableViewStyleGrouped];
    // 设置键盘托管
    self.tableView.delegate = self;
    // 设置表格数据源
    self.tableView.dataSource = self;
    // 添加子视图-tableView
    [self.view addSubview:self.tableView];
    // 创建数据源
    NSArray *array = [NSArray arrayWithObjects:@"赵信", @"阿木木", @"贾克斯", @"努努", @"阿卡利", nil];
    NSArray *arrayImage = [NSArray arrayWithObjects:@"zx.jpg", @"amm.jpg", @"jxs.jpg", @"nn.jpg",
                                                    @"akl.jpg", nil];
    self.listData = array;
    self.listImage = arrayImage;
}

#pragma mark - UITableView

// 返回表格section，也就是多少列
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 返回数据源中数组数量，也就是多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

#pragma mark - UITableViewCell

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        // cell如果没有了，那么就创建一个新的cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:kCellIdentifier];
    }else {
        // cell如果不需要，那么就从主视图中移除，释放内存
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    NSUInteger row = [indexPath row];

    UIImage *image = [UIImage imageNamed:[self.listImage objectAtIndex:row]];
    cell.imageView.image = image;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    cell.textLabel.text = [self.listData objectAtIndex:row];
    cell.detailTextLabel.text = @"查看详细";

    return cell;

}

// 设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

// 设置单元格缩进
- (NSInteger)tableView:(UITableView *)tableView
    indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger row = [indexPath row];
//    if (row % 2 == 0) {
//        return 0;
//    }
    
    return 0;
}

// 选中单元格触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSString *rowValue = [self.listData objectAtIndex:row];
    NSString *msg = [[NSString alloc] initWithFormat:@"你选择了%@", rowValue];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
























































