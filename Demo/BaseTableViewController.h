//
//  BaseTableViewController.h
//  SigmaTableViewModelModel
//
//  Created by yangke on 16/4/14.
//  Copyright © 2016年 yangke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MemberType) {
    MemberTypeEmployee,
    MemberTypeManager,
};

@interface BaseTableViewController : UITableViewController

@property (nonatomic, assign) MemberType type;

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)msg;

@end
