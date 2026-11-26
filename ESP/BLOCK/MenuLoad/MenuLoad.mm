#import <UIKit/UIKit.h>
#include "Includes.h"
#import "APIClient.h"
#import "Hinaabil.h"
#import <AVFoundation/AVFoundation.h>

extern bool MenDeal;

static UIWindow *MenuGetActiveWindow(void) {
    NSArray<UIWindow *> *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *win in windows) {
        if (win.isKeyWindow && win.rootViewController.view) {
            return win;
        }
    }
    for (UIWindow *win in windows) {
        if (win.rootViewController.view) {
            return win;
        }
    }
    for (UIWindow *win in windows) {
        if (!win.hidden && win.bounds.size.width > 0 && win.bounds.size.height > 0) {
            return win;
        }
    }
    return windows.firstObject;
}

@interface ImGuiLoad ()
@property (nonatomic, strong) ImGuiDrawView *vna;
@property (nonatomic, assign) BOOL autoOpened;
@property (nonatomic, assign) NSInteger retryCount;
@end

@implementation ImGuiLoad

+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[self share] autoOpenWhenReady];
        [[self share] initTapGes];
    });
}

+ (instancetype)share {
    static ImGuiLoad *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[ImGuiLoad alloc] init];
    });
    return tool;
}

- (void)autoOpenWhenReady {
    if (self.autoOpened) return;

    UIWindow *win = MenuGetActiveWindow();
    UIView *targetView = win.rootViewController.view ?: win;

    if (!targetView) {
        if (self.retryCount < 30) {
            self.retryCount++;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self autoOpenWhenReady];
            });
        }
        return;
    }

    self.autoOpened = YES;
    MenDeal = true;

    if (!_vna) {
        _vna = [[ImGuiDrawView alloc] init];
    }

    if (_vna.view.superview != targetView) {
        _vna.view.frame = targetView.bounds;
        _vna.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [targetView addSubview:_vna.view];
    }

    _vna.view.hidden = NO;
    _vna.view.userInteractionEnabled = YES;
    [targetView bringSubviewToFront:_vna.view];
}

- (void)initTapGes {
    UIWindow *win = MenuGetActiveWindow();
    UIView *targetView = win.rootViewController.view ?: win;
    if (!targetView) return;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(show)];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 2;
    tap.cancelsTouchesInView = NO;
    [targetView addGestureRecognizer:tap];
}

- (void)show {
    UIWindow *win = MenuGetActiveWindow();
    UIView *targetView = win.rootViewController.view ?: win;
    if (!targetView) return;

    if (!_vna) {
        _vna = [[ImGuiDrawView alloc] init];
    }

    if (MenDeal) {
        MenDeal = false;
        _vna.view.hidden = YES;
        _vna.view.userInteractionEnabled = NO;
    } else {
        MenDeal = true;
        if (_vna.view.superview != targetView) {
            _vna.view.frame = targetView.bounds;
            _vna.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [targetView addSubview:_vna.view];
        }
        _vna.view.hidden = NO;
        _vna.view.userInteractionEnabled = YES;
        [targetView bringSubviewToFront:_vna.view];
    }
}

@end
