//
//  LEOViewController.h
//  TextViewSample
//
//  Created by roger on 13-4-21.
//
//

#import <UIKit/UIKit.h>

@interface LEOViewController : UIViewController<UITextViewDelegate>
{
    UILabel *labelView;
}

@property (nonatomic, strong) UILabel *labelView;

@end
