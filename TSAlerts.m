//
//  TSAlerts.m
//  Sea Battle
//
//  Created by Mac on 21.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSAlerts.h"

static NSString *alert = @"Закончить игру?";
static NSString *font = @"Savoye LET";
static CGFloat redColor = 113.0 / 255.0;
static CGFloat greenColor = 43.0 / 255.0;
static CGFloat blueColor = 249.0 / 255.0;

@implementation TSAlerts

#pragma mark - Created view note shot

+ (void)viewNoteShot:(CGRect)rect color:(UIColor *)color parentVIew:(UIView *)parentVIew view:(UIView *)view
{
    view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = color;
    view.alpha = 0.7f;
    view.userInteractionEnabled = NO;
    [parentVIew addSubview:view];
    [view autorelease];
}

#pragma mark - Created alert game over

+ (UIView *)createdAlertGameOver:(UIView *)parentView;
{
    CGRect rect = CGRectMake(184, -100, 200, 120);
    UIColor *color = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1];
    UIView *alertView = [[UIView alloc] initWithFrame:rect];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.alpha = 0;
    alertView.layer.cornerRadius = 5;
    [parentView addSubview:alertView];
    
    CGRect labelRect = CGRectMake(20, 15, 170, 50);
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    [label setTextColor:color];
    [label setFont:[UIFont fontWithName:font size:34.0]];
    [label setText:alert];
    [alertView addSubview:label];
    
    CGRect newRect = CGRectMake(184, 100, 200, 120);
    [UIView animateWithDuration:0.5
                     animations:^{
                         alertView.frame = newRect;
                         alertView.alpha = 0.85f;
                     }];
    [label autorelease];
    return alertView;
}

@end
