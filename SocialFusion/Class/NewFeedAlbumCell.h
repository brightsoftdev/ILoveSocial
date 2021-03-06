//
//  NewFeedAlbumCell.h
//  SocialFusion
//
//  Created by He Ruoyun on 12-2-12.
//  Copyright (c) 2012年 TJU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumDetailController.h"
@interface NewFeedAlbumCell : UITableViewCell
{
    IBOutlet AlbumDetailController* detailController;
}
-(void)initWithFeedData:(NewFeedRootData*)_feedData  context:(NSManagedObjectContext*)context renren:(RenrenUser*)ren weibo:(WeiboUser*)wei;
@end
