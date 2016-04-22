//
//  TSGeneratedPoint.h
//  Sea Battle
//
//  Created by Mac on 21.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

//  Класс для корректного расположения кораблей в сетке

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TSGeneratedPointDelegate <NSObject>

@required

- (void)pointTransmission:(CGPoint)point;

@end

@interface TSGeneratedPoint : NSObject

@property (assign, nonatomic) id <TSGeneratedPointDelegate> delegate;

- (void)receivingPoint:(CGPoint)point;

@end
