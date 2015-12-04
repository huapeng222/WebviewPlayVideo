//
//  ViewController.m
//  WebviewPlayVideo
//
//  Created by roya-7 on 15/9/7.
//  Copyright (c) 2015年 化召鹏. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<UIWebViewDelegate>{
    AppDelegate *app;
}

@end

@implementation ViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeVisibleNotification object:nil];
}

-(void)playerWillExitFullscreen:(id)sender{
    NSLog(@"退出播放视频了");
    app.isFull=NO;
    
    /**
     下边方法的使用场景:
     如果点击视频,自动旋转为横屏播放状态,点击完成按钮,需要是程序变为竖屏状态,需要下边的代码
     */
    UIViewController *vc = [[UIViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
    [vc dismissViewControllerAnimated:NO completion:nil];
    
}
-(void)playerWillShowFullScreen:(id)sender{
    NSLog(@"播放视频了");
    app.isFull=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title=@"webView";
        CGRect rect=self.view.frame;
//    rect.size.height-=64;
    UIWebView *webView=[[UIWebView alloc] initWithFrame:rect];
    webView.delegate=self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.tudou.com/albumplay/O8GDpd7v8RA/qTfiUJAEdm0.html"]]];
    [self.view addSubview:webView];
    
    app=(AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    //通知写在这里是因为网页加载完成但是没有播放视频,也会调用playerWillExitFullscreen方法
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeVisibleNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillExitFullscreen:) name:UIWindowDidBecomeHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillShowFullScreen:) name:UIWindowDidBecomeVisibleNotification object:nil];
    

}
@end
