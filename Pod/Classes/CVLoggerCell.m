//
//  CVLoggerCell.m
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#import "CVLoggerCell.h"

@implementation CVLoggerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.logLabel = [[UILabel alloc] init];
        self.logLabel.textColor = [UIColor blackColor];
        self.logLabel.numberOfLines = 0;
        
        self.logLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        self.logLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.logLabel];
        
        NSDictionary *views = @{@"logLabel":self.logLabel};
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[logLabel]-8-|"
                                                                       options: 0
                                                                       metrics:nil
                                                                         views:views];
        [self.contentView addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[logLabel]-4-|"
                                                              options: 0
                                                              metrics:nil
                                                                views:views];
        [self.contentView addConstraints:constraints];
    }
    
    return self;
}


@end
