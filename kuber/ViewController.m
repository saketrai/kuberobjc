//
//  ViewController.m
//  kuber
//
//  Created by Saket Rai on 6/26/15.
//  Copyright (c) 2015 Saket Rai. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "DraggableViewBackground.h"
#import "TakePicVC.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *marketImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    CGRect frame = self.view.frame;
    frame.origin.y = -self.view.frame.size.height; //optional: if you want the view to drop down
    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:frame];
    draggableBackground.alpha = 0; //optional: if you want the view to fade in
    
    [self.view addSubview:draggableBackground];
    
    //optional: animate down and in
    [UIView animateWithDuration:0.5 animations:^{
        draggableBackground.center = self.view.center;
        draggableBackground.alpha = 1;
    }];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showNewEventViewController)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
   // NSLog(@"awaked");
  //  NSLog(@"Pic");

    
//    PFQuery *query = [PFQuery queryWithClassName:@"marketPics"];
//    //[query whereKey:@"imageName" equalTo:@"dstemkoski@example.com"];
//    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//        if (!object) {
//            NSLog(@"The getFirstObject request failed.");
//        } else {
//            // The find succeeded.
//            NSLog(@"Successfully retrieved the object %@",object);
//            PFFile *userImageFile = [object objectForKey:@"imageFile"];
//            [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
//                if (!error) {
//                    self.marketImage.image = [UIImage imageWithData:imageData];
//                    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
//                    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//                    [self.marketImage addGestureRecognizer:gestureRecognizer];
//                }
//            }];
//        }
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showNewEventViewController
{
    NSLog(@"Button CLicked");
    
    [self performSegueWithIdentifier:@"takePic" sender:self];

}

@end
