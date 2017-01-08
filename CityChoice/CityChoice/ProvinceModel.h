//
//  ProvinceModel.h
//  CityChoice
//
//  Created by 杨晓亮 on 17/1/4.
//  Copyright © 2017年 OMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject

@property (nonatomic,copy) NSString *pId;
@property (nonatomic,copy) NSString *pName;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,retain) NSMutableArray *citys;

@end
