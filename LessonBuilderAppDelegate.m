//
//  LessonBuilderAppDelegate.m
//  LessonBuilder
//
//  Created by Vikram on 2/6/15.
//  Copyright 2015 __MyCompanyName__. All rights reserved.
//

#include <Carbon/Carbon.h>
#import "LessonBuilderAppDelegate.h"

@implementation LessonBuilderAppDelegate
@synthesize inputArea;

- (void) applicationDidFinishLaunching: (NSNotification *) anotif {
	NSLog (@"App launched");

	NSString *chapterMark = @"{CHAPTER}";
	// Load up the interface with all the strings currently in the dictionary
	NSArray *pieces = [NSArray arrayWithContentsOfFile:@"/Users/viki/lesson.plist"];
	
	NSMutableArray *lessonsDecomposed = [NSMutableArray array];
	// All the elements in there are chapters, which are themselves arrays.
	for (NSArray *chapter in pieces) {
		// The first element in the chapter is the chapter name
		NSString *chapterName = [NSString stringWithFormat:@"%@%@", chapterMark, [chapter objectAtIndex:0]];
		[lessonsDecomposed addObject:chapterName];
		for (int i = 1; i < [chapter count]; i++) {
			[lessonsDecomposed addObject:[chapter objectAtIndex:i]];
		}
	}
	[[self inputArea] setString:[lessonsDecomposed componentsJoinedByString:@"\n"]];

	TISInputSourceRef source = TISCopyCurrentKeyboardInputSource();
	NSString *s = (TISGetInputSourceProperty(source, kTISPropertyInputSourceID));
	NSLog (@"The source name is: %@", s);	
}

- (IBAction) saveClicked: (id) sender {
	/// The string that will specify a chapter starter.
	NSString *chapterMark = @"{CHAPTER}";
	NSLog(@"Save the lines into a plist here");
	NSString *lines = [[self inputArea] string];
	// Separate them into an array
	NSArray *pieces = [lines componentsSeparatedByString:@"\n"];
	NSLog(@"There are %d pieces: %@", [pieces count], pieces);

	// Find the ones that start out with the delimiter and make them new chapters.
	NSMutableArray *allLessons = [NSMutableArray array];
	NSMutableArray *chapterContents = [NSMutableArray array];
	for (NSString *value in pieces) {
		NSLog(@"The value is: %@", value);
		if ([value hasPrefix:chapterMark]) {
			// Start a new chapter here.
			// Remove the prefix, and use the remaining as the name of the chapter.
			NSString *chapterName = [value substringFromIndex:[chapterMark length]];
			NSLog(@"New chapter name: %@", chapterName);
			// Add previous chapter to the lessons, unless it is empty
			if ([chapterContents count] > 0) {
				[allLessons addObject:chapterContents];
			}
			// Start a new chapter, with the first string as the name of the chapter
			chapterContents = [NSMutableArray arrayWithObject:chapterName];
		} else {
			[chapterContents addObject:value];
		}
	}
	// Finally, add the final chapter to the lesson
	[allLessons addObject:chapterContents];
	[allLessons writeToFile:@"/Users/viki/lesson.plist" atomically:YES];
	
	// And write it as an array for the different keyboard layouts here:
	
}

@end
