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
//  OVDataController.m
//  rrrr_cocoa_wrapper
//
//  Created by Berend Schotanus on 08-11-13.
//

#import "OVDataController.h"

#import "router.h"
#import "router_request.h"
#import "router_result.h"
#import "util.h"

#import "OVAgency.h"
#import "OVStop.h"
#import "OVJourneyPattern.h"
#import "OVVehicleJourney.h"

#define VER_SCALE           111195.0

// C utility functions
rtime_t rtimeFromNSDate(NSDate *date);
double horScaleForLatitude(double latitude);

static tdata_t _ctx;

@implementation OVDataController

+ (instancetype)sharedInstance {
    
    static id _sharedInstance = nil;
    static dispatch_once_t once_token = 0;
    
    dispatch_once(&once_token, ^{
        if (_sharedInstance == nil) {
            _sharedInstance = [[OVDataController alloc] init];
        }
    });
    return _sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        NSURL *dataURL = [[NSBundle mainBundle] URLForResource:@"timetable" withExtension:@"dat"];
        tdata_load(&_ctx, (char *)[[dataURL path] cStringUsingEncoding:[NSString defaultCStringEncoding]]);
    }
    return self;
}

- (void)dealloc
{
    tdata_close(&_ctx);
}

- (tdata_t *)dataContext
{
    return &_ctx;
}

- (NSArray *)agencies
{
    if (!_agencies) {
        NSUInteger n = self.dataContext->n_agency_ids;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:n];
        for (int32_t i = 0; i < n; i++) {
            [array addObject:[[OVAgency alloc] initWithIndex:i]];
        }
        _agencies = array;
    }
    return _agencies;
}

- (NSArray *)stops
{
    if (!_stops) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:_ctx.n_stops];
        for (int32_t i = 0; i < _ctx.n_stops; i++) {
            [array addObject:[[OVStop alloc] initWithIndex:i]];
        }
        _stops = array;
    }
    return _stops;
}

- (NSArray *)stopsWithinRange:(float)distanceInMeters fromCoordinate:(CLLocationCoordinate2D)coordinate
{
    double deltaLon = distanceInMeters / horScaleForLatitude(coordinate.latitude);
    double deltaLat = distanceInMeters / VER_SCALE;
    double minLon = coordinate.longitude - deltaLon;
    double maxLon = coordinate.longitude + deltaLon;
    double minLat = coordinate.latitude - deltaLat;
    double maxLat = coordinate.latitude + deltaLat;

    NSMutableArray *foundStops = [NSMutableArray arrayWithCapacity:10];
    for (uint32_t index = 0; index < _ctx.n_stops; ++index) {
        latlon_t latlon = _ctx.stop_coords[index];
        if (latlon.lon > minLon && latlon.lon < maxLon && latlon.lat > minLat && latlon.lat < maxLat) {
            [foundStops addObject:self.stops[index]];
        }
    }
    return foundStops;
}

- (void)testTime:(NSDate *)time
{
    rtimeFromNSDate(time);
}

- (NSString *)routeFrom:(OVStop *)origin to:(OVStop *)destination time:(NSDate *)time arriveBy:(bool)arriveBy
{
    return nil;
    
    /*
    NSLog(@"route from %@ to %@", origin.name, destination.name);
    
    char result_buf[4096] = "test";
    router_t router;
    router_setup(&router, &_ctx);
    router_request_t req;
    router_request_initialize (&req);
    
    req.from=origin.index;
    req.to=destination.index;
    req.time=rtimeFromNSDate(time);
    req.day_mask = 1;
    req.walk_speed=0.9;
    req.arrive_by=arriveBy;
    router_route(&router, &req);
    // repeat search in reverse to compact transfers
    int n_reversals = req.arrive_by ? 1 : 2;
    for (int i = 0; i < n_reversals; ++i) {
        router_request_reverse (&router, &req); // handle case where route is not reversed
        router_route (&router, &req);
    }
    
    int result_length = router_result_dump(&router, &req, result_buf, 4096);
    NSLog(@"Result length: %i", result_length);
    NSString *result = [[NSString alloc] initWithUTF8String:result_buf];
    router_teardown(&router);
    
    return result;*/
}

@end

rtime_t rtimeFromNSDate(NSDate *date)
{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [cal components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    NSInteger seconds = (((comps.hour * 60) + comps.minute) * 60) + comps.second;
    rtime_t rtime = SEC_TO_RTIME(seconds);
    /* shift rtime to day 1. day 0 is yesterday. */
    rtime += RTIME_ONE_DAY;
    return rtime;
}

double horScaleForLatitude(double latitude)
{
    return VER_SCALE * cos(latitude * M_PI / 180);
}


