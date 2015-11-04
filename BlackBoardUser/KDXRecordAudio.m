//
//  XRecordAudio.m
//  KDFuDao
//
//  Created by bing.hao on 14-6-11.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import "KDXRecordAudio.h"

@implementation KDXRecordAudio

- (id)init
{
    self = [super init];
    if (self) {
        
        NSString * path = pathcwf(@"player/audio.caf");
        NSURL    * url  = [NSURL fileURLWithPath:path];

        unlink([path UTF8String]);
        
        NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
        
        [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatMPEG4AAC] forKey: AVFormatIDKey];
        [recordSettings setObject:[NSNumber numberWithFloat:11025.0f] forKey: AVSampleRateKey]; //44100.0f
        [recordSettings setObject:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
//        [recordSettings setObject:[NSNumber numberWithInt:8] forKey:AVLinearPCMBitDepthKey];
//        [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
//        [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];

        NSError * error = nil;
        
        _record = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&error];

        [_record prepareToRecord];
        
        if (error) {
             NSLog(@"%@", error);
        }
       
    }
    return self;
}

- (void)dealloc
{
    [_record stop];
    
    ObjectRelease(_record);
}

- (void)start:(NSTimeInterval)timeInterval
{
    if ([_record isRecording] == NO) {
        [_record recordAtTime:timeInterval];
    }
}

- (void)pause
{
    if ([_record isRecording]) {
        [_record pause];
    }
}

- (void)finishedRecord
{
    [_record stop];
}


@end
