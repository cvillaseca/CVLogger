//
//  CVLogButton.m
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#import "CVLogButton.h"


@implementation CVLogButton


- (void)drawRect:(CGRect)rect {
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.backgroundColor = [UIColor colorWithWhite:.8f alpha:.4f];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    CGPoint touchLocation = [touch locationInView:currentWindow];
    
    CGRect screenLimit = [[UIScreen mainScreen] bounds];
    
    if ((touchLocation.x + self.frame.size.width) < screenLimit.size.width &&
        (touchLocation.y + self.frame.size.height) < screenLimit.size.height &&
        touchLocation.x - self.frame.size.width > 0 &&
        touchLocation.y - self.frame.size.height > 0) {
        self.center = touchLocation;
    }
    
    [self touchesCancelled:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor colorWithWhite:.6f alpha:.7f];
        }];
        
    });
    
    
}

@end
