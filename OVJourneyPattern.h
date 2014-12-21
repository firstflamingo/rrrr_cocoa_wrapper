//
//  OVRoute.h
//  OpenOVDemo
//
//  Created by Berend Schotanus on 15-11-13.
//  Copyright (c) 2013 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVObject.h"

@class OVStop, OVTrip;

@interface OVJourneyPattern : OVObject

@property (nonatomic, readonly) journey_pattern_t pattern, nextPattern;
@property (nonatomic, readonly) NSString *shortName;
@property (nonatomic, readonly) NSString *headsign;

// Stops

@property (nonatomic, readonly) NSUInteger nrOfStops;
@property (nonatomic, strong) NSArray *stops;

- (int32_t)stopIndexAtIndex:(int32_t)index;
- (OVStop *)stopAtIndex:(int32_t)index;

// Trips

@property (nonatomic, readonly) NSUInteger nrOfTrips;
@property (nonatomic, strong) NSArray *trips;

@end
