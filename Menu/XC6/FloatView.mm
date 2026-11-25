//
//  FloatView.mm
//

#import "Menu/XC6/FloatView.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "ESP/API/APIClient.h"
#import "ESP/encrypt.h"

@implementation FloatView

+ (void)initialize {
    [super initialize];

    APIClient *API = [[APIClient alloc] init];
    [API setToken:NSSENCRYPT("3UNf6rmCj6JQTG5wLcp+p+JS+BQV/pOKqUZvRkHQJPwBp1IHMKPqLemp7U3UoJOZdaEw/5b2uoKh9uQZyxwxJ2N17gsnsuY6S/R513lcF84=")];
    [API paid:^{
        // Develop By ERRORMVPX
    }];
}

BOOL menuOpenedByVolumeDown;
float previousVolume;
static int menuToggleMethod = 0;

+ (void)setMenuToggleMethod:(int)method {
    menuToggleMethod = method;

    if (method == 1) {
        
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
        for (UIGestureRecognizer *recognizer in mainWindow.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UITapGestureRecognizer class]]) {
                UITapGestureRecognizer *tap = (UITapGestureRecognizer *)recognizer;
                if (tap.numberOfTapsRequired == 2 && tap.numberOfTouchesRequired == 3) {
                    return; 
                }
            }
        }

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.numberOfTapsRequired = 2;
        tap.numberOfTouchesRequired = 3;
        [mainWindow addGestureRecognizer:tap];
        [tap addTarget:self action:@selector(globalIconTap)];
    }
}

+ (int)getMenuToggleMethod {
    return menuToggleMethod;
}

// This is called from dynamic gesture
+ (void)globalIconTap {
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    for (UIView *view in mainWindow.subviews) {
        if ([view isKindOfClass:[FloatView class]]) {
            FloatView *fv = (FloatView *)view;
            [fv iconOnClick];
            break;
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame :(ModuleControl*)control {
    self.moduleControl = control;

    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = frame.size.width * 0.3;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];

        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];

        if (menuToggleMethod == 0) {
            // Volume Button Mode
            menuOpenedByVolumeDown = NO;
            previousVolume = [[AVAudioSession sharedInstance] outputVolume];

            NSTimer *volumeMonitor = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60)
                                                                      repeats:YES
                                                                        block:^(NSTimer * _Nonnull timer) {
                AVAudioSession *audioSession = [AVAudioSession sharedInstance];
                [audioSession setActive:YES error:nil];
                float currentVolume = [audioSession outputVolume];

                if (currentVolume < previousVolume) {
                    // Volume Down
                    menuOpenedByVolumeDown = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.moduleControl->menuStatus = true;
                    });
                } else if (currentVolume > previousVolume && menuOpenedByVolumeDown) {
                    // Volume Up after Down
                    menuOpenedByVolumeDown = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.moduleControl->menuStatus = false;
                    });
                }

                previousVolume = currentVolume;
            }];
            [[NSRunLoop currentRunLoop] addTimer:volumeMonitor forMode:NSRunLoopCommonModes];
        } else {
            // Gesture Mode — also triggered dynamically in class method
            UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            tap.numberOfTapsRequired = 2;
            tap.numberOfTouchesRequired = 3;
            [mainWindow addGestureRecognizer:tap];
            [tap addTarget:self action:@selector(iconOnClick)];
        }
    }
    return self;
}

- (void)iconOnClick {
    NSLog(@"3-finger tap detected");
    self.moduleControl->menuStatus = !self.moduleControl->menuStatus;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    _startLocation = pt;
    [[self superview] bringSubviewToFront:self];
}

@end
