//
//  RAIUnitedState.h
//  InterviewTest
//
//  Created by iMac on 11/7/16.
//  Copyright © 2016 RoundarchIsobar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAIUnitedState : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* abbreviation;
@property (nonatomic, strong) NSString* capital;
@property (nonatomic, strong) NSString* mostPopulatedCity;
@property (nonatomic, strong) NSString* population;
@property (nonatomic, strong) NSString* squareMiles;
@property (nonatomic, strong) NSString* primaryTimeZone;
@property (nonatomic, strong) NSString* secondaryTimeZone;
@property (nonatomic, strong) NSString* dst;


-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
