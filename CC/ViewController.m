//
//  ViewController.m
//  CC
//
//  Created by 樊康鹏 on 16/8/24.
//  Copyright © 2016年 FanKaren. All rights reserved.
//

#import "ViewController.h"
#import "FKPYDController.h"
#import "FKPTabbarController.h"
@interface ViewController ()
@property (nonatomic ,strong) FKPYDController *ydController;
@property (nonatomic ,strong) UIImageView *launchImg;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.launchImg];
    
}
- (void)viewDidLayoutSubviews
{
    if (![FUserDefaults objectForKey:@"FirstLanunch"]) {
        [self setupYDView];
    }else
        [self ShowADView];
}
#pragma mark  -- 引导页
- (void)setupYDView
{
    NSArray *img = @[FImageWithName(@"HomeLaunchImg"),FImageWithName(@"HomeLaunchImg"),FImageWithName(@"HomeLaunchImg"),FImageWithName(@"HomeLaunchImg")];
    _ydController = [[FKPYDController alloc] initWithCoverImageNames:img backgroundImageNames:img];
    [self.view addSubview:_ydController.view];
    FWeakObject(self);
    _ydController.didSelectedEnter = ^(){
        [weakObject.ydController.view removeFromSuperview];
        [FUserDefaults setBool:YES forKey:@"FirstLanunch"];
        //加载广告
        [weakObject ShowADView];
    };
}
#pragma mark --显示广告内容
- (void)ShowADView
{
    FKPTabbarController *tabbar = [[FKPTabbarController alloc] init];
    
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    window.rootViewController = tabbar;
    [window makeKeyAndVisible];
}
#pragma mark -- 创建广告内容
- (void)setupADView
{
    
}
- (UIImageView *)launchImg
{
    if (!_launchImg) {
        _launchImg = [[UIImageView alloc] initWithFrame:self.view.frame];
        _launchImg.image = [UIImage imageNamed:@"HomeLaunchImg"];
    }
    return _launchImg;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
