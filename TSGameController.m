//
//  TSGameController.m
//  Sea Battle
//
//  Created by Mac on 16.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSGameController.h"
#import "TSCalculationService.h"
#import "TSCalculationOfResponseShots.h"
#import "TSGeneratedPoint.h"
#import "TSSoundManager.h"
#import "TSStarterController.h"
#import "TSAlerts.h"

//static BOOL positon = NO;
static BOOL userInteractionAlert = NO;
static NSString *backgroundSheet = @"battle";
static NSString *buttonImgYes = @"button yes";
static NSString *buttonImgNo = @"button no";

@interface TSGameController () <TSCalculationServiceDelegate, TSCalculationOfResponseShotsDelegate>

@property (retain, nonatomic) IBOutletCollection(UIView) NSArray *collectionShip;
@property (retain, nonatomic) IBOutletCollection(UIView) NSArray *collectionEnemyShip;
//@property (retain, nonatomic) UIView *currentView;
@property (retain, nonatomic) UIView *hitView;
@property (retain, nonatomic) UIView *alertView;
@property (retain, nonatomic) UIButton *button;

@property (retain, nonatomic) TSCalculationService *servise;
@property (retain, nonatomic) TSCalculationOfResponseShots *responseShots;


@end

@implementation TSGameController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:backgroundSheet];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    UIView *frame = [[self.delegate rectViewOne] objectAtIndex:0];
    [self.view addSubview:frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint locationPoint = [touch locationInView:self.view];
//    _currentView = [self.view hitTest:locationPoint withEvent:event];
    if (positionButtonStart == YES) {
        BOOL verification = CGRectContainsPoint(_hitView.frame, locationPoint);
        if (verification == NO) {
            if (userInteractionAlert == NO) {
                [[TSSoundManager sharedManager] shotSound];
                _servise = [[TSCalculationService alloc] init];
                _servise.delegate = self;
                [_servise calculateTheAreaForRectangle:locationPoint ships:self.collectionEnemyShip];
            }
        } else {
            NSLog(@"ПОВТОР!");
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
//    CGPoint locationPoint = [[touches anyObject] locationInView:self.view];
//    _currentView.center = locationPoint;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    
}

#pragma mark - TSCalculationServiceDelegate

- (void)calculationResponseView:(CGRect)rect color:(UIColor *)color
{
    [self noteShot:rect color:color];
}

#pragma mark - TSCalculationOfResponseShotsDelegate

- (void)calculationEnemyShotView:(CGRect)rect point:(CGPoint)point color:(UIColor *)color
{
    BOOL verification = CGRectContainsPoint(_hitView.frame, point);
//    NSLog(@"HitView.frame x = %ld, y = %ld, width = %ld, height = %ld,", (long)_hitView.frame.origin.x,
//                                                                         (long)_hitView.frame.origin.x,
//                                                                         (long)_hitView.frame.size.width,
//                                                                         (long)_hitView.frame.size.height);
    if (verification == NO) {
        [self noteShot:rect color:color];
    } else {
        NSLog(@"ПОВТОР ПРОТИВНИК!!!");
        [self transitionProgress];
    }
}

#pragma mark - After firing indication

- (void)noteShot:(CGRect)rect color:(UIColor *)color
{
    [TSAlerts viewNoteShot:rect color:color parentVIew:self.view view:_hitView];
}

#pragma mark - Enemy shot

- (void)transitionProgress
{
    [[TSSoundManager sharedManager] shotSound];
    _responseShots = [[TSCalculationOfResponseShots alloc] init];
    _responseShots.delegate = self;
    [_responseShots shotRequest:self.collectionShip];
}

//#pragma mark - UITapGestureRecognizer
//
//- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
//{
//    if (positon == NO) {
//        [UIView animateWithDuration:0.2
//                         animations:^{
//                             _currentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
//                         }];
//        positon = YES;
//    } else {
//        [UIView animateWithDuration:0.2
//                         animations:^{
//                             _currentView.transform = CGAffineTransformMakeRotation(M_PI);
//                         }];
//        positon = NO;
//    }
//}

#pragma mark - Actions

- (IBAction)backAtion:(id)sender {
 
    if (userInteractionAlert == NO) {
        _alertView = [TSAlerts createdAlertGameOver:self.view];
        UIButton *buttonYes = [self buttonSelected:buttonImgYes x:40 y:50];
        UIButton *buttonNo = [self buttonSelected:buttonImgNo x:110 y:50];
        [buttonYes addTarget:self action:@selector(hangleButtonYes) forControlEvents:UIControlEventTouchUpInside];
        [buttonNo addTarget:self action:@selector(hangleButtonNo) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:buttonYes];
        [_alertView addSubview:buttonNo];
        userInteractionAlert = YES;
    }
}

#pragma mark - Button Alert Game Over

- (UIButton *)buttonSelected:(NSString *)question  x:(CGFloat)x y:(CGFloat)y
{
    _button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 50, 50)];
    UIImage *image = [UIImage imageNamed:question];
    [_button setImage:image forState:UIControlStateNormal];
    return _button;
}

- (void)hangleButtonYes
{
    [self dismissViewControllerAnimated:YES completion:nil];
    userInteractionAlert = NO;
}

- (void)hangleButtonNo
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         _alertView.frame = CGRectMake(184, 520, 200, 120);
                         _alertView.alpha = 0;
                     }];
        userInteractionAlert = NO;
}

- (void)userInteractionEnabled
{
    for (UIView *ship in self.collectionShip) {
        ship.userInteractionEnabled = NO;
    }
    for (UIView *ship in self.collectionEnemyShip) {
        ship.userInteractionEnabled = NO;
    }
}

#pragma mark - Destruction of objects

- (void)dealloc {
    [_collectionShip release];
    [_collectionEnemyShip release];
//    [_currentView release];
    [_servise release];
    [_responseShots release];
//    [_hitView release];
    [_alertView release];
    [_button release];
    [super dealloc];
}

@end
