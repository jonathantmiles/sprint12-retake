//
//  JTMPokemonObject.h
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JTMPokemonObject : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic, nullable) NSNumber *id;
@property (nonatomic, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, nullable) NSURL *spriteURL;

@end

NS_ASSUME_NONNULL_END
