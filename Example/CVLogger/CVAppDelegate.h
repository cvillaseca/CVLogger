//
//  CVAppDelegate.h
//  CVLogger
//
//  Created by Cristian Villaseca on 03/12/2016.
//  Copyright (c) 2016 Cristian Villaseca. All rights reserved.
//
#import <CVLogger/CVLogger.h>

@import UIKit;

@interface CVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CVLogger *cvlogger;

@end
