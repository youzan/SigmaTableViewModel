# SigmaTableViewModel

## Description

SigmaTableViewModel is a lightweight view model to help to implement tableview UI, especially those complex tableviews with different types of cells and dynamic logic.

## SigmaTableViewModel vs UITableViewDataSource+UITableViewDelegate
Apple provides the UITableViewDataSource & UITableViewDelegate to implement the tableview UI but a big problem is that the UI logic exists in multiple places and there will be lots of duplicate code.  
e.g. Let's take a look at a store management UI like this:
![](https://github.com/youzan/SigmaTableViewModel/blob/master/images/manager.png)
There are 2 kinds of users will use this UI, manager and employee. Manager can see all above rows, and employee can only see some of them, like
![](https://github.com/youzan/SigmaTableViewModel/blob/master/images/employee.png)
In traditional way, we may need to implement the UI like this:
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
There will be more *if else* code in the rest datasrouce & delegate methods, especially in the *tableView:cellForRowAtIndexPath:* method. Take a look at the code in class **BadTableViewController** for more details. 
We can see the problem here. There are so many hardcode things and duplicate logic & code. What we need is to use a model to hold all the logic and only use the model in these delegate & datasource methods.  That is what the **SigmaTableViewModel** does.
SigmaTableViewModel provides an depth 2 array ***sectionModelArray***. The 1st level is the section, and 2nd level is row. So what we need is to create this array and tell tableview to use it, like this:
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[YZSTableViewModel alloc] init];
    self.tableView.delegate = self.viewModel;
    self.tableView.dataSource = self.viewModel;
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)initDataSource {
    ...
    [self.viewModel.sectionModelArray removeAllObjects];
    YZWeak(self);
    // store info section
    YZSTableViewSectionModel *sectionModel = [[YZSTableViewSectionModel alloc] init];
    [self.viewModel.sectionModelArray addObject:sectionModel];
    ...
    YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
    [sectionModel.cellModelArray addObject:cellModel];
    cellModel.height = 80;
    cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        ...
        return cell;
    };
    if (self.type == MemberTypeManager) {
        // product list entry
        YZSTableViewCellModel *cellModel = [[YZSTableViewCellModel alloc] init];
        [sectionModel.cellModelArray addObject:cellModel];
        cellModel.renderBlock = ^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
            ...
            return cell;
        };
        cellModel.selectionBlock = ^(NSIndexPath *indexPath, UITableView *tableView) {
            ...
        };
    }
    ...
}
```
Take a look at the code in the class **GoodTableViewController** in the demo for more details.  


## Exercise
If we want to move the *Withdraw* row to the 3rd row in that section, what we need to do in traditional way and in SigmaTableViewModel way? What if we what to hide the *Income* row for employee? 

## Usage 
2 steps to use the SigmaTableViewModel.

 1. Create an instance of the SigmaTableViewModel and use it as the tableview's delegate and datasource.
 2. Create the *sectionModelArray* for the view model instance.

 ## Installation
 ### CocoaPods
 Coming soon...

 ### Use the source code directly
 You can also download the project and copy all files in the *Lib* folder to your project.

## More Discussions

 - SigmaTableViewModel only provides some frequently used functions of UITableViewDataSource & UITableViewDelegate. If you needs more functions, you can subclass it and provide the implementation for those functions. 
 - If we put all code to generate the sectionModelArray in the same method, the method will be very long. So we can put the code to generate different sections in different methods like in the demo. 
 - If the code in those cell's blocks can be reused,  we can put them in some methods and only invoke these methods in those blocks.

## License
MIT 