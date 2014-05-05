//
//  CrazyDragViewController.h
//  CrazyDrag
//
//  Created by Jon on 14-5-4.
//  Copyright (c) 2014年 iOSlearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrazyDragViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;

@end
