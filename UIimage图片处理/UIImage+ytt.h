//
//  UIImage+ytt.h
//  UIimage图片处理
//
//  Created by 泰吉通 on 16/12/8.
//  Copyright © 2016年 泰吉通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ytt)
+ (UIImage *)pixelBufferToImage:(CVPixelBufferRef) pixelBufffer;
+ (UIImage *)scaleImage:(UIImage *)image withScale:(float)scale;
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size;
+ (UIImage *)mosaicImage:(UIImage *)image withLevel:(int)level;
+ (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level;

@end
