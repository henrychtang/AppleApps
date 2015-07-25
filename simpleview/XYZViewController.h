//
//  XYZViewController.h
//  simpleview
//
//  Created by Henry Tang on 4/8/13.
//  Copyright (c) 2013 Henry Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MyUIImageView.h"

@interface XYZViewController : UIViewController{
    IBOutlet UILabel *seconds;
    NSTimer *timer;
    int MainInt;
    NSArray *charImageArray;
    MyUIImageView  *charImageViewArray[10];
    MyUIImageView  *targetImageViewArray[10];
    NSArray *wordArray;
    int array_size;
    int currentIndex;

 }

@property (weak, nonatomic) IBOutlet MyUIImageView *lastImage;
@property (weak, nonatomic) IBOutlet UIImageView *T_Image;
@property (weak, nonatomic) IBOutlet UIImageView *target_1;
@property (weak, nonatomic) IBOutlet UIImageView *target_2;
@property (weak, nonatomic) IBOutlet UIImageView *target_3;

@property (weak, nonatomic) IBOutlet UIImageView *A_Image;
@property (weak, nonatomic) IBOutlet UIImageView *B_Image;
@property (weak, nonatomic) IBOutlet UIImageView *C_Image;
@property (weak, nonatomic) IBOutlet UIImageView *animalImageView;

@property IBOutlet UIImageView *charImageView1;
@property IBOutlet UIImageView *charImageView2;
@property IBOutlet UIImageView *charImageView3;
@property IBOutlet UIImageView *charImageView4;
@property IBOutlet UIImageView *charImageView5;

- (void) countdown;
- (void) checkFinished;
- (void) next;
- (IBAction) start:(id)sender;
- (IBAction)SwitchView:(id)sender;
- (IBAction)Reset:(id)sender;
- (IBAction)ClearAll:(id)sender;
- (IBAction)Next:(id)sender;
- (IBAction)Previous:(id)sender;


@end
