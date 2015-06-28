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
    
    PFQuery *query = [PFQuery queryWithClassName:@"marketPics"];
    //[query whereKey:@"imageName" equalTo:@"dstemkoski@example.com"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (!objects) {
                NSLog(@"The getFirstObject request failed.");
            } else {
                // The find succeeded.
                NSLog(@"Successfully retrieved the object %lu",(unsigned long)objects.count);
                if(objects.count > 0) {
                    NSInteger numLoadedCardsCap =(([objects count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[objects count]);
                    
                    for (int i = 0; i<[objects count]; i++) {
                        DraggableView *newCard = [[DraggableView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - CARD_WIDTH)/2, (self.view.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)];
                        newCard.information.text = [[objects objectAtIndex:i]objectForKey:@"imageName"]; //%%% placeholder for card-specific information
                        
                        
                        PFFile *userImageFile =  [[objects objectAtIndex:i]objectForKey:@"imageFile"];;
                        [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                            if (!error) {
                                newCard.cardImageView.image = [UIImage imageWithData:imageData];
                            }
                        }];
                        
                        //draggableView.cardImageView.image=[UIImage imageNamed:@"ring.jpg"];
                        newCard.delegate = self;
                        
                        [draggableBackground.allCards addObject:newCard];
                        
                        if (i<numLoadedCardsCap) {
                            //%%% adds a small number of cards to be loaded
                            [draggableBackground.loadedCards addObject:newCard];
                        }
                    }
                    
                    for (int i = 0; i<[draggableBackground.loadedCards count]; i++) {
                        if (i>0) {
                            [draggableBackground insertSubview:[draggableBackground.loadedCards objectAtIndex:i] belowSubview:[draggableBackground.loadedCards objectAtIndex:i-1]];
                        } else {
                            [draggableBackground addSubview:[draggableBackground.loadedCards objectAtIndex:i]];
                        }
                        draggableBackground.cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
                    }
                }
                
                
            }
            
        }
    }];

}

- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor {
    self = [super init];
    if (self) {
        self.view = [[UIView alloc] initWithFrame:CGRectZero];
        self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.view.backgroundColor = aBkgColor;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = aText;
        label.font = [UIFont boldSystemFontOfSize:40];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                  UIViewAutoresizingFlexibleTopMargin    |
                                  UIViewAutoresizingFlexibleBottomMargin);
        [self.view addSubview:label];
        
        CGSize bestSize = [label.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                             options:NSStringDrawingTruncatesLastVisibleLine
                                                             context:NULL].size;
        label.frame = CGRectMake(0,
                                 ((CGRectGetHeight(self.view.frame)-bestSize.height)/2.0f),
                                 CGRectGetWidth(self.view.frame),
                                 bestSize.height);
        
    }
    return self;
}

- (DMPagerNavigationBarItem *)pagerItem {
    return self.pagerObj;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showNewEventViewController
{
//    NSLog(@"Button CLicked");
//    
//    [self performSegueWithIdentifier:@"takePic" sender:self];

}

//- (DMPagerNavigationBarItem *)pagerItem {
//    DMPagerNavigationBarItem *item;
//    UIImage *itemIcon = [UIImage imageWithContentsOfFile:@"messageButton"];
//    NSAttributedString *itemTitle = @"abc";
//    item = [DMPagerNavigationBarItem newItemWithText:itemTitle andIcon: itemIcon];
//    item.renderingMode = DMPagerNavigationBarItemModeOnlyText;
//    return item;
//}

@end
