//
//  YZSTableViewSectionModel.m
//  SigmaTableViewModel
//
//  Created by yangke on 8/25/15.
//  Copyright (c) 2015 yangke. All rights reserved.
//

#import "YZSTableViewSectionModel.h"

@implementation YZSTableViewSectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.headerHeight = UITableViewAutomaticDimension;
        self.footerHeight = UITableViewAutomaticDimension;
        self.cellModelArray = [NSMutableArray array];
    }
    return self;
}

@end
