//
//  RAITableTaskViewController.m
//  InterviewTest
//
//  Copyright (c) 2014 Isobar. All rights reserved.
//

#import "RAITableTaskViewController.h"
#import "RAIUnitedStateViewController.h"
#import "RAIUnitedState.h"

@interface RAITableTaskViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,weak) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* states;
@end

@implementation RAITableTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Table";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        _states = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getStateData];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    //NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"RAITableTaskInstructions" ofType:@"html"];
    //NSString *html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    //NSURL *base = nil;
   
    //[self.webView loadHTMLString:html baseURL:base];
}

#pragma mark -- tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_states count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellID = @"cellID";
    UITableViewCell* cell;// = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath]; //I really don't wanna create a nib file right now, no time.

        RAIUnitedState* currentState = [_states objectAtIndex:indexPath.row];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = currentState.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RAIUnitedState* currentState = [_states objectAtIndex:indexPath.row];
    RAIUnitedStateViewController* vc = [[RAIUnitedStateViewController alloc]initWithNibName:@"RAIUnitedStateViewController" bundle:[NSBundle mainBundle]];
    vc.currentState = currentState;
    [self.navigationController pushViewController:vc animated:YES];
    
}






#pragma mark -- helper functions

-(void)getStateData{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"states" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];

    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary* stateDictionary = [dictionary objectForKey:@"states"];
    NSArray* states = [stateDictionary objectForKey:@"state"];
    
    for (NSDictionary* dict in states) {
        NSDictionary* stateInfo = [dict objectForKey:@"@attributes"];
        RAIUnitedState* currentState = [[RAIUnitedState alloc]initWithDictionary:stateInfo];
        [_states addObject:currentState];
        
    }
    
}



@end
