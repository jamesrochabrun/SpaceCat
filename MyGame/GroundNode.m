//
//  GroundNode.m
//  MyGame
//
//  Created by James Rochabrun on 30-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "GroundNode.h"

@implementation GroundNode

+ (instancetype)groundWithSize:(CGSize)size {
    
    GroundNode *groundNode = [self spriteNodeWithColor:[SKColor greenColor] size:size];
    groundNode.name = @"Ground";
    groundNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    groundNode.position = CGPointMake(size.width/2, size.height/2);
    groundNode.physicsBody.affectedByGravity = NO;
    return groundNode;
}

@end
