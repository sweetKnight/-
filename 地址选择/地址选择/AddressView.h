//
//  AddressView.h
//  tablebg
//
//  Created by 冯剑锋 on 15/12/2.
//  Copyright © 2015年 冯剑锋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MakeSureButtonClick)(NSString *type);
@interface AddressView : UIView

- (instancetype)init;

@property (nonatomic, copy) NSString *province; // 省份
@property (nonatomic, copy) NSString *city;  // 城市
@property (nonatomic, copy) NSString *area;  // 地区
@property (nonatomic, copy) NSString *provinceId; // 省份Id
@property (nonatomic, copy) NSString *cityId;  // 城市Id
@property (nonatomic, copy) NSString *areaId;  // 地区Id
@property (nonatomic, copy) MakeSureButtonClick block;

- (void)showInView:(UIView *) view;
- (void)cancelPicker;

@end
