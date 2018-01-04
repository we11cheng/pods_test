//
//  WKWebView+Gwc_showPicture.m
//  Omnistore
//
//  Created by admin on 16/10/2017.
//  Copyright © 2017 guanweicheng. All rights reserved.
//

#import "WKWebView+Gwc_showPicture.h"
//#import "BYBigPhotoPageVC.h"
#import <objc/runtime.h>

static char imgUrlArrayKey;

@implementation WKWebView (Gwc_showPicture)

- (void)setImgUrlArray:(NSArray *)imgUrlArray
{
    objc_setAssociatedObject(self, &imgUrlArrayKey, imgUrlArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)imgUrlArray
{
    return objc_getAssociatedObject(self, &imgUrlArrayKey);
}

-(NSArray *)getImageUrlByJS:(WKWebView *)wkWebView
{
    
    //查看大图代码
    //js方法遍历图片添加点击事件返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgUrlStr='';\
    for(var i=0;i<objs.length;i++){\
    if(i==0){\
    if(objs[i].alt==''){\
    imgUrlStr=objs[i].src;\
    }\
    }else{\
    if(objs[i].alt==''){\
    imgUrlStr+='#'+objs[i].src;\
    }\
    }\
    objs[i].onclick=function(){\
    if(this.alt==''){\
    document.location=\"myweb:imageClick:\"+this.src;\
    }\
    };\
    };\
    return imgUrlStr;\
    };";
    
    //用js获取全部图片
    [wkWebView evaluateJavaScript:jsGetImages completionHandler:^(id Result, NSError * error) {
        NSLog(@"js___Result==%@",Result);
        NSLog(@"js___Error -> %@", error);
    }];
    
    
    NSString *js2=@"getImages()";
    
    __block NSArray *array=[NSArray array];
    [wkWebView evaluateJavaScript:js2 completionHandler:^(id Result, NSError * error) {
        NSLog(@"js2__Result==%@",Result);
        NSLog(@"js2__Error -> %@", error);
        
        NSString *resurlt=[NSString stringWithFormat:@"%@",Result];
        
        if([resurlt hasPrefix:@"#"])
        {
            resurlt=[resurlt substringFromIndex:1];
        }
        NSLog(@"result===%@",resurlt);
        array=[resurlt componentsSeparatedByString:@"#"];
        NSLog(@"array====%@",array);
        [wkWebView setImgUrlArray:array];
    }];
    
    return array;
}

-(BOOL)showBigImage:(NSURLRequest *)request
{
    //将url转换为string
    NSString *requestString = [[request URL] absoluteString];
    
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"])
    {
        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
        NSLog(@"image url------%@", imageUrl);
        
        //NSArray *imgUrlArr=[self imgUrlArray];
//        BYBigPhotoPageVC *photoPage = [[BYBigPhotoPageVC alloc]initWithImageSourceArray:@[imageUrl]];
//        photoPage.initialPageIndex = 0;
//        [[UIViewController wh_currentViewController] presentViewController:photoPage animated:YES completion:^{
//   
//        }];
//        
        return NO;
    }
    return YES;
}

@end
