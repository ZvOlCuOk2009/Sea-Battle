//
//  TSGeneratedPoint.m
//  Sea Battle
//
//  Created by Mac on 21.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSGeneratedPoint.h"

static NSInteger cellSize = 22;
static NSInteger correctionValue = 12;

@implementation TSGeneratedPoint

- (void)receivingPoint:(CGPoint)point
{
    NSInteger intermediateResultX = point.x / cellSize;
    NSInteger newOriginX = intermediateResultX * cellSize;
    NSInteger intermediateResultY = point.y / cellSize;
    NSInteger newOriginY = (intermediateResultY * cellSize) + correctionValue;
    CGPoint newPoint = CGPointMake(newOriginX, newOriginY);
    [self.delegate pointTransmission:newPoint];
}

@end
