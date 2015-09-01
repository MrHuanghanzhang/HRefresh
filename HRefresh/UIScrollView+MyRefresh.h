//
//  UIScrollView+MyRefresh.h
//  HRefresh
//
//  Created by 黄含章 on 15/8/31.
//  Copyright (c) 2015年 Comdosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultTopView.h"
#import "DefaultBottomView.h"

@interface UIScrollView (MyRefresh)

@property(nonatomic,strong)DefaultTopView *topShowView;

@property(nonatomic,strong)DefaultBottomView *bottomShowView;

-(void)addTopTarget:(id)taget andAction:(SEL)sel withView:(DefaultTopView *)topShowView;

-(void)addBottomTarget:(id)taget andAction:(SEL)sel withView:(DefaultBottomView *)bottomShowView;

-(void)updateBottomViewY:(float)Y;

-(void)TopEndRefresh;

-(void)BottomEndRefresh;
@end
