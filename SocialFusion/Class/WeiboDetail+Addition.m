//
//  WeiboDetail+Addition.m
//  SocialFusion
//
//  Created by Blue Bitch on 11-10-5.
//  Copyright 2011年 Tongji Apple Club. All rights reserved.
//

#import "WeiboDetail+Addition.h"

@implementation WeiboDetail (Addition)

+ (WeiboDetail *)insertDetailInformation:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *userID = [[dict objectForKey:@"id"] stringValue];
    
    if (!userID || [userID isEqualToString:@""]) {
        return nil;
    }
    
    WeiboDetail *result = [WeiboDetail detailWithID:userID inManagedObjectContext:context];
    if (!result) {
        result = [NSEntityDescription insertNewObjectForEntityForName:@"WeiboDetail" inManagedObjectContext:context];
    }
    
    result.gender = [dict objectForKey:@"gender"];
    result.selfDescription = [dict objectForKey:@"description"];
    result.location = [dict objectForKey:@"location"];
    result.verified = [NSNumber numberWithBool:[[dict objectForKey:@"verified"] boolValue]];
    
    result.domainURL = [dict objectForKey:@"domain"];
    result.blogURL = [dict objectForKey:@"url"];
    
    result.friendsCount = [[dict objectForKey:@"friends_count"] stringValue];
    result.followersCount = [[dict objectForKey:@"followers_count"] stringValue];
    result.statusesCount = [[dict objectForKey:@"statuses_count"] stringValue];
    result.favouritesCount = [[dict objectForKey:@"favourites_count"] stringValue];
    
    BOOL following = [[dict objectForKey:@"following"] boolValue];
    
    result.following = [NSNumber numberWithBool:following];
    
    return result;
}

+ (WeiboDetail *)detailWithID:(NSString *)userID inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"WeiboDetail" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"ownerID == %@", userID]];
    
    WeiboDetail *res = [[context executeFetchRequest:request error:NULL] lastObject];
    
    [request release];
    
    return res;
}

@end
