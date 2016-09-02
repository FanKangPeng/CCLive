//
//  FKPTabbarController.m
//  CC
//
//  Created by 樊康鹏 on 16/8/24.
//  Copyright © 2016年 FanKaren. All rights reserved.
//

#import "FKPTabbarController.h"
#import "FKPHomeController.h"
#import "FKPLiveListController.h"
#import "FKPCenterController.h"
#import "FKPMessageController.h"
#import "FKPVideoController.h"
#import "FKPNavigationController.h"
@interface FKPTabbarController ()

@end

@implementation FKPTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setAllSubView];
    
}
#pragma mark -- 添加所有子视图
- (void)setAllSubView
{
    FKPHomeController *homeController = [[FKPHomeController alloc] init];
    FKPNavigationController *homeNavi = [[FKPNavigationController alloc] initWithRootViewController:homeController];
    homeNavi.tabBarItem.title = @"直播";
    [self addChildViewController:homeNavi];
    
    FKPVideoController *videoController = [[FKPVideoController alloc] init];
    FKPNavigationController *videoNavi = [[FKPNavigationController alloc] initWithRootViewController:videoController];
    videoNavi.tabBarItem.title = @"视频";
    [self addChildViewController:videoNavi];
    
    FKPLiveListController *liveController = [[FKPLiveListController alloc] init];
    FKPNavigationController *liveNavi = [[FKPNavigationController alloc] initWithRootViewController:liveController];
    liveNavi.tabBarItem.title = @"手机直播";
    [self addChildViewController:liveNavi];
    
    FKPMessageController *messageController = [[FKPMessageController alloc] init];
    FKPNavigationController *messageNavi = [[FKPNavigationController alloc] initWithRootViewController:messageController];
    messageNavi.tabBarItem.title = @"消息";
    [self addChildViewController:messageNavi];
    
    FKPCenterController *centerController = [[FKPCenterController alloc] init];
    FKPNavigationController *centerNavi = [[FKPNavigationController alloc] initWithRootViewController:centerController];
    centerNavi.tabBarItem.title = @"我的";
    [self addChildViewController:centerNavi];
    
    // 字体颜色 选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : DefaultFontSize(11), NSForegroundColorAttributeName : FRGBAColor(36, 210, 234, 1)} forState:UIControlStateSelected];
    
    // 字体颜色 未选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : DefaultFontSize(11),  NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];

 
}



@end
 