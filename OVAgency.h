//
//  OVAgency.h
//  OpenOVDemo
//
//  Created by Berend Schotanus on 10-12-14.
//  Copyright (c) 2014 First Flamingo Enterprise B.V. All rights reserved.
//

#import "OVObject.h"

@interface OVAgency : OVObject

@property (nonatomic, readonly) NSString *id_;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *url;

@property (nonatomic, strong) NSArray *journeyPatterns;

@end
