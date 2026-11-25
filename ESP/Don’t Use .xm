#import <UIKit/UIKit.h>
#import <objc/runtime.h>

%hook UIViewController

- (void)viewDidLoad {
    %orig; // Always call original first

    // Only inject into specific screens (not every view controller)
    // Example: only inject if it’s the main menu
    NSString *vcName = NSStringFromClass([self class]);
    if ([vcName containsString:@"OverlayView"] || [vcName containsString:@"GameViewController"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, self.view.center.y - 75, self.view.frame.size.width - 100, 150)];
            myLabel.numberOfLines = 0;
            myLabel.text = [NSString stringWithFormat:@"PRIVATE"]; // Optional text
            myLabel.textAlignment = NSTextAlignmentCenter;
            myLabel.textColor = [UIColor blackColor]; // Start black
            myLabel.shadowColor = [UIColor blackColor];
            myLabel.shadowOffset = CGSizeMake(1, 1);
            myLabel.backgroundColor = [UIColor clearColor];
            myLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 150);

            // Set custom font (if available)
            myLabel.font = [UIFont fontWithName:@"nasalization" size:40];

            [self.view addSubview:myLabel];

            CGFloat speed = 0.8f;
            void (^changeRainbowColor)(void) = ^{
                CGFloat time = CACurrentMediaTime();
                CGFloat red = sin(time * speed + 0.0f) * 0.8f + 0.8f;
                CGFloat green = sin(time * speed + 2.0f) * 0.8f + 0.8f;
                CGFloat blue = sin(time * speed + 4.0f) * 0.8f + 0.8f;
                [UIView animateWithDuration:0.05 animations:^{
                    myLabel.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
                }];
            };

            changeRainbowColor();

            [NSTimer scheduledTimerWithTimeInterval:0.033 repeats:YES block:^(NSTimer * _Nonnull timer) {
                changeRainbowColor();
            }];
        });
    }
}

%end
