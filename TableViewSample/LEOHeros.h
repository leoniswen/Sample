//
//  LEOHeros.h
//  TableViewSample
//
//  Created by roger on 13-4-14.
//
//

#import <Foundation/Foundation.h>

@interface LEOHeros : NSObject
{
    NSString *name;     //英雄名称
    NSString *job;      //英雄副名
    int cPriceGold;     //国服金币价格
    int cPricePoint;    //国服点券价格
    int aPriceGold;     //美服金币价格
    int aPricePoint;    //美服点券价格
    int health;         //生命值
    int damage;         //攻击力
    int Mana;           //魔法值
    int moveSpeed;
}

@end
