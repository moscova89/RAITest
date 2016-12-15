//
//  RAIUnitedState.m
//  InterviewTest
//
//  Created by iMac on 11/7/16.
//  Copyright © 2016 RoundarchIsobar. All rights reserved.
//

#import "RAIUnitedState.h"

@implementation RAIUnitedState




-(instancetype)initWithDictionary:(NSDictionary*)dictionary{
    self = [super init];
    if (self) {
        if (dictionary != nil) {
            _name                   = [dictionary objectForKey:@"name"];
            _abbreviation           = [dictionary objectForKey:@"abbreviation"];
            _capital                = [dictionary objectForKey:@"capital"];
            _mostPopulatedCity      = [dictionary objectForKey:@"most-populous-city"];
            _population             = [dictionary objectForKey:@"population"];
            _squareMiles            = [dictionary objectForKey:@"square-miles"];
            _primaryTimeZone        = [dictionary objectForKey:@"time-zone-1"];
            _secondaryTimeZone      = [dictionary objectForKey:@"time-zone-2"];
            _dst                    = [dictionary objectForKey:@"dst"];


        }
    }
    return self;
    
}

@end
