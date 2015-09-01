//
//  DefaultTopView.m
//  HRefresh
//
//  Created by 黄含章 on 15/8/31.
//  Copyright (c) 2015年 Comdosoft. All rights reserved.
//

#import "DefaultTopView.h"

@interface DefaultTopView()

@property(nonatomic,strong)UILabel *showLabel;

@end

@implementation DefaultTopView

- (instancetype)initWithFrame:(CGRect)frame WithParentTableView:(UIScrollView *)tableView {
    self = [super initWithFrame:frame];
    if (self) {
        self.showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        self.showLabel.textAlignment = NSTextAlignmentCenter;
        [self.showLabel setText:@"test"];
        self.isLoading = NO;
        self.parentScrollView = tableView;
        [self addSubview:self.showLabel];
    }
    return self;
}

- (void)adjustStatusByTopY:(float)y {
    if (self.parentScrollView.isDragging) {
        if (y < self.frame.origin.y) {
            self.topRefreshStatus = RefreshStates_BeforeRefresh;
        }else {
            self.topRefreshStatus = RefreshStates_Normal;
        }
    }
    else {
        if (y <= self.frame.origin.y) {
            self.topRefreshStatus = RefreshStates_Refreshing;
        }
    }
}

- (void)setTopRefreshStatus:(int)topRefreshStatus {
    if (_topRefreshStatus == topRefreshStatus) {
        return;
    }
    switch (topRefreshStatus) {
        case RefreshStates_Normal:{
            _isLoading = NO;
            [UIView animateWithDuration:0.25 animations:^{
                self.parentScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                self.parentScrollView.scrollEnabled = YES;
                
            }];
            [self showNormal];
            break;
        }
            
        case RefreshStates_BeforeRefresh:
            _isLoading = NO;
            [self showBeforeRefresh];
            break;
            
        case RefreshStates_Refreshing:{
            _isLoading = YES;
            [UIView animateWithDuration:0.25 animations:^{
                self.parentScrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
                self.parentScrollView.scrollEnabled = NO;
                
            }];
            
            [self showRefreshing];
            [self.actionTar performSelector:self.action withObject:nil];
            break;
        }
        default:
            break;
    }
}

-(void) showBeforeRefresh{
    [self.showLabel setText:@"松开刷新"];
}
-(void) showNormal{
    [self.showLabel setText:@"下拉刷新"];
}
-(void) showRefreshing{
    [self.showLabel setText:@"刷新中..."];
}
@end
