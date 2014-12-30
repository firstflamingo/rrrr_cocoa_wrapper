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
//  OVVehicleJourney.h
//  rrrr_cocoa_wrapper
//
//  Created by Berend Schotanus on 15-11-13.
//

#import "OVObject.h"

@class OVJourneyPattern;

@interface OVVehicleJourney : OVObject

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
