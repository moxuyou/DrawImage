//
//  ViewController.m
//  DrawImage
//
//  Created by moxuyou on 16/6/19.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "ViewController.h"
#import "LXHDrawView.h"
#import "LXHDrawImageView.h"

@interface ViewController ()<LXHDrawViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet LXHDrawView *drawView;
/** */
@property (nonatomic , weak)LXHDrawImageView *lxhView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drawView.delegate = self;
    
}
- (IBAction)clear:(UIBarButtonItem *)sender {
    self.drawView.clear = YES;
}

- (IBAction)reset:(UIBarButtonItem *)sender {
    self.drawView.reset = YES;
}
- (IBAction)delete:(UIBarButtonItem *)sender {
    self.drawView.myDelete = YES;
}
- (IBAction)photo:(UIBarButtonItem *)sender {
    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
    pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    pickVC.delegate = self;
    [self presentViewController:pickVC animated:YES completion:nil];
}
- (IBAction)save:(UIBarButtonItem *)sender {
    //    [self.drawView getImage];
    UIGraphicsBeginImageContextWithOptions(self.drawView.frame.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"完成！");
}
- (IBAction)redColor:(UIButton *)sender {
    [self.drawView setColor:[UIColor redColor]];
}

- (IBAction)black:(UIButton *)sender {
    [self.drawView setColor:[UIColor blackColor]];
}
- (IBAction)yellow:(UIButton *)sender {
    [self.drawView setColor:[UIColor yellowColor]];
}
- (IBAction)valueChange:(UISlider *)sender {
    self.drawView.lineSize = sender.value;
}

- (void)drawView:(LXHDrawView *)view WithImage:(UIImage *)image
{
    //    NSData *data = UIImagePNGRepresentation(image);
    //    [data writeToFile:@"/Users/moxuyou/Desktop/drawView.png" atomically:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    LXHDrawImageView *view = [[LXHDrawImageView alloc] init];
    view.frame = self.drawView.frame;
    view.image = image;
    [self.view addSubview:view];
    self.lxhView = view;
    
    self.lxhView.block = ^(UIImage *newImage){
//        NSData *data = UIImagePNGRepresentation(newImage);
//        [data writeToFile:@"/Users/moxuyou/Desktop/drawView123.png" atomically:YES];
        self.drawView.image = newImage;
    };
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
