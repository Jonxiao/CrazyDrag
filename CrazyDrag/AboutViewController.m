//
//  AboutViewController.m
//  CrazyDrag
//
//  Created by Jon on 14-5-4.
//  Copyright (c) 2014年 iOSlearning. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

- (IBAction)close:(id)sender;

@end

@implementation AboutViewController

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *htmlFile = [[NSBundle mainBundle]pathForResource:@"CrazyDrag" ofType:@"html"];
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]];
    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
//    NSURL *url = [NSURL URLWithString:@"http://www.apple.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
