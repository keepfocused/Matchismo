//
//  Card.m
//  Matchismo
//
//  Created by Danil on 02.07.16.
//  Copyright (c) 2016 CS193p. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

-(NSString *)description
{
    return self.contents;
}

@end
