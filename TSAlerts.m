//
//  TSAlerts.m
//  Sea Battle
//
//  Created by Mac on 21.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSAlerts.h"

static NSString *alert = @"Закончить игру?";

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

+ (void)createdAlertGameOver:(UIView *)parentView button:(UIButton *)yesButon button:(UIButton *)noButton;
{
    CGRect rect = CGRectMake(184, -100, 200, 120);
    UIColor *color = [UIColor colorWithRed:113.0 / 255.0 green:43.0 / 255.0 blue:249.0 / 255.0 alpha:1];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0;
    view.layer.cornerRadius = 5;
    [parentView addSubview:view];
    
    CGRect labelRect = CGRectMake(25, 15, 150, 50);
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    [label setTextColor:color];
    [label setFont:[UIFont fontWithName:@"Savoye LET" size:32.0]];
    [label setText:alert];
    [view addSubview:label];
    
    yesButon = [[UIButton alloc] initWithFrame:CGRectMake(25, 50, 50, 50)];
    [yesButon setTintColor:color];
    [yesButon setTitle:@"Да" forState:UIControlStateNormal];
    [label addSubview:yesButon];
    
    noButton = [[UIButton alloc] initWithFrame:CGRectMake(125, 50, 50, 50)];
    [noButton setTintColor:color];
    [noButton setTitle:@"Нет" forState:UIControlStateNormal];
    [label addSubview:noButton];
    
    CGRect newRect = CGRectMake(184, 100, 200, 120);
    [UIView animateWithDuration:0.5
                     animations:^{
                         view.frame = newRect;
                         view.alpha = 0.85f;
                     }];
    [yesButon autorelease];
    [noButton autorelease];
    [label autorelease];
    [view autorelease];
}

@end
