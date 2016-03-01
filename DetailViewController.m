//
//  DetailViewController.m
//  DreamCatcher
//
//  Created by ALIREZA TABRIZI on 2/25/16.
//  Copyright © 2016 AR-T.com, Inc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.descriptionStrng;
    self.title = self.titleString;
}


@end
