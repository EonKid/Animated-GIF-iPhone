//
//  AnimatedGifExampleViewController.m
//  AnimatedGifExample
//
//  Created by Stijn Spijker on 05-07-09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "AnimatedGifExampleViewController.h"

@implementation AnimatedGifExampleViewController

//
// viewDidLoad
//
// Get's the animated gif, and places it on the view.
//
- (void)viewDidLoad
{
	[super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animatedGifDidStart:) name:AnimatedGifDidStartLoadingingEvent object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animatedGifDidFinish:) name:AnimatedGifDidFinishLoadingingEvent object:nil];
    
    NSURL * firstUrl = [NSURL URLWithString:@"https://ps.vk.me/c538316/u896232/docs/aea430132f2c/1394991425_140509903.gif?extra=lAhS4VR5PB3t8Q4vKh1Bw0UyjiYVhMZRowikezVvQzVeh5u3b1YScaiXGqpl9djZnJg8w46l_rjOYi5kaLGPm2Zo"];
    UIImageView * firstAnimation = 	[AnimatedGif getAnimationForGifAtUrl: firstUrl];
    [ivTwo addSubview:firstAnimation];
}

-(IBAction) makeClear:(id)sender {
    for (UIView * subview in ivOne.subviews) {
        [subview removeFromSuperview];
    }
    lastY = 0;
    [AnimatedGif clear];
}
-(IBAction)addMore:(id)sender {
    NSURL 			* firstUrl = [[NSBundle mainBundle] URLForResource:@"2" withExtension:@"gif"];
    UIImageView 	* firstAnimation = 	[AnimatedGif getAnimationForGifAtUrl: firstUrl];
	[ivOne addSubview:firstAnimation];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    
    [super didReceiveMemoryWarning];
}

#pragma mark - AnimatedGif events
-(void)animatedGifDidStart:(NSNotification*) notify {
    AnimatedGifQueueObject * object = notify.object;
    NSLog(@"Url will be loaded: %@", object.url);
}
-(void)animatedGifDidFinish:(NSNotification*) notify {
    AnimatedGifQueueObject * object = notify.object;
    if ([object.url isFileURL]) {
        [object sizeToParentWidth];
        CGRect fr = object.gifView.frame;
        fr.origin.y = lastY;
        object.gifView.frame = fr;
        lastY += 20;
    } else {
        [object sizeToParentWidth];
    }
}

@end