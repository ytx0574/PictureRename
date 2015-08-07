//
//  Item.h
//  Rename
//
//  Created by Johnson on 8/6/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Item : NSCollectionViewItem
@property (weak) IBOutlet NSImageView *picture;
@property (weak) IBOutlet NSTextField *label;
@end
