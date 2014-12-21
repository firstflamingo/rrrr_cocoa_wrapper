//
//  OVObject.m
//  OpenOVDemo
//
//  Created by Berend Schotanus on 12-11-13.
//  Copyright (c) 2013 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVObject.h"

@implementation OVObject

- (id)initWithIndex:(int32_t)index
{
    self = [super init];
    if (self) {
        self.index = index;
    }
    return self;
}

- (OVDataController *)dataController
{
    return [OVDataController sharedInstance];
}

- (tdata_t *)ctx
{
    return self.dataController.dataContext;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ [%d]", [super description], self.index];
}

@end

uint32_t numberOfSetBits(uint32_t i)
{
    i = i - ((i >> 1) & 0x55555555);
    i = (i & 0x33333333) + ((i >> 2) & 0x33333333);
    return (((i + (i >> 4)) & 0x0F0F0F0F) * 0x01010101) >> 24;
}

NSString *stringFromRTime(rtime_t rtime) {
    int32_t minutes = RTIME_TO_SEC(rtime) / 60;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes / 60, minutes % 60];
}
