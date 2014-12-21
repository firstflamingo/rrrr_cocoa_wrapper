//
//  OVStopAct.m
//  OVDataBrowser
//
//  Created by Berend Schotanus on 11-12-14.
//  Copyright (c) 2014 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVStopAct.h"
#import "OVTrip.h"
#import "OVJourneyPattern.h"
#import "OVStop.h"

@implementation OVStopAct

- (instancetype)initWithIndex:(int32_t)index trip:(OVTrip *)trip
{
    self = [super initWithIndex:index];
    if (self) {
        self.trip = trip;
    }
    return self;
}

- (OVStop *)stop
{
    return [self.trip.journeyPattern stopAtIndex:self.index];
}

- (rtime_t)arrival
{
    return self.trip.beginTime + self.trip.stopTimes[self.index].arrival;
}

- (rtime_t)departure
{
    return self.trip.beginTime + self.trip.stopTimes[self.index].departure;
}

- (NSString *)arrivalString
{
    return stringFromRTime(self.arrival);
}

- (NSString *)departureString
{
    return stringFromRTime(self.departure);
}

@end

