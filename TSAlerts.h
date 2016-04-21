//
//  TSAlerts.h
//  Sea Battle
//
//  Created by Mac on 21.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//
//   Класс для создания вью и предупреждений

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TSAlerts : NSObject

+ (void)viewNoteShot:(CGRect)rect color:(UIColor *)color parentVIew:(UIView *)parentVIew view:(UIView *)view;
+ (void)createdAlertGameOver:(UIView *)parentView button:(UIButton *)yesButon button:(UIButton *)noButton;

@end
