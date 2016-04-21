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

static BOOL positon = NO;

@interface TSGameController () <TSCalculationServiceDelegate, TSCalculationOfResponseShotsDelegate, TSGeneratedPointDelegate>

@property (retain, nonatomic) IBOutletCollection(UIView) NSArray *collectionShip;
@property (retain, nonatomic) IBOutletCollection(UIView) NSArray *collectionEnemyShip;
@property (retain, nonatomic) UIView *currentView;
@property (retain, nonatomic) UIView *hitView;

@property (retain, nonatomic) TSCalculationService *servise;
@property (retain, nonatomic) TSCalculationOfResponseShots *responseShots;
@property (retain, nonatomic) TSGeneratedPoint *generationPoint;

@end

@implementation TSGameController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"sheet"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint locationPoint = [touch locationInView:self.view];
    _currentView = [self.view hitTest:locationPoint withEvent:event];
    if (positionButtonStart == YES) {
        [[TSSoundManager sharedManager] shotSound];
        BOOL verification = CGRectContainsPoint(_hitView.frame, locationPoint);
        if (verification == NO) {
            _servise = [[TSCalculationService alloc] init];
            _servise.delegate = self;
            [_servise calculateTheAreaForRectangle:locationPoint ships:self.collectionEnemyShip];
        } else {
            NSLog(@"ПОВТОР!");
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    CGPoint locationPoint = [[touches anyObject] locationInView:self.view];
    _currentView.center = locationPoint;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    CGPoint point = _currentView.frame.origin;
    _generationPoint = [[TSGeneratedPoint alloc] init];
    _generationPoint.delegate = self;
    [_generationPoint receivingPoint:point];
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

#pragma mark - TSGeneratedPointDelegate

- (void)pointTransmission:(CGPoint)point
{
    CGRect frame = CGRectMake(point.x, point.y, _currentView.frame.size.width, _currentView.frame.size.height);
    _currentView.frame = frame;
}

- (void)noteShot:(CGRect)rect color:(UIColor *)color
{
    [TSAlerts viewNoteShot:rect color:color parentVIew:self.view view:_hitView];
}

- (void)transitionProgress
{
    [[TSSoundManager sharedManager] shotSound];
    _responseShots = [[TSCalculationOfResponseShots alloc] init];
    _responseShots.delegate = self;
    [_responseShots shotRequest:self.collectionShip];
}

#pragma mark - UITapGestureRecognizer

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (positon == NO) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             _currentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
                         }];
        positon = YES;
    } else {
        [UIView animateWithDuration:0.2
                         animations:^{
                             _currentView.transform = CGAffineTransformMakeRotation(M_PI);
                         }];
        positon = NO;
    }
}

#pragma mark - Actions

- (IBAction)backAtion:(id)sender {
 
    UIButton *yesButton = [[UIButton alloc]init];
    UIButton *noButton = [[UIButton alloc]init];
    [TSAlerts createdAlertGameOver:self.view button:yesButton button:noButton];
//    [self dismissViewControllerAnimated:YES completion:nil];
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
    [_currentView release];
    [_servise release];
    [_responseShots release];
    [_hitView release];
    [super dealloc];
}

@end
