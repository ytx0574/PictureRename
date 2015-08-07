//
//  Item.m
//  Rename
//
//  Created by Johnson on 8/6/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "Item.h"

@interface Item ()

@end

@implementation Item

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];
    if (representedObject) {
        self.picture.image = [[NSImage alloc] initWithContentsOfFile:representedObject];
        self.label.stringValue = [representedObject lastPathComponent];
    }
}

@end
