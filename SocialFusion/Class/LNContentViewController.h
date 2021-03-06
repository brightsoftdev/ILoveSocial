//
//  LNContentViewController.h
//  SocialFusion
//
//  Created by Blue Bitch on 12-1-19.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@protocol LNContentViewControllerDelegate;
@interface LNContentViewController : UIViewController<UIScrollViewDelegate> {
    NSMutableArray *_contentViewControllerHeap;
    NSUInteger _currentContentIndex;
    NSMutableArray *_contentViewIdentifierHeap;
    UIScrollView *_scrollView;
    id<LNContentViewControllerDelegate> _delegate;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain, readonly) NSMutableArray *contentViewControllerHeap;
@property (nonatomic) NSUInteger currentContentIndex;
@property (nonatomic, readonly) NSUInteger contentViewCount;
@property (nonatomic, assign) id<LNContentViewControllerDelegate> delegate;

- (id)initWithLabelIdentifiers:(NSArray *)identifiers andUsers:(NSDictionary *)userDict;
- (void)setContentViewAtIndex:(NSUInteger)index forIdentifier:(NSString *)identifier;
- (void)addUserContentViewWithIndentifier:(NSString *)identifier andUsers:(NSDictionary *)userDict;
- (void)removeContentViewAtIndex:(NSUInteger)index;
- (NSString *)currentContentIdentifierAtIndex:(NSUInteger)index;

@end

@protocol LNContentViewControllerDelegate<NSObject>

- (void)contentViewController:(LNContentViewController *)vc didScrollToIndex:(NSUInteger)index;

@end