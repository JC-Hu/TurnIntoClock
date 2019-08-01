//
//  ViewController.m
//  TurnIntoClock
//
//  Created by Jason Hu on 2019/7/19.
//  Copyright © 2019 Jason Hu. All rights reserved.
//

#import "ViewController.h"

#import "TICUserDefaults.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic) NSArray *tempDateLabelConstraints;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    [self updateForStyle];
    [self updateForShowDate];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self updateForShowDate];
        [self.view layoutIfNeeded];
        
        [self switchStyleButtonAction:nil];
        
    });
    
    [self startClock];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self switchStyleButtonAction:nil];
}

- (void)startClock
{
    [self updateTimeAndDate];
}

- (void)updateTimeAndDate
{
    NSDate *date = [NSDate date];
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];//系统所在时区
//
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//
//    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"HH:mm"];
    
    self.timeLabel.text = [formatter stringFromDate:date];
    
    [formatter setDateFormat:@"EEE MM-dd"];
    self.dateLabel.text = [formatter stringFromDate:date];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateTimeAndDate];
    });
    
}

- (IBAction)sizeSliderAction:(id)sender
{
    
}

- (IBAction)buttonAction:(id)sender
{
    
    [self switchStyleButtonAction:nil];
    [self showDateButtonAction:nil];
    
}


- (void)updateForStyle {
    if (TICUserDefaults.sharedManager.lightBackground) {
        self.view.backgroundColor = UIColor.whiteColor;
        self.timeLabel.textColor = UIColor.blackColor;
        self.dateLabel.textColor = UIColor.blackColor;
    } else {
        self.view.backgroundColor = UIColor.blackColor;
        self.timeLabel.textColor = UIColor.whiteColor;
        self.dateLabel.textColor = UIColor.whiteColor;
    }
}

- (void)updateForShowDate
{
    
    if (TICUserDefaults.sharedManager.showDate) {
        
        self.dateLabel.hidden = NO;
        if (self.tempDateLabelConstraints) {
            [self.dateLabel addConstraints:self.tempDateLabelConstraints];
        }
        
    } else {
        
        self.dateLabel.hidden = YES;
        self.tempDateLabelConstraints = self.dateLabel.constraints;
        [self.dateLabel removeConstraints:self.dateLabel.constraints];
        
    }
}


- (IBAction)switchStyleButtonAction:(id)sender
{
    TICUserDefaults.sharedManager.lightBackground = !TICUserDefaults.sharedManager.lightBackground;
    
    [self updateForStyle];
}

- (IBAction)showDateButtonAction:(id)sender
{
    TICUserDefaults.sharedManager.showDate = !TICUserDefaults.sharedManager.showDate;
    
    [self updateForShowDate];
}




- (BOOL)prefersHomeIndicatorAutoHidden
{
    return YES;
}


@end
