//  Copyright (c) 2014 First Flamingo Enterprise B.V.
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
//  OVTransfer.m
//  rrrr_cocoa_wrapper
//
//  Created by Berend Schotanus on 18-12-14.
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
