//
//  OVDataContext.h
//  OpenOVDemo
//
//  Created by Berend Schotanus on 08-11-13.
//  Copyright (c) 2013 First Flamingo Enterprise B.V. All rights reserved.
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
