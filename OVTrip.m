//
//  OVTrip.m
//  OpenOVDemo
//
//  Created by Berend Schotanus on 15-11-13.
//  Copyright (c) 2013 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVTrip.h"
#import "OVJourneyPattern.h"
#import "OVStopAct.h"

@interface OVTrip ()

@property (nonatomic, readonly) trip_t trip, nextTrip;

@end


@implementation OVTrip

- (instancetype)initWithIndex:(int32_t)index journeyPattern:(OVJourneyPattern *)pattern
{
    self = [super initWithIndex:index];
    if (self) {
        self.journeyPattern = pattern;
    }
    return self;
}

- (trip_t)trip
{
    return self.ctx->trips[self.index];
}

- (trip_t)nextTrip
{
    return self.ctx->trips[self.index + 1];
}

- (NSArray *)stopActs
{
    if (!_stopActs) {
        NSUInteger n = self.journeyPattern.pattern.n_stops;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:n];
        for (int32_t i = 0; i < n; i++) {
            OVStopAct *stopAct = [[OVStopAct alloc] initWithIndex:i trip:self];
            [array addObject:stopAct];
        }
        _stopActs = array;
    }
    return _stopActs;
}

- (NSString *)id_
{
    return [[NSString alloc] initWithUTF8String:tdata_trip_id_for_index(self.ctx, self.index)];
}

- (rtime_t)beginTime
{
    return self.trip.begin_time;
}

- (NSString *)beginTimeString
{
    return stringFromRTime(self.beginTime);
}

- (uint16_t)attributes
{
    return self.trip.trip_attributes;
}

- (calendar_t)active
{
    return self.ctx->trip_active[self.index];
}

- (uint32_t)occurrences
{
    return numberOfSetBits(self.active);
}

- (stoptime_t *)stopTimes
{
    return &self.ctx->stop_times[self.trip.stop_times_offset];
}

@end
