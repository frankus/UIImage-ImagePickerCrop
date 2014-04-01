//
//  UIImage+ImagePickerCrop.h
//  ImagePickerCropDemo
//
//  Created by Frank Schmitt on 4/1/14.
//  Copyright (c) 2014 Frank Schmitt. See LICENSE. 
//

#import <UIKit/UIKit.h>

@interface UIImage (ImagePickerCrop)

+ (UIImage *)croppedImageWithImagePickerInfo:(NSDictionary *)info;

@end
