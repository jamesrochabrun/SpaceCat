//
//  HudNode.h
//  MyGame
//
//  Created by James Rochabrun on 30-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HudNode : SKNode
@property (nonatomic) NSInteger lives;
@property (nonatomic) NSInteger score;

+ (instancetype)hudAtPosition:(CGPoint)position inFrame:(CGRect)frame;
- (void)addPoints:(NSInteger)points;
- (BOOL)loseLife;
@end
