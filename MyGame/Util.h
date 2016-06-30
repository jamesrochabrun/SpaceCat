//
//  Util.h
//  MyGame
//
//  Created by James Rochabrun on 30-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int ProjectileSpeed = 400;
static const int SpaceDogMinSpeed = -100;
static const int SpaceDogMaxSpeed = -50;

//we use this specifically for bitmasks like the collision and contact mask
//<< bitwise shift operation move one bit to the left, creating 4 diferent bits
typedef NS_OPTIONS(uint32_t, CollisionCategory ) {
    CollisionCategoryEnemy          = 1 << 0, //0000
    CollisionCatergoryProjectile    = 1 << 1, //0010
    CollisionCategoryDebris         = 1 << 2, //0100
    CollisionCategoryGround         = 1 << 3  //1000
};

@interface Util : NSObject

+ (NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max;

@end
