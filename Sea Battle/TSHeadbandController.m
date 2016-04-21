//
//  TSHeadbandController.m
//  Sea Battle
//
//  Created by Mac on 21.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSHeadbandController.h"
#import "TSStarterController.h"

@implementation TSHeadbandController

- (IBAction)startAction:(id)sender {
    
    TSStarterController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TSStarterController"];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:controller animated:NO completion:nil];
}

@end
