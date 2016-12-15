//
//  RAITouchTaskViewController.m
//  InterviewTest
//
//  Copyright (c) 2014 Isobar. All rights reserved.
//

#import "RAITouchTaskViewController.h"
#import "RAITouchView.h"
#include <stdlib.h>

@interface RAITouchTaskViewController ()

@property (nonatomic,weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSMutableArray* touchViews;
@end

@implementation RAITouchTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Views";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _touchViews = [[NSMutableArray alloc]init];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"RAITouchTaskInstructions" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *base = nil;
    [self.webView loadHTMLString:html baseURL:base];
}

- (IBAction)summonView:(id)sender {
    
    RAITouchView* touchView = [[[NSBundle mainBundle]loadNibNamed:@"RAITouchView" owner:self options:nil] firstObject];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RAITouchViewTapped:)];
    [touchView addGestureRecognizer:tap];
    
    touchView.touchCount = 0;
    
    touchView.countLabel.text = [NSString stringWithFormat:@"%li",(long)touchView.touchCount];
    touchView.frame = CGRectMake( arc4random_uniform(self.view.frame.size.width - 50), arc4random_uniform(self.view.frame.size.height - 50), 50, 50);
    
    for (RAITouchView* tv in _touchViews) {
        if (CGRectIntersectsRect(touchView.frame, tv.frame)) {
            touchView.frame = CGRectMake( arc4random_uniform(self.view.frame.size.width - 50), arc4random_uniform(self.view.frame.size.height - 150), 50, 50);
            
        }
    }

    
    [self.view addSubview:touchView];
    [_touchViews addObject:touchView];
    
    
}

-(void)RAITouchViewTapped:(UITapGestureRecognizer*)tap{
    RAITouchView* touchView = (RAITouchView*)tap.view;
    touchView.touchCount += 1;
      touchView.countLabel.text = [NSString stringWithFormat:@"%li",(long)touchView.touchCount];
    
    if (touchView == nil) {
        return;
    }
    __weak RAITouchTaskViewController* weakself = self;
    [UIView animateWithDuration:arc4random_uniform(5) animations:^{
        CGFloat x = touchView.frame.origin.x + randomFloatBetween(-20, 20);
        CGFloat y = touchView.frame.origin.y + randomFloatBetween(-20, 20);
        CGRect newFrame =[weakself repositionFrame:touchView.frame x:x y:y];
        touchView.frame = newFrame;
       //TODO: account for Frames intersecting each other.
    }];
}

-(CGRect)repositionFrame:(CGRect)frame x:(CGFloat)x y:(CGFloat)y{
    return CGRectMake(x, y, frame.size.width, frame.size.height);
}

float randomFloatBetween(float smallNumber, float bigNumber)
{
    float diff = bigNumber - smallNumber;
    return (((float) rand() / RAND_MAX) * diff) + smallNumber;
}

-(void)pauseLayer:(CALayer*)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
