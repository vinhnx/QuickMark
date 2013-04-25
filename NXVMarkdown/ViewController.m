//
//  ViewController.m
//  NXVMarkdown
//
//  Created by Nguyen Xuan Vinh on 25/04/2013.
//  Copyright (c) 2013 Nguyen Xuan Vinh. All rights reserved.
//

#import "ViewController.h"

#import "MMMarkdown.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *markdownView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    NSError *error;

    NSString *markdown = @"# Example\nWhat a *library*! **this** is a [link](http://google.com/)\nAnd cat :3\n\n![cat](http://placekitten.com/g/290/250)\n\nSee *log* for ouput html";

    NSMutableString *html = [[NSMutableString alloc] init];
    [html appendString:[NSString stringWithFormat:@"<html>"
                        "<head>"
                        "  <meta charset='UTF-8'/>"
                        "  <style>%@</style>"
                        "</head>", [self css]]];
    
    [html appendString:[MMMarkdown HTMLStringWithMarkdown:markdown error:&error]];

    [_markdownView loadHTMLString:html baseURL:nil];

    NSLog(@"%@", html);
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
