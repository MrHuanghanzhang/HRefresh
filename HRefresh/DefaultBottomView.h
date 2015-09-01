//
//  DefaultBottomView.h
//  HRefresh
//
//  Created by 黄含章 on 15/8/31.
//  Copyright (c) 2015年 Comdosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BottomViewDelagate <NSObject>

-(void)showBeforeRefresh;

@end

enum BottomRefreshStates {
    BottomRefreshStates_Normal = 1,
    BottomRefreshStates_BeforeRefresh = 2,
    BottomRefreshStates_Refreshing = 3,
};

@interface DefaultBottomView : UIView <BottomViewDelagate>

@property(nonatomic,weak) id actionTar;

@property(nonatomic,assign) SEL action;

@property(nonatomic,assign) int BottomRefreshStates;

@property(nonatomic,weak)UIScrollView *parentScrollView;

- (instancetype)initWithFrame:(CGRect)frame WithParentTableView:(UIScrollView *)tableView;

@property(nonatomic,assign)BOOL isLoading;

- (void)adjustStatusByBottomY:(float)y;

@end
