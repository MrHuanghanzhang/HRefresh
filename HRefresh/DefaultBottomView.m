//
//  DefaultBottomView.m
//  HRefresh
//
//  Created by 黄含章 on 15/8/31.
//  Copyright (c) 2015年 Comdosoft. All rights reserved.
//

#import "DefaultBottomView.h"

@interface DefaultBottomView()

@property(nonatomic,strong)UILabel *showLabel;

@end

@implementation DefaultBottomView

- (instancetype)initWithFrame:(CGRect)frame WithParentTableView:(UIScrollView *)tableView {
    self = [super initWithFrame:frame];
    if (self) {
        self.showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50)];
        self.showLabel.textAlignment = NSTextAlignmentCenter;
        [self.showLabel setText:@"test"];
        [self addSubview:self.showLabel];
        self.parentScrollView = tableView;
    }
    return self;
}

- (void)adjustStatusByBottomY:(float)y {
    if (_parentScrollView.contentSize.height < [UIScreen mainScreen].bounds.size.height - 50) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    if (self.parentScrollView.isDragging) {
        if (y < self.frame.origin.y ) {
            self.BottomRefreshStates = BottomRefreshStates_BeforeRefresh;
        }else {
            self.BottomRefreshStates = BottomRefreshStates_Normal;
        }
    }
    else {
        if (_parentScrollView.contentSize.height - y + 50 < [UIScreen mainScreen].bounds.size.height - self.frame.size.height && y > 0 && _parentScrollView.contentSize.height > [UIScreen mainScreen].bounds.size.height - 50) {
            NSLog(@"_parentScrollView.contentSize.height%f",_parentScrollView.contentSize.height);
            NSLog(@"offset------%f",y);
            self.BottomRefreshStates = BottomRefreshStates_Refreshing;
        }
    }
}

- (void)setBottomRefreshStates:(int)BottomRefreshStates {
    if (_BottomRefreshStates == BottomRefreshStates) {
        return;
    }
    switch (BottomRefreshStates) {
        case BottomRefreshStates_Normal:{
            _isLoading = NO;
            [UIView animateWithDuration:0.25 animations:^{
                self.parentScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                self.parentScrollView.scrollEnabled = YES;
                
            }];
            [self showNormal];
            break;
        }
            
        case BottomRefreshStates_BeforeRefresh:
            _isLoading = NO;
            [self showBeforeRefresh];
            break;
            
        case BottomRefreshStates_Refreshing:{
            _isLoading = YES;
            [UIView animateWithDuration:0.25 animations:^{
                self.parentScrollView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
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
    [self.showLabel setText:@"上拉刷新"];
}
-(void) showRefreshing{
    [self.showLabel setText:@"刷新中..."];
}

@end
