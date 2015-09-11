//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Liz Chaddock on 9/10/15.
//  Copyright (c) 2015 Liz Chaddock. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *toggle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (weak, nonatomic) IBOutlet UILabel *defaultTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *toggleLabel;
- (IBAction)onSelect:(id)sender;
- (IBAction)onToggle:(id)sender;

@end

@implementation SettingsViewController

- (void)onSelect:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.defaultTipControl.selectedSegmentIndex forKey:@"selectedSegment"];
    [defaults synchronize];
}

- (IBAction)onToggle:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[self.toggle isOn] forKey:@"isOn"];
    
    if ([self.toggle isOn]) {
        self.view.backgroundColor = [UIColor blackColor];
        self.toggleLabel.textColor = [UIColor whiteColor];
        self.defaultTipLabel.textColor = [UIColor whiteColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.toggleLabel.textColor = [UIColor blackColor];
        self.defaultTipLabel.textColor = [UIColor blackColor];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.defaultTipControl.selectedSegmentIndex = [defaults integerForKey:@"selectedSegment"];
    
    [self.toggle setOn:[defaults integerForKey:@"isOn"]];
    //Change colors to match toggle
    if ([self.toggle isOn]) {
        self.view.backgroundColor = [UIColor blackColor];
        self.toggleLabel.textColor = [UIColor whiteColor];
        self.defaultTipLabel.textColor = [UIColor whiteColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.toggleLabel.textColor = [UIColor blackColor];
        self.defaultTipLabel.textColor = [UIColor blackColor];
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Regular state for tip control
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:17], UITextAttributeFont,
                                [UIColor blackColor], UITextAttributeTextColor,
                                nil];
    [self.defaultTipControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    //highlighted state for tip control
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [self.defaultTipControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
