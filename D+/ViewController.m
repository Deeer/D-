//
//  ViewController.m
//  D+
//
//  Created by Dee on 15/4/18.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <MessageUI/MessageUI.h>
//#import "authorViewController.h"
//typedef enum
//{
//  play,
//  eating,
//    
//    
//}taskStyle;

@interface ViewController ()<MFMailComposeViewControllerDelegate>
@property (nonatomic,strong)UIImageView *imageCover;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UIView *Cover;
@property (nonatomic,assign)BOOL isEntered ;
@property (nonatomic,strong)LAContext *context;
- (IBAction)call:(id)sender;
- (IBAction)play:(id)sender;
- (IBAction)eating:(id)sender;
- (IBAction)boring:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self authEnter];
//    NSLog(@"asdasss");

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:xxxxxx"]];//呼叫号码
}

- (IBAction)play:(id)sender {
    
    
    [self sendeText:@"出去玩会儿？！" andObject:@"xxxxxx"];
    
}

- (IBAction)eating:(id)sender {
   
    [self sendeText:@"饿死了😂😂😂" andObject:@"xxxxxx"];
    
}

- (IBAction)boring:(id)sender {
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"weixin://"]];
}
-(void)sendeText:(NSString*)body andObject:(NSString*)object
{
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc]init];
    if ([MFMessageComposeViewController canSendText]) {
        controller.body = body;
        controller.recipients =[NSArray arrayWithObjects:object,nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)authEnter
{

    [self addCover];
   
    
    LAContext * context =[[LAContext alloc]init];
    context.localizedFallbackTitle  = @"";
    
    NSError *error =nil;
    NSString *reason =@"真的是你吗？";
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        

        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError *error) {
            if (success) {
                
//                NSLog(@"success");
            dispatch_async(dispatch_get_main_queue(), ^{
                [_Cover removeFromSuperview];
            });
                
                
                
            }else
            {
//                NSLog(@"failed");
            }
            
        }];
        
    }

    /*
    authorViewController *auController =[[authorViewController alloc]init];
        [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",self);
    [self presentViewController:auController animated:YES completion:^{
        auController.view.backgroundColor =[UIColor redColor]; 
    }];
    
    */
    
    
 
    
    
 
}
-(void)addCover
{
    if (_Cover ==nil) {
     
    
    _Cover =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    _imageCover =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _imageCover.image = [UIImage imageNamed:@"IMG_1369.jpg"];
    
    
    _btn =[[UIButton alloc]initWithFrame:CGRectMake(60, 400, 200, 50)];
    [_btn setTitle:@"进行指纹验证" forState:UIControlStateNormal ];
    _btn.backgroundColor =[UIColor redColor];
    
    [_btn addTarget:self action:@selector(authEnter) forControlEvents:UIControlEventTouchUpInside];
    
    [_Cover addSubview:_imageCover];
    [_Cover addSubview:_btn];
    [self.view bringSubviewToFront:_Cover];
        [self.view addSubview:_Cover];
        _isEntered =YES;
        
    }
    
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationIsLandscape(UIInterfaceOrientationPortrait);
}

//-(void)removeCover
//{
//    _imageCover.hidden=YES;
////    _imageCover.image
//    [_imageCover removeFromSuperview];
//   dispatch_sync(dispatch_get_main_queue(), ^{
//     
//       [self.view setNeedsDisplay];
//       [self.view setNeedsLayout];
//   });
//  
//    
//}

@end
