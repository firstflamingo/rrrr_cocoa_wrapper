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
//  OVRoute.h
//  rrrr_cocoa_wrapper
//
//  Created by Berend Schotanus on 15-11-13.
//

#import "OVObject.h"

typedef NS_OPTIONS(uint8_t, OVStopActOptions) {
    stopActNoOptions = 0,
    stopActWaitsIfEarly = 1 << 0,
    stopActAllowsBoarding = 1 << 1,
    stopActAllowsAlighting = 1 << 2,
};

@class OVStop, OVVehicleJourney;

@interface OVJourneyPattern : OVObject

@property (nonatomic, readonly) journey_pattern_t pattern, nextPattern;
@property (nonatomic, readonly) NSString *lineCode;
@property (nonatomic, readonly) NSString *headsign;

// Stops

@property (nonatomic, readonly) NSUInteger nrOfStops;
@property (nonatomic, strong) NSArray *stops;

- (int32_t)stopIndexAtIndex:(int32_t)index;
- (OVStop *)stopAtIndex:(int32_t)index;
- (OVStopActOptions)stopActOptionsAtIndex:(int32_t)index;

// VehicleJourneys

@property (nonatomic, readonly) NSUInteger nrOfVehicleJourneys;
@property (nonatomic, strong) NSArray *vjs;

@end
