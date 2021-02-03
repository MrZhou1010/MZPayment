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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}

@end
