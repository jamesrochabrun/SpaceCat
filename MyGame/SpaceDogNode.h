//
//  SpaceDogNode.h
//  MyGame
//
//  Created by James Rochabrun on 30-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSUInteger, SpaceDogType) {
    SpaceDogTypeA = 0,
    SpacedogTypeB = 1
};

@interface SpaceDogNode : SKSpriteNode

+  (instancetype)spaceDogType:(SpaceDogType)type;

@end
