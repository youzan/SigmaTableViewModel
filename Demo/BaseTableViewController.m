//
//  BaseTableViewController.m
//  SigmaTableViewModelModel
//
//  Created by yangke on 16/4/14.
//  Copyright © 2016年 yangke. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Store Management";
    self.tableView.backgroundColor =
    [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1];
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)msg {
    if (NSClassFromString(@"UIAlertController")) {
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:title
                                            message:msg
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok =
        [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end
