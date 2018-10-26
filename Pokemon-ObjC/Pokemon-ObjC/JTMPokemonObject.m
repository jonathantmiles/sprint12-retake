//
//  JTMPokemonObject.m
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/26/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

#import "JTMPokemonObject.h"

@implementation JTMPokemonObject

- (instancetype)initWithName:(NSString *)name id:(NSNumber *)id spriteURL:(NSURL *)spriteURL abilities:(NSArray<NSString *> *)abilities
{
    self = [super init];
    if (self) {
        _name = name;
        _id = id;
        _spriteURL = spriteURL;
        _abilities = abilities;
    }
    return self;
}

@end
