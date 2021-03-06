//
//  BLCViewController.m
//  Alcolator
//
//  Created by Jeanne on 7/18/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCWineViewController.h"

@interface BLCWineViewController () <UITextFieldDelegate>

//@property (weak, nonatomic) UILabel *beerLabel;

@property (weak, nonatomic) UIButton *calculateButton;

@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation BLCWineViewController

- (NSString*) getViewTitle
{
    return @"Wine";
}

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
    
    // Allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // Add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (void)viewDidLoad
{
    // Calls the superclass's implementation
    [super viewDidLoad];
    //self.viewTitle = @"Wine";
    //[self setViewTitle:@"Wine"];
    self.navigationItem.title = @"Wine";
    
    // Set our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Tells the text field that `self`, this instance of `BLCViewController` should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    self.beerPercentTextField.backgroundColor = [UIColor lightGrayColor];
    
    // Tells `self.beerCountSlider` that when its value changes, it should call `[self -sliderValueDidChange:]`.
    // This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Tells `self.calculateButton` that when a finger is lifted from the button while still inside its bounds, to call `[self -buttonPressed:]`
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    // Tells the tap gesture recognizer to call `[self -tapGestureDidFire:]` when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    
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

    CGFloat top = 100; //self.view.bounds.size.height + 10;
    CGFloat padding;
    CGFloat itemHeight;
    CGFloat multiplier;
    
    //self.view.frame.size.height
    //CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewWidth;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        padding = 20;
        itemHeight = 44;
        multiplier = 4;
        viewWidth = screenWidth;
        NSLog(@"portrait");
    }
    else {
        padding = 20;
        itemHeight = 20;
        multiplier = 1;
        viewWidth = screenHeight;
        NSLog(@"landscape");
    }
    
    CGFloat itemWidth = viewWidth - padding - padding;

    self.beerPercentTextField.frame = CGRectMake(padding, top, itemWidth, itemHeight);
    [self.view addSubview:self.beerPercentTextField];
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    [self.view addSubview:self.beerCountSlider];
        
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * multiplier);
        
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
    
    [self.view addSubview:self.resultLabel];
    [self.view addSubview:self.calculateButton];
    
    //[self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {
    // Make sure the text is a number
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = [NSString stringWithFormat:NSLocalizedString(@"%d beer", nil), numberOfBeers];
    } else {
        beerText = [NSString stringWithFormat:NSLocalizedString(@"%d beers", nil), numberOfBeers];
    }
    NSString* viewTitle = [self getViewTitle];
    self.navigationItem.title = [NSString stringWithFormat:NSLocalizedString(@"%@ (%@)", nil), viewTitle, beerText];

    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];
}

- (void)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    // first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
