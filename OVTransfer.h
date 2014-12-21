//
//  OVTransfer.h
//  OVDataBrowser
//
//  Created by Berend Schotanus on 18-12-14.
//  Copyright (c) 2014 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVObject.h"

@class OVStop;

@interface OVTransfer : OVObject

- (instancetype)initWithIndex:(int32_t)index origin:(OVStop*)origin;

@property (nonatomic, weak) OVStop *origin;
@property (nonatomic, readonly) OVStop *destination;
@property (nonatomic, readonly) NSUInteger distance;
@property (nonatomic, readonly) NSString *distanceString;

@end
