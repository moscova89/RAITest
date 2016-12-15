//
//  RAINetworkTaskViewController.h
//  InterviewTest
//
//  Copyright (c) 2014 Isobar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RAINetworkTaskViewController : UIViewController <NSURLConnectionDelegate,UITextFieldDelegate,UIWebViewDelegate>

@property (nonatomic, strong) NSMutableData* responseData;
@end
