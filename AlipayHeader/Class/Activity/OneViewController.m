//
//  OneViewController.m
//  AppFlash
//
//  Created by 李欢欢 on 2016/12/6.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#ifndef	weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef	strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

#import "OneViewController.h"
#import "MJRefresh.h"
#import "MJRefreshHeader.h"
#import "HomeUserView.h"
#import "HomeTopCell.h"
#import "UIColor+PXColors.h"
#import "UIView+Extension.h"

@interface OneViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIScrollView * bgScrollView;
@property (nonatomic, strong) UIView * bgHeaderView;
@property (nonatomic, strong) HomeUserView * homeUserView;
@property (nonatomic, strong) HomeTopCell * topView;

@property (nonatomic, assign) NSInteger indexPage;
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation OneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customize];
    [self reflash];
    [self setupTableView];
}

- (void)customize
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.indexPage = 1;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.f, 44.f)];
    self.titleLabel.font = [UIFont systemFontOfSize:17.f];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"首页";
    self.titleLabel.hidden = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = self.titleLabel;
    
}

- (void)reflash
{
    [self.tableView reloadData];
    [self updataContentSize:self.tableView.contentSize];
}

- (void)setupTableView
{
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        @strongify(self);
        
        [self.tableView.mj_header endRefreshing];

        self.indexPage = 1;
        
        [self.tableView.mj_footer resetNoMoreData];
        
        [self.tableView reloadData];
        [self updataContentSize:self.tableView.contentSize];
    }];
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        @strongify(self);
        
        [self.tableView.mj_footer endRefreshing];
        
        self.indexPage ++;
        if ( self.indexPage > 3 )
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
        [self updataContentSize:self.tableView.contentSize];
    }];
}

- (void)updataContentSize:(CGSize)size
{
    CGSize contentSize = size;
    CGRect tableViewFrame = self.tableView.frame;
    if ( self.indexPage > 3 )
    {
        if ( size.height < [UIScreen mainScreen].bounds.size.height - 64.f - 49.f - 147.f - 85.f )
        {
            tableViewFrame.size.height = size.height + 44.f + [UIScreen mainScreen].bounds.size.height - 64.f - 49.f - 147.f - 85.f;
            contentSize.height = contentSize.height + 44.f + [UIScreen mainScreen].bounds.size.height - 64.f - 49.f;
        }
        else
        {
            tableViewFrame.size.height = size.height + 44.f;
            contentSize.height = contentSize.height + 147.f + 85.f + 44.f;
        }
    }
    else
    {
        if ( size.height < [UIScreen mainScreen].bounds.size.height - 64.f - 49.f - 147.f - 85.f )
        {
            tableViewFrame.size.height = size.height + [UIScreen mainScreen].bounds.size.height - 64.f - 49.f - 147.f - 85.f;
            contentSize.height = contentSize.height + [UIScreen mainScreen].bounds.size.height - 64.f - 49.f;
        }
        else
        {
            tableViewFrame.size.height = size.height;
            contentSize.height = contentSize.height + 147.f + 85.f;
        }
    }
    self.bgScrollView.contentSize = contentSize;
    self.tableView.frame = tableViewFrame;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ( self.titleLabel.hidden )
    {
        self.titleLabel.hidden = NO;
    }
    if (scrollView == self.bgScrollView)
    {
        if ( scrollView.contentOffset.y <= 0 )
        {
            CGRect newFrame = self.bgHeaderView.frame;
            newFrame.origin.y = scrollView.contentOffset.y;
            self.bgHeaderView.frame = newFrame;
            
            newFrame = self.tableView.frame;
            newFrame.origin.y = scrollView.contentOffset.y + 147.f + 85.f;
            self.tableView.frame = newFrame;
            
            if (![self.tableView.mj_header isRefreshing])
            {
                self.tableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
            }
            
            newFrame = self.homeUserView.frame;
            newFrame.origin.y = 0;
            self.homeUserView.frame = newFrame;
        }
        else
        {
            if ( [self.tableView.mj_footer isRefreshing] )
            {
                self.tableView.contentOffset = CGPointMake(0, 44.f);
            }
            else
            {
                self.tableView.contentOffset = CGPointMake(0, 0);
            }
            
            
            CGRect newFrame = self.homeUserView.frame;
            newFrame.origin.y = scrollView.contentOffset.y / 2.f;
            self.homeUserView.frame = newFrame;
        }
        
        CGFloat alpha = (1 - scrollView.contentOffset.y / 147.f * 2.5 ) > 0 ? (1 - scrollView.contentOffset.y / 147.f * 2.5 ) : 0;
        
        self.homeUserView.alpha = alpha;
        if ( alpha > 0.5 )
        {
            self.titleLabel.alpha = 0;
        }
        else
        {
            CGFloat newAlpha =  alpha * 2;
            self.titleLabel.alpha = 1 - newAlpha;
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ( scrollView == self.bgScrollView )
    {
        if ( scrollView.contentOffset.y < - 64.f )
        {
            [self.tableView.mj_header beginRefreshing];
        }
        else if (scrollView.contentOffset.y > 0 &&
                 scrollView.contentOffset.y <= 147.f)
        {
            [self setBgScrollViewAnimationWithOffsetY:scrollView.contentOffset.y];
        }
        else if ( scrollView.contentOffset.y > self.tableView.contentSize.height - 147.f - 85.f - 44.f)
        {
            if ( self.indexPage <= 3 )
            {
                [self.tableView.mj_footer beginRefreshing];
            }
        }
    }
}

- (void)setBgScrollViewAnimationWithOffsetY:(CGFloat)offsetY
{
    if ( offsetY > 147.f / 2.f)
    {
        [self.bgScrollView setContentOffset:CGPointMake(0, 147.f) animated:YES];
    }
    else
    {
        [self.bgScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10 * self.indexPage;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ( !cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row%ld",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.0001f;
}

- (UIScrollView *)bgScrollView
{
    if ( !_bgScrollView )
    {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.f - 49.f)];
        
        _bgScrollView.delegate = self;
        _bgScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 147.f);
        _bgScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(147.f + 85.f, 0, 0, 0);
        [self.view addSubview:_bgScrollView];
    }
    return _bgScrollView;
}

- (UITableView *)tableView
{
    if ( !_tableView )
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 147.f + 85.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 147.f - 85.f - 64.f - 49.f) style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        [self.bgScrollView addSubview:_tableView];
    }
    return _tableView;
}

- (UIView *)bgHeaderView
{
    if ( !_bgHeaderView )
    {
        _bgHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 147.f + 85.f)];
        _bgHeaderView.backgroundColor = [UIColor colorWithHexString:@"b7945f"];
        
        [self.bgScrollView addSubview:_bgHeaderView];
    }
    return _bgHeaderView;
}

- (HomeUserView *)homeUserView
{
    if ( !_homeUserView )
    {
        _homeUserView = [[[NSBundle mainBundle] loadNibNamed:@"HomeUserView" owner:self options:nil] lastObject];
        _homeUserView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 147.f);
        [self.bgHeaderView addSubview:_homeUserView];
    }
    return _homeUserView;
}

- (HomeTopCell *)topView
{
    if ( !_topView )
    {
        _topView = [[[NSBundle mainBundle] loadNibNamed:@"HomeTopCell" owner:self options:nil] lastObject];
        _topView.frame = CGRectMake(0, 148.f, [UIScreen mainScreen].bounds.size.width, 85.f);
        [self.bgHeaderView addSubview:_topView];
    }
    return _topView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.bgHeaderView.height = 147.f + 85.f;
    self.homeUserView.height = 147.f;
    self.topView.height = 85.f;
}

@end
