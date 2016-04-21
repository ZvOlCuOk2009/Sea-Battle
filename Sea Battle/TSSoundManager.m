//
//  TSSoundManager.m
//  Sea Battle
//
//  Created by Mac on 21.04.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "TSSoundManager.h"

@interface TSSoundManager ()

@property (retain, nonatomic) AVPlayer *player;

@end

@implementation TSSoundManager

+ (TSSoundManager *) sharedManager
{
    static TSSoundManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TSSoundManager alloc] init];
    });
    return manager;
}

- (void)shotSound
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shoot" ofType:@"mp3"];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:path]];
    _player = [[AVPlayer alloc] initWithPlayerItem:item];
    _player.volume = 0.7;
    [_player play];
    [item release];
}

-(void)dealloc
{
    [super dealloc];
    _player = nil;
}

@end
