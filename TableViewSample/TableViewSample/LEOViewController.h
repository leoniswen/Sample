//
//  LEOViewController.h
//  TableViewSample
//
//  Created by roger on 13-4-14.
//
//

#import <UIKit/UIKit.h>

@interface LEOViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *listData;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITableViewCell *tableViewCell;

@end
