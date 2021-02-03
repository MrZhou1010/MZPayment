//
//  MZPaymentVC.m
//  MZPayment
//
//  Created by Mr.Z on 2021/1/4.
//

#import "MZPaymentVC.h"
#import "MZPaymentStyleCell.h"

typedef NS_ENUM(NSInteger, MZPaymentStyle) {
    MZPaymentStyleAlipay = 0,
    MZPaymentStyleWxpay
};

@interface MZPaymentVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, assign) MZPaymentStyle paymentStyle;

@end

@implementation MZPaymentVC

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 60.0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@{@"title": @"支付宝", @"image": @"icon_pay_alipay"},
                        @{@"title": @"微信", @"image": @"icon_pay_wxpay"}];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收银台";
    self.paymentStyle = MZPaymentStyleAlipay;
    [self setupUI];
    [self setupHeaderView];
    [self setupFooterView];
}

- (void)setupUI {
    [self.tableView registerClass:[MZPaymentStyleCell class] forCellReuseIdentifier:@"paymentStyleCellId"];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}

- (void)setupHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100.0)];
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10.0, self.view.bounds.size.width, 80.0)];
    amountLabel.text = @"￥0.01";
    amountLabel.textColor = [UIColor redColor];
    amountLabel.font = [UIFont boldSystemFontOfSize:26];
    amountLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:amountLabel];
    self.tableView.tableHeaderView = headerView;
}

- (void)setupFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200.0)];
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor = [UIColor blueColor];
    sureBtn.layer.cornerRadius = 5.0;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:sureBtn];
    self.tableView.tableFooterView = footerView;
}

- (void)sureBtnAction:(UIButton *)btn {
    
}

@end
