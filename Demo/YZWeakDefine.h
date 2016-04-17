//
//  YZWeakDefine.h
//  Koudaitong
//
//  Created by 邱灿清 on 15/12/2.
//  Copyright © 2015年 qima. All rights reserved.
//

#ifndef YZWeakDefine_h
#define YZWeakDefine_h

#ifndef weakifyObject
#if __has_feature(objc_arc)
#define weakifyObject(object) ext_keywordify __weak __typeof__(object) weak##_##object = object;
#else
#define weakifyObject(object) ext_keywordify __block __typeof__(object) block##_##object = object;
#endif
#endif

#ifndef strongifyObject
#if __has_feature(objc_arc)
#define strongifyObject(object) ext_keywordify __strong __typeof__(object) object = weak##_##object;
#else
#define strongifyObject(object)                                                                    \
    ext_keywordify __strong __typeof__(object) object = block##_##object;
#endif
#endif

#undef YZWeak
#define YZWeak(...) @weakifyObject(__VA_ARGS__)

#undef YZStrong
#define YZStrong(...) @strongifyObject(__VA_ARGS__)

#if DEBUG
#define ext_keywordify                                                                             \
    autoreleasepool {                                                                              \
    }
#else
#define ext_keywordify                                                                             \
    try {                                                                                          \
    } @catch (...) {                                                                               \
    }
#endif

#endif

/* YZWeakDefine_h */

/*
 eg:
     YZWeak(self);
     self.block = ^(NSString *test){
        YZStrong(self);
        self.model = 1;
        void (^inBlock)(void) = ^(){
            YZStrong(self);
            self.model = 3;
     };
        inBlock();
     };

     Demo *model = [[Demo alloc] init];
     YZWeak(model);
     self.modelBlock = ^(NSString *modelStr){
        YZStrong(model);
        YZStrong(self);
        [model modelWithViewController:self];
     };

     self.block(@"sds");

 */
