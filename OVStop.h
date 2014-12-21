//
//  OVStop.h
//  OpenOVDemo
//
//  Created by Berend Schotanus on 12-11-13.
//  Copyright (c) 2013 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVObject.h"

@class OVJourneyPattern;

@interface OVStop : OVObject



@property (nonatomic, readonly) NSString *id_;
@property (nonatomic, readonly) uint8_t *attributes;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *platform;

@property (nonatomic, readonly) NSUInteger nrOfTransferLinks;
@property (nonatomic, readonly) NSArray *transfers;

- (OVStop*)transferTargetAtIndex:(NSUInteger)index;
- (NSUInteger)transferDistanceAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSUInteger nrOfJourneyPatterns;
@property (nonatomic, readonly) NSArray *journeyPatterns;

@end
