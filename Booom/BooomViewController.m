//
//  BooomViewController.m
//  Booom
//
//  Created by Shinichi Asabe on 6/1/14.
//  Copyright (c) 2014 Yu Asabe. All rights reserved.
//

#import "BooomViewController.h"
#import "SettingsViewController.h"
#import <SpriteKit/SpriteKit.h>

@interface BooomViewController ()
@property (nonatomic, strong) SKScene *scene;
@property (nonatomic, strong) SKView *skView;


@end

@implementation BooomViewController
@synthesize imageSizeBVC;
@synthesize imageNumBVC;
@synthesize skView;
@synthesize isCleared;

- (void)loadView
{
    [super loadView] ;
    // SpriteKitを使うため、SKView を仕様
    skView = [[SKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = skView;
}

- (void)settings {
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //SecondViewController *viewController =
    //[storyboard instantiateViewControllerWithIdentifier:@"SecondView"];
    //[self presentViewController:svc animated:YES completion:NULL];
    
    //SettingsViewController *setView = [storyboard instantiateViewControllerWithIdentifier:@"settings"];    //[self presentViewController:setView animated:YES completion:nil];
    [self performSegueWithIdentifier:@"toSettings" sender:self];
    //[self dismissViewControllerAnimated:NO completion:nil];
    //[self presentViewController:setView animated:NO completion:nil];
}

- (void)clearAll2 {
    [[self scene] enumerateChildNodesWithName:@"object" usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
        NSLog(@"Clear All");
    }];
    
}


//
//- (void)viewWillAppear {
//    NSLog(@"%d",isCleared);
//    
//    if (isCleared) {
//        [self clearAll2];
//        isCleared = false;
//    } else {
//        NSLog(@"not cleared");
//    }
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSLog(@"%d",isCleared);
//    
//    if (isCleared) {
//        [self clearAll2];
//        isCleared = false;
//    } else {
//        NSLog(@"not cleared");
//    }
//    
    imageSizeBVC = 20;
    imageNumBVC = 0;
	
    skView = (SKView *)self.view;
    // Sceneを作る
    self.scene = [SKScene sceneWithSize:self.view.bounds.size];
    // 枠を設定
    self.scene.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:
                              CGRectMake(0, 0, skView.frame.size.width, skView.frame.size.height)];
    self.scene.backgroundColor = [SKColor whiteColor];
    // 表示するSceneを設定
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoButton.center = CGPointMake(300, 550);
    [infoButton addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    [skView addSubview:infoButton];
    
    [skView presentScene:self.scene];
    
    // タップの処理を指定
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [skView addGestureRecognizer:gesture];
    

}

#pragma mark - Gesture Handler
- (void)tapped:(UITapGestureRecognizer *)gesture {
    
//    int imageNum;
//    int imageSize;
    BOOL triangle = false ; // 形状: true->triangle, false->circle
    
//    SettingsViewController *svc = [[SettingsViewController alloc] init];

    

    NSLog(@"%d, %d", imageNumBVC, imageSizeBVC);
    
    // Spriteを作る ===================================
//    SKSpriteNode *sprite = triangle
//    ? [SKSpriteNode spriteNodeWithImageNamed:@"triangle"]
//    : [SKSpriteNode spriteNodeWithImageNamed:@"orange"];
    
    SKSpriteNode *sprite = [[SKSpriteNode alloc] init];
    int randomNum = arc4random() % 2;
    
    if (imageNumBVC == 0) {
        if (randomNum == 0) {
            sprite = [SKSpriteNode spriteNodeWithImageNamed:@"melon"];
        } else {
            sprite = [SKSpriteNode spriteNodeWithImageNamed:@"melon2"];
        }
        

    } else if (imageNumBVC == 1) {
        
        if (randomNum == 0) {
            sprite = [SKSpriteNode spriteNodeWithImageNamed:@"orange"];
        } else {
            sprite = [SKSpriteNode spriteNodeWithImageNamed:@"orange2"];
        }

        //sprite = [SKSpriteNode spriteNodeWithImageNamed:@"orange"];
        
    } else if (imageNumBVC == 2) {
        if (randomNum == 0) {
            sprite = [SKSpriteNode spriteNodeWithImageNamed:@"watermelon"];
        } else {
            sprite = [SKSpriteNode spriteNodeWithImageNamed:@"watermelon2"];
        }

        
    } else {
        sprite = [SKSpriteNode spriteNodeWithImageNamed:@"orange"];
    }
    
    
    // tap位置に移動 ===================================
    CGPoint tappedPos = [gesture locationInView:gesture.view];
    tappedPos = CGPointMake(tappedPos.x, self.view.frame.size.height-tappedPos.y) ;
    sprite.position = tappedPos;
    // サイズを変更
    const CGFloat radius = imageSizeBVC;
    sprite.size = (CGSize){radius * 2, radius * 2};
    
    sprite.name = @"object";
    
    
    // 物理形状を変更 ===================================
    if (triangle) {
        // 三角型
        CGFloat offsetX = sprite.frame.size.width * sprite.anchorPoint.x;
        CGFloat offsetY = sprite.frame.size.height * sprite.anchorPoint.y;
        
        // CGPath Reference: https://developer.apple.com/library/mac/documentation/graphicsimaging/reference/CGPath/Reference/reference.html
        // SKPhysicsBody Path Generator: http://dazchong.com/spritekit/
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0 - offsetX, radius*2 - offsetY);
        CGPathAddLineToPoint(path, NULL, radius - offsetX, 0 - offsetY);
        CGPathAddLineToPoint(path, NULL, radius*2 - offsetX, radius*2 - offsetY);
        CGPathCloseSubpath(path);
        
        sprite.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
        CGPathRelease(path);
    } else {
        // 円型
        SKPhysicsBody *pbody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
        pbody.restitution = 0.5;
        sprite.physicsBody = pbody;
    }
    
    // Sceneに追加 ===================================
    [self.scene addChild:sprite];
    
    //[self clearAll2];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
