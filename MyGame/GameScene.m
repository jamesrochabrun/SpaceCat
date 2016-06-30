//
//  GameScene.m
//  MyGame
//
//  Created by James Rochabrun on 29-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
    backGround.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    backGround.size = self.frame.size;
    
    [self addChild:backGround];
    
    SKSpriteNode *machine = [SKSpriteNode spriteNodeWithImageNamed:@"machine_1"];
    machine.position = CGPointMake(CGRectGetMidX(self.frame), 12);
    machine.anchorPoint = CGPointMake(0.5, 0);
    [self addChild:machine];
    
}

- (void)update:(NSTimeInterval)currentTime {
    
    NSLog(@"%f", fmod(currentTime, 60));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
