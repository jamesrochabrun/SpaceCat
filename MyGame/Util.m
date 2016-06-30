//
//  Util.m
//  MyGame
//
//  Created by James Rochabrun on 30-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max {
    
    return arc4random()%(max - min) + min;
}

@end
