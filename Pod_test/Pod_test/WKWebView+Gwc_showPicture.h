//
//  WKWebView+Gwc_showPicture.h
//  Omnistore
//
//  Created by admin on 16/10/2017.
//  Copyright © 2017 guanweicheng. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (Gwc_showPicture)

@property (nonatomic, strong)NSArray *imgUrlArray;


-(NSArray *)getImageUrlByJS:(WKWebView *)wkWebView;
-(BOOL)showBigImage:(NSURLRequest *)request;

@end
