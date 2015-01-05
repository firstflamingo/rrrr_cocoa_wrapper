//  Copyright (c) 2013-2014 First Flamingo Enterprise B.V.
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
//  OVRoute.m
//  rrrr_cocoa_wrapper
//
//  Created by Berend Schotanus on 15-11-13.
//

#import "OVJourneyPattern.h"

#import "OVDataController.h"
#import "OVVehicleJourney.h"
#import "OVStop.h"

@implementation OVJourneyPattern

- (journey_pattern_t)pattern
{
    return self.ctx->journey_patterns[self.index];
}

- (NSString *)lineCode
{
    return [[NSString alloc] initWithUTF8String:tdata_line_code_for_journey_pattern(self.ctx, self.index)];
}

- (NSString *)headsign
{
    return [[NSString alloc] initWithUTF8String:tdata_headsign_for_journey_pattern(self.ctx, self.index)];
}

- (NSString *)description
{
    NSMutableString *desc = [NSMutableString stringWithCapacity:80];
    [desc appendFormat:@"%@ \"%@ %@\"", [super description], self.lineCode, self.headsign];
    
    NSUInteger n_stops = self.nrOfStops;
    [desc appendFormat:@"\n\t%ld stops:", n_stops];
    for (int32_t index = 0; index < n_stops; index++) {
        OVStop *route = [self stopAtIndex:index];
        [desc appendFormat:@"\n%@", route.name];
        if (index < n_stops - 1) [desc appendString:@", "];
    }
    
    return desc;
}

#pragma mark - Stops

- (NSUInteger)nrOfStops
{
    return self.pattern.n_stops;
}

- (NSArray *)stops
{
    if (!_stops) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.nrOfStops];
        for (int32_t i = 0; i < self.nrOfStops; i++) {
            [array addObject:[self stopAtIndex:i]];
        }
        _stops = array;
    }
    return _stops;
}

- (int32_t)stopIndexAtIndex:(int32_t)index
{
    spidx_t *route_stops = tdata_points_for_journey_pattern(self.ctx, self.index);
    return route_stops[index];
}

- (OVStop *)stopAtIndex:(int32_t)index
{
    return self.dataController.stops[[self stopIndexAtIndex:index]];
}

- (OVStopActOptions)stopActOptionsAtIndex:(int32_t)index
{
    uint8_t *attributes = tdata_stop_attributes_for_journey_pattern(self.ctx, self.index);
    return attributes[index];
}

#pragma mark - VehicleJourneys

- (NSUInteger)nrOfVehicleJourneys
{
    return self.pattern.n_vjs;
}

- (NSArray *)vjs
{
    if (!_vjs) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.nrOfVehicleJourneys];
        for (uint32_t i = 0; i < self.nrOfVehicleJourneys; i++) {
            OVVehicleJourney *vj = [[OVVehicleJourney alloc] initWithIndex:i + self.pattern.vj_ids_offset journeyPattern:self];
            [array addObject:vj];
        }
        _vjs = array;
    }
    return _vjs;
}

@end
