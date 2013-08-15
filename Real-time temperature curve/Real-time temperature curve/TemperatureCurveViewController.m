//
//  TemperatureCurveViewController.m
//  Real-time temperature curve
//
//  Created by david on 13-8-15.
//  Copyright (c) 2013年 WalkerFree. All rights reserved.
//

#import "TemperatureCurveViewController.h"

@interface TemperatureCurveViewController ()

@end

@implementation TemperatureCurveViewController

@synthesize webViewForSelectDate;
@synthesize timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIInterfaceOrientation orientation = [UIDevice currentDevice].orientation;
//    if(UIDeviceOrientationIsPortrait(orientation) || orientation == UIDeviceOrientationUnknown){
//        if([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]){
//            [[UIDevice currentDevice] performSelector:@selector(setOrientation:)
//                                           withObject:(id)UIDeviceOrientationLandscapeRight];
//        }
//    
//    }

    CGRect webFrame = self.view.frame;
    webFrame.origin.x = 0;
    webFrame.origin.y = 0;
    
    webViewForSelectDate = [[UIWebView alloc] initWithFrame:webFrame];
    webViewForSelectDate.delegate = self;
    webViewForSelectDate.scalesPageToFit = YES;
    webViewForSelectDate.opaque = NO;
    webViewForSelectDate.backgroundColor = [UIColor clearColor];
    webViewForSelectDate.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self.view addSubview:webViewForSelectDate];
    
    NSString *htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"curve.bundle/index.html"];
    
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webViewForSelectDate loadRequest:request];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

-(void) updateData{
    NSDate *nowDate = [[NSDate alloc] init];
    NSTimeInterval nowTimeInterval = [nowDate timeIntervalSince1970] * 1000;
    
    int temperature = [self getRandomNumber:20 to:50];
    
    NSMutableString *jsStr = [[NSMutableString alloc] initWithCapacity:0];
    [jsStr appendFormat:@"updateData(%f,%d)",nowTimeInterval, temperature];
    
    [webViewForSelectDate stringByEvaluatingJavaScriptFromString:jsStr];
}

-(int) getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}

#pragma mark - delegate o webview
-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(updateData)
                                           userInfo:nil
                                            repeats:YES];
}

@end
