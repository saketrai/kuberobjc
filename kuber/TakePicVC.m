//
//  TakePicVC.m
//  
//
//  Created by Saket Rai on 6/27/15.
//
//

#import "TakePicVC.h"
#import <Parse/Parse.h>

@interface TakePicVC ()
@property (weak, nonatomic) IBOutlet UIImageView *pickedImageView;

@end

@implementation TakePicVC
- (IBAction)openCamera:(id)sender {
    [self useCamera:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIImage* image3 = [UIImage imageNamed:@"openBox3"];
//    CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
//    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
//    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
//    [someButton addTarget:self action:@selector(addtoOpenBox)
//         forControlEvents:UIControlEventTouchUpInside];
//    [someButton setShowsTouchWhenHighlighted:YES];
//    
//    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
//    self.navigationItem.rightBarButtonItem=mailbutton;
    NSLog(@"Pushed");
    


}

- (void) pager:(DMPagerViewController *) aController didChangePageFrom:(NSInteger) aOldPage to:(NSInteger) aNewPage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(useCamera:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Take Pic" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
}
- (void) pager:(DMPagerViewController *) aController didScrollTo:(CGPoint) aOffset
{

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

- (void) useCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = YES;
    }
}
//    - (void) useCameraRoll:(id)sender
//    {
//        if ([UIImagePickerController isSourceTypeAvailable:
//             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
//        {
//            UIImagePickerController *imagePicker =
//            [[UIImagePickerController alloc] init];
//            imagePicker.delegate = self;
//            imagePicker.sourceType =
//            UIImagePickerControllerSourceTypePhotoLibrary;
//            imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
//            imagePicker.allowsEditing = NO;
//            [self presentViewController:imagePicker
//                               animated:YES completion:nil];
//            _newMedia = NO;
//        }
//    }
//}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *pickedImage = info[UIImagePickerControllerOriginalImage];
        
        self.pickedImageView.image = pickedImage;
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(pickedImage,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
        
       // NSData *imageData = UIImagePNGRepresentation(pickedImage,0.5);
        NSData *imageData = UIImageJPEGRepresentation(pickedImage, 0.5);

        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
        
        PFObject *userPhoto = [PFObject objectWithClassName:@"marketPics"];
        userPhoto[@"imageName"] = @"Remote";
        userPhoto[@"imageFile"] = imageFile;
        userPhoto[@"username"]=[[PFUser currentUser] username];
        [userPhoto saveInBackground];
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addToOpenBox
{
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
