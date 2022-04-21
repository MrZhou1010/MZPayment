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

#pragma mark - UI
- (void)setupUI {
    self.tableView.frame = self.view.bounds;
    [self.tableView registerClass:[MZPaymentStyleCell class] forCellReuseIdentifier:@"paymentStyleCellId"];
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
    sureBtn.frame = CGRectMake(60.0, 60.0, self.view.bounds.size.width - 120.0, 40.0);
    sureBtn.backgroundColor = [UIColor blueColor];
    sureBtn.layer.cornerRadius = 5.0;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:sureBtn];
    self.tableView.tableFooterView = footerView;
}

- (void)sureBtnAction:(UIButton *)btn {
    if (self.paymentStyle == MZPaymentStyleAlipay) {
        
    } else if (self.paymentStyle == MZPaymentStyleWxpay) {
        
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MZPaymentStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paymentStyleCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateImageName:self.dataSource[indexPath.row][@"image"] title:self.dataSource[indexPath.row][@"title"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MZPaymentStyleCell *selectedCell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
    MZPaymentStyleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectedIndexPath = indexPath;
    selectedCell.selected = NO;
    cell.selected = YES;
    if (indexPath.row == 0) {
        self.paymentStyle = MZPaymentStyleAlipay;
    } else if (indexPath.row == 1) {
        self.paymentStyle = MZPaymentStyleWxpay;
    }
}

@end
