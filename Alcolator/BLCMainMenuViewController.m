//
//  BLCViewController.m
//  Alcolator
//
//  Created by Jeanne on 7/18/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCMainMenuViewController.h"
#import "BLCWineViewController.h"
#import "BLCWhiskeyViewController.h"

@interface BLCMainMenuViewController ()

@end

@implementation BLCMainMenuViewController

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    //decide number of origination tob supported by Viewcontroller.
    return UIInterfaceOrientationMaskAll;
}

- (void)loadView {
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Alocator";
    
    [self updateInterface];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"willRotateToInterfaceOrientation");
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"didRotateFromInterfaceOrientation");
    [[self.view subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self updateInterface];
}

-(void)updateInterface {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGFloat buttonHeight = self.wineButton.frame.size.height;
    CGFloat buttonWidth = self.wineButton.frame.size.width;
    CGFloat padding;
    CGFloat viewWidth;
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        viewWidth = screenWidth;
        padding = 20;
    }
    else {
        viewWidth = screenHeight;
        padding = 50;
    }
    self.wineButton.frame = CGRectMake(padding, 100, buttonWidth, buttonHeight);
    self.whiskeyButton.frame = CGRectMake(viewWidth - padding - buttonWidth, 100, buttonWidth, buttonHeight);
    
    [self.view addSubview:self.wineButton];
    [self.view addSubview:self.whiskeyButton];
}

- (UIButton *)wineButton {
    if(!_wineButton) {
        _wineButton = [[UIButton alloc] init];
        [_wineButton setTitle:NSLocalizedString(@"Show Wine", nil) forState:UIControlStateNormal];
        _wineButton.backgroundColor = [UIColor whiteColor];
        [_wineButton setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
        _wineButton.frame = CGRectMake(25, 100, 130, 50);
        [_wineButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
        [[_wineButton layer] setBorderWidth:1.0f];
        [[_wineButton layer] setBorderColor:[UIColor blueColor].CGColor];
        [_wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wineButton;
}

- (UIButton *)whiskeyButton {
    if(!_whiskeyButton) {
        _whiskeyButton = [[UIButton alloc] init];
        [_whiskeyButton setTitle:NSLocalizedString(@"Show Whiskey", nil) forState:UIControlStateNormal];
        _whiskeyButton.backgroundColor = [UIColor whiteColor];
        [_whiskeyButton setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
        _whiskeyButton.frame = CGRectMake(175, 100, 130, 50);
        [_whiskeyButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
        [[_whiskeyButton layer] setBorderWidth:1.0f];
        [[_whiskeyButton layer] setBorderColor:[UIColor blueColor].CGColor];
        [_whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _whiskeyButton;
}

- (void)winePressed:(UIButton *)sender {
    [self.navigationController pushViewController:[[BLCWineViewController alloc] init] animated: YES];
}

- (void)whiskeyPressed:(UIButton *)sender {
    [self.navigationController pushViewController:[[BLCWhiskeyViewController alloc] init] animated: YES];
}

@end
