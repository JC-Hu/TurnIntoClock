//
//  TICUserDefaults.h
//  TurnIntoClock
//
//  Created by Jason Hu on 2019/7/19.
//  Copyright © 2019 Jason Hu. All rights reserved.
//

#import "JHBaseUserDefaults.h"

@interface TICUserDefaults : JHBaseUserDefaults

@property (nonatomic) BOOL showDate;
@property (nonatomic) BOOL timeFormat24;
@property (nonatomic) BOOL lightBackground;
@property (nonatomic) NSInteger timeLabelSize;
@property (nonatomic) NSInteger dateLabelSize;
@property (nonatomic) NSInteger timeLabelFontWeight;
@property (nonatomic) NSInteger dateLabelFontWeight;




@end


