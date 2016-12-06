//
//  RootViewController.m
//  APPFlash
//
//  Created by 李欢欢 on 2016/12/5.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#import "RootViewController.h"
#import "NavigationController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "TabBarItemView.h"
#import "UIView+Extension.h"
#import "UIColor+PXColors.h"
@interface RootViewController ()<UITabBarControllerDelegate>
{
    UIView *_tabBarView;//tabBar的背景视图
    UIImageView *_selectedView;//选中后图片
    TabBarItemView *_lastItemView;//ItemView的最后一个传进来的视图
}
@property (nonatomic, strong) TabBarItemView *lastItemView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _creatViewControllers];//加载三级控制器
    [self _creatTabBar];//加载TabBar
    self.delegate = self;
    
}

#pragma mark - Private Methods
- (void)_creatViewControllers {
    
    //隐藏TabBar上方的黑线
    [self.tabBar setBackgroundImage:[self imageWithColor:[UIColor clearColor]]];
    [self.tabBar setShadowImage:[self imageWithColor:[UIColor clearColor]]];
    //隐藏navigationBar下方的黑线
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.alpha = 1;
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0.984 green:0.663 blue:0.153 alpha:1.000]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor colorWithRed:0.984 green:0.663 blue:0.153 alpha:1.000]]];
    
    // 创建三级控制器
    OneViewController *OneViewVC = [[OneViewController alloc]init];
    TwoViewController *TwoViewVC = [[TwoViewController alloc]init];
    ThreeViewController *ThreeViewVC = [[ThreeViewController alloc]init];
    NSArray *VCArray = @[OneViewVC,TwoViewVC,ThreeViewVC];
    NSMutableArray *viewCtrls = [[NSMutableArray alloc]initWithCapacity:VCArray.count];
    
    for (UIViewController *viewCtrl in VCArray) {
        NavigationController *naviCtrl = [[NavigationController alloc]initWithRootViewController:viewCtrl];
        
        [viewCtrls addObject:naviCtrl];
    }
    self.viewControllers = viewCtrls;
}

- (void)_creatTabBar {
    
    _tabBarView = [[UIView alloc]initWithFrame:self.tabBar.bounds];
    _tabBarView.backgroundColor = [UIColor colorWithHexString:@"b7945f"];

    _tabBarView.userInteractionEnabled = YES;//触摸能有反应
    [self.tabBar addSubview:_tabBarView];
    CGFloat width = [UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
    
    //    计算Item宽度
    CGFloat itemWidth = width / 3;
    _tabBarView.width = width;
    
    NSArray *imgs = @[@"icon_home",@"icon_exchange",@"icon_settings"];
    NSArray *selectImgs = @[@"icon_home_pressed",@"icon_exchange_pressed",@"icon_settings_pressed"];
    NSArray *titles = @[@"首页",@"朋友",@"我的"];
    for (NSInteger i  = 0; i < 3; i++) {
        TabBarItemView *itemView = [[TabBarItemView alloc]initWithFrame:CGRectMake(i * itemWidth, 0.f,itemWidth , 49)];
        itemView.tag = 100 + i;
        [itemView setItemImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
        [itemView setItemImage:[UIImage imageNamed:selectImgs[i]] forState:UIControlStateSelected];
        [itemView setItemTitle:titles[i]];
        
        if (i == 0) {
            [itemView setItemSelected:YES];
            _lastItemView = itemView;
        }
        
        //重新布局，调整图片上下间距
        [itemView setNeedsLayout];
        
        __weak TabBarItemView *thisItemView = itemView;
        [itemView setBlock:^(TabBarItemView *sender){
            // 如果两次都选中同一个，不做任何事情
            if (_lastItemView != thisItemView) {
                
                // 取消上一次的选中状态
                [_lastItemView setItemSelected:NO];
                
                // 让当前按钮成为选中状态
                [thisItemView setItemSelected:YES];
                
                // 设置itemView
                _lastItemView = thisItemView;
                
                // 选取视图控制器
                self.selectedIndex = thisItemView.tag - 100;
            }
        }];
        [_tabBarView addSubview:itemView];
    }
    
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake( 0.0f, 0.0f, size.width, size.height );
    
    UIGraphicsBeginImageContext( rect.size );
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage * result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSLog(@"%@",viewController);
    NSLog(@"%ld",self.selectedIndex);
    return YES;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    for (UIView *subView in self.tabBar.subviews)
    {
        Class class = NSClassFromString(@"UITabBarButton");
        
        if ([subView isMemberOfClass:class])
        {
            [subView removeFromSuperview];
        }
    }
}

@end
