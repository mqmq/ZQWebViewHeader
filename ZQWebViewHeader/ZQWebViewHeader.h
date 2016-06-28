//
//  ZQWebViewHeader.h
//  ZQWebViewHeader
//
//  Created by zhang on 16/6/27.
//  Copyright © 2016年 zhangqq.com. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ZQWebViewHeader : UIWebView
//webview头
@property (nonatomic,strong)UIView *header;
//webview尾
@property (nonatomic,strong)UIView *footder;

//调整头区高度
- (void)setHeaderHight:(CGFloat)hight animate:(BOOL)animate;
@end
