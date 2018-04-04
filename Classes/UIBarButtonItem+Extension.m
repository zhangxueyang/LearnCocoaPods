//
//  UIBarButtonItem+Extension.m
//  TestRelease
//
//  Created by Gary on 2018/2/25.
//  Copyright © 2018年 Gary. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import <objc/runtime.h>

@implementation XYUIBarbuttonItemActionBlock

-(id)initWithCallBack:(void (^)(id))callBack
{
    if (self = [super init]) {
        _callBack = callBack;
    }
    return self;
}

-(void)invoke:(id)sender
{
    self.callBack ? self.callBack(sender) : nil;
}

@end

static const int block_key;

@implementation UIBarButtonItem (Extension)

///快速生成图片的barButtonItem
+ (instancetype)barButtonWithImage:(UIImage *)image Target:(id)target Action:(barButtonBlock)block
{
    return [[self alloc] initWithImage:image action:block];
}

///快速生成文字的barButtonItem
+ (instancetype)barButtonWithTitle:(NSString *)title Target:(id)target Action:(barButtonBlock)block
{
    return [[self alloc] initWithTitle:title action:block];
}

#pragma mark -------- 方法交换
- (void)setActionBlock:(void (^)(id sender))callBack {
    XYUIBarbuttonItemActionBlock *target = [[XYUIBarbuttonItemActionBlock alloc] initWithCallBack:callBack];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id))actionBlock {
    XYUIBarbuttonItemActionBlock *target = objc_getAssociatedObject(self, &block_key);
    return target.callBack;
}


///快速生成图片的barButtonItem
-(instancetype)initWithImage:(UIImage *)image action:(void (^)(id sender))block {
    UIBarButtonItem *item = [self initWithImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    [item setActionBlock:block];
    return item;
}

- (instancetype)initWithTitle:(NSString *)title action:(void (^)(id sender))block {
    UIBarButtonItem *item = [self initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    [item setActionBlock:block];
    return item;
}

@end
