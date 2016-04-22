//
//  TSGameController.h
//  Sea Battle
//
//  Created by Mac on 16.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TSGameControllerDelegate

- (NSArray *)rectViewOne;

@end

@interface TSGameController : UIViewController

@property (assign, nonatomic) id <TSGameControllerDelegate> delegate;

@end
