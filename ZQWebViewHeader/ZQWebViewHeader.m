//
//  ZQWebViewHeader.m
//  ZQWebViewHeader
//
//  Created by zhang on 16/6/27.
//  Copyright © 2016年 zhangqq.com. All rights reserved.
//

#import "ZQWebViewHeader.h"

CG_INLINE CGRect
CGRectSetX(CGRect rect, CGFloat x)
{
    rect.origin.x = x;
    return rect;
}

CG_INLINE CGRect
CGRectSetY(CGRect rect, CGFloat y)
{
    rect.origin.y = y;
    return rect;
}

CG_INLINE CGRect
CGRectSetH(CGRect rect, CGFloat h)
{
    rect.size.height = h;
    return  rect;
}

@interface ZQWebViewHeader()<UIWebViewDelegate>

@property (nonatomic,strong)UIView *zqBrowserView;

@end

@implementation ZQWebViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _zqBrowserView = [self.scrollView.subviews lastObject];
    }
    return self;
}

- (void)reloadFootderFrame {
    CGSize contentSize = self.scrollView.contentSize;
    _footder.frame = CGRectSetY(_footder.frame,CGRectGetMaxY(_zqBrowserView.frame));
    self.scrollView.contentSize = CGSizeMake(contentSize.width, CGRectGetMaxY(_zqBrowserView.frame) + _footder.frame.size.height);
}

//set header
- (void)setHeader:(UIView *)header {
    if (_header) {
        [_header removeFromSuperview];
        _header = nil;
    }
    _header = header;
    [self.scrollView addSubview:header];
    _zqBrowserView.frame = CGRectSetY(_zqBrowserView.frame, CGRectGetMaxY(header.frame));
}
//set fooderView
- (void)setFootder:(UIView *)footder {
    
    if (_footder) {
        [_footder removeFromSuperview];
        _footder = nil;
    }
    _footder = footder;
    [self.scrollView addSubview:footder];
    self.delegate = self;
    [self reloadFootderFrame];
}

- (void)setHeaderHight:(CGFloat)hight animate:(BOOL)animate {
    
    [UIView animateWithDuration:animate?0.3:0 animations:^{
        _header.frame = CGRectSetH(_header.frame, hight);
        _zqBrowserView.frame = CGRectSetY(_zqBrowserView.frame, hight);
    } completion:^(BOOL finished) {
        [self reloadFootderFrame];
    }];
}

//UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (_footder) {
        [self addObserver];
        [self reloadFootderFrame];
    }
}
//observer
- (void)addObserver {
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserver {
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self removeObserver];
    [self reloadFootderFrame];
    [self addObserver];
}
@end

