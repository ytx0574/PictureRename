//
//  ViewController.m
//  Rename
//
//  Created by Johnson on 8/6/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "ViewController.h"
#import "Item.h"

#define EmpityString  @""

@interface ViewController () <NSTextViewDelegate>
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (weak) IBOutlet NSMatrix *matrix;
@property (weak) IBOutlet NSButton *buttonCodeOutput;
@property (weak) IBOutlet NSButton *buttonOneX;
@property (weak) IBOutlet NSButton *buttonTwoX;
@property (weak) IBOutlet NSButton *buttonThreeX;
@property (weak) IBOutlet NSCollectionView *collectionView;

@property (strong, nonatomic) NSMutableSet *setForPictureLink;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.collectionView.itemPrototype = [self.storyboard instantiateControllerWithIdentifier:NSStringFromClass([Item class])];
    self.collectionView.itemPrototype = [[Item alloc] init];
    // Do any additional setup after loading the view.
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

#pragma mark - Click
- (IBAction)clickExport:(id)sender {
    if (self.setForPictureLink.count == 0) {

        return;
    }
    
    
    NSMutableArray *arrayFileUrls = [NSMutableArray array];
    if (self.matrix.selectedColumn == 0) {
        
    }else if (self.matrix.selectedColumn == 1) {
    
    }else {
    
    }
    
    
    [self.setForPictureLink enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        NSString *path = obj;
        NSString *name = [path lastPathComponent];
        path = [path stringByReplacingOccurrencesOfString:name withString:EmpityString];
        name = [name stringByReplacingOccurrencesOfString:@".PNG" withString:EmpityString];
        name = [name stringByReplacingOccurrencesOfString:@".png" withString:EmpityString];
        name = [name stringByReplacingOccurrencesOfString:@"@2x" withString:EmpityString];
        name = [name stringByReplacingOccurrencesOfString:@"@3x" withString:EmpityString];
        
        NSData *data = [NSData dataWithContentsOfFile:obj];
        if (self.buttonCodeOutput.stringValue.integerValue == YES) {
            NSImage *image = [[NSImage alloc] initWithContentsOfFile:obj];
            NSBitmapImageRep *bitmapImageRep = [[NSBitmapImageRep alloc] initWithData:data];
            bitmapImageRep.pixelsHigh = bitmapImageRep.pixelsHigh * 2;
            bitmapImageRep.pixelsWide = bitmapImageRep.pixelsWide * 2;
        }else {
            if (self.buttonOneX.stringValue.integerValue == YES) {
                NSString *newFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
                BOOL flag = [data writeToFile:newFilePath atomically:YES];
                flag ? [arrayFileUrls addObject:[NSURL fileURLWithPath:newFilePath]] : nil;
            }
            if (self.buttonTwoX.stringValue.integerValue == YES){
                NSString *newFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.png", name]];
                BOOL flag = [data writeToFile:newFilePath atomically:YES];
                flag ? [arrayFileUrls addObject:[NSURL fileURLWithPath:newFilePath]] : nil;
            }
            if (self.buttonThreeX.stringValue.integerValue == YES) {
                NSString *newFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@3x.png", name]];
                BOOL flag = [data writeToFile:newFilePath atomically:YES];
                flag ? [arrayFileUrls addObject:[NSURL fileURLWithPath:newFilePath]] : nil;
            }
        }
    }];
    
    [[NSWorkspace sharedWorkspace] activateFileViewerSelectingURLs:arrayFileUrls];
}

- (IBAction)clickClean:(id)sender {
    [self.setForPictureLink removeAllObjects];
    self.textView.string = EmpityString;
    [self.collectionView setContent:self.setForPictureLink.allObjects];
}

#pragma mark - NSTextViewDelegate
- (BOOL)textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString;
{
    if (replacementString.length < 5) {
        return NO;
    }
    textView.string = replacementString;
    return NO;
}

- (void)textViewDidChangeSelection:(NSNotification *)notification;
{
    if ([self.textView.string isEqualToString:EmpityString]) {
        return;
    }
    self.setForPictureLink = self.setForPictureLink ?: [NSMutableSet set];
    [self.setForPictureLink addObjectsFromArray:[self.textView.string componentsSeparatedByString:@"\n"]];
    [self.collectionView setContent:self.setForPictureLink.allObjects];
}

@end
