//
//  LXHDrawView.h
//  day6-touch实现画板
//
//  Created by moxuyou on 16/5/18.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXHDrawView;
@protocol LXHDrawViewDelegate <NSObject>

- (void)drawView:(LXHDrawView *)view WithImage:(UIImage *)image;

@end
@interface LXHDrawView : UIView

/** */
@property (nonatomic , assign, getter=isClear)BOOL clear;
@property (nonatomic , assign, getter=isReset)BOOL reset;
@property (nonatomic , assign, getter=isDelete)BOOL myDelete;
@property (nonatomic , assign)UIColor *color;
@property (nonatomic , assign)CGFloat lineSize;
/** */
@property (nonatomic , weak)id<LXHDrawViewDelegate> delegate;
/**  */
@property (nonatomic , strong)UIImage *image;

- (void)getImage;

@end
