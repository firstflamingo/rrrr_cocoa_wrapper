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
//  OVObject.h
//  rrrr_cocoa_wrapper
//
//  Created by Berend Schotanus on 12-11-13.
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
