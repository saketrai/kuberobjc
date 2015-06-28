//
//  TakePicVC.h
//  
//
//  Created by Saket Rai on 6/27/15.
//
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "DMPagerViewController.h"
@class DMPagerNavigationBarItem;


@interface TakePicVC : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,DMPagerViewControllerProtocol>
@property BOOL newMedia;
@property (nonatomic,strong) DMPagerNavigationBarItem	*pagerObj;

- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor;

@end
