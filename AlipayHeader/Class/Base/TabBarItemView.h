//
//  TabBarItemView.h
//  AppFlash
//
//  Created by 李欢欢 on 2016/12/6.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBarItemView;
typedef void(^itemViewBlock)(TabBarItemView *sender);
@interface TabBarItemView : UIView
{
    UIButton     *_itemButton;
    UILabel      *_itemLabel;
    itemViewBlock _block;
}
@property (nonatomic, copy  ) itemViewBlock block;
@property (nonatomic, strong) UIButton      *itemButton;
@property (nonatomic, strong) UILabel       *itemLabel;
// 设置按钮的图片
- (void)setItemImage:(UIImage *)image forState:(UIControlState)state;

// 设置标题
- (void)setItemTitle:(NSString *)title;

//设置选中状态
- (void)setItemSelected:(BOOL)selected;

@end
