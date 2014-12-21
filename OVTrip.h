//
//  OVTrip.h
//  OpenOVDemo
//
//  Created by Berend Schotanus on 15-11-13.
//  Copyright (c) 2013 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVObject.h"

@class OVJourneyPattern;

@interface OVTrip : OVObject

- (instancetype)initWithIndex:(int32_t)index journeyPattern:(OVJourneyPattern*)pattern;

@property (nonatomic, weak) OVJourneyPattern *journeyPattern;
@property (nonatomic, strong) NSArray *stopActs;

@property (nonatomic, readonly) NSString *id_;
@property (nonatomic, readonly) rtime_t beginTime;
@property (nonatomic, readonly) NSString *beginTimeString;
@property (nonatomic, readonly) uint16_t attributes;
@property (nonatomic, readonly) calendar_t active;
@property (nonatomic, readonly) uint32_t occurrences;
@property (nonatomic, readonly) stoptime_t *stopTimes;

@end
