//
//  BadTableViewController.m
//  SigmaTableViewModelModel
//
//  Created by yangke on 16/4/14.
//  Copyright © 2016年 yangke. All rights reserved.
//

#import "BadTableViewController.h"

@implementation BadTableViewController

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (self.type) {
        case MemberTypeEmployee:
            return 3;
            break;
        case MemberTypeManager:
            return 4;
            break;
        default:
            return 3;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.type == MemberTypeEmployee) {
            return 1;  // only store info
        } else {
            return 2;  // store info and goods entry
        }
    } else if (section == 1) {
        if (self.type == MemberTypeEmployee) {
            return 2;  // order list
        } else {
            return 3;  // advanced settings...
        }
    } else if (section == 2) {
        if (self.type == MemberTypeEmployee) {
            return 1;  // about
        } else {
            return 3;  // store income and withdraw
        }
    } else {
        return 1;  // about
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Store Info";
    } else if (section == 1) {
        if (self.type == MemberTypeEmployee) {
            return @"Income Info";
        } else {
            return @"Advanced Settings";
        }
    } else if (section == 2) {
        if (self.type == MemberTypeEmployee) {
            return @"Other";
        } else {
            return @"Income Info";
        }
    } else {
        return @"Other";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identify_CellWithImage = @"CellWithImage";
    static NSString *Identify_EntryCell = @"EntryCell";
    static NSString *Identify_CellWithBigFont = @"CellWithBigFont";

    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:Identify_CellWithImage];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:Identify_CellWithImage];
                UIImageView *iconView =
                [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_store"]];
                iconView.frame = CGRectMake(10, 10, 60, 60);
                iconView.tag = 1;
                [cell.contentView addSubview:iconView];
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 250, 40)];
                titleLabel.font = [UIFont boldSystemFontOfSize:20];
                titleLabel.tag = 2;
                [cell.contentView addSubview:titleLabel];
                UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 250, 25)];
                descLabel.tag = 3;
                [cell.contentView addSubview:descLabel];
            }
            UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:2];
            titleLabel.text = @"MacBook Online";
            UILabel *descLabel = (UILabel *)[cell.contentView viewWithTag:3];
            descLabel.text = @"Macbooks, very cheep here~";
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:Identify_EntryCell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textLabel.text = @"View all products";
        }
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_EntryCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (self.type == MemberTypeEmployee) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Orders";
            } else {
                cell.textLabel.text = @"Income";
            }
        } else {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Store Decoration";
            } else if (indexPath.row == 1) {
                cell.textLabel.text = @"Store Location";
            } else {
                cell.textLabel.text = @"Open Time";
            }
        }
    } else if (indexPath.section == 2) {
        if (self.type == MemberTypeEmployee) {
            cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:Identify_EntryCell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textLabel.text = @"About";
        } else {
            if (indexPath.row == 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:Identify_CellWithBigFont];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:Identify_CellWithBigFont];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.textLabel.font = [UIFont boldSystemFontOfSize:22];
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                }
                cell.textLabel.text = @"Withdraw";
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:Identify_EntryCell];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                if (indexPath.row == 1) {
                    cell.textLabel.text = @"Orders";
                } else {
                    cell.textLabel.text = @"Income";
                }
            }
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_EntryCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"About";
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        } else {
            return 44;
        }
    } else if (indexPath.section == 1) {
        return 44;
    } else if (indexPath.section == 2) {
        if (self.type == MemberTypeEmployee) {
            return 44;
        } else {
            if (indexPath.row == 0) {
                return 60;
            } else {
                return 44;
            }
        }
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self showAlertWithTitle:@"" andMessage:@"Entry to show product list"];
    } else if (indexPath.section == 1) {
        if (self.type == MemberTypeEmployee) {
            if (indexPath.row == 0) {
                [self showAlertWithTitle:@"" andMessage:@"Entry to show orders"];
            } else {
                [self showAlertWithTitle:@"" andMessage:@"Entry to show income info"];
            }
        } else {
            if (indexPath.row == 0) {
                [self showAlertWithTitle:@"" andMessage:@"Entry to do store decoration"];
            } else if (indexPath.row == 1) {
                [self showAlertWithTitle:@"" andMessage:@"Entry to set store location"];
            } else {
                [self showAlertWithTitle:@"" andMessage:@"Entry to set open time"];
            }
        }
    } else if (indexPath.section == 2) {
        if (self.type == MemberTypeEmployee) {
            [self showAlertWithTitle:@"" andMessage:@"Entry to show about info"];
        } else {
            if (indexPath.row == 0) {
                [self showAlertWithTitle:@"" andMessage:@"Entry to withdraw money"];
            } else if (indexPath.row == 1) {
                [self showAlertWithTitle:@"" andMessage:@"Entry to show orders"];
            } else {
                [self showAlertWithTitle:@"" andMessage:@"Entry to show income info"];
            }
        }
    } else {
        [self showAlertWithTitle:@"" andMessage:@"Entry to show about info"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == [tableView numberOfSections] - 1) {
        return 40;
    }
    return 0.1;
}

@end
