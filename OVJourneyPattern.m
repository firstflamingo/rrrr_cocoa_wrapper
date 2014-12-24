//
//  OVRoute.m
//  OpenOVDemo
//
//  Created by Berend Schotanus on 15-11-13.
//  Copyright (c) 2013 First Flamingo Enterprise B.V. All rights reserved.
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

- (journey_pattern_t)nextPattern
{
    return self.ctx->journey_patterns[self.index + 1];
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
    return self.nextPattern.journey_pattern_point_offset - self.pattern.journey_pattern_point_offset;
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

#pragma mark - VehicleJourneys

- (NSUInteger)nrOfVehicleJourneys
{
    return self.nextPattern.vj_ids_offset - self.pattern.vj_ids_offset;
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
