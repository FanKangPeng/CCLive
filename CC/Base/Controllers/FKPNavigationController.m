//
//  FKPNavigationController.m
//  CC
//
//  Created by 樊康鹏 on 16/8/24.
//  Copyright © 2016年 FanKaren. All rights reserved.
//

#import "FKPNavigationController.h"
#import "FKPProductMethods.h"
@interface FKPNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation FKPNavigationController
+ (void)initialize
{
    if (self == [FKPNavigationController class]) {
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        [bar setBackgroundImage:[UIColor imageWithColor:FRGBAColor(36, 210, 234, 1) size:CGSizeMake(FScreenWidth, FNavBarHeight + FStatusBarHeight)] forBarMetrics:UIBarMetricsDefault];
    }
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加个手势 用作全屏侧滑
     id target = self.interactivePopGestureRecognizer.delegate;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    [self.view addGestureRecognizer:pan];
    // 取消边缘滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    pan.delegate = self;
  
}
#pragma mark ---- <UIGestureRecognizerDelegate>


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 判断下当前是不是在根控制器
    return self.childViewControllers.count > 1;
}

#pragma mark ---- <非根控制器隐藏底部tabbar>
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
