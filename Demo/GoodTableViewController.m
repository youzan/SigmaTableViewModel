//
//  GoodTableViewController.m
//  SigmaTableViewModelModel
//
//  Created by yangke on 16/4/14.
//  Copyright © 2016年 yangke. All rights reserved.
//

#import "GoodTableViewController.h"
#import "YZSTableViewModel.h"
#import "YZWeakDefine.h"

static NSString *Identify_CellWithImage = @"CellWithImage";
static NSString *Identify_EntryCell = @"EntryCell";
static NSString *Identify_CellWithBigFont = @"CellWithBigFont";

@interface GoodTableViewController ()

@property (nonatomic, strong) YZSTableViewModel *viewModel;

@end

@implementation GoodTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[YZSTableViewModel alloc] init];
    self.tableView.delegate = self.viewModel;
    self.tableView.dataSource = self.viewModel;
    [self initViewModel];
    [self.tableView reloadData];
}

- (void)initViewModel {
    [self.viewModel.sectionModelArray removeAllObjects];
    [self.viewModel.sectionModelArray addObject:[self storeInfoSection]];
    if (self.type == MemberTypeManager) {
        [self.viewModel.sectionModelArray addObject:[self advancedSettinsSection]];
    }
    [self.viewModel.sectionModelArray addObject:[self incomeInfoSection]];
    [self.viewModel.sectionModelArray addObject:[self otherSection]];
}

- (YZSTableViewSectionModel*)storeInfoSection {
    YZWeak(self);
    YZSTableViewSectionModel *sectionModel = [[YZSTableViewSectionModel alloc] init];
    sectionModel.headerTitle = @"Store Info";
    sectionModel.headerHeight = 40;
    sectionModel.footerHeight = 0.1;
    // store info cell
    YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.height = 80;
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_CellWithImage];
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
        return cell;
    };
    if (self.type == MemberTypeManager) {
        // product list cell
        YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
        [sectionModel.cellModelArray addObject:cellModel];
        cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:Identify_EntryCell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textLabel.text = @"View all products";
            return cell;
        };
        cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            YZStrong(self);
            [self showAlertWithTitle:@"" andMessage:@"Entry to show product list"];
        };
    }
    return sectionModel;
}

- (YZSTableViewSectionModel*)advancedSettinsSection {
    YZWeak(self);
    YZSTableViewSectionModel *sectionModel = [[YZSTableViewSectionModel alloc] init];
    sectionModel.headerTitle = @"Advanced Settings";
    sectionModel.headerHeight = 40;
    sectionModel.footerHeight = 0.1;
    // store decoration
    YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_EntryCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"Store Decoration";
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YZStrong(self);
        [self showAlertWithTitle:@"" andMessage:@"Entry to do store decoration"];
    };
    // Store location
    cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_EntryCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"Store Location";
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YZStrong(self);
        [self showAlertWithTitle:@"" andMessage:@"Entry to set store location"];
    };
    // Open Time
    cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_EntryCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"Open Time";
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YZStrong(self);
        [self showAlertWithTitle:@"" andMessage:@"Entry to set store open time"];
    };
    return sectionModel;
}

- (YZSTableViewSectionModel*)incomeInfoSection {
    YZWeak(self);
    YZSTableViewSectionModel *sectionModel = [[YZSTableViewSectionModel alloc] init];
    sectionModel.headerTitle = @"Income Info";
    sectionModel.headerHeight = 40;
    sectionModel.footerHeight = 0.1;
    if (self.type == MemberTypeManager) {
        // Withdraw
        YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
        [sectionModel.cellModelArray addObject:cellModel];
        cellModel.height = 60;
        cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_CellWithBigFont];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:Identify_CellWithBigFont];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = [UIFont boldSystemFontOfSize:22];
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }
            cell.textLabel.text = @"Withdraw";
            return cell;
        };
        cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            YZStrong(self);
            [self showAlertWithTitle:@"" andMessage:@"Entry to withdraw money"];
        };
    }
    // orders
    YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_EntryCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"Orders";
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YZStrong(self);
        [self showAlertWithTitle:@"" andMessage:@"Entry to see orders"];
    };
    // Income
    cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_EntryCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"Income";
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YZStrong(self);
        [self showAlertWithTitle:@"" andMessage:@"Entry to see Income"];
    };
    return sectionModel;
}

- (YZSTableViewSectionModel*)otherSection {
    YZWeak(self);
    YZSTableViewSectionModel *sectionModel = [[YZSTableViewSectionModel alloc] init];
    sectionModel.headerTitle = @"Other";
    sectionModel.headerHeight = 40;
    sectionModel.footerHeight = 40;
    // about
    YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_EntryCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_EntryCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"About";
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YZStrong(self);
        [self showAlertWithTitle:@"" andMessage:@"Entry to see about info"];
    };
    return sectionModel;
}
@end
