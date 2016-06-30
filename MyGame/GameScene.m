//
//  GameScene.m
//  MyGame
//
//  Created by James Rochabrun on 29-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "GameScene.h"
#import "MachineNode.h"
#import "SpaceCatNode.h"
#import "ProjectileNode.h"
#import "SpaceDogNode.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
    backGround.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    backGround.size = self.frame.size;
    
    [self addChild:backGround];
    
    MachineNode *machine = [MachineNode machineAtPosition: CGPointMake(CGRectGetMidX(self.frame), 12)];
  
    [self addChild:machine];
    
    SpaceCatNode *spaceCat = [SpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
    [self addChild:spaceCat];
    
    //adding the enemy
    [self addSpaceDog];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint position = [touch locationInNode:self];
        [self shootProjectileTowardsPosition:position];
    }
    
}

- (void)shootProjectileTowardsPosition:(CGPoint)position {
    //casting the sknode to the spacecatnode
    SpaceCatNode *spaceCat = (SpaceCatNode*)[self childNodeWithName:@"SpaceCat"];
    [spaceCat performTap];
    
    //puting the projectile at the top of the machine
    //creating a instance of machine node to get its height
    MachineNode *machine = (MachineNode*)[self childNodeWithName:@"Machine"];
    
    CGPoint heightOfMachineNodeMinusSpace = CGPointMake(machine.position.x, machine.position.y + machine.frame.size.height - 15);
    
    ProjectileNode *projectile = [ProjectileNode projectileAtPosition:heightOfMachineNodeMinusSpace];
    [self addChild:projectile];
    
    //lastly
    [projectile moveTowardsPosition:position];
    
}

- (void)addSpaceDog {
    
    SpaceDogNode *spaceDogA = [SpaceDogNode spaceDogType:SpaceDogTypeA];
    spaceDogA.position = CGPointMake(100, 300);
    [self addChild:spaceDogA];
    
    SpaceDogNode *spaceDogB = [SpaceDogNode spaceDogType:SpacedogTypeB];
    spaceDogB.position = CGPointMake(200, 300);
    [self addChild:spaceDogB];
    
    
}










@end
