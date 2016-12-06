//
//  BaseViewController.m
//  AppFlash
//
//  Created by 李欢欢 on 2016/12/6.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
