//
//  FKPLiveController.m
//  CC
//
//  Created by 樊康鹏 on 16/8/25.
//  Copyright © 2016年 FanKaren. All rights reserved.
//

#import "FKPLiveController.h"
#import "FKPRefreshHeader.h"
#import "FKPLiveCell.h"

#define ToppicUrl @"http://mobilelive.cc.163.com/topic/banner?system=ios&version=2.0.3"
#define HostList @"http://mobilelive.cc.163.com/mobilelive/hot_list"

@interface FKPLiveController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *arr;
@property (nonatomic ,assign) NSUInteger page;
@property (nonatomic ,assign) NSUInteger pages;
@end

@implementation FKPLiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
   [self DataCapturing];
}
- (void)DataCapturing
{
    [AFNetWorkTools requestWihtMethod:RequestMethodTypeGet url:HostList params:@{@"size":@"20",@"attr":@"1",@"uid":@"29654344",@"width":@"750",@"height":@"750",@"page":[NSString stringWithFormat:@"%zd",_page]} contentType:[NSSet setWithObject:@"application/javascript"] showLoadImg:YES success:^(id response) {
        if (!_arr) {
            self.arr = [NSMutableArray array];
        }
        [_arr addObjectsFromArray:[[response objectForKey:@"data"] objectForKey:@"info_list"]];
        _pages = [[[response objectForKey:@"data"] objectForKey:@"pages"] integerValue];
        if (!_tableView) {
            [self.view addSubview:self.tableView];
        }else
        {
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            [_tableView reloadData];
        }
        
        
    } failure:^(NSError *err) {
        
    }];
}
- (void)loadMoreDataCapturing
{
    _page ++ ;
    if (_page <= _pages) {
        [self DataCapturing];
    }
}
#pragma mark -- UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FKPLiveCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"FKPLiveCell"];
    if (!cell) {
        cell = [[FKPLiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FKPLiveCell"];
    }
    cell.data = _arr[indexPath.section];
 
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到直播页面
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data = _arr[indexPath.section];
    return [tableView cellHeightForIndexPath:indexPath model:data keyPath:@"data" cellClass:[FKPLiveCell class] contentViewWidth:FScreenWidth];
}
#pragma mark --setter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, FScreenWidth, FScreenHeight - 113) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        FWeakObject(self)
        _tableView.mj_header = [FKPRefreshHeader headerWithRefreshingBlock:^{
            weakObject.page = 1;
            weakObject.arr = [NSMutableArray array];
            [weakObject DataCapturing];
        }];
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weakObject loadMoreDataCapturing];
        }];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
