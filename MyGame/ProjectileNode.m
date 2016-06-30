//
//  ProjectileNode.m
//  MyGame
//
//  Created by James Rochabrun on 29-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "ProjectileNode.h"
#import "Util.h"

@implementation ProjectileNode

+ (instancetype)projectileAtPosition:(CGPoint)position{
    
    ProjectileNode *projectile = [self spriteNodeWithImageNamed:@"projectile_1"];
    projectile.position = position;
    projectile.name = @"projectile";
    
    [projectile setUpAnimation];
    return projectile;
}


- (void)setUpAnimation {
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"projectile_1"],
                          [SKTexture textureWithImageNamed:@"projectile_2"],
                          [SKTexture textureWithImageNamed:@"projectile_3"]];
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    SKAction *repeatAction = [SKAction repeatActionForever:animation];
    [self runAction:repeatAction];
}

- (void)moveTowardsPosition:(CGPoint)position {
    
    //calculating slope = (y3 - y1) / (x3 - x1)
    float slope = (position.y - self.position.y) / (position.x - self.position.x);
    
    //slope = (y2 - y1) / (x2 - x1)
    //y2 - y1 = slope *(x2 - x1)
    //y2 = slope * x2 - slope * x1 + y1
    
    float offScreenX;
    
    //if the user tapped to the left the position x its setted -10
    if (position.x <= self.position.x) {
        offScreenX = -10;
    } else {
        offScreenX = self.parent.frame.size.width + 10;
    }
    
    float offScreenY = slope * offScreenX - slope * self.position.x + self.position.y;
    
    CGPoint pointOffScreen = CGPointMake(offScreenX, offScreenY);
    
    float distanceA = pointOffScreen.y - self.position.y;
    float distanceB = pointOffScreen.x - self.position.x;
    
    //getting the distance using teorema de pitagoras
    float distanceC = sqrtf(powf(distanceA, 2) + powf(distanceB, 2));
    
    //distance = speed * time
    //time = distance / speed
    float time = distanceC / ProjectileSpeed;
    float waitToFade = time * 0.75;
    float fadeTime = time - waitToFade;
    
    SKAction *moveProjectile = [SKAction moveTo:pointOffScreen duration:time];
    [self runAction:moveProjectile];
    
    //adding daing effect to the projectile
    NSArray *sequence = @[[SKAction waitForDuration:waitToFade],
                          [SKAction fadeOutWithDuration:fadeTime],
                          [SKAction removeFromParent]];//good practice to remove
    
    [self runAction:[SKAction sequence:sequence]];
}














@end
