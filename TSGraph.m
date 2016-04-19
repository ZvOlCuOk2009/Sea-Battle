//
//  TSGraph.m
//  Sea Battle
//
//  Created by Mac on 19.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSGraph.h"

@implementation TSGraph

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
    CGContextSetLineWidth(context, 3.0);
    CGContextMoveToPoint(context, 10.0, 10.0);
    CGContextAddLineToPoint(context, 100.0, 100.0);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
