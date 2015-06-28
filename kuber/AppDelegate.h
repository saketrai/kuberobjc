//
//  AppDelegate.h
//  kuber
//
//  Created by Saket Rai on 6/26/15.
//  Copyright (c) 2015 Saket Rai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Parse/Parse.h>
//#import <DMPagerViewController/DMPagerViewController.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//@property (strong, nonatomic) DMPagerViewController	*pagerController;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

