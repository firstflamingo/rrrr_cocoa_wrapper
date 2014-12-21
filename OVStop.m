//
//  OVStop.m
//  OpenOVDemo
//
//  Created by Berend Schotanus on 12-11-13.
//  Copyright (c) 2013 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVStop.h"

#import "OVDataController.h"
#import "OVJourneyPattern.h"
#import "OVTransfer.h"

@interface OVStop ()

@property (nonatomic, readonly) stop_t stop;
@property (nonatomic, readonly) stop_t nextStop;
@property (nonatomic, readonly) latlon_t latlon;


@end

@implementation OVStop


- (stop_t)stop
{
    return self.ctx->stops[self.index];
}

- (stop_t)nextStop
{
    return self.ctx->stops[self.index + 1];
}

- (latlon_t)latlon
{
    return self.ctx->stop_coords[self.index];
}

- (NSString *)id_
{
    return [[NSString alloc] initWithUTF8String:tdata_stop_id_for_index(self.ctx, self.index)];
}

- (uint8_t *)attributes
{
    return tdata_stop_attributes_for_index(self.ctx, self.index);
}

- (NSString *)name
{
    return [[NSString alloc] initWithUTF8String:tdata_stop_name_for_index(self.ctx, self.index)];
}

- (NSString *)platform
{
    return [[NSString alloc] initWithUTF8String:tdata_platformcode_for_index(self.ctx, self.index)];
}

- (NSUInteger)nrOfTransferLinks
{
    if (self.index < self.ctx->n_stops) {
        return self.nextStop.transfers_offset - self.stop.transfers_offset;
    } else {
        return 0;
    }
}

- (NSArray *)transfers
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.nrOfTransferLinks];
    for (int32_t i = 0; i < self.nrOfTransferLinks; i++) {
        OVTransfer *transfer = [[OVTransfer alloc] initWithIndex:i origin:self];
        [array addObject:transfer];
    }
    return array;
}

- (OVStop *)transferTargetAtIndex:(NSUInteger)index
{
    NSUInteger stopIndex = self.ctx->transfer_target_stops[self.stop.transfers_offset + index];
    return self.dataController.stops[stopIndex];
}

- (NSUInteger)transferDistanceAtIndex:(NSUInteger)index
{
    return self.ctx->transfer_dist_meters[self.stop.transfers_offset + index] << 4; // actually in units of 16 meters
}

- (NSUInteger)nrOfJourneyPatterns
{
    return self.nextStop.journey_patterns_at_stop_offset - self.stop.journey_patterns_at_stop_offset;
}

- (NSArray *)journeyPatterns
{
    uint32_t *routes;
    uint32_t n_routes = tdata_journey_patterns_for_stop(self.ctx, self.index, &routes);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:n_routes];
    for (NSUInteger i = 0; i < n_routes; i++) {
        [array addObject:[[OVJourneyPattern alloc] initWithIndex:routes[i]]];
    }
    return array;
}

- (NSString *)description
{
    NSMutableString *desc = [NSMutableString stringWithCapacity:80];
    [desc appendFormat:@"%@ %@", [super description], self.name];
    
    NSUInteger n_routes = self.nrOfJourneyPatterns;
    [desc appendFormat:@"\n\t%lu routes: ", (unsigned long)n_routes];
    
    NSUInteger n_transfers = self.nrOfTransferLinks;
    [desc appendFormat:@"\n\t%lu transfers: ", (unsigned long)n_transfers];
    for (NSUInteger index = 0; index < MIN(3, n_transfers); index++) {
        OVStop *target = [self transferTargetAtIndex:index];
        [desc appendFormat:@"%@: %lu meter", target.name, (unsigned long)[self transferDistanceAtIndex:index]];
        if (index < n_transfers - 1) [desc appendString:@", "];
    }
    if (n_transfers > 3) [desc appendFormat:@"and %lu more...", n_transfers - 3];
    
    return desc;
}

@end
