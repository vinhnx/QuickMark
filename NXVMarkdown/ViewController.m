//
//  ViewController.m
//  NXVMarkdown
//
//  Created by Nguyen Xuan Vinh on 25/04/2013.
//  Copyright (c) 2013 Nguyen Xuan Vinh. All rights reserved.
//

#import "ViewController.h"

#import "MMMarkdown.h"
#import "SVModalWebViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *markdownView;
@property (nonatomic, copy) NSMutableString *html;
@property (nonatomic, strong) SVModalWebViewController *webViewController;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
        
    NSError *error;
    
    _html = [[NSMutableString alloc] init];
    [_html appendString:[NSString stringWithFormat:@"<html>"
                         "<head>"
                         "  <meta charset='UTF-8'/>"
                         "  <style>%@</style>"
                         "</head>", [self css]]];
    
    [_html appendString:[MMMarkdown HTMLStringWithMarkdown:[self markdownString] error:&error]];
    
    [_markdownView loadHTMLString:_html baseURL:nil];
    _markdownView.delegate = self;
    
    NSLog(@"%@", _html);

}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:[NSString stringWithFormat:@"%@", [request URL]]];
        webViewController.barsTintColor             = [UIColor colorWithWhite:0.933 alpha:1.000];
        [webViewController.toolbar setTintColor:[UIColor colorWithWhite:0.122 alpha:1.000]];
        [self presentViewController:webViewController animated:YES completion:NULL];
        return NO;
    }
    
    return YES;
}

- (NSString *)css {
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"css"];
    NSString *cssString = [NSString stringWithContentsOfFile:filePath
                                                    encoding:NSUTF8StringEncoding
                                                       error:&error];

    if (error != nil) {
        NSLog(@"Error: %@", error);
        
        return nil;
    }

    return cssString;
}

- (NSString *)markdownString {
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"foo" ofType:@"md"];
    NSString *markdownString = [NSString stringWithContentsOfFile:filePath
                                                    encoding:NSUTF8StringEncoding
                                                       error:&error];
    
    if (error != nil) {
        NSLog(@"Error: %@", error);
        
        return nil;
    }
    
    return markdownString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
