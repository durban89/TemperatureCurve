//
//  TemperatureCurveViewController.h
//  Real-time temperature curve
//
//  Created by david on 13-8-15.
//  Copyright (c) 2013年 WalkerFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemperatureCurveViewController : UIViewController<UIWebViewDelegate, UITextFieldDelegate>

@property(retain, nonatomic) UIWebView *webViewForSelectDate;
@property(retain, nonatomic) NSTimer *timer;

@end
