//
//  ViewController.m
//  SigmaTableViewModel
//
//  Created by yangke on 8/25/15.
//  Copyright (c) 2015 yangke. All rights reserved.
//

#import "RootViewController.h"
#import "YZSTableViewModel.h"
#import "YZWeakDefine.h"
#import "BadTableViewController.h"
#import "GoodTableViewController.h"

@interface RootViewController ()
@property (nonatomic, strong) YZSTableViewModel *viewModel;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.viewModel = [[YZSTableViewModel alloc] init];
    self.tableView.delegate = self.viewModel;
    self.tableView.dataSource = self.viewModel;
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)initDataSource {
    static NSString *Identify_Cell = @"Cell";

    YZWeak(self);
    [self.viewModel.sectionModelArray removeAllObjects];
    YZSTableViewSectionModel *sectionModel = [[YZSTableViewSectionModel alloc] init];
    [self.viewModel.sectionModelArray addObject:sectionModel];
    sectionModel.headerTitle = @"Traditional Implementation";
    sectionModel.headerHeight = 40;
    sectionModel.footerHeight = 0.1;
    YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_Cell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_Cell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"Employee";
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YZStrong(self);
        [self manageStoreByMember:MemberTypeEmployee withTraditionalWay:YES];
    };
    cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_Cell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_Cell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"Manager";
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YZStrong(self);
        [self manageStoreByMember:MemberTypeManager withTraditionalWay:YES];
    };

    sectionModel = [[YZSTableViewSectionModel alloc] init];
    [self.viewModel.sectionModelArray addObject:sectionModel];
    sectionModel.headerTitle = @"Better Implementation";
    sectionModel.headerHeight = 40;
    cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_Cell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_Cell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"Employee";
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YZStrong(self);
        [self manageStoreByMember:MemberTypeEmployee withTraditionalWay:NO];
    };
    cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify_Cell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:Identify_Cell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = @"Manager";
        return cell;
    };
    cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        YZStrong(self);
        [self manageStoreByMember:MemberTypeManager withTraditionalWay:NO];
    };
}

- (void)manageStoreByMember:(MemberType)type withTraditionalWay:(BOOL)tradition {
    BaseTableViewController *storeVC = nil;
    if (tradition) {
        storeVC = [[BadTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    } else {  // better way
        storeVC = [[GoodTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    }
    storeVC.type = type;
    [self.navigationController pushViewController:storeVC animated:YES];
}

@end
