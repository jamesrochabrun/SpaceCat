//
//  TitleScene.m
//  MyGame
//
//  Created by James Rochabrun on 29-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "TitleScene.h"
#import "GameScene.h"
#import <AVFoundation/AVFoundation.h>

@interface TitleScene ()
@property (nonatomic) SKAction *pressStartSFX;
@property (nonatomic) AVAudioPlayer *backgroundMusic;

@end

@implementation TitleScene


//this is the splash scene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"splash_1"];
    backGround.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    backGround.size = self.frame.size;

    [self addChild:backGround];
    
    //adding sound effect
    self.pressStartSFX = [SKAction playSoundFileNamed:@"PressStart.caf" waitForCompletion:NO];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"StartScreen" withExtension:@"mp3"];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.backgroundMusic.numberOfLoops = -1; //repeat infineteley
    [self.backgroundMusic prepareToPlay];
    [self.backgroundMusic play];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //sound effect running
    [self runAction:self.pressStartSFX];
    
    //this generates the transition from one scene to another
    GameScene *gameScene = [GameScene  sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:gameScene transition:transition];
}





@end
