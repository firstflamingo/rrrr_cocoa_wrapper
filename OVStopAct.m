//
//  OVStopAct.m
//  OVDataBrowser
//
//  Created by Berend Schotanus on 11-12-14.
//  Copyright (c) 2014 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVStopAct.h"
#import "OVVehicleJourney.h"
#import "OVStop.h"

@implementation OVStopAct

- (instancetype)initWithIndex:(int32_t)index vj:(OVVehicleJourney *)vj
{
    self = [super initWithIndex:index];
    if (self) {
        self.vj = vj;
    }
    return self;
}

- (OVStop *)stop
{
    return [self.vj.journeyPattern stopAtIndex:self.index];
}

- (OVStopActOptions)options
{
    return [self.vj.journeyPattern stopActOptionsAtIndex:self.index];
}

- (rtime_t)arrival
{
    return self.vj.beginTime + self.vj.stopTimes[self.index].arrival;
}

- (rtime_t)departure
{
    return self.vj.beginTime + self.vj.stopTimes[self.index].departure;
}

- (NSString *)arrivalString
{
    return stringFromRTime(self.arrival);
}

- (NSString *)departureString
{
    return stringFromRTime(self.departure);
}

- (BOOL)waitsIfEarly
{
    return self.options & stopActWaitsIfEarly;
}

- (BOOL)allowsBoarding
{
    return self.options & stopActAllowsBoarding;
}

- (BOOL)allowsAlighting
{
    return self.options & stopActAllowsAlighting;
}

@end

