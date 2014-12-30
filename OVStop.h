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
//  OVStop.h
//  rrrr_cocoa_wrapper
//
//  Created by Berend Schotanus on 12-11-13.
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
