//
//  Card.h
//  Matchismo
//
//  Created by Danil on 02.07.16.
//  Copyright (c) 2016 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;
@property (nonatomic,weak)NSString *description;

- (int)match:(NSArray *)otherCards;

@end
