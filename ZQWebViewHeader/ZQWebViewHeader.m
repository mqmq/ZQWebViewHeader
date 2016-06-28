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

@interface ZQWebViewHeader()

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

- (void)reloadFooterFrame {
    CGSize contentSize = self.scrollView.contentSize;
    _footer.frame = CGRectSetY(_footer.frame,CGRectGetMaxY(_zqBrowserView.frame));
    self.scrollView.contentSize = CGSizeMake(contentSize.width, CGRectGetMaxY(_zqBrowserView.frame) + _footer.frame.size.height);
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
    
    if (_footer) {
        [_footer removeFromSuperview];
        _footer = nil;
    }
    _footer = footder;
    [self.scrollView addSubview:footder];
    [self reloadFooterFrame];
    [self addObserver];
}

- (void)setHeaderHight:(CGFloat)hight animate:(BOOL)animate {
    
    [UIView animateWithDuration:animate?0.3:0 animations:^{
        _header.frame = CGRectSetH(_header.frame, hight);
        _zqBrowserView.frame = CGRectSetY(_zqBrowserView.frame, hight);
    } completion:^(BOOL finished) {
        [self reloadFooterFrame];
    }];
}

//UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //缩小到小于webview宽度时
    CGFloat w = scrollView.frame.size.width;
    if (scrollView.contentSize.width < w) {
        CGSize contentSize = scrollView.contentSize;
        contentSize.width = w;
        scrollView.contentSize = contentSize;
    }
    //左右露边
    _header.frame = CGRectSetX(_header.frame, scrollView.contentOffset.x);
    _footer.frame = CGRectSetX(_footer.frame, scrollView.contentOffset.x);
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
    [self reloadFooterFrame];
    [self addObserver];
}
@end

