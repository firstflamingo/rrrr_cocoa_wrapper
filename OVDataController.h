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
//  OVDataController.h
//  rrrr_cocoa_wrapper
//
//  Created by Berend Schotanus on 08-11-13.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "tdata.h"

@class OVAgency, OVStop, OVJourneyPattern, OVVehicleJourney;

@interface OVDataController : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly) tdata_t *dataContext;

@property (nonatomic, strong) NSArray *agencies;
@property (nonatomic, strong) NSArray *stops;

- (NSArray*)stopsWithinRange:(float)distanceInMeters fromCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)testTime:(NSDate *)time;
- (NSString *)routeFrom:(OVStop*)origin to:(OVStop*)destination time:(NSDate*)time arriveBy:(bool)arriveBy;

@end
