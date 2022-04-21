//
//  ViewController.m
//  MZPayment
//
//  Created by Mr.Z on 2021/1/4.
//

#import "ViewController.h"
#import "MZPaymentVC.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *paymentBtn;

@end

@implementation ViewController

#pragma mark - Lazy
- (UIButton *)paymentBtn {
    if (!_paymentBtn) {
        _paymentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _paymentBtn.frame = CGRectMake(100.0, 200.0, 160.0, 60.0);
        [_paymentBtn setTitle:@"支付测试" forState:UIControlStateNormal];
        [_paymentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_paymentBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _paymentBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"支付";
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.paymentBtn];
}

- (void)btnAction:(UIButton *)btn {
    [self.navigationController pushViewController:[MZPaymentVC new] animated:YES];
}

@end
