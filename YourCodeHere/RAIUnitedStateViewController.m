//
//  RAIUnitedStateViewController.m
//  InterviewTest
//
//  Created by iMac on 11/7/16.
//  Copyright © 2016 RoundarchIsobar. All rights reserved.
//

#import "RAIUnitedStateViewController.h"
#import "RAIUnitedState.h"
@interface RAIUnitedStateViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stateName;
@property (weak, nonatomic) IBOutlet UILabel *squareMiles;
@property (weak, nonatomic) IBOutlet UILabel *capital;
@property (weak, nonatomic) IBOutlet UILabel *mostPopulatedCity;
@property (weak, nonatomic) IBOutlet UILabel *population;
@property (weak, nonatomic) IBOutlet UILabel *timeZone1;
@property (weak, nonatomic) IBOutlet UILabel *timezone2;
@property (weak, nonatomic) IBOutlet UILabel *dst;
@property (weak, nonatomic) IBOutlet UIImageView *abbreviationImageView;

@end

@implementation RAIUnitedStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(_currentState != nil){
        _stateName.text = _currentState.name;
        _squareMiles.text = _currentState.squareMiles;
        _capital.text = _currentState.capital;
        _mostPopulatedCity.text = _currentState.mostPopulatedCity;
        _population.text = [NSString stringWithFormat:@"Population: %@",_currentState.population ];
        _timeZone1.text = _currentState.primaryTimeZone;
        _timezone2.text = _currentState.secondaryTimeZone;
        _dst.text = [NSString stringWithFormat:@"dst? %@",_currentState.dst ];
 
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString* urlString = [NSString stringWithFormat:@"http://www.50states.com/no/0%@f.gif", _currentState.abbreviation];
    NSURL* url = [NSURL URLWithString:urlString];
    NSData* imageData = [NSData dataWithContentsOfURL:url];
   UIImage* image = [UIImage imageWithData:imageData];
    [_abbreviationImageView setImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
