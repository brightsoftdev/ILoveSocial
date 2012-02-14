//
//  NewFeedData+NewFeedData_Addition.m
//  SocialFusion
//
//  Created by He Ruoyun on 11-11-7.
//  Copyright (c) 2011年 Tongji Apple Club. All rights reserved.
//

#import "NewFeedData+NewFeedData_Addition.h"
#import "NewFeedRootData+Addition.h"
#import "NSString+HTMLSet.h"
//#import "CalculateHeight.h"
@implementation NewFeedData (NewFeedData_Addition)

-(NSString*)getBlog
{
    return nil;
}
-(NSString*)getActor_ID
{
    return self.actor_ID;
}
-(NSString*)getSource_ID
{
    return self.source_ID;
}

-(int)getComment_Count
{
    return [self.comment_Count intValue];
}


-(void)setCount:(int)count
{
    self.comment_Count=[NSNumber numberWithInt:count];
}
-(NSDate*)getDate
{
    return self.update_Time;
}



-(int)getStyle
{
    return [self.style intValue];
}

-(NSString*)getFeedName
{
    return self.owner_Name;
}



-(NSString*)getHeadURL
{
    return self.owner_Head;
}


-(NSString*)getPostMessage
{

    
    return [NSString stringWithFormat:@"<span style=\"font-weight:bold;\">%@:</span>%@",self.repost_Name,self.repost_Status];
    
    // NSLog(@"%@",[tempString stringByAppendingFormat:@"%@",post_Status]);
   // return [tempString stringByAppendingFormat:@":%@",self.repost_Status] ;
    
    
}


-(NSString*)getPostName
{
    return self.repost_Name;
}


-(NSString*)getName
{
    return [self.message replaceHTMLSign];
}


- (void)configureNewFeed:(int)style height:(int)height getDate:(NSDate*)getDate Owner:(User*)myUser Dic:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context {
    [super configureNewFeed:style height:height getDate:getDate Owner:myUser Dic:dict inManagedObjectContext:context];
    if(style == kNewFeedStyleWeibo) {
        self.pic_URL = [dict objectForKey:@"thumbnail_pic"];
        self.pic_big_URL = [dict objectForKey:@"bmiddle_pic"];
        
        NSDictionary* attachment = [dict objectForKey:@"retweeted_status"];
        if ([attachment count] != 0)
        {
            if ([attachment count] != 0)
            {
                self.repost_ID = [[[attachment  objectForKey:@"user"] objectForKey:@"id"] stringValue];
                self.repost_StatusID = [[attachment objectForKey:@"id"] stringValue ];
                self.repost_Name = [[attachment objectForKey:@"user"] objectForKey:@"screen_name"] ;
                self.repost_Status = [attachment objectForKey:@"text"] ;
                self.pic_URL = [attachment objectForKey:@"thumbnail_pic"];
                self.pic_big_URL = [attachment objectForKey:@"bmiddle_pic"];
            }
        }
        
        self.message = [dict objectForKey:@"text"];
    }
    else if(style == kNewFeedStyleRenren) {
        
    }
}

+ (NewFeedData *)insertNewFeed:(int)style height:(int)height getDate:(NSDate*)getDate Owner:(User*)myUser Dic:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context
{
    if (style==0)//renren
    {
        NSString *statusID = [NSString stringWithFormat:@"%@", [[dict objectForKey:@"post_id"] stringValue]];
        if (!statusID || [statusID isEqualToString:@""]) {
            return nil;
        }
        
        NewFeedData *result = [NewFeedData feedWithID:statusID inManagedObjectContext:context];
        if (!result) {
            result = [NSEntityDescription insertNewObjectForEntityForName:@"NewFeedData" inManagedObjectContext:context];
        }
        
        [result configureNewFeed:style height:height getDate:getDate Owner:myUser Dic:dict inManagedObjectContext:context];

        
        
       // NSLog(@"%@",result.style);
        
        result.actor_ID=[[dict objectForKey:@"actor_id"] stringValue];
        
        result.owner_Head= [dict objectForKey:@"headurl"] ;
        
        result.owner_Name=[dict objectForKey:@"name"] ;
        
        
        
        NSDateFormatter *form = [[NSDateFormatter alloc] init];
        [form setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        
        NSString* dateString=[dict objectForKey:@"update_time"];
        result.update_Time=[form dateFromString: dateString];
        
        
        [form release];
        
        
        result.comment_Count=[NSNumber numberWithInt:    [ [[dict objectForKey:@"comments"] objectForKey:@"count"] intValue]];
        
        result.source_ID= [[dict objectForKey:@"source_id"] stringValue];
        
        result.message=[dict objectForKey:@"message"];
        
        NSArray* attachments=[dict objectForKey:@"attachment"];
        if ([attachments count]!=0)
        {
            NSDictionary* attachment=[attachments objectAtIndex:0];
            if ([attachment count]!=0)
            {
                result.repost_ID=[[attachment objectForKey:@"owner_id"] stringValue] ;
                
                result.repost_Name=[attachment objectForKey:@"owner_name"];
                
                
                result.repost_Status=[attachment objectForKey:@"content"] ;
                
                result.repost_StatusID=[[attachment objectForKey:@"media_id"] stringValue] ;
    
            }
        }
            

        result.cellheight=[NSNumber numberWithInt:height];
                  
        
        result.get_Time=getDate;
 

        return result;
    }
    else
    {
        NSString *statusID = [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
        if (!statusID || [statusID isEqualToString:@""]) {
            return nil;
        }
        
        NewFeedData *result = [NewFeedData feedWithID:statusID inManagedObjectContext:context];
        if (!result) {
            result = [NSEntityDescription insertNewObjectForEntityForName:@"NewFeedData" inManagedObjectContext:context];
        }
        
        [result configureNewFeed:style height:height getDate:getDate Owner:myUser Dic:dict inManagedObjectContext:context];
        
        return result;
    }
}


+ (NewFeedData *)feedWithID:(NSString *)statusID inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"NewFeedData" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"post_ID == %@", statusID]];
    NewFeedData *res = [[context executeFetchRequest:request error:NULL] lastObject];
    [request release];
    return res;
}



@end
