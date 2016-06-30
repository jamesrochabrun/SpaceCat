//
//  GameScene.m
//  MyGame
//
//  Created by James Rochabrun on 29-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "GameScene.h"
#import "MachineNode.h"
#import "SpaceCatNode.h"
#import "ProjectileNode.h"
#import "SpaceDogNode.h"
#import "GroundNode.h"
#import "Util.h"
#import <AVFoundation/AVFoundation.h>
#import "HudNode.h"


@interface GameScene ()
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property (nonatomic) NSTimeInterval totalGameTime;
@property (nonatomic) NSInteger minSpeed;
@property (nonatomic) NSTimeInterval addEnemyTimeInterval;

//sound properties
@property (nonatomic) SKAction *damageSFX;
@property (nonatomic) SKAction *explodeSFX;
@property (nonatomic) SKAction *laserSFX;
@property (nonatomic) AVAudioPlayer *backGroundMusic;
@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    
    //initializing the properties of time to 0
    self.lastUpdateTimeInterval = 0;
    self.timeSinceEnemyAdded = 0;
    self.addEnemyTimeInterval = 1.5; //we can chenge this initial value
    self.totalGameTime = 0;
    self.minSpeed = SpaceDogMinSpeed; //this comes from the Util.h file
    
    /* Setup your scene here */
    SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithImageNamed:@"background_1"];
    backGround.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    backGround.size = self.frame.size;
    [self addChild:backGround];
    
    //adding the space cat
    [self addSpaceCat];
    
    //phisic world stuf setting the gravity of the scene and the contactdelegate
    self.physicsWorld.gravity = CGVectorMake(0, -9.8);
    self.physicsWorld.contactDelegate = self;
    
    //adding the ground phisic
    GroundNode *ground = [GroundNode groundWithSize:CGSizeMake(self.frame.size.width, 22)];
    [self addChild:ground];
    
    //sound effects
    [self setUpSounds];
    
    //adding the hud
    [self setUpHudNode];
    
}

- (void)setUpHudNode {
    
    HudNode *hud = [HudNode hudAtPosition:CGPointMake(0, self.frame.size.height -20) inFrame:self.frame];
    [self addChild:hud];
}

- (void)setUpSounds {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Gameplay" withExtension:@"mp3"];
    self.backGroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.backGroundMusic.numberOfLoops = -1; //repeat infineteley
    [self.backGroundMusic prepareToPlay];
    [self.backGroundMusic play];
    
    self.damageSFX = [SKAction playSoundFileNamed:@"Damage.caf" waitForCompletion:NO];
    self.explodeSFX = [SKAction playSoundFileNamed:@"Explode.caf" waitForCompletion:NO];
    self.laserSFX = [SKAction playSoundFileNamed:@"Laser.caf" waitForCompletion:NO];
    
}

//dog
- (void)addSpaceDog {
    
    //beacuse we just have two dogs pics
    NSInteger randomSpaceDog = [Util randomWithMin:0 max:2];
    
    SpaceDogNode *spaceDog = [SpaceDogNode spaceDogType:randomSpaceDog];
    
    float dy = [Util randomWithMin:SpaceDogMinSpeed max:SpaceDogMaxSpeed];
    spaceDog.physicsBody.velocity = CGVectorMake(0, dy);

    float y = self.frame.size.height + spaceDog.size.height;
    float x = [Util randomWithMin:10 + spaceDog.size.width max:self.frame.size.width - spaceDog.size.width- 10];
    spaceDog.position = CGPointMake(x, y);
    [self addChild:spaceDog];
}

- (void)update:(NSTimeInterval)currentTime { //this runs every second or every time the loop game runs
    
    if (self.lastUpdateTimeInterval) {
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
    //1.0 is one second passed since last enemy added
    if (self.timeSinceEnemyAdded > self.addEnemyTimeInterval) {
        [self addSpaceDog];
        self.timeSinceEnemyAdded = 0;
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if (self.totalGameTime > 480) {
        //480 / 60 = 8 minutes
        self.addEnemyTimeInterval = 0.50;
        self.minSpeed = -160;
    } else if (self.totalGameTime > 240) {
        //240 / 60 = 4
        self.addEnemyTimeInterval = 0.65;
        self.minSpeed = -150;
    } else if (self.totalGameTime > 20) {
        //120 / 60 = 2
        self.addEnemyTimeInterval = 0.75;
        self.minSpeed = -125;
    } else if (self.totalGameTime > 10) {
        self.addEnemyTimeInterval = 1.00;
        self.minSpeed = -100;
    }
 
}

//cat
- (void)addSpaceCat {
    MachineNode *machine = [MachineNode machineAtPosition: CGPointMake(CGRectGetMidX(self.frame), 12)];
    
    [self addChild:machine];
    
    SpaceCatNode *spaceCat = [SpaceCatNode spaceCatAtPosition:CGPointMake(machine.position.x, machine.position.y-2)];
    [self addChild:spaceCat];
}


//projectile
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint position = [touch locationInNode:self];
        [self shootProjectileTowardsPosition:position];
    }
    
}

