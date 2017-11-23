//
//  KeychainItemWrapperArc.h
//  Throne
//
//  Created by Kahuna Systems on 3/4/16.
//  Copyright (c) 2016 Throne VIP Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainItemWrapperArc : NSObject

+ (void)keyChainSaveKey:(NSString *)key data:(id)data;

+ (id)keyChainLoadKey:(NSString *)key;

+ (void)keyChainDeleteKey:(NSString *)service;

@end
