//
//  AddressView.h
//  tablebg
//
//  Created by 冯剑锋 on 15/12/2.
//  Copyright © 2015年 冯剑锋. All rights reserved.
//

#import "AddressView.h"
//#import "Config.h"

@interface AddressView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *provinces;
@property (nonatomic, strong) NSMutableArray *cityArray;    // 城市数据
@property (nonatomic, strong) NSMutableArray *areaArray;    // 区信息
@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation AddressView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230);
        
        UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        [self addSubview:headView];
        
        UIButton * makeSureButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 0, 80, 30)];
        [makeSureButton setTitle:@"确定" forState:UIControlStateNormal];
        [makeSureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [makeSureButton addTarget:self action:@selector(makeSureButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:makeSureButton];
        
        UIButton * cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:cancelButton];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 200)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sweetArr" ofType:@"plist"];
        NSArray *provinceArray = [[NSArray alloc] initWithContentsOfFile:path];
        
        self.provinces = [provinceArray mutableCopy];
        self.cityArray = [[[self.provinces firstObject] objectForKey:@"cities"] mutableCopy];
        self.areaArray = [[[self.cityArray firstObject] objectForKey:@"areas"] mutableCopy];
        [self addSubview:_pickerView];
        
        self.province = self.provinces[0][@"divisionName"];
        self.city = self.cityArray[0][@"divisionName"];
        self.provinceId = self.provinces[0][@"id"];
        
        if (self.areaArray.count != 0) {
            self.area = self.areaArray[0][@"divisionName"];
            self.cityId = self.cityArray[0][@"id"];
            self.areaId = self.areaArray[0][@"id"];
        }else{
            self.area = @"";
        }
    }
    return self;
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinces.count;
    }else if (component == 1) {
        return self.cityArray.count;
    }else{
        return self.areaArray.count;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sweetArr" ofType:@"plist"];
    NSArray *provinceArray = [[NSArray alloc] initWithContentsOfFile:path];
    if (component == 0) {
        self.selectedArray = [provinceArray[row][@"cities"] mutableCopy];
        [self.cityArray removeAllObjects];
        self.cityArray = self.selectedArray;
        self.areaArray = [NSMutableArray arrayWithArray:[self.selectedArray firstObject][@"areas"]];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else if (component == 1) {
        if (self.selectedArray.count == 0) {
            self.selectedArray = [provinceArray firstObject][@"cities"];
        }
        self.areaArray = [NSMutableArray arrayWithArray:[self.selectedArray objectAtIndex:row][@"areas"]];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }else{
    }
    NSInteger index = [_pickerView selectedRowInComponent:0];
    NSInteger index1 = [_pickerView selectedRowInComponent:1];
    NSInteger index2 = [_pickerView selectedRowInComponent:2];
    self.province = self.provinces[index][@"divisionName"];
    self.city = self.cityArray[index1][@"divisionName"];
    self.provinceId = self.provinces[index][@"id"];
    self.cityId = self.cityArray[index1][@"id"];
    if (self.areaArray.count != 0) {
        self.area = self.areaArray[index2][@"divisionName"];
        self.areaId = self.areaArray[index2][@"id"];
    }else{
        self.area = @"";
    }
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinces[row][@"divisionName"];
    }else if (component == 1){
        return self.cityArray[row][@"divisionName"];
    }else{
        if (self.areaArray.count != 0) {
            return self.areaArray[row][@"divisionName"];
        }else{
            return nil;
        }
    }
}

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}

- (NSMutableArray *)provinces{
    if (!_provinces) {
        self.provinces = [@[] mutableCopy];
    }
    return _provinces;
}

- (NSMutableArray *)cityArray{
    if (!_cityArray) {
        self.cityArray = [@[] mutableCopy];
    }
    return _cityArray;
}
- (NSMutableArray *)areaArray{
    if (!_areaArray) {
        self.areaArray = [@[] mutableCopy];
    }
    return _areaArray;
}
- (NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        self.selectedArray = [@[] mutableCopy];
    }
    return _selectedArray;
}

#pragma mark - buttonClick
-(void)makeSureButtonClick{
    if (self.block) {
        self.block(@"确认");
    }
    [self cancelPicker];
}

-(void)cancelButtonClick{
    if (self.block) {
        self.block(@"取消");
    }
    [self cancelPicker];
}

@end
