//
//  SpaceCatNode.h
//  MyGame
//
//  Created by James Rochabrun on 29-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SpaceCatNode : SKSpriteNode

+ (instancetype)spaceCatAtPosition:(CGPoint)position ;
- (void)performTap ;

@end
