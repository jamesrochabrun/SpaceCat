//
//  GroundNode.m
//  MyGame
//
//  Created by James Rochabrun on 30-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "GroundNode.h"
#import "Util.h"

@implementation GroundNode

+ (instancetype)groundWithSize:(CGSize)size {
    
    GroundNode *groundNode = [self spriteNodeWithColor:[SKColor clearColor] size:size];
    groundNode.name = @"Ground";
    groundNode.position = CGPointMake(size.width/2, size.height/2);
    [groundNode setUpPhysicsBody];
    return groundNode;
}

- (void)setUpPhysicsBody {
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    
    //gravity
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    
    //using the collision and contact bitmask
    self.physicsBody.categoryBitMask = CollisionCategoryGround;
    self.physicsBody.collisionBitMask = CollisionCategoryDebris;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;
    
}

@end
