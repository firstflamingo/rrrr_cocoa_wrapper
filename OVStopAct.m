//  Copyright (c) 2014 First Flamingo Enterprise B.V.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  OVStopAct.m
//  rrrr_cocoa_wrapper
//
//  Created by Berend Schotanus on 11-12-14.
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

