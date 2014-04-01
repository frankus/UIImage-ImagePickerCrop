//
//  UIImage+ImagePickerCrop.m
//  ImagePickerCropDemo
//
//  Created by Frank Schmitt on 4/1/14.
//  Copyright (c) 2014 Frank Schmitt. See LICENSE. 
//

#import "UIImage+ImagePickerCrop.h"

@implementation UIImage (ImagePickerCrop)

+ (UIImage *)croppedImageWithImagePickerInfo:(NSDictionary *)info {
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGRect cropRect = [[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];
    CGAffineTransform rotateTransform = CGAffineTransformIdentity;
    
    switch (originalImage.imageOrientation) {
        case UIImageOrientationDown:
            rotateTransform = CGAffineTransformRotate(rotateTransform, M_PI);
            rotateTransform = CGAffineTransformTranslate(rotateTransform, -originalImage.size.width, -originalImage.size.height);
            break;
            
        case UIImageOrientationLeft:
            rotateTransform = CGAffineTransformRotate(rotateTransform, M_PI_2);
            rotateTransform = CGAffineTransformTranslate(rotateTransform, 0.0, -originalImage.size.height);
            break;
            
        case UIImageOrientationRight:
            rotateTransform = CGAffineTransformRotate(rotateTransform, -M_PI_2);
            rotateTransform = CGAffineTransformTranslate(rotateTransform, -originalImage.size.width, 0.0);
            break;
            
        default:
            break;
    }
    
    CGRect rotatedCropRect = CGRectApplyAffineTransform(cropRect, rotateTransform);
    
    CGImageRef croppedImage = CGImageCreateWithImageInRect([originalImage CGImage], rotatedCropRect);
    UIImage *result = [UIImage imageWithCGImage:croppedImage scale:[UIScreen mainScreen].scale orientation:originalImage.imageOrientation];
    CGImageRelease(croppedImage);
    
    return result;
}

@end