- (void)shootProjectileTowardsPosition:(CGPoint)position {
    //casting the sknode to the spacecatnode
    SpaceCatNode *spaceCat = (SpaceCatNode*)[self childNodeWithName:@"SpaceCat"];
    [spaceCat performTap];
    
    //puting the projectile at the top of the machine
    //creating a instance of machine node to get its height
    MachineNode *machine = (MachineNode*)[self childNodeWithName:@"Machine"];
    
    CGPoint heightOfMachineNodeMinusSpace = CGPointMake(machine.position.x, machine.position.y + machine.frame.size.height - 15);
    
    ProjectileNode *projectile = [ProjectileNode projectileAtPosition:heightOfMachineNodeMinusSpace];
    [self addChild:projectile];
    
    //lastly
    [projectile moveTowardsPosition:position];
    
    //run the sound for laser
    [self runAction:self.laserSFX];
    
}

#pragma contacteDelegatemethod

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    //preventing confussion arround bodyA and B
    
    SKPhysicsBody *firstBody, *secondBody;
    
    //remeber enemy is less value than the projectile 0000 < 0010
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == CollisionCategoryEnemy &&
        secondBody.categoryBitMask == CollisionCatergoryProjectile ) {
        
        SpaceDogNode *spaceDog  = (SpaceDogNode*)firstBody.node;
        ProjectileNode *projectile = (ProjectileNode*)secondBody.node;
        
        //score
        [self addPoints:PointsPerHeat];
        
        //runing sound for explosion when projectile hits enemy
        [self runAction:self.explodeSFX];
        
        [spaceDog removeFromParent];
        [projectile removeFromParent];
        NSLog(@"bam");
        
    } else if (firstBody.categoryBitMask == CollisionCategoryEnemy &&
               secondBody.categoryBitMask == CollisionCategoryGround) {
        //runing sound for damage sound when the dog hits the floor
        [self runAction:self.damageSFX];
        
        SpaceDogNode *spaceDog = (SpaceDogNode*)firstBody.node;
        [spaceDog removeFromParent];
        NSLog(@"hit the floor ");
        
        //user looses a life
        [self enemyTouchedTheFloor];
    }
    
    [self createDebrisAtPosition:contact.contactPoint];
}

//adding points method
- (void)addPoints:(NSInteger)points {
    
    HudNode *hud = (HudNode*)[self childNodeWithName:@"HUD"];
    [hud addPoints:points];
}

//loosing lifes
- (void)enemyTouchedTheFloor {
    HudNode *hud = (HudNode*)[self childNodeWithName:@"HUD"];
    [hud loseLife];

}

- (void)createDebrisAtPosition:(CGPoint)position {
    
    NSInteger numberOfPieces = [Util randomWithMin:5 max:20];
    
    for (int i = 0; i < numberOfPieces; i++) {
        NSInteger randomPiece = [Util randomWithMin:1 max:4];
        NSString *imageName = [NSString stringWithFormat:@"debri_%ld", (long)randomPiece];
        
        SKSpriteNode *debris = [SKSpriteNode spriteNodeWithImageNamed:imageName];
        debris.position = position;
        [self addChild:debris];
        
        //phisics body
        debris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:debris.frame.size];
        debris.physicsBody.categoryBitMask = CollisionCategoryDebris;
        debris.physicsBody.contactTestBitMask = 0;
        debris.physicsBody.collisionBitMask = CollisionCategoryGround | CollisionCategoryDebris;
        debris.name = @"Debris";
        
        debris.physicsBody.velocity = CGVectorMake([Util randomWithMin:-150 max:150],
                                                   [Util randomWithMin:150 max:350]);
        
        [debris runAction:[SKAction waitForDuration:2.0] completion:^{
            [debris removeFromParent];
        }];
        
    }
    
    //particles
    NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
    
    explosion.position = position;
    [self addChild:explosion];
    
    [explosion runAction:[SKAction waitForDuration:2.0] completion:^{
        [explosion removeFromParent];
    }];
}












@end
