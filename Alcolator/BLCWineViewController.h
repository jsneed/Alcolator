//
//  BLCViewController.h
//  Alcolator
//
//  Created by Jeanne on 7/18/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCWineViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;

- (NSString*) getViewTitle;
- (void)buttonPressed:(UIButton *)sender;

@end
