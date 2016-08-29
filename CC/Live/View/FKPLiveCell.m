//
//  FKPLiveCell.m
//  CC
//
//  Created by 樊康鹏 on 16/8/29.
//  Copyright © 2016年 FanKaren. All rights reserved.
//

#import "FKPLiveCell.h"

@interface FKPLiveCell ()
@property (nonatomic ,strong)UIImageView *accountImg;
@property (nonatomic ,strong)UILabel *nameLb;
@property (nonatomic ,strong)UILabel *countLb;
@property (nonatomic ,strong)UIImageView *coverImg;
@end


@implementation FKPLiveCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.accountImg];
         [self.contentView addSubview:self.nameLb];
         [self.contentView addSubview:self.countLb];
         [self.contentView addSubview:self.coverImg];
    }
    return self;
}
- (void)setData:(NSDictionary *)data
{
    _nameLb.text = [data objectForKey:@"nickname"];
    _countLb.text = [NSString stringWithFormat:@"%@人正在观看",[data objectForKey:@"visitor"]];
    [_accountImg sd_setImageWithURL:[NSURL URLWithString:[data objectForKey:@"cover"]]];
    UIImage *cacheImg = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[data objectForKey:@"cover"]];
    if (cacheImg) {
        _coverImg.image = cacheImg;
    }else
        _coverImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectForKey:@"cover"]]]];
    UIImage *image = _coverImg.image;
    _coverImg.frame = CGRectMake(0, 30, FScreenWidth, FScreenWidth/image.size.width * image.size.height);
    [self setupAutoHeightWithBottomView:_coverImg bottomMargin:0];
    [[SDImageCache sharedImageCache] storeImage:image forKey:[data objectForKey:@"cover"]];
}
#pragma mark --懒加载
- (UIImageView *)accountImg
{
    if (!_accountImg) {
        _accountImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        _accountImg.layer.cornerRadius = 10;
        _accountImg.layer.masksToBounds =  YES;
    }
    return _accountImg;
}
- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] initWithFrame:CGRectMake(28, 5, 200, 20)];
        _nameLb.font = DefaultFontSize(13);
    }
    return _nameLb;
}
- (UILabel *)countLb
{
    if (!_countLb) {
        _countLb = [[UILabel alloc] initWithFrame:CGRectMake(150, 5, FScreenWidth - 155, 20)];
        _countLb.font = DefaultFontSize(13);
        _countLb.textAlignment = NSTextAlignmentRight;
    }
    return _countLb;
}
- (UIImageView *)coverImg
{
    if (!_coverImg) {
        _coverImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, FScreenWidth, 200)];
    }
    return _coverImg;
}
@end
