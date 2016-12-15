//
//  RAIInstructionsViewController.m
//  InterviewTest
//
//  Copyright (c) 2014 Isobar. All rights reserved.
//

#import "RAIInstructionsViewController.h"

@interface RAIInstructionsViewController ()

@property (nonatomic,weak) IBOutlet UIWebView *webView;

@end

@implementation RAIInstructionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // here as an quick and dirty way to refresh the page when you switch off the tab and back on to clear what the links go to
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"RAIInstructions" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *base = nil;
    [self.webView loadHTMLString:html baseURL:base];
}

- (IBAction)okPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
