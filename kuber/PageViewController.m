//
//  PageViewController.m
//  kuber
//
//  Created by Saket Rai on 6/28/15.
//  Copyright (c) 2015 Saket Rai. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()
{
    NSArray *myViewControllers;
}


@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.delegate = self;
    self.dataSource = self;
    
    UIViewController *p1 = [self.storyboard
                            instantiateViewControllerWithIdentifier:@"kuberMarket"];
    UIViewController *p2 = [self.storyboard
                            instantiateViewControllerWithIdentifier:@"takePic"];
    UIViewController *p3 = [self.storyboard
                            instantiateViewControllerWithIdentifier:@"takePic"];
//    UIViewController *p4 = [self.storyboard
//                            instantiateViewControllerWithIdentifier:@"Intro4ID"];
    myViewControllers= [[NSMutableArray alloc]init];
    myViewControllers = @[p1,p2,p3];
    
    [self setViewControllers:@[p1]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO completion:nil];
    
    NSLog(@"loaded!");
}
-(UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    return myViewControllers[index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
     viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [myViewControllers indexOfObject:viewController];
    
    --currentIndex;
    currentIndex = currentIndex % (myViewControllers.count);
    return [myViewControllers objectAtIndex:currentIndex];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [myViewControllers indexOfObject:viewController];
    
    ++currentIndex;
    currentIndex = currentIndex % (myViewControllers.count);
    return [myViewControllers objectAtIndex:currentIndex];
}

-(NSInteger)presentationCountForPageViewController:
(UIPageViewController *)pageViewController
{
    return myViewControllers.count;
}

-(NSInteger)presentationIndexForPageViewController:
(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation
 
 

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
