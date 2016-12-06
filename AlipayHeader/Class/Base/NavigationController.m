
//
//  NavigationController.m
//  AppFlash
//
//  Created by 李欢欢 on 2016/12/6.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#import "NavigationController.h"
#import "UIColor+PXColors.h"
#import "UIImage+Extension.h"
@interface NavigationController ()

@end

@implementation NavigationController

// 当类第一次被加载的时调用
// 当类第一次被加载的时调用
+ (void)initialize
{
    // 取出导航条item的外观对象(主题对象)
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    // 设置默认状态文字的颜色
    NSMutableDictionary * titleTextAttributes = [NSMutableDictionary dictionary];
    NSMutableDictionary * hightitleTextAttributes = [NSMutableDictionary dictionary];
    titleTextAttributes[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"FFFFFF"];
    titleTextAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    hightitleTextAttributes[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    [item setTitleTextAttributes:hightitleTextAttributes forState:UIControlStateHighlighted];
    
    UINavigationBar * bar = [UINavigationBar appearance];
    bar.titleTextAttributes = titleTextAttributes;
    bar.barTintColor = [UIColor colorWithHexString:@"b7945f"];
    [bar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"b7945f"]] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //屏幕左边缘右划返回功能
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = (id)self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
