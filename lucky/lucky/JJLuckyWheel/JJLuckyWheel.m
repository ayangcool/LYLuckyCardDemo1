//
//  JJLuckyWheel.m
//  lucky
//
//  Created by zhoujjtech on 5/17/16.
//  Copyright © 2016 zhoujjtech. All rights reserved.
//

#import "JJLuckyWheel.h"
#import "JJButton.h"

@interface JJLuckyWheel () <CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *rotateImageView;
@property (strong, nonatomic) UIButton *selectedBtn;
@property (nonatomic , strong) NSMutableArray *btnArray;
@property (nonatomic, assign) BOOL animation1Stop;

@end

@implementation JJLuckyWheel

+ (instancetype)luckyWheel {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JJLuckyWheel class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnArray = [NSMutableArray array];
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *norImage = [UIImage imageNamed:@"Lucky.bundle/LuckyAstrology"];
    UIImage *selImage = [UIImage imageNamed:@"Lucky.bundle/LuckyAstrologyPressed"];
    CGFloat imageH = norImage.size.height * scale;
    CGFloat imageW = norImage.size.width / 12 * scale;
    for (NSInteger i = 0; i < 12; i++) {
        UIButton *btn = [JJButton buttonWithType:UIButtonTypeCustom];
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        CGSize size = self.rotateImageView.frame.size;
        btn.layer.position = CGPointMake(size.width * 0.5, size.height * 0.5);
        btn.bounds = CGRectMake(0, 0, 68, 143);
        CGFloat angle = 2 * M_PI / 12;
        btn.transform = CGAffineTransformMakeRotation(angle * i);
        [self.rotateImageView addSubview:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"Lucky.bundle/LuckyRototeSelected"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        CGRect rect = CGRectMake(i * imageW, 0, imageW, imageH);
        CGImageRef imageRef = CGImageCreateWithImageInRect(norImage.CGImage, rect);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [btn setImage:image forState:UIControlStateNormal];
        
        imageRef = CGImageCreateWithImageInRect(selImage.CGImage, rect);
        image = [UIImage imageWithCGImage:imageRef];
        [btn setImage:image forState:UIControlStateSelected];
        [self.btnArray addObject:btn];
        if (i == 0) {
            [self selected:btn];
        }
    }
}

- (void)animationPart1 {
    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
    baseAnimation.keyPath = @"transform.rotation";
    baseAnimation.byValue = @(6 * 2 * M_PI);
    baseAnimation.duration = 2;
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    baseAnimation.fillMode = kCAFillModeForwards;
    baseAnimation.repeatCount = CGFLOAT_MAX;
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.delegate = self;
    [self.rotateImageView.layer addAnimation:baseAnimation forKey:@"animation1"];
}

- (void)animationPart2 {
    self.rotateImageView.transform = CGAffineTransformMakeRotation(0.25 * 2 * M_PI);
    CABasicAnimation *animationPart2 = [CABasicAnimation animation];
    animationPart2.keyPath = @"transform.rotation.z";
    animationPart2.byValue = @(3 * 2 * M_PI);
    animationPart2.duration = 1.0;
    animationPart2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationPart2.fillMode = kCAFillModeForwards;
    animationPart2.removedOnCompletion = NO;
    animationPart2.delegate = self;
    [self.rotateImageView.layer addAnimation:animationPart2 forKey:@"animation2"];
}

- (void)animationPart3 {
    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
    baseAnimation.keyPath = @"transform.rotation.z";
//    baseAnimation.fromValue = @(0.5 * 2 * M_PI);
    baseAnimation.byValue = @(2 * 2 * M_PI);
    baseAnimation.duration = 1.1;
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    baseAnimation.fillMode = kCAFillModeForwards;
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.delegate = self;
    [self.rotateImageView.layer addAnimation:baseAnimation forKey:@"animation3"];
}

- (void)animationPart4 {
    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
    baseAnimation.keyPath = @"transform.rotation.z";
//    baseAnimation.toValue = @(2 * M_PI + 0.5 * 2 * M_PI);
    baseAnimation.byValue = @(2 * M_PI);
    baseAnimation.duration = 1.3;
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    baseAnimation.fillMode = kCAFillModeForwards;
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.delegate = self;
    [self.rotateImageView.layer addAnimation:baseAnimation forKey:@"animation4"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CAAnimation *animation2 = [self.rotateImageView.layer animationForKey:@"animation2"];
    CAAnimation *animation3 = [self.rotateImageView.layer animationForKey:@"animation3"];
    CAAnimation *animation4 = [self.rotateImageView.layer animationForKey:@"animation4"];
    if (anim == animation2) {
        [self.rotateImageView.layer removeAllAnimations];
        [self animationPart3];
    } else if (anim == animation3) {
        [self.rotateImageView.layer removeAllAnimations];
        [self animationPart4];
    } else if (anim == animation4) {
        NSLog(@"动画结束 %@", self.rotateImageView);
        [self.rotateImageView.layer removeAllAnimations];
    }
}

- (IBAction)selectNumber:(id)sender {
    self.rotateImageView.transform = CGAffineTransformMakeRotation(0.5 * 2 * M_PI);
    [self animationPart2];
    
    NSLog(@"selectNumber all - angle %@", NSStringFromCGAffineTransform(_selectedBtn.transform));
    CGFloat angle = atan2(_selectedBtn.transform.b, _selectedBtn.transform.a);
    NSLog(@"selectNumber - angle %@ a: %@ b: %@ c: %@ d: %@", @(angle / (2 * M_PI)), @(_selectedBtn.transform.a), @(_selectedBtn.transform.b), @(_selectedBtn.transform.c), @(_selectedBtn.transform.d));
    // 旋转转盘
    NSLog(@"selectNumber - rotateImageView.transForm：%@", NSStringFromCGAffineTransform(self.rotateImageView.transform));
}

- (void)selected:(UIButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

- (void)animation1Btn {
    [self animationPart1];
}

- (void)animation2Btn {
    [self animationPart2];
}

- (void)animation3Btn {
    [self animationPart3];
}

- (void)animation4Btn {
    [self animationPart4];
}


@end
