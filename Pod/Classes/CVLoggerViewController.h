//
//  CVLoggerViewController.h
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#import <UIKit/UIKit.h>

@protocol CVLoggerDelegate <NSObject>

-(void) CVLoggerDidClosed;

@end

@interface CVLoggerViewController : UIViewController

@property (nonatomic) NSInteger collapseHeight;

@property (nonatomic, weak) id <CVLoggerDelegate> delegate;

@end
