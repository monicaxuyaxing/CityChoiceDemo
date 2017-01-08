//
//  ProvinceModel.m
//  CityChoice
//
//  Created by 杨晓亮 on 17/1/4.
//  Copyright © 2017年 OMS. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel

- (NSMutableArray *) citys
{
    if(!_citys)
    {
        _citys = [NSMutableArray array];
    }
    return _citys;
}

@end
