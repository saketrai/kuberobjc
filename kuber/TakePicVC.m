//
//  TakePicVC.m
//  
//
//  Created by Saket Rai on 6/27/15.
//
//

#import "TakePicVC.h"

@interface TakePicVC ()
@property (weak, nonatomic) IBOutlet UIImageView *pickedImageView;

@end

@implementation TakePicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self useCamera:self];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
