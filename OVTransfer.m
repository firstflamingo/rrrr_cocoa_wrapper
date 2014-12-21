//
//  OVTransfer.m
//  OVDataBrowser
//
//  Created by Berend Schotanus on 18-12-14.
//  Copyright (c) 2014 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVTransfer.h"
#import "OVStop.h"

@implementation OVTransfer

- (instancetype)initWithIndex:(int32_t)index origin:(OVStop *)origin
{
    self = [super initWithIndex:index];
    if (self) {
        self.origin = origin;
    }
    return self;
}

- (OVStop *)destination
{
    return [self.origin transferTargetAtIndex:self.index];
}

- (NSUInteger)distance
{
    return [self.origin transferDistanceAtIndex:self.index];
}

- (NSString *)distanceString
{
    return [NSString stringWithFormat:@"%lu m", (unsigned long)self.distance];
}

@end
