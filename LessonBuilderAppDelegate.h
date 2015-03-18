//
//  LessonBuilderAppDelegate.h
//  LessonBuilder
//
//  Created by Vikram on 2/6/15.
//  Copyright 2015 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LessonBuilderAppDelegate : NSObject {
	NSTextView *inputArea;
}

@property (assign) IBOutlet NSTextView *inputArea;
- (void) applicationDidFinishLaunching: (NSNotification *) anotif;
- (IBAction) saveClicked: (id) sender;


@end
