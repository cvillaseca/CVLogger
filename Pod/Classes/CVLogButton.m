//
//  CVLogButton.m
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#import "CVLogButton.h"


@implementation CVLogButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
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
}

@end
