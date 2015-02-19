//
//  MessageTableViewCell.m
//  HipaaGram
//
//  Created by ault on 2/18/15.
//  Copyright (c) 2015 Catalyze Inc. All rights reserved.
//

#import "MessageTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MessageTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTimestamp;
@property (weak, nonatomic) IBOutlet UIView *viewMessageHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblFrom;

@property (strong, nonatomic) NSMutableArray *constraints;

@end

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)initializeWithMessage:(Message *)message sender:(BOOL)sender {
    if (!_constraints) {
        _constraints = [NSMutableArray array];
    }
    for (UIView *view in _viewMessageHolder.subviews) {
        [view removeFromSuperview];
    }
    UITextView *txtMessage = [self generateTextView];
    txtMessage.text = [message text];
    _lblFrom.text = [message sender];
    
    NSDate *timestamp = [message date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy, h:mm.ss a"];
    _lblTimestamp.text = [format stringFromDate:timestamp];
    
    [_viewMessageHolder addSubview:txtMessage];
    
    CGSize idealSize = [txtMessage sizeThatFits:CGSizeMake(_viewMessageHolder.frame.size.width*0.8, 0)];
    NSDictionary *views = @{@"txt":txtMessage};
    NSArray *constraint_HORIZONTAL;
    CGFloat widthDifference = _viewMessageHolder.frame.size.width - fmin(fmax(idealSize.width, 40.0), _viewMessageHolder.frame.size.width*0.8);
    if (sender) {
        constraint_HORIZONTAL = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[txt]-0-|", widthDifference]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views];
        txtMessage.textAlignment = NSTextAlignmentRight;
        _lblFrom.textAlignment = NSTextAlignmentRight;
        txtMessage.backgroundColor = [UIColor colorWithRed:51.0/255.0f green:181.0/255.0f blue:229.0/255.0f alpha:1.0f];
    } else {
        constraint_HORIZONTAL = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[txt]-%f-|", widthDifference]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views];
        txtMessage.textColor = [UIColor blackColor];
        txtMessage.backgroundColor = [UIColor colorWithRed:225.0/255.0f green:225.0/255.0f blue:225.0/255.0f alpha:1.0f];
    }
    
    NSArray *constraint_VERTICAL = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[txt]-0-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:views];
    for (id constraintsArray in _constraints) {
        [self removeConstraints:constraintsArray];
    }
    [_constraints addObject:constraint_HORIZONTAL];
    [_constraints addObject:constraint_VERTICAL];
    [_viewMessageHolder addConstraints:constraint_VERTICAL];
    [_viewMessageHolder addConstraints:constraint_HORIZONTAL];
}

- (UITextView *)generateTextView {
    UITextView *txtView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, _viewMessageHolder.frame.size.width, _viewMessageHolder.frame.size.height)];
    txtView.textAlignment = NSTextAlignmentLeft;
    txtView.translatesAutoresizingMaskIntoConstraints = NO;
    txtView.layer.cornerRadius = 15;
    txtView.dataDetectorTypes = UIDataDetectorTypeAll;
    txtView.editable = NO;
    txtView.textColor = [UIColor whiteColor];
    txtView.font = [UIFont systemFontOfSize:14.0];
    txtView.scrollEnabled = NO;
    txtView.showsHorizontalScrollIndicator = NO;
    txtView.showsVerticalScrollIndicator = NO;
    return txtView;
}

@end
