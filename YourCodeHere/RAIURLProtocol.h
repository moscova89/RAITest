//
//  RAIURLProtocol.h
//  InterviewTest
//
//  Created by iMac on 11/7/16.
//  Copyright © 2016 RoundarchIsobar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAIURLProtocol : NSURLProtocol< NSURLConnectionDelegate>

@property(nonatomic, strong) NSURLConnection* urlConnection;
@property(nonatomic, strong) NSURLResponse* urlResponse;
@property(nonatomic, strong) NSMutableData* urlData;

@end
