//
//  TabBarItemView.m
//  AppFlash
//
//  Created by 李欢欢 on 2016/12/6.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#import "TabBarItemView.h"

@implementation TabBarItemView

// 通过代码创建控件时会调用
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatItemView];
    }
    return self;
}

// 通过xib/Storboard创建时调用
- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self creatItemView];
    }
    return self;
}

- (void)creatItemView
{
    
    // item
    _itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _itemButton.frame = self.bounds;
    _itemButton.imageEdgeInsets = UIEdgeInsetsMake(-10.f, 0, 0, 0);
    [_itemButton addTarget:self action:@selector(didSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_itemButton];
    
    // 名字
    _itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, self.bounds.size.height - 15.f, self.bounds.size.width, 11.f)];
    _itemLabel.highlightedTextColor = [UIColor whiteColor];
    _itemLabel.textAlignment = NSTextAlignmentCenter;
    _itemLabel.backgroundColor = [UIColor clearColor];
    _itemLabel.textColor = [UIColor colorWithRed:0.412 green:0.341 blue:0.227 alpha:1.000];
    _itemLabel.font = [UIFont systemFontOfSize:10.f];
    [_itemButton addSubview:_itemLabel];
    
}
#pragma mark - Public Methods
- (void)setItemImage:(UIImage *)image forState:(UIControlState)state
{
    
    [_itemButton setImage:image forState:state];
}

- (void)setItemTitle:(NSString *)title
{
    
    _itemLabel.text = title;
}

- (void)setItemSelected:(BOOL)selected
{
    _itemButton.selected = selected;
    _itemLabel.highlighted = selected;
    
}
#pragma mark - Action Methods
- (void)didSelected:(UIButton *)sender
{
    
    if (!sender.selected) {
        if (_block != nil) {
            self.block(self);
        }
    }
}

@end
