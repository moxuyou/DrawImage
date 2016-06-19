//
//  LXHDrawImageView.h
//  day6-touch实现画板
//
//  Created by moxuyou on 16/5/19.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myblock)(UIImage *);
@interface LXHDrawImageView : UIView

@property (nonatomic ,weak)UIImage *image;
/** */
@property (nonatomic , copy)myblock block;

@end
