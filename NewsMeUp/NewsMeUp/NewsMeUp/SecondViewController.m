//
//  SecondViewController.m
//  NewsMeUp
//
//  Created by Gregg Jaskiewicz on 15/05/2018.
//  Copyright © 2018 Permutive. All rights reserved.
//

#import "SecondViewController.h"
#import <Permutive/Permutive.h>


@interface SecondViewController ()

@property(nonatomic, weak) IBOutlet UITextField *identityField;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.identityField.text = @"foobar1";
}

- (IBAction)reset:(id)sender {
    [Permutive reset];
}

- (IBAction)setIdentity:(id)sender {
    NSString *identity = self.identityField.text;

    if (identity.length > 0) {
        [Permutive setIdentity:identity];
    }
}

- (IBAction)sendEvent:(id)sender {

    [[[Permutive permutive] eventTracker] track:@"event"];
}

@end
