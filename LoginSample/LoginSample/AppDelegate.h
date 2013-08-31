//
//  LEOAppDelegate.h
//  LoginSample
//
//  Created by roger on 13-7-31.
//  Copyright (c) 2013年 roger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableDictionary *userData;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginView *viewController;

@property (strong, nonatomic) NSMutableDictionary *userData;


@end
