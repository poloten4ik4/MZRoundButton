//
//  ViewController.m
//  RoundButton
//
//  Created by Михаил Заславский on 02.12.15.
//  Copyright © 2015 Mikezs. All rights reserved.
//

#import "ViewController.h"
#import "MZRoundButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MZRoundButton *acceptButton;
@property (weak, nonatomic) IBOutlet MZRoundButton *cancelButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    self.acceptButton.showsActivityIndicator=YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.acceptButton.showsActivityIndicator=NO;
    });
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
