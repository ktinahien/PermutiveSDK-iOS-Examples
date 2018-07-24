//
//  FirstViewController.m
//  NewsMeUp
//
//  Created by Gregg Jaskiewicz on 15/05/2018.
//  Copyright © 2018 Permutive. All rights reserved.
//

#import "FirstViewController.h"
#import <Permutive/Permutive.h>

@interface FirstViewController ()

@property(nonatomic, strong) id<PermutiveTriggerAction> triggerAction;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    id<PermutiveTriggerAction> triggerAction = [[[Permutive permutive] triggersProvider] triggerActionForAllSegmentsWithTriggerType:PermutiveTriggerOnChange];
    [triggerAction setTriggerBlock:^(NSUInteger segmentID, NSNumber * _Nullable value, NSNumber * _Nullable oldValue) {
        NSLog(@"segment: %lu, new value: %@, old value: %@", (unsigned long)segmentID, value, oldValue);
    }];

    self.triggerAction = triggerAction;
}

@end
