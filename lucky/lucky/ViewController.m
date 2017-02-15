//
//  ViewController.m
//  lucky
//
//  Created by zhoujjtech on 5/17/16.
//  Copyright © 2016 zhoujjtech. All rights reserved.
//

#import "ViewController.h"
#import "JJLuckyWheel.h"

@interface ViewController ()

@property (weak, nonatomic) JJLuckyWheel *luckyView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JJLuckyWheel *view = [JJLuckyWheel luckyWheel];
    view.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [self.view addSubview:view];
    self.luckyView = view;
}

- (IBAction)animation1:(id)sender {
    [self.luckyView animation1Btn];
}

- (IBAction)animation2:(id)sender {
    [self.luckyView animation2Btn];
}

- (IBAction)animation3:(id)sender {
    [self.luckyView animation3Btn];
}

- (IBAction)animation4:(id)sender {
    [self.luckyView animation4Btn];
}

@end
