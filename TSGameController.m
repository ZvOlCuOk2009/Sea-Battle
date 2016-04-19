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

static BOOL positon = NO;
static BOOL start = NO;

@interface TSGameController () <TSCalculationServiceDelegate>

@property (retain, nonatomic) IBOutletCollection(UIView) NSArray *collectionShip;
@property (retain, nonatomic) IBOutletCollection(UIView) NSArray *collectionEnemyShip;
@property (retain, nonatomic) UIView *currentView;

@property (retain, nonatomic) TSCalculationService *servise;
@property (retain, nonatomic) TSCalculationOfResponseShots *responseShots;

@end

@implementation TSGameController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    CGPoint locationPoint = [[touches anyObject] locationInView:self.view];
    _currentView = [self.view hitTest:locationPoint withEvent:event];
    _servise = [[TSCalculationService alloc] init];
    _servise.delegate = self;
    [_servise calculateTheAreaForRectangle:locationPoint ships:self.collectionEnemyShip];
    if (start == YES) {
        /// * * *
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    CGPoint locationPoint = [[touches anyObject] locationInView:self.view];
    _currentView.center = locationPoint;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{

}

#pragma mark - TSCalculationServiceDelegate

- (void)calculationResponseView:(CGRect)rect color:(UIColor *)color
{
    [self createRedView:rect color:color];
}

#pragma mark - TSCalculationOfResponseShotsDelegate

- (void)calculationEnemyShotView:(CGRect)rect color:(UIColor *)color
{
    [self createRedView:rect color:color];
}

- (void)createRedView:(CGRect)rect color:(UIColor *)color
{
    UIView *hitView = [[UIView alloc] initWithFrame:rect];
    hitView.backgroundColor = color;
    hitView.alpha = 0.7;
    hitView.userInteractionEnabled = NO;
    [self.view addSubview:hitView];
    [hitView autorelease];
}

- (void)transitionProgress
{
    _responseShots = [[TSCalculationOfResponseShots alloc] init];
    _responseShots.delegate = self;
    [_responseShots shotRequest:self.collectionShip];
}

#pragma mark - UITapGestureRecognizer

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (positon == NO) {
        _currentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        positon = YES;
    } else {
        _currentView.transform = CGAffineTransformMakeRotation(M_PI);
        positon = NO;
    }
}

#pragma mark - Actions

- (IBAction)actionStart:(id)sender {
    
    for (UIView *ship in self.collectionShip) {
        ship.userInteractionEnabled = NO;
    }
    for (UIView *ship in self.collectionEnemyShip) {
        ship.userInteractionEnabled = NO;
    }
    start = YES;
}

#pragma mark - Destruction of objects

- (void)dealloc {
    [_collectionShip release];
    [_collectionEnemyShip release];
    [_currentView release];
    [_servise release];
    [_responseShots release];
    [super dealloc];
}

@end
