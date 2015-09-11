//
//  TipViewController.m
//  tipcalculator
//
//  Created by Liz Chaddock on 9/10/15.
//  Copyright (c) 2015 Liz Chaddock. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateValues];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void) viewDidAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.tipControl.selectedSegmentIndex = [defaults integerForKey:@"selectedSegment"];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:17], UITextAttributeFont,
                                [UIColor blackColor], UITextAttributeTextColor,
                                nil];
    [self.tipControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [self.tipControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.tipControl.selectedSegmentIndex = [defaults integerForKey:@"selectedSegment"];
    
    if ([defaults objectForKey:@"bill"]) {
        self.billTextField.text = [defaults objectForKey:@"bill"];
        [self updateValues];
    }
    
    if ([defaults integerForKey:@"isOn"]) {
        self.view.backgroundColor = [UIColor blackColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    for (UIView *view in [self.view subviews]) {
        //Check if the view is of UILabel class
        if ([view isKindOfClass:[UILabel class]]) {
            //Cast the view to a UILabel
            UILabel *label = (UILabel *)view;
            //Set the color to label
            if ([defaults integerForKey:@"isOn"]) {
                label.textColor = [UIColor whiteColor];
            } else {
                label.textColor = [UIColor blackColor];
            }
        }
    }
    
}


- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:self.billTextField.text forKey:@"bill"]; //save bill amount
    [defaults synchronize];
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

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
