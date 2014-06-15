
//
//  SettingsViewController.m
//  Booom
//
//  Created by Shinichi Asabe on 6/1/14.
//  Copyright (c) 2014 Yu Asabe. All rights reserved.
//

#import "SettingsViewController.h"
#import "BooomViewController.h"

@interface SettingsViewController ()

@end


@implementation SettingsViewController
@synthesize imageNum;
@synthesize imageSize;
@synthesize finalImage;
@synthesize sizeBar;
@synthesize imageMelon;
@synthesize imageOrange;
@synthesize imageWatermelon;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    imageMelon.alpha = 0.5;
    imageOrange.alpha = 0.5;
    imageWatermelon.alpha = 0.5;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)okButton:(id)sender {
    imageSize = sizeBar.value;
    
//    
//    BooomViewController *bvc = [[BooomViewController alloc] init];
//    bvc.imageNumBVC = imageNum;
//    bvc.imageSizeBVC = imageSize;
    
    NSLog(@"%d %d",imageNum, imageSize);
    
    BooomViewController *bvc = (BooomViewController *)[self presentingViewController];
    
    bvc.imageSizeBVC = imageSize;
    bvc.imageNumBVC = imageNum;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self presentViewController:bvc animated:YES completion:nil];
}

- (IBAction)chooseMelon:(id)sender {
    imageNum = 0;
    imageMelon.alpha = 1.0;
    imageOrange.alpha = 0.5;
    imageWatermelon.alpha = 0.5;
    //imageMelon.backgroundColor = [UIColor redColor];
    //finalImage.center.x
//    [finalImage setFrame:CGRectMake(finalImage.frame.origin.x, finalImage.frame.origin.y, 20, 20)];
//    [finalImage setImage:[UIImage imageNamed:@"melon.png"]];
    [finalImage setImage:[UIImage imageNamed:@"melon.png"]];

    
}

- (IBAction)chooseOrange:(id)sender {
    imageNum = 1;
    imageOrange.alpha = 1.0;
    imageMelon.alpha = 0.5;
    imageWatermelon.alpha = 0.5;
    //imageOrange.backgroundColor = [UIColor redColor];
    [finalImage setImage:[UIImage imageNamed:@"orange.png"]];

}

- (IBAction)chooseWaterMelon:(id)sender {
    imageNum = 2;
    imageWatermelon.alpha = 1.0;
    imageMelon.alpha = 0.5;
    imageOrange.alpha = 0.5;
    //imageWatermelon.backgroundColor = [UIColor redColor];
    [finalImage setImage:[UIImage imageNamed:@"watermelon.png"]];

}

- (IBAction)setSize:(id)sender {
    imageSize = sizeBar.value;
    NSLog(@"%d", imageSize);
    //[finalImage setImage:[self imageWithImage:finalImage.image scaledToSize:CGSizeMake(imageSize, imageSize)]];
    //[imageMelon setFrame:CGRectMake(0, 0, imageSize, imageSize)];
    [imageMelon setBounds:CGRectMake(0, 0, imageSize*2, imageSize*2)];
    [imageOrange setBounds:CGRectMake(0, 0, imageSize*2, imageSize*2)];
    [imageWatermelon setBounds:CGRectMake(0, 0, imageSize*2, imageSize*2)];
}

- (IBAction)clearAll:(id)sender {
    //BooomViewController *bvc = [[BooomViewController alloc] init];
    //[bvc clearAll2];
    //bvc.isCleared = true;
    //NSLog(@"%d",bvc.isCleared);
    //[[self parentViewController] performSelector:@selector(clearAll2)];
    
    
    BooomViewController *bvc = (BooomViewController *)self.presentingViewController;
    [self dismissViewControllerAnimated:YES completion:^{
        [bvc clearAll2];
    }];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
