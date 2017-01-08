//
//  CityModel.h
//  CityChoice
//
//  Created by 杨晓亮 on 17/1/4.
//  Copyright © 2017年 OMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property (nonatomic,copy) NSString *cId;
@property (nonatomic,copy) NSString *cName;
@property (nonatomic,assign) BOOL selected;

@end
