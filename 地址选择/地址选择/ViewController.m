//
//  ViewController.m
//  地址选择
//
//  Created by 冯剑锋 on 16/7/26.
//  Copyright © 2016年 冯剑锋. All rights reserved.
//

#import "ViewController.h"
#import "AddressView.h"
@interface ViewController ()
@property (nonatomic, strong) AddressView *addressView;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _addressView = [[AddressView alloc]init];
    
    __weak typeof(self) weakSelf = self;
    _addressView.block = ^(NSString *type){
        if ([type isEqualToString:@"确认"]) {
            weakSelf.adressLabel.text = [NSString stringWithFormat:@"%@ id=%@",weakSelf.addressView.city, weakSelf.addressView.cityId];
        }
    };
}

- (IBAction)showAddressPick:(id)sender {
    [_addressView showInView:self.view];
}


@end
