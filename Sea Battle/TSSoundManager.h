//
//  TSSoundManager.h
//  Sea Battle
//
//  Created by Mac on 21.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//
//   Класс для создания звуков

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface TSSoundManager : NSObject

+ (TSSoundManager *) sharedManager;
- (void)shotSound;

@end
