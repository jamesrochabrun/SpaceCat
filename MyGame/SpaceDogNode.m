//
//  SpaceDogNode.m
//  MyGame
//
//  Created by James Rochabrun on 30-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "SpaceDogNode.h"

@implementation SpaceDogNode

//steps for this create an instance of the node
//- create an array of textures odf different images
//- create an instance of skaction
//- use the instance method runAction
//-return the instance node (spacedog)

+  (instancetype)spaceDogType:(SpaceDogType)type {
    
    SpaceDogNode *spaceDog;
    
    NSArray *textures;
    
    if (type ==  SpaceDogTypeA) {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_A_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_A_2"],
                     [SKTexture textureWithImageNamed:@"spacedog_A_3"]];
    } else {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_B_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_2"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_3"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_4"]];
    }
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    //dont forget that runAction its an instance method and should be called through the instance
    [spaceDog runAction:[SKAction repeatActionForever:animation]];
    
    return spaceDog;
}

@end
