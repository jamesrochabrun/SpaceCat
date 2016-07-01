//
//  HudNode.m
//  MyGame
//
//  Created by James Rochabrun on 30-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "HudNode.h"
#import "Util.h"

@implementation HudNode

+ (instancetype)hudAtPosition:(CGPoint)position inFrame:(CGRect)frame {

    HudNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 10;
    hud.name = @"HUD";
    
    //adding cathead icon
    SKSpriteNode *catHead = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_cat_1"];
    catHead.position = CGPointMake(30, -10);
    [hud addChild:catHead];
    
    //initializing number of lives, got from util.h
    hud.lives = Maxlives;
    
    //creating a lastlifebar to compare and set the position
    SKSpriteNode *lastLifeBar;
    
    //adding the live status bar
    for (int i = 0; i < hud.lives; i++) {
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_life_1"];
        lifeBar.name = [NSString stringWithFormat:@"Life%d", i + 1];
        [hud addChild:lifeBar];
        
        //set the position of the lifebar
        if (lastLifeBar == nil) {
            lifeBar.position = CGPointMake(catHead.position.x +30, catHead.position.y);
        } else {
            lifeBar.position = CGPointMake(lastLifeBar.position.x +10, lastLifeBar.position.y);
        }
        
        //setting lastLifebar
        lastLifeBar = lifeBar;
    }
    
    //label for score
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize = 24;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(frame.size.width -20, -10);
    [hud addChild:scoreLabel];
    
    return hud;
}


- (void)addPoints:(NSInteger)points {
    self.score += points;
    SKLabelNode *scoreLabel = (SKLabelNode*)[self childNodeWithName:@"Score"];
    scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.score];
}

- (BOOL)loseLife {
    
    if (self.lives > 0) {
        NSString *lifeNodeName = [NSString stringWithFormat:@"Life%ld", (long)self.lives];
        SKNode *lifeToRemove = [self childNodeWithName:lifeNodeName];
        [lifeToRemove removeFromParent];
        self.lives--;
    }
    
    //when the amount of lives are 0 this returns true
    return self.lives == 0;
    
}






@end
