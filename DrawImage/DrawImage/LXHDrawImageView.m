//
//  LXHDrawImageView.m
//  day6-touch实现画板
//
//  Created by moxuyou on 16/5/19.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHDrawImageView.h"

@interface LXHDrawImageView ()<UIGestureRecognizerDelegate>

/**  */
@property (nonatomic , strong)UIImageView *imageView;

@end
@implementation LXHDrawImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = _image;
}

- (void)awakeFromNib
{
    [self setUp];
}
- (void)setUp
{
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint panP = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, panP.x, panP.y);
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
//    CGPoint pinch = [pinch ];
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    
    pinch.scale = 1;
}

- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    rotation.rotation = 0;
}

- (void)longPress:(UIPinchGestureRecognizer *)longPress
{
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 1;
        } completion:^(BOOL finished) {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            [self.layer renderInContext:ctx];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
//            NSData *data = UIImagePNGRepresentation(image);
//            [data writeToFile:@"/Users/moxuyou/Desktop/drawView11.png" atomically:YES];
            
            self.block(image);
        }];
    }];
    
    [self removeFromSuperview];
}


- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        _imageView.frame = self.bounds;
        [self addSubview:_imageView];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self.imageView addGestureRecognizer:pan];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        pinch.delegate = self;
        [self.imageView addGestureRecognizer:pinch];
        
        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
        rotation.delegate = self;
        [self.imageView addGestureRecognizer:rotation];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self.imageView addGestureRecognizer:longPress];
    }
    return _imageView;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


@end
