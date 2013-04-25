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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSError  *error;
    NSString *markdown   = @"# Example\nWhat a *library*! **this** is a [link](http://google.com/)\nAnd cat :3\n\n![cat](http://placekitten.com/200/300)\n\nSee *log* for ouput html";
    
    NSString *html = [MMMarkdown HTMLStringWithMarkdown:markdown error:&error];
    
    [_markdownView loadHTMLString:html baseURL:nil];
    
    NSLog(@"%@", html);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
