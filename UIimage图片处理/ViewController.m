//
//  ViewController.m
//  UIimage图片处理
//
//  Created by 泰吉通 on 16/12/8.
//  Copyright © 2016年 泰吉通. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ytt.h"

@interface ViewController ()
@property(nonatomic,copy)NSString * paths;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString * imgPath = [[NSBundle mainBundle]pathForResource:@"011" ofType:@"jpg"];
    _paths = imgPath;
    UIImage * iamg = [UIImage imageWithContentsOfFile:imgPath];
    
//    UIImage * iamg = [UIImage imageNamed:@"011.jpg"];
    
    UIImageView * imagView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 150)];
    [imagView setImage:iamg];
    [self.view addSubview:imagView];
    
    UIImage * imag2 = [UIImage transToMosaicImage:iamg blockLevel:10];
    UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 300, 200, 150)];
    [imageView2 setImage:imag2];
    [self.view addSubview:imageView2];
    
    UIImage * img3 = [UIImage scaleImage:iamg withScale:0.5];
    NSData * imageData = UIImageJPEGRepresentation(img3,1);
    
    NSInteger length = [imageData length]/1000;
    
    NSData * imageData2 = UIImageJPEGRepresentation(iamg,1);
    
    NSInteger length2 = [imageData2 length]/1000;

    if (img3) {
        
        
        NSLog(@"原图片   width===%fheight=====%f",iamg.size.width,iamg.size.height);
        NSLog(@"缩放图片  width===%fheight=====%f",img3.size.width,img3.size.height);
        NSLog(@"原来图片image大小   ==================%ld",length2);
        NSLog(@"缩放后图片image大小   ==================%ld",length);
        
    }
    
    NSLog(@"图片大小====%@",[self fileSize]);
    NSLog(@"图片大小2====%@",[self fileToSize]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 计算文件大小一
- (NSString *)fileSize
{
    // 总大小
    unsigned long long size = 0;
    NSString *sizeText = nil;
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件属性
    NSDictionary *attrs = [mgr attributesOfItemAtPath:_paths error:nil];
    
    // 如果这个文件或者文件夹不存在,或者路径不正确直接返回0;
    if (attrs == nil) return 0;
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:_paths];
        for (NSString *subpath in enumerator) {
            // 全路径
            NSString *fullSubpath = [subpath stringByAppendingPathComponent:subpath];
            // 累加文件大小
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
            
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
        }
        return sizeText;
    } else { // 如果是文件
        size = attrs.fileSize;
        if (size >= pow(10, 9)) { // size >= 1GB
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        } else { // 1KB > size
            sizeText = [NSString stringWithFormat:@"%zdB", size];
        }
        
    }
    return sizeText;
}

#pragma 计算文件大小方法二
- (NSString*)fileToSize
{
    // 总大小
    unsigned long long size = 0;
    NSString *sizeText = nil;
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    BOOL exist = [manager fileExistsAtPath:_paths isDirectory:&isDir];
    
    // 判断路径是否存在
    if (!exist) return @"d";
    if (isDir) { // 是文件夹
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:_paths];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [subPath stringByAppendingPathComponent:subPath];
            size += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
            
        }
    }else{ // 是文件
        size += [manager attributesOfItemAtPath:_paths error:nil].fileSize;
    }
    NSString * sizeTe = [NSString stringWithFormat:@"%llu",size];
    return sizeTe;
}

@end
