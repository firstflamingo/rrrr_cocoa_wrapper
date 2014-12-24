//
//  OVVehicleJourney.m
//  OpenOVDemo
//
//  Created by Berend Schotanus on 15-11-13.
//  Copyright (c) 2013 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVVehicleJourney.h"
#import "OVJourneyPattern.h"
#import "OVStopAct.h"

@interface OVVehicleJourney ()

@property (nonatomic, readonly) vehicle_journey_t vj, nextVj;

@end


@implementation OVVehicleJourney

- (instancetype)initWithIndex:(int32_t)index journeyPattern:(OVJourneyPattern *)pattern
{
    self = [super initWithIndex:index];
    if (self) {
        self.journeyPattern = pattern;
    }
    return self;
}

- (vehicle_journey_t)vj
{
    return self.ctx->vjs[self.index];
}

- (vehicle_journey_t)nextVj
{
    return self.ctx->vjs[self.index + 1];
}

- (NSArray *)stopActs
{
    if (!_stopActs) {
        NSUInteger n = self.journeyPattern.pattern.n_stops;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:n];
        for (int32_t i = 0; i < n; i++) {
            OVStopAct *stopAct = [[OVStopAct alloc] initWithIndex:i vj:self];
            [array addObject:stopAct];
        }
        _stopActs = array;
    }
    return _stopActs;
}

- (NSString *)id_
{
    return [[NSString alloc] initWithUTF8String:tdata_vehicle_journey_id_for_index(self.ctx, self.index)];
}

- (rtime_t)beginTime
{
    return self.vj.begin_time;
}

- (NSString *)beginTimeString
{
    return stringFromRTime(self.beginTime);
}

- (uint16_t)attributes
{
    return self.vj.vj_attributes;
}

- (calendar_t)active
{
    return self.ctx->vj_active[self.index];
}

- (uint32_t)occurrences
{
    return numberOfSetBits(self.active);
}

- (stoptime_t *)stopTimes
{
    return &self.ctx->stop_times[self.vj.stop_times_offset];
}

@end
