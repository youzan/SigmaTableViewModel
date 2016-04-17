//
//  YZSTableViewCellModel.h
//  SigmaTableViewModel
//
//  Created by yangke on 8/25/15.
//  Copyright (c) 2015 yangke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef UITableViewCell * (^YZSCellRenderBlock)(NSIndexPath *indexPath, UITableView *tableView);
typedef NSIndexPath * (^YZSCellWillSelectBlock)(NSIndexPath *indexPath, UITableView *tableView);
typedef void (^YZSCellSelectionBlock)(NSIndexPath *indexPath, UITableView *tableView);
typedef void (^YZSCellWillDisplayBlock)(UITableViewCell *cell, NSIndexPath *indexPath, UITableView *tableView);
typedef void (^YZSCellCommitEditBlock)(NSIndexPath *indexPath, UITableView *tableView,
                                       UITableViewCellEditingStyle editingStyle);

/** Table view's row model */
@interface YZSTableViewCellModel : NSObject

@property (nonatomic, copy) YZSCellRenderBlock renderBlock;            // required
@property (nonatomic, copy) YZSCellWillDisplayBlock willDisplayBlock;  // optional
@property (nonatomic, copy) YZSCellWillSelectBlock willSelectBlock;    // optional
@property (nonatomic, copy) YZSCellWillSelectBlock willDeselectBlock;  // optional
@property (nonatomic, copy) YZSCellSelectionBlock selectionBlock;      // optional
@property (nonatomic, copy) YZSCellSelectionBlock deselectionBlock;    // optional
@property (nonatomic, copy) YZSCellCommitEditBlock commitEditBlock;    // optional
// if not specified, will use UITableViewAutomaticDimension as default value
@property (nonatomic, assign) CGFloat height;  // optional
@property (nonatomic, assign) BOOL canEdit;    // default NO
//@property (nonatomic, assign) BOOL canMove;   //default NO
@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;  // cell's editing style
@property (nonatomic, copy) NSString *deleteConfirmationButtonTitle;  // delete confirmation title

@end
