//
//  CrazyDragViewController.m
//  CrazyDrag
//
//  Created by Jon on 14-5-4.
//  Copyright (c) 2014年 iOSlearning. All rights reserved.
//

#import "CrazyDragViewController.h"
#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CrazyDragViewController ()

{
    int currentValue;
    int targetValue;
    int score;
    int pround;
}

- (IBAction)showAlert:(id)sender;
- (IBAction)sildeMoved:(id)sender;
- (IBAction)startOver:(id)sender;
- (IBAction)showInfo:(id)sender;

@property (nonatomic, strong)AVAudioPlayer *audioPlayer;

@end

@implementation CrazyDragViewController

@synthesize slider, targetLabel, scoreLabel, roundLabel, audioPlayer;

- (void)updateLabels{
    
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", pround];
}

- (void)startNewRound{
    
    pround += 1;
    
    targetValue = 1 + (arc4random()%100);
    currentValue = 50;
    self.slider.value = currentValue;
}

- (void)playBackgroundMusic{
    
    NSString *musicPath = [[NSBundle mainBundle]pathForResource:@"no" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    if(audioPlayer == nil){
        NSString *errorInfo = [NSString stringWithString:[error description]];
        NSLog(@"the error is %@", errorInfo);
    }else{
        [audioPlayer play];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlight = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlight forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SlideTrackLeft"]stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SlideTrackRight"]stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
    
    [self startNewRound];
    [self updateLabels];
    [self playBackgroundMusic];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startNewGame{
    
    score = 0;
    pround = 0;
    [self startNewRound];
}

- (IBAction)showAlert:(id)sender {
    
    int difference;
    int point;

    difference = abs(currentValue - targetValue);
    point = 100 - difference;
    score += point;
    
    NSString *title;
    
    if (difference == 0) {
        title = @"土豪你太NB了！";
    }else if (difference < 10){
        title = @"土豪你太帅了！";
    }else if (difference < 20){
        title = @"还算可以，土豪";
    }else{
        title = @"加油啊，土豪";
    }
    
    NSString *message = [NSString stringWithFormat:@"帅哥，你的得分是：%d", point];
    
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"您辛苦了" otherButtonTitles:nil, nil]show];

}

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self startNewRound];
    [self updateLabels];
}

- (IBAction)sildeMoved:(UISlider*)sender {
    
    currentValue = (int)lroundf(sender.value);

}
- (IBAction)startOver:(id)sender {
    
    //添加过渡效果
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;// 淡入淡出
    transition.duration = 1;//持续1秒
    transition.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)showInfo:(id)sender {
    
    AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
