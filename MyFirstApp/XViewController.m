//
//  XViewController.m
//  MyFirstApp
//
//  Created by roger on 13-4-6.
//
//

#import "XViewController.h"

@interface XViewController ()

@end

@implementation XViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    imgShowImage.image = [UIImage imageNamed:@"nonopanda-2.png"];
    UIImage *imageNono_1 = [UIImage imageNamed:@"nonopanda-1.png"];
    UIImage *imageNono_2 = [UIImage imageNamed:@"nonopanda-2.png"];
    UIImage *imageNono_3 = [UIImage imageNamed:@"nonopanda-3.png"];
    
    imgShowImage.animationImages = [NSArray arrayWithObjects:imageNono_1, imageNono_2, imageNono_3, nil];
    imgShowImage.animationDuration = 2;
    [imgShowImage startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressLeftButton:(UIButton *)sender {
    
}
- (void)dealloc {
    [lblShowText release];
    [imgShowImage release];
    [super dealloc];
}
- (IBAction)btnPressLeftButton:(id)sender {
    lblShowText.text = @"你按下了左按键";
}

- (IBAction)btnPressRightButton:(id)sender {
    lblShowText.text = @"你按下了右按键";
}
@end
