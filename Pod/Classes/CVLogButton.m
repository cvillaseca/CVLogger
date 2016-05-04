//
//  CVLogButton.m
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#import "CVLogButton.h"

#define kButtonMargin 5.0f

@implementation CVLogButton

-(instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (!(self = [super initWithCoder:aDecoder])) {
        return nil;
    }
    [self commonInit];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return nil;
    }
    [self commonInit];
    return self;
}

-(void) commonInit {
    self.frame = CGRectMake(50, 70, 40, 40);
    self.backgroundColor = [UIColor colorWithWhite:.6f alpha:.7f];
    [self setShowsTouchWhenHighlighted:YES];
    [self setTransparentWithAnimation];
}

- (void)drawRect:(CGRect)rect {
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.backgroundColor = [UIColor colorWithWhite:.6f alpha:.7f];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    CGPoint touchLocation = [touch locationInView:currentWindow];
    self.center = touchLocation;

    [self touchesCancelled:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    CGRect frame = self.frame;
    CGRect screenLimit = [[UIScreen mainScreen] bounds];
    BOOL change = NO;
    
    if (self.frame.origin.x < kButtonMargin) {
        change = YES;
        frame.origin.x = kButtonMargin;
    }
    
    if (self.frame.origin.y < kButtonMargin) {
        change = YES;
        frame.origin.y = kButtonMargin;
    }
    
    if (self.frame.origin.x + self.frame.size.width > screenLimit.size.width - kButtonMargin ) {
        change = YES;
        frame.origin.x = screenLimit.size.width - kButtonMargin - frame.size.width ;
        
    }
    
    if (self.frame.origin.y + self.frame.size.height > screenLimit.size.height - kButtonMargin ) {
        change = YES;
        frame.origin.y = screenLimit.size.height - kButtonMargin - frame.size.height ;
    }
    
    if (change) {
        [UIView animateWithDuration:0.6 animations:^{
            self.frame = frame;
        }];
    }
    
    [self setTransparentWithAnimation];
    
}

-(void) setTransparentWithAnimation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor colorWithWhite:.8f alpha:.4f];
        }];
        
    });
}

@end
