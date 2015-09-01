//
//  ViewController.m
//  HRefresh
//
//  Created by 黄含章 on 15/8/31.
//  Copyright (c) 2015年 Comdosoft. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+MyRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,TopViewDelagate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)DefaultTopView *topV;

@property(nonatomic,strong)DefaultBottomView *bottomV;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ViewController

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50);
        _tableView.backgroundColor = [UIColor cyanColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    NSLog(@"%f ---- %f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
    self.dataArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5", nil];
    
    [_tableView addTopTarget:self andAction:@selector(topRefreshMove) withView:self.topV];
    
    [_tableView addBottomTarget:self andAction:@selector(bottomRefreshMove) withView:self.bottomV];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld条数据",indexPath.row];
    
    [_tableView updateBottomViewY:tableView.contentSize.height];
    return cell;
}

- (void)topRefreshMove {
    NSLog(@"下拉刷新");
    [_dataArray removeAllObjects];
    for (int i = 0; i < 20; i++) {
        [_dataArray addObject:@"a"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView TopEndRefresh];
        [_tableView reloadData];
    });
}

- (void)bottomRefreshMove {
    for (int i = 0; i < 10; i++) {
        [_dataArray addObject:@"a"];
    }
    NSLog(@"上啦刷新");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView BottomEndRefresh];
        [_tableView reloadData];
    });
}
@end
