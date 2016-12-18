//
//  ViewController.m
//  06手势识别
//
//  Created by apple on 15-6-10.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 添加轻触手势
    // 1.1 创建一个"轻触手势对象"
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabGesture:)];
    
    
    
    // 点击几次
    //tap.numberOfTapsRequired = 5;
    
    // 几根手指点击
    //tap.numberOfTouchesRequired = 2;
    
    // 1.2 为某个控件添加"手势识别"对象
    [self.imgView addGestureRecognizer:tap];
    
    
    
    
    // 2. 添加一个"长按手势"
    // 2.1 创建一个"长按手势对象"
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    
    // 设置最小的长按时间
    //longPress.minimumPressDuration = 2;
    
    longPress.allowableMovement = 50;
    [self.imgView addGestureRecognizer:longPress];
    
    
    // 3. 轻扫手势
    // 创建一个轻扫手势对象, 默认的方向是向右的（只识别向右的轻扫）
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    [self.imgView addGestureRecognizer:swipe];
    [self.imgView addGestureRecognizer:swipeLeft];
    
    
    // 4. 添加一个旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGesture:)];
    rotation.delegate = self;
    [self.imgView addGestureRecognizer:rotation];
    
    // 5. 捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    pinch.delegate = self;
    [self.imgView addGestureRecognizer:pinch];
    
    
    // 6. 拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.imgView addGestureRecognizer:pan];
    
}
- (void)panGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint trans = [recognizer translationInView:recognizer.view];
    //recognizer.view.transform = CGAffineTransformMakeTranslation(trans.x, trans.y);
    recognizer.view.transform = CGAffineTransformTranslate(recognizer.view.transform, trans.x, trans.y);
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
}
// 允许旋转和捏合手势同时识别
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

// 捏合手势监听方法
- (void)pinchGesture:(UIPinchGestureRecognizer *)recognizer
{
   // recognizer.view.transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1.0;
}


// 旋转手势监听方法
- (void)rotationGesture:(UIRotationGestureRecognizer *)recognizer
{
    NSLog(@"%f", recognizer.rotation);
    // 让图片跟着旋转
   // recognizer.view.transform = CGAffineTransformMakeRotation(recognizer.rotation);
    
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    
    recognizer.rotation = 0;
}



// 轻扫手势监听方法
- (void)swipeGesture:(UISwipeGestureRecognizer *)recoginzer
{
    
    CGPoint from = recoginzer.view.center;
    CGPoint to;
    
    //NSLog(@"扫了。。。");
    if (recoginzer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"向左扫。。");
        to = CGPointMake(from.x - 300, from.y);
    } else {
        NSLog(@"向右扫。。");
        to = CGPointMake(from.x + 300, from.y);
    }
    
    // 通过动画的方式执行
    [UIView animateWithDuration:0.5 animations:^{
        recoginzer.view.center = to;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            recoginzer.view.center = from;
        }];
    }];
}


// 长按手势的监听方法
- (void)longPressGesture:(UILongPressGestureRecognizer *)recognizer
{
    // 表示开始识别到了这个手势
    if (recognizer.state == UIGestureRecognizerStateBegan) {
       // NSLog(@"long press拉。。。");
        [UIView animateWithDuration:0.5 animations:^{
            recognizer.view.alpha = 0.4;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                recognizer.view.alpha = 1;
            }];
        }];
    }
    
}

// 轻触手势的监听方法
- (void)tabGesture:(UITapGestureRecognizer *)recognizer
{
    //[recognizer locationInView:recognizer.view];
    NSLog(@"tap.....");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
