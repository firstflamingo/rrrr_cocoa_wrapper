//
//  OVAgency.m
//  OpenOVDemo
//
//  Created by Berend Schotanus on 10-12-14.
//  Copyright (c) 2014 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVAgency.h"
#import "OVJourneyPattern.h"

@implementation OVAgency

- (NSString *)id_
{
    if (self.index < self.ctx->n_agency_ids) {
        return [[NSString alloc] initWithUTF8String:tdata_agency_id_for_index(self.ctx, self.index)];
    } else {
        return nil;
    }
}

- (NSString *)name
{
    if (self.index < self.ctx->n_agency_names) {
        return [[NSString alloc] initWithUTF8String:tdata_agency_name_for_index(self.ctx, self.index)];
    } else {
        return nil;
    }
}

- (NSString *)url
{
    if (self.index < self.ctx->n_agency_urls) {
        return [[NSString alloc] initWithUTF8String:tdata_agency_url_for_index(self.ctx, self.index)];
    } else {
        return nil;
    }
}

- (NSArray *)journeyPatterns
{
    if (!_journeyPatterns) {
        NSUInteger n = self.ctx->n_journey_patterns;
        NSMutableArray *array = [NSMutableArray array];
        for (int32_t i = 0; i < n; i++) {
            journey_pattern_t pattern = self.ctx->journey_patterns[i];
            if (pattern.agency_index == self.index) {
                [array addObject:[[OVJourneyPattern alloc] initWithIndex:i]];
            }
        }
        _journeyPatterns = array;
    }
    return _journeyPatterns;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@", self.id_, self.name, self.url];
}

@end
