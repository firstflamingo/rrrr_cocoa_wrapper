//
//  OVStopAct.h
//  OVDataBrowser
//
//  Created by Berend Schotanus on 11-12-14.
//  Copyright (c) 2014 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVJourneyPattern.h"

@class OVVehicleJourney, OVStop;

@interface OVStopAct : OVObject

- (instancetype)initWithIndex:(int32_t)index vj:(OVVehicleJourney*)vj;

@property (nonatomic, weak) OVVehicleJourney *vj;
@property (nonatomic, readonly) OVStop *stop;
@property (nonatomic, readonly) OVStopActOptions options;
@property (nonatomic, readonly) rtime_t arrival, departure;
@property (nonatomic, readonly) NSString *arrivalString, *departureString;
@property (nonatomic, readonly) BOOL waitsIfEarly, allowsBoarding, allowsAlighting;

@end
