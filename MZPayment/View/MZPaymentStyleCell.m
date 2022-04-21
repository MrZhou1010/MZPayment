//
//  MZPaymentStyleCell.m
//  MZPayment
//
//  Created by Mr.Z on 2021/1/4.
//

#import "MZPaymentStyleCell.h"

@interface MZPaymentStyleCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *selectedImageView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation MZPaymentStyleCell

#pragma mark - Lazy
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)selectedImageView {
    if (!_selectedImageView) {
        _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _selectedImageView.image = [UIImage imageNamed:@"icon_pay_unSelected"];
    }
    return _selectedImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }
    return _lineView;
}

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.selectedImageView.image = [UIImage imageNamed:selected ? @"icon_pay_selected": @"icon_pay_unSelected"];
}

- (void)setupViews {
    self.iconImageView.frame = CGRectMake(16.0, 10.0, 20.0, 20.0);
    self.titleLabel.frame = CGRectMake(56.0, 10.0, 120.0, 20.0);
    self.selectedImageView.frame = CGRectMake(self.contentView.frame.size.width - 36.0, 10.0, 20.0, 20.0);
    self.lineView.frame = CGRectMake(16.0, self.contentView.frame.size.height - 1.0, self.contentView.frame.size.width - 16.0, 1.0);
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.selectedImageView];
    [self.contentView addSubview:self.lineView];
}

- (void)updateImageName:(NSString *)imageName title:(NSString *)title {
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = title;
}

@end
