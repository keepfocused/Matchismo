//
//  PlayingCard.h
//  Matchismo
//
//  Created by Admin on 05.07.16.
//  Copyright © 2016 CS193p. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
+ (NSArray *)rankStrings;

@end
