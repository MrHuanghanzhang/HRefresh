//
//  DefaultTopView.h
//  HRefresh
//
//  Created by 黄含章 on 15/8/31.
//  Copyright (c) 2015年 Comdosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopViewDelagate <NSObject>

-(void)showBeforeRefresh;

@end

enum RefreshStates {
    RefreshStates_Normal = 1,
    RefreshStates_BeforeRefresh = 2,
    RefreshStates_Refreshing = 3,
};

@interface DefaultTopView : UIView <TopViewDelagate>

@property(nonatomic,weak) id actionTar;

@property(nonatomic,assign) SEL action;

@property(nonatomic,assign) int topRefreshStatus;

@property(nonatomic,weak)UIScrollView *parentScrollView;

@property(nonatomic,assign)BOOL isLoading;

- (instancetype)initWithFrame:(CGRect)frame WithParentTableView:(UIScrollView *)tableView;

-(void)adjustStatusByTopY:(float)y;

@end
