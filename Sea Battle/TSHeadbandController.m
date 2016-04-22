//
//  TSHeadbandController.m
//  Sea Battle
//
//  Created by Mac on 21.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSHeadbandController.h"
#import "TSStarterController.h"

@interface TSHeadbandController ()

@property (retain, nonatomic) IBOutlet UIButton *gameCompButton;
@property (retain, nonatomic) IBOutlet UIButton *gameBluetoothButton;
@property (retain, nonatomic) IBOutlet UIView *loadingIndicatorView;

@end

@implementation TSHeadbandController

- (void)viewDidLoad
{
    [UIView animateWithDuration:3.0
                     animations:^{
                         _loadingIndicatorView.frame = CGRectMake(146, 260, 277, 4);
                     }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0
                         animations:^{
                             _gameCompButton.frame = CGRectMake(134, 65, 300, 44);
                             _gameBluetoothButton.frame = CGRectMake(134, 130, 300, 49);
                             _gameCompButton.alpha = 1;
                             _gameBluetoothButton.alpha = 1;
                         }];
    });
}

- (IBAction)startAction:(id)sender
{
    TSStarterController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TSStarterController"];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:controller animated:NO completion:nil];
    [_loadingIndicatorView removeFromSuperview];
}

- (void)dealloc {
    [_gameCompButton release];
    [_gameBluetoothButton release];
    [_loadingIndicatorView release];
    [super dealloc];
}
@end
