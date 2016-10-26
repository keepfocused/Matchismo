//
//  Deck.h
//  Matchismo
//
//  Created by Admin on 05.07.16.
//  Copyright © 2016 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
