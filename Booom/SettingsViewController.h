//
//  SettingsViewController.h
//  Booom
//
//  Created by Shinichi Asabe on 6/1/14.
//  Copyright (c) 2014 Yu Asabe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
- (IBAction)okButton:(id)sender;
- (IBAction)chooseMelon:(id)sender;
- (IBAction)chooseOrange:(id)sender;
- (IBAction)chooseWaterMelon:(id)sender;
- (IBAction)setSize:(id)sender;
- (IBAction)clearAll:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *finalImage;
@property (weak, nonatomic) IBOutlet UISlider *sizeBar;
@property (weak, nonatomic) IBOutlet UIButton *imageMelon;
@property (weak, nonatomic) IBOutlet UIButton *imageOrange;
@property (weak, nonatomic) IBOutlet UIButton *imageWatermelon;


@property (nonatomic) int imageNum;
@property (nonatomic) int imageSize;

@end
