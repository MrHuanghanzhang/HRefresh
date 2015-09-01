//
//  UIScrollView+MyRefresh.m
//  HRefresh
//
//  Created by 黄含章 on 15/8/31.
//  Copyright (c) 2015年 Comdosoft. All rights reserved.
//

#import "UIScrollView+MyRefresh.h"
#import "UIScrollView+MyRefresh.h"
#import "DefaultTopView.h"
#import "DefaultBottomView.h"
#import <objc/runtime.h>

@implementation UIScrollView (MyRefresh)

static char topShowViewChar;

static char bottomShowViewChar;

-(void)updateBottomViewY:(float)Y {
    self.bottomShowView.frame = CGRectMake(0, Y - 50, [UIScreen mainScreen].bounds.size.width, 50);
}

- (void)addTopTarget:(id)target andAction:(SEL)sel withView:(DefaultTopView *)topShowView{
    
    if(self.topShowView){
        [self.topShowView removeFromSuperview];
    }
    
    if(topShowView){
        self.topShowView = topShowView;
    }else{
        self.topShowView = [[DefaultTopView alloc]initWithFrame:CGRectMake(0, -50, [UIScreen mainScreen].bounds.size.width, 50) WithParentTableView:self];
    }
    self.topShowView.action = sel;
    self.topShowView.actionTar = target;
    self.topShowView.topRefreshStatus = RefreshStates_Normal;
    self.topShowView.parentScrollView =self;
    [self addSubview:self.topShowView];
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)addBottomTarget:(id)taget andAction:(SEL)sel withView:(DefaultBottomView *)bottomShowView {
    if(self.bottomShowView){
        [self.bottomShowView removeFromSuperview];
    }
    
    if(bottomShowView){
        self.bottomShowView = bottomShowView;
    }else{
        
        NSLog(@"%f",self.contentSize.height);
        self.bottomShowView = [[DefaultBottomView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) WithParentTableView:self];
    }
    self.bottomShowView.action = sel;
    self.bottomShowView.actionTar = taget;
    self.bottomShowView.BottomRefreshStates = BottomRefreshStates_Normal;
    self.bottomShowView.parentScrollView =self;
    [self addSubview:self.bottomShowView];
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"contentOffset"]){
        NSValue * point = (NSValue *)[change objectForKey:@"new"];
        CGPoint p = [point CGPointValue];
        if (self.topShowView.isLoading) {
            return;
        }
        [self.topShowView adjustStatusByTopY:p.y];
        
        if (self.bottomShowView.isLoading) {
            return;
        }
        if (self.contentSize.height - p.y + 50 < [UIScreen mainScreen].bounds.size.height - 50) {
            [self.bottomShowView adjustStatusByBottomY:p.y];
        }
    }
}

#pragma mark---自定义实现的get set 方法来实现分类增加属性功能

- (DefaultTopView *)topShowView{
    return objc_getAssociatedObject(self, &topShowViewChar);
}

- (DefaultBottomView *)bottomShowView {
    return objc_getAssociatedObject(self, &bottomShowViewChar);
}

-(void)setTopShowView:(DefaultTopView *)topShowView{
    objc_setAssociatedObject(self, &topShowViewChar,topShowView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setBottomShowView:(DefaultBottomView *)bottomShowView {
    objc_setAssociatedObject(self, &bottomShowViewChar,bottomShowView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)TopEndRefresh{
    self.topShowView.topRefreshStatus = RefreshStates_Normal;
}

- (void)BottomEndRefresh {
    self.bottomShowView.BottomRefreshStates = BottomRefreshStates_Normal;
}
@end
