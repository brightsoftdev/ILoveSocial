//
//  LNLabelPageViewController.h
//  SocialFusion
//
//  Created by Blue Bitch on 12-1-19.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNLabelViewController.h"

@protocol LNLabelPageViewControllerDelegate;
@interface LNLabelPageViewController : UIViewController<LNLabelViewControllerDelegate> {
    NSMutableArray *_labelViews;
    NSUInteger _page;
    id<LNLabelPageViewControllerDelegate> _delegate;
    NSMutableArray *_labelInfoSubArray;
}

@property NSUInteger page;
@property (nonatomic, assign) id<LNLabelPageViewControllerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *labelInfoSubArray;
@property (nonatomic, retain, readonly) NSMutableArray *labelViews;

- (id)initWithInfoSubArray:(NSMutableArray *)array pageIndex:(NSUInteger)page;
- (void)selectOtherPage:(NSUInteger)page;
- (void)activateLastLabel:(LabelInfo *)info delayed:(BOOL)delay;
- (void)openLabelPostAnimation;
- (void)closeParentLabelAnimation;
- (void)closePageWithReturnLabel:(LNLabelViewController *)labelView;

@end

@protocol LNLabelPageViewControllerDelegate <NSObject>

- (void)labelPageView:(LNLabelPageViewController *)pageView didSelectLabel:(LNLabelViewController *)label;
- (void)labelPageView:(LNLabelPageViewController *)pageView didRemoveLabel:(LNLabelViewController *)label;
- (void)labelPageView:(LNLabelPageViewController *)pageView didOpenLabel:(LNLabelViewController *)label;
- (void)labelPageView:(LNLabelPageViewController *)pageView didCloseLabel:(LNLabelViewController *)label;
- (void)labelPageView:(LNLabelPageViewController *)pageView didFinishCloseLabel:(LNLabelViewController *)label;

@end