//
//  XYZViewController.m
//  simpleview
//
//  Created by Henry Tang on 4/8/13.
//  Copyright (c) 2013 Henry Tang. All rights reserved.
//

#import "XYZViewController.h"
#import "MainContentViewController.h"


@interface XYZViewController ()


@end


@implementation XYZViewController


@synthesize lastImage;
@synthesize target_1;
@synthesize target_2;
@synthesize target_3;
@synthesize A_Image;
@synthesize B_Image;
@synthesize C_Image;
@synthesize T_Image;
@synthesize animalImageView;
@synthesize charImageView1;
@synthesize charImageView2;
@synthesize charImageView3;
@synthesize charImageView4;
@synthesize charImageView5;


- (IBAction)SwitchView:(id)sender {

       // MainContentViewController *mainContentViewController =[[MainContentViewController alloc] initWithNibName:@"mainContentViewController" bundle:nil];
    

}




- (void) countdown {
    MainInt -=1;
    
    seconds.text=[NSString stringWithFormat: @"%02d", MainInt];
    
    if (MainInt<=0 && timer) {
        [timer invalidate];
        timer = nil;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Times Up"
                                                        message:@"You have xx/10 correct!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    

    
}

- (IBAction) start:(id)sender{
    
    CFBundleRef mainBundle=CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef =CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"Toggle",
                                             (CFStringRef) @"mp3", NULL);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
    if(!timer){
        MainInt=15;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    }
    //set animal image
    UIImage *animalImage = [UIImage imageNamed:@"DOG.jpeg"];
    animalImageView.image=animalImage;
    
    }
