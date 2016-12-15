//
//  CachedResponse+CoreDataProperties.h
//  InterviewTest
//
//  Created by iMac on 11/7/16.
//  Copyright © 2016 RoundarchIsobar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CachedResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface CachedResponse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *data;
@property (nullable, nonatomic, retain) NSString *encoding;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *mimeType;

@end

NS_ASSUME_NONNULL_END
