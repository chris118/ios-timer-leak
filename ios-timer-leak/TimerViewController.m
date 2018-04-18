//
//  TimerViewController.m
//  ios-timer-leak
//
//  Created by Chris on 2018/4/18.
//  Copyright © 2018年 Chris. All rights reserved.
//

#import "TimerViewController.h"
#import "PTProxy.h"

@interface TimerViewController ()
@property (nonatomic, assign)NSInteger counter;
@property (nonatomic, strong)NSTimer *countTimer;
@property (nonatomic, strong)PTProxy *proxy;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.proxy = [PTProxy alloc];
    self.proxy.obj = self;
    
    
    /************************ 关于NSloop导致Timer停止 ****************************/
    //测试1:
    //滚动table定时器会停止
//    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(count) userInfo:nil repeats:YES];
    
    //测试2:
    // 用NSRunLoopCommonModes的方式加入Mainloop， timer不会停止
//    self.countTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(count) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];

    
    
    /************************ 关于循环引用 ****************************/
    
    //测试3:
    //测试1, 测试2:中的创建timer的方式都会循环引用， 即使用weakSelf
//    //    self.countTimer = [NSTimer timerWithTimeInterval:1 target:weakSelf selector:@selector(count) userInfo:nil repeats:YES];
//        self.countTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(count) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
    
    
    //测试4:
    //使用block方式 不存在循环引用 dealloc可以调用到
//    __weak typeof(self) weakSelf = self;
//    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"%ld", weakSelf.counter++);
//    }];
    

    //测试5:
//    //使用NSProxy修正循环引用 dealloc可以调用到
//    self.countTimer = [NSTimer timerWithTimeInterval:1 target:self.proxy selector:@selector(count) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

-(void)count{
    NSLog(@"%ld", self.counter++);
}
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    NSLog(@"TimerViewController dealloc");
    [self.countTimer invalidate];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
@end
