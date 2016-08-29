//
//  LoadIMG.m
//  CC
//
//  Created by 樊康鹏 on 16/8/26.
//  Copyright © 2016年 FanKaren. All rights reserved.
//

#import "LoadIMG.h"

@interface LoadIMG ()
@property (nonatomic ,strong) UIImageView *loadImages;
@end

@implementation LoadIMG

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 64, FScreenWidth, FScreenHeight - 64)];
    if (self) {
        self.backgroundColor  = [UIColor clearColor];
        [self addSubview:self.loadImages];
    }
    return self;
}
- (UIImageView *)loadImages
{
    if (!_loadImages) {
        _loadImages = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2 - 25, self.height/2 - 25, 50, 50)];
        _loadImages.animationImages = @[[UIImage imageNamed:@"cc_load_1"],
                                        [UIImage imageNamed:@"cc_load_2"],
                                        [UIImage imageNamed:@"cc_load_3"],
                                        [UIImage imageNamed:@"cc_load_4"],
                                        [UIImage imageNamed:@"cc_load_5"],
                                        [UIImage imageNamed:@"cc_load_6"],
                                        [UIImage imageNamed:@"cc_load_7"],
                                        [UIImage imageNamed:@"cc_load_8"],
                                        [UIImage imageNamed:@"cc_load_9"],
                                        [UIImage imageNamed:@"cc_load_10"],
                                        [UIImage imageNamed:@"cc_load_11"],
                                        [UIImage imageNamed:@"cc_load_12"]];
        _loadImages.animationDuration = 0.4;
        [_loadImages startAnimating];
    }
    return _loadImages;
}

@end
