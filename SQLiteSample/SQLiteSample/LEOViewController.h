//
//  LEOViewController.h
//  SQLiteSample
//
//  Created by roger on 13-8-5.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface LEOViewController : UIViewController
{
    sqlite3 *db;
}

@end
