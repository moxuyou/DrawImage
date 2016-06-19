//
//  LXHDrawView.m
//  day6-touch实现画板
//
//  Created by moxuyou on 16/5/18.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "LXHDrawView.h"
#import "LXHBezierPath.h"

@interface LXHDrawView ()

/** */
@property (nonatomic , assign)CGPoint curPoint;
@property (nonatomic , assign)CGPoint startPoint;
/**  */
@property (nonatomic , strong)NSMutableArray *lineArray;
/**  */
@property (nonatomic , strong)LXHBezierPath *path;

@end
@implementation LXHDrawView

- (NSMutableArray *)lineArray
{
    if (_lineArray == nil) {
        _lineArray = [NSMutableArray array];
    }
    return _lineArray;
}

- (void)drawRect:(CGRect)rect {
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:self.startPoint];
    for (int i=0; i<self.lineArray.count; ++i) {
        
        LXHBezierPath *path = self.lineArray[i];
        if ([path isKindOfClass:[LXHBezierPath class]]) {
            [path.color set];
            [path stroke];
        }else if ([path isKindOfClass:[UIImage class]]){
            UIImage *image = (UIImage *)path;
            [image drawInRect:self.frame];
        }
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.startPoint = [touch locationInView:self];
    
    self.path = [LXHBezierPath bezierPath];
    [self.path moveToPoint:self.startPoint];
    [self.lineArray addObject:self.path];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    self.curPoint = [touch locationInView:self];
    
    [self.path addLineToPoint:self.curPoint];
//
    if (self.lineSize < 1.0) {
        self.lineSize = 1.0;
    }
    self.path.lineWidth = self.lineSize;
    self.path.color = self.color;
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
//    
//    self.curPoint = [touch locationInView:self];
//    [self setNeedsDisplay];
}

- (void)setLineSize:(CGFloat)lineSize
{
    _lineSize = lineSize * 20;
}

- (void)setClear:(BOOL)clear
{
    _clear = clear;
    [self.lineArray removeAllObjects];
    [self setNeedsDisplay];
}
- (void)setReset:(BOOL)reset
{
    _reset = reset;
    [self.lineArray removeLastObject];
    [self setNeedsDisplay];
}
- (void)setMyDelete:(BOOL)myDelete
{
    _myDelete = myDelete;
    _color = [UIColor whiteColor];
    
}

- (void)setColor:(UIColor *)color
{
    _color = color;
}

- (void)getImage
{
//    UIGraphicsBeginImageContext(self.frame.size);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    [self.layer renderInContext:ctx];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    if ([self.delegate respondsToSelector:@selector(drawView:WithImage:)]) {
//        [self.delegate drawView:self WithImage:newImage];
//    }
//    UIGraphicsEndImageContext();
}

- (void)setImage:(UIImage *)image
{
    [self.lineArray addObject:image];
    [self setNeedsDisplay];
}

@end
