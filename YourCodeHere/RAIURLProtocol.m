//
//  RAIURLProtocol.m
//  InterviewTest
//
//  Created by iMac on 11/7/16.
//  Copyright © 2016 RoundarchIsobar. All rights reserved.
//

#import "RAIURLProtocol.h"
#import "RAIAppDelegate.h"
#import "CachedResponse.h"

@implementation RAIURLProtocol


+(BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    if ([NSURLProtocol propertyForKey:@"MyURLProtocolHandledKey" inRequest:request]) {
        NSLog(@"Returning NO: %@, %@",request, request.URL);
        return NO;
    }
    NSLog(@"Returning YES: %@, %@",request, request.URL);

    return YES;
}

+(NSURLRequest*)canonicalRequestForRequest:(NSURLRequest *)request{
    return request;
}

+(BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

-(void)startLoading{
    
    
    CachedResponse *cachedResponse = [self cachedResponseForCurrentRequest];
    if (cachedResponse) {
        NSLog(@"serving response from cache");
        
        NSData *data = cachedResponse.data;
        NSString *mimeType = cachedResponse.mimeType;
        NSString *encoding = cachedResponse.encoding;
        
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL
                                                            MIMEType:mimeType
                                               expectedContentLength:data.length
                                                    textEncodingName:encoding];
        
        
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    } else {
        
        NSLog(@"serving response from NSURLConnection");
        
        NSMutableURLRequest *newRequest = [self.request mutableCopy];
        [NSURLProtocol setProperty:@YES forKey:@"MyURLProtocolHandledKey" inRequest:newRequest];
        
        _urlConnection = [NSURLConnection connectionWithRequest:newRequest delegate:self];
    }
}
-(void)stopLoading{
    [_urlConnection cancel];
    _urlConnection = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    
    self.urlResponse = response;
    self.urlData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
    [self.urlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
     [self saveCachedResponse];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

#pragma mark -- caching

- (void)saveCachedResponse {
    NSLog(@"saving cached response");
    
    RAIAppDelegate *delegate = (RAIAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    CachedResponse *cachedResponse = [NSEntityDescription insertNewObjectForEntityForName:@"CachedResponse"
                                                                      inManagedObjectContext:context];
    cachedResponse.data = self.urlData;
    cachedResponse.url = self.request.URL.absoluteString;
   
    cachedResponse.mimeType = self.urlResponse.MIMEType;
    
    NSError *error;
    BOOL const success = [context save:&error];
    if (!success) {
        NSLog(@"Could not cache the response.");
    }
}


- (CachedResponse *)cachedResponseForCurrentRequest {

    RAIAppDelegate *delegate = (RAIAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CachedResponse"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url == %@", self.request.URL.absoluteString];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    
    
    if (result && result.count > 0) {
        return [result firstObject];
    }
    
    NSLog(@"no cached reponse for current request");
    return nil;
}



@end
