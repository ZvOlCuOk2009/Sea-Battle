//
//  TSCalculationService.m
//  Sea Battle
//
//  Created by Mac on 16.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSCalculationService.h"
#import "TSSoundManager.h"

static CGFloat sideRect = 22;
static CGFloat correctionValueX = 23;
static CGFloat correctionValueY = 12;
static BOOL counter = YES;

@interface TSCalculationService ()

@property (assign, nonatomic) CGRect rect;

@end

@implementation TSCalculationService

#pragma mark - ModuleProtocol

- (void)calculateTheAreaForRectangle:(CGPoint)transmittedPoint ships:(NSArray *)collectionShips
{
    _rect = CGRectMake((long)[self calculationValuePositionX:transmittedPoint],
                       (long)[self calculationValuePositionY:transmittedPoint], sideRect, sideRect);
    for (UIView *ship in collectionShips) {
        BOOL verification = CGRectContainsPoint(ship.frame, transmittedPoint);
        if (verification == YES) {
//            NSLog(@"RECT USER x = %ld, y = %ld", (long)[self calculationValuePositionX:transmittedPoint],
//                                                     (long)[self calculationValuePositionY:transmittedPoint]);
            [self.delegate calculationResponseView:_rect color:[self redBackgroundColor]];
            counter = NO;
        }
    }
    if (counter == YES) {
        [self.delegate calculationResponseView:_rect color:[self grayBackgroundColor]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.delegate transitionProgress];
        });
    } else {
        counter = YES;
    }
}

#pragma mark - Background Color View

- (UIColor *)redBackgroundColor
{
    return [UIColor redColor];
}

- (UIColor *)grayBackgroundColor
{
    return [UIColor lightGrayColor];
}

#pragma mark - Сalculation of the affected area

- (NSInteger)calculationValuePositionX:(CGPoint)point
{
    NSInteger result = point.x - correctionValueX;
    NSInteger intermediateResult = result / sideRect;
    NSInteger positionX = (intermediateResult * sideRect) + correctionValueX;
    return positionX;
}

- (NSInteger)calculationValuePositionY:(CGPoint)point
{
    NSInteger result = point.y - correctionValueY;
    NSInteger intermediateResult = result / sideRect;
    NSInteger positionY = (intermediateResult * sideRect) + correctionValueY;
    return positionY;
}

@end
