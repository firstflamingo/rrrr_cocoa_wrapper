//
//  OVObject.h
//  OpenOVDemo
//
//  Created by Berend Schotanus on 12-11-13.
//  Copyright (c) 2013 First Flamingo Enterprise B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OVDataController.h"

@interface OVObject : NSObject

- initWithIndex:(int32_t)index;

@property (nonatomic, readonly) OVDataController *dataController;
@property (nonatomic, readonly) tdata_t *ctx;
@property (nonatomic, assign) int32_t index;

@end

uint32_t numberOfSetBits(uint32_t i);
NSString *stringFromRTime(rtime_t rtime);
