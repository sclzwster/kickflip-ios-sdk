//
//  KFHLSMonitor.m
//  FFmpegEncoder
//
//  Created by Christopher Ballinger on 1/16/14.
//  Copyright (c) 2014 Christopher Ballinger. All rights reserved.
//

#import "KFHLSMonitor.h"
#import "KFHLSUploader.h"

@interface KFHLSMonitor()
@property (nonatomic, strong) NSMutableSet *hlsUploaders;
@end

static KFHLSMonitor *_sharedMonitor = nil;

@implementation KFHLSMonitor

+ (KFHLSMonitor*) sharedMonitor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedMonitor = [[KFHLSMonitor alloc] init];
    });
    return _sharedMonitor;
}

- (id) init {
    if (self = [super init]) {
        self.hlsUploaders = [NSMutableSet set];
    }
    return self;
}

- (void) monitorFolderPath:(NSString *)path endpoint:(KFS3Stream *)endpoint delegate:(id<KFHLSUploaderDelegate>)delegate {
    KFHLSUploader *hlsUploader = [[KFHLSUploader alloc] initWithDirectoryPath:path stream:endpoint];
    hlsUploader.delegate = delegate;
    [self.hlsUploaders addObject:hlsUploader];
}

@end
