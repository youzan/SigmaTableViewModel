[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/youzan/SigmaTableViewModel/blob/master/LICENSE)&nbsp;
[![CocoaPods](https://img.shields.io/badge/pod-v1.0.0-blue.svg)](http://cocoapods.org/?q=SigmaTableViewModel)&nbsp;
[![Platform](https://img.shields.io/badge/platform-ios-yellow.svg)](https://www.apple.com/nl/ios/)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Build Status](https://travis-ci.org/youzan/SigmaTableViewModel.svg?branch=master)](https://travis-ci.org/youzan/SigmaTableViewModel)

<p>
<a href="https://github.com/youzan/"><img alt="有赞logo" width="36px" src="https://img.yzcdn.cn/public_files/2017/02/09/e84aa8cbbf7852688c86218c1f3bbf17.png" alt="youzan">
</p></a>
<p align="center">
    <img alt="项目logo" width="200px" src="https://github.com/youzan/SigmaTableViewModel/blob/master/images/sigma.png">
</p>
<p align="center">A simple view model for building organized and scalable TableViews.</p>

[中文版README](http://www.cocoachina.com/ios/20160428/16002.html)

## SigmaTableViewModel vs UITableViewDataSource + UITableViewDelegate
Apple provides the UITableViewDataSource & UITableViewDelegate to implement the tableview UI, but a big problem is that the UI logic exists in multiple places and there will be lots of duplicate code, especially those complex tableview UIs with different types of cells and dynamic logic.

**e.g.** Let's take a look at a store management UI like this:

<img src="https://github.com/youzan/SigmaTableViewModel/blob/master/images/manager.png" width="300">

2 kinds of users will use this UI, manager and employee. Manager can see all above rows, while employee can only see some of them, like

<img src="https://github.com/youzan/SigmaTableViewModel/blob/master/images/employee.png" width="300">


In the traditional way, we may implement the UI like this:
```objective-c
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
... 
```

There will be more *if else* code in the rest datasrouce & delegate methods, especially in the *tableView:cellForRowAtIndexPath:* method. Take a look at the code in *BadTableViewController* in the demo for more details. 

We can see the problem here. There are so many hardcode things and duplicate code. What we need is to use a model to hold all the logic and only use the model in these delegate & datasource methods.  That is what the *SigmaTableViewModel* does.

*SigmaTableViewModel* provides the ***YZSTableViewModel*** as the view model and a depth 2 array ***sectionModelArray*** in it. The 1st level of the array is the section, and the 2nd level is the row. So what we need is to construct this array and ask tableview to use it, like this:

```objective-c
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
    YZSTableViewSectionModel *sectionModel = [[YZSTableViewSectionModel alloc] init];
    ...
    // store info cell
    YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.height = 80;
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        ...
    };
    if (self.type == MemberTypeManager) {
        // product list cell
        YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
        [sectionModel.cellModelArray addObject:cellModel];
        cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
            ...
        };
        cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            ...
        };
    }
    return sectionModel;
}
...
```
Take a look at the code in the *GoodTableViewController* in the demo for more details.  


## Exercise
If we want to move the *Withdraw* row to the 3rd row in that section, what do we need to do in the traditional way? And how about in SigmaTableViewModel way? What if we what to hide the *Income* row for employee? 

## Usage 
2 steps to use the SigmaTableViewModel.

 1. Create an instance of the ***YZSTableViewModel*** and use it as the tableview's delegate and datasource.
 2. Construct the ***sectionModelArray*** for the view model instance.

## Installation
### CocoaPods
 1. Add `pod 'SigmaTableViewModel'` to your Podfile.
 2. Run `pod install` or `pod update`.

### Manually
 1. Download all the files in the `Lib` subdirectory.
 2. Add the source files to your Xcode project.

## More Discussions
 - SigmaTableViewModel only provides some frequently used functions of UITableViewDataSource & UITableViewDelegate. If you needs more functions, you can subclass *YZSTableViewModel* and implement those functions. 
 - If the code in those cell's blocks can be reused,  we can put them in some methods and only invoke these methods in those blocks.
 - The block is used frequently in the view model so we have to be careful about the retain cycle. Always use weak-strong dance for safe. In the demo, we use **YZWeak** & **YZStrong** macros to simplify the weak-strong dance code.

## License
[MIT](https://zh.wikipedia.org/wiki/MIT%E8%A8%B1%E5%8F%AF%E8%AD%89)