//
//  ViewController.h
//  kuber
//
//  Created by Saket Rai on 6/26/15.
//  Copyright (c) 2015 Saket Rai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMPagerViewController.h"
@class DMPagerNavigationBarItem;


@interface ViewController : UIViewController <DMPagerViewControllerProtocol>
@property (nonatomic,strong) DMPagerNavigationBarItem	*pagerObj;

- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor;


@end

