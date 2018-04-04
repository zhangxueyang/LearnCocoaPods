//
//  UIBarButtonItem+Extension.h
//  TestRelease
//
//  Created by Gary on 2018/2/25.
//  Copyright © 2018年 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYUIBarbuttonItemActionBlock :NSObject

@property(nonatomic,copy)void(^callBack)(id sender);

-(id)initWithCallBack:(void(^)(id sender))callBack;

-(void)invoke:(id)sender;

@end



typedef void(^barButtonBlock)(UIBarButtonItem *btn);

@interface UIBarButtonItem (Extension)

///快速生成图片的barButtonItem
+ (instancetype)barButtonWithImage:(UIImage *)image Target:(id)target Action:(barButtonBlock)block;
///快速生成文字的barButtonItem
+ (instancetype)barButtonWithTitle:(NSString *)title Target:(id)target Action:(barButtonBlock)block;

@end




