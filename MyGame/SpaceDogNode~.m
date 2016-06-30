//
//  SpaceDogNode.m
//  MyGame
//
//  Created by James Rochabrun on 30-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "SpaceDogNode.h"

@implementation SpaceDogNode

+  (instancetype)spaceDogType:(SpaceDogType)type {
    
    SpaceDogNode *spaceDog;
    
    NSArray *textures;
    
    if (type ==  SpaceDogTypeA) {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_A_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_1"]]
    } else {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_B_1"];
    }
    return spaceDog;
}

@end