- (void) moveSound{
    CFBundleRef mainBundle=CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef =CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"Toggle",
                                             (CFStringRef) @"mp3", NULL);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touches Began");
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    int     xPos = location.x ;
    int     yPos = location.y ;
    NSLog(@"Touches Moved %d, %d", xPos, yPos);
    for (int i=0;i<10;i++){
        if(CGRectContainsPoint(charImageViewArray[i].frame, location)){
            
            lastImage = charImageViewArray[i];
            NSLog(@"Touched Char: %@",charImageViewArray[i].charName);
        }
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    int     xPos = location.x ;
    int     yPos = location.y ;
        NSLog(@"Touches Moved %d, %d", xPos, yPos);
    for (int i=0;i<10;i++){
        if(lastImage == charImageViewArray[i]){
            charImageViewArray[i].center=CGPointMake(xPos, yPos);
            NSLog(@"Moved Char: %@",charImageViewArray[i].charName);
        }
    }
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSString *currentWord= [wordArray objectAtIndex: currentIndex];
    for (int i = 0; i<currentWord.length;i++){
            if(CGRectIntersectsRect(targetImageViewArray[i].frame, lastImage.frame)){
                lastImage.center=CGPointMake(CGRectGetMidX(targetImageViewArray[i].frame), CGRectGetMidY(targetImageViewArray[i].frame) );
                NSLog(@"xxxxxx %@, %@", targetImageViewArray[i].charName,lastImage.charName );

                if([targetImageViewArray[i].charName isEqualToString: lastImage.charName])
                    targetImageViewArray[i].isMatched=1;

    
            }
    }
    
    if (lastImage!=nil){
        //play sound
        CFBundleRef mainBundle=CFBundleGetMainBundle();
        CFURLRef soundFileURLRef;
        soundFileURLRef =CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"Toggle",
                                                 (CFStringRef) @"mp3", NULL);
        UInt32 soundID;
        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
        AudioServicesPlaySystemSound(soundID);
    }
    lastImage=nil;
    NSLog(@"Touches Ended");
        [self checkFinished];
}
- (void) checkFinished{
    int isMatached=1;
    NSString *currentWord= [wordArray objectAtIndex: currentIndex];
    for (int i = 0; i<currentWord.length;i++){
        NSLog(@"check finished, %@, %d", targetImageViewArray[i].charName,targetImageViewArray[i].isMatched );
        if(targetImageViewArray[i].isMatched==0){
            isMatached=0;
            break;
        }
    }
    if (isMatached==1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bingo"
                                                        message:@"That's it!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        ++currentIndex ;
        if(currentIndex ==[wordArray count])
            currentIndex=0;
        [self change];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [target_1  setFrame:CGRectMake( 30, 400, 45, 45)];
    [target_2  setFrame:CGRectMake( 130, 400, 45, 45)];
    [target_3  setFrame:CGRectMake( 230, 400, 45, 45)];

    NSString *myString =@"CAT";
    NSString *ichar  = [NSString stringWithFormat:@"%c", [myString characterAtIndex:0]];
    NSLog(@"%@",ichar);

    NSLog(@"%@",[NSString stringWithFormat:@"%c", [myString characterAtIndex:1]]);
    NSLog(@"%@",[NSString stringWithFormat:@"%c", [myString characterAtIndex:2]]);

    
    currentIndex=0;
    wordArray=[NSArray arrayWithObjects: @"CAT", @"DOG", @"COW",@"LION",@"CROCODILE",@"FISH",@"WHALE",@"DOLPHIN",@"SHARK",nil];
    
    
    //charImageViewArray=[]
    NSString *myStr;
    for(myStr in wordArray) {
        NSLog(@"%@",myStr);
    }
    NSLog(@"%@",[wordArray objectAtIndex: 0]);
    NSLog(@"%@",[wordArray objectAtIndex: 1]);
    NSLog(@"%@",[wordArray objectAtIndex: 2]);
    NSLog(@"array size: %d",[wordArray count]);
    [self change];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)change{

    NSString *filename=[[wordArray objectAtIndex: currentIndex] stringByAppendingString:@".jpeg"];
    NSLog(@"fileanme:%@",filename);
    UIImage *animalImage = [UIImage imageNamed:filename];
    //animalImageView.transform=CGAffineTransformScale(animalImageView.transform, 1.0, -1.0);
    animalImageView.image=animalImage;
    NSString *currentWord= [wordArray objectAtIndex: currentIndex];
   
    //clear target
    for (int i=0;i<10;i++){
        [targetImageViewArray[i] removeFromSuperview];
    }
    //clear char
    for (int i=0;i<10;i++){
        [charImageViewArray[i] removeFromSuperview];
    }

    int offset=0;
    switch (currentWord.length) {
        case 3:
            offset=180;
            break;
        case 4:
            offset=150;
            break;
        case 5:
            offset=120;
            break;
        case 6:
            offset=90;
            break;
        case 7:
            offset=60;
            break;
        case 8:
            offset=30;
            break;
        case 9:
            offset=15;
            break;
            
        default:
            break;
    }
  
    //Display Target
    for (int i = 0; i<currentWord.length;i++){
        NSLog(@"%c",[currentWord characterAtIndex:i]);
        // Display target
        
        int x=30+i*55+offset;
        int y=250;
        targetImageViewArray[i]   = [[MyUIImageView alloc] initWithFrame:CGRectMake (x, y, 35, 35)];
        targetImageViewArray[i].charName=[currentWord substringWithRange:NSMakeRange(i,1)];
        NSLog(@"Set target: %@",targetImageViewArray[i].charName);
        NSString *charFileName=@"target.png";
        UIImage *theChar = [UIImage imageNamed:charFileName];
        targetImageViewArray[i].image=theChar;
        [self.view addSubview:targetImageViewArray[i]];
        [self.view bringSubviewToFront:targetImageViewArray[i]];
    }
    
    for (int i = 0; i<currentWord.length;i++){
        NSLog(@"%c",[currentWord characterAtIndex:i]);
        // Display Char
        int x=250+rand()%220;
        int y=50+rand()%150;
        charImageViewArray[i]   = [[MyUIImageView alloc] initWithFrame:CGRectMake (x, y, 45, 45)];
        charImageViewArray[i].charName=[currentWord substringWithRange:NSMakeRange(i,1)];
        NSLog(@"set Char: %@",charImageViewArray[i].charName);
        NSString *charFileName=[[currentWord substringWithRange:NSMakeRange(i,1)] stringByAppendingString:@".png"];
        UIImage *theChar = [UIImage imageNamed:charFileName];
        charImageViewArray[i].image=theChar;
        [self.view addSubview:charImageViewArray[i]];
        [self.view bringSubviewToFront:charImageViewArray[i]];
    }
}

- (IBAction)ClearAll:(id)sender {

    [T_Image  removeFromSuperview];
    [A_Image removeFromSuperview];
    [C_Image removeFromSuperview];
    [charImageView1 removeFromSuperview];
    [charImageView2 removeFromSuperview];
    [charImageView3 removeFromSuperview];
    [charImageView4 removeFromSuperview];
    [charImageView5 removeFromSuperview];
    [target_1 removeFromSuperview];
    [target_2 removeFromSuperview];
    [target_3 removeFromSuperview];
    
    for (int i=0;i<10;i++){
       [charImageViewArray[i] removeFromSuperview];
    }
}


- (IBAction)Reset:(id)sender {
    [A_Image  setFrame:CGRectMake( 30, 250, 45, 45)];
    [C_Image  setFrame:CGRectMake( 130, 220, 45, 45)];
    [T_Image  setFrame:CGRectMake( 230, 250, 45, 45)];
    [T_Image  removeFromSuperview];

}

- (IBAction)Next:(id)sender {
    ++currentIndex ;
    if(currentIndex ==[wordArray count])
        currentIndex=0;
    [self change];
}

- (IBAction)Previous:(id)sender {
    --currentIndex ;
    if(currentIndex < 0)
        currentIndex=[wordArray count]-1;
    [self change];
}
@end
