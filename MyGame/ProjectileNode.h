//
//  ProjectileNode.h
//  MyGame
//
//  Created by James Rochabrun on 29-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ProjectileNode : SKSpriteNode


+ (instancetype)projectileAtPosition:(CGPoint)position;
- (void)moveTowardsPosition:(CGPoint)position;

@end
