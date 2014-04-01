//
//  FMSViewController.m
//  ImagePickerCropDemo
//
//  Created by Frank Schmitt on 4/1/14.
//  Copyright (c) 2014 Frank Schmitt. See LICENSE. 
//

#import "FMSViewController.h"
#import "UIImage+ImagePickerCrop.h"

@interface FMSViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FMSViewController

- (void)displayImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = YES;
    
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)takeOrChoosePhoto:(UIBarButtonItem *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Existing", nil] showFromBarButtonItem:sender animated:YES];
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        [self displayImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        [self displayImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex)
        return;
    
    UIImagePickerControllerSourceType sourceType = buttonIndex ? UIImagePickerControllerSourceTypePhotoLibrary : UIImagePickerControllerSourceTypeCamera;
    
    [self displayImagePickerWithSourceType:sourceType];
}

#pragma mark - Image picker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.imageView.image = [UIImage croppedImageWithImagePickerInfo:info];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Scroll view delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
