//
//  RAINetworkTaskViewController.m
//  InterviewTest
//
//  Copyright (c) 2014 Isobar. All rights reserved.
//

#import "RAINetworkTaskViewController.h"

@interface RAINetworkTaskViewController ()

@property (nonatomic,weak) IBOutlet UIWebView *webView;
@property (nonatomic,strong) NSURLResponse* urlResponse;
@property (weak, nonatomic) IBOutlet UITextField *addressBar;
@property (nonatomic, strong) NSMutableArray* history;
@property (nonatomic) unsigned long backCount;

@end

@implementation RAINetworkTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Network";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        _history = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"RAINetworkTaskInstructions" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *base = nil;
    [self.webView loadHTMLString:html baseURL:base];
}

- (IBAction)GO:(id)sender {
    NSString* urlString = _addressBar.text;
    if (![urlString containsString:@"http://"]) {
        urlString = [NSString stringWithFormat:@"http://%@",_addressBar.text];
    }
    NSURLRequest* request =  [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSURLConnection* connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    [connection start];
  
    _backCount = 0;
}
- (IBAction)Back:(id)sender {
   
    
    //Accidentally tried to reinvent the wheel. For more information, see the commented code
 //   if([_webView canGoBack]){
        [_webView goBack];
 //   }
//    _backCount += 1;
//    unsigned long howFarBack = (_history.count - 1) - (_backCount);
//    if (howFarBack < _history.count) {
//        NSString* urlString = [_history objectAtIndex:howFarBack];
//        NSURLRequest* request =  [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//        
//        NSURLConnection* connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
//        [connection start];
//    }
    
}
- (IBAction)Forward:(id)sender {

    //Accidentally tried to reinvent the wheel. For more information, see the commented code
    //    if ([_webView canGoForward]) {
        [_webView goForward];
//    }
//    if (_backCount != 0) {
//        _backCount -= 1;
//    }
//    unsigned long howFarBack = (_history.count - 1) - (_backCount);
//    if (howFarBack < _history.count) {
//        NSString* urlString = [_history objectAtIndex:howFarBack];
//        NSURLRequest* request =  [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//        
//        NSURLConnection* connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
//        [connection start];
//    }
 
    
}

#pragma mark -- NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    _responseData = [[NSMutableData alloc] init];
    _urlResponse = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (_responseData) {
        [self.webView loadData:_responseData MIMEType:_urlResponse.MIMEType textEncodingName:_urlResponse.textEncodingName baseURL:connection.currentRequest.URL];
    }

    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@ error! %@ %@",connection, error, error.localizedDescription);
}

#pragma mark -- UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (webView.isLoading) {
        NSLog(@"didfinishloading isloading");
    }else{
        NSLog(@"didfinishloading is not loading");
        [_history addObject:webView.request.URL.absoluteString];

    }
    
    
}



@end
