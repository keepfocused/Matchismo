//
//  ViewController.m
//  Matchismo
//
//  Created by Admin on 29.06.16.
//  Copyright © 2016 CS193p. All rights reserved.
//


#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *numberOfMatchesSegment;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) NSMutableArray *flipsHistory;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *sliderMaxLabel;


@end

@implementation ViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        _game.numberOfMatches =[self numberOfMatches];
        
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)numberOfMatches
{
    return self.numberOfMatchesSegment.selectedSegmentIndex+2;
}


- (IBAction)takeHistory:(UISlider *)sender {
    int selectedIndex = (int) sender.value;
    if (selectedIndex < 0 || (selectedIndex > self.flipCount-1)) return;
    self.resultsLabel.alpha = (selectedIndex < self.flipCount-1) ? 0.5 : 1.0;
    NSString *text = [NSString stringWithFormat:@"%d:",(selectedIndex+1)];
    self.resultsLabel.text = [text stringByAppendingString:[self.flipsHistory objectAtIndex:selectedIndex]];
    
    
}

- (IBAction)dealPress:(id)sender {
    self.numberOfMatchesSegment.enabled =YES;
    self.game = nil;
    self.flipsHistory = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)changeNumberOfMatches:(UISegmentedControl *)sender {
    self.game = nil;
    [self updateUI];
}

- (IBAction)touchCardButton:(id)sender
{
    self.numberOfMatchesSegment.enabled =NO;
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    self.flipCount++;
    [self updateUI];
}
- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    [self updateFlipResult];
    self.historySlider.maximumValue = self.flipCount;
    [self.historySlider setValue:(float)self.flipCount animated:YES];
    self.sliderMaxLabel.text = [NSString stringWithFormat:@"%d",(int)ceilf(self.historySlider.maximumValue)];
}

-(void)updateFlipResult
{
    NSString *text=@" ";
    if ([self.game.matchedCards  count]>0)
    {
        text = [text stringByAppendingString:[self.game.matchedCards componentsJoinedByString:@" "]];
        if ([self.game.matchedCards count] == [self numberOfMatches])
        {
            if (self.game.lastFlipPoints<0) {
                text = [text stringByAppendingString:[NSString stringWithFormat:@"✘ %ld penalty",(long)self.game.lastFlipPoints]];
            } else {
                text = [text stringByAppendingString:[NSString stringWithFormat:@"✔ +%ld bonus",(long)self.game.lastFlipPoints]];
            }
        } else text =[self textForSingleCard];
        [self.flipsHistory addObject:text];
    } else text = @"Play game!";
    self.resultsLabel.text = text;
}

- (NSString *)textForSingleCard
{
    Card *card = [self.game.matchedCards lastObject];
    return [NSString stringWithFormat:@" %@ flipped %@",card,(card.isChosen) ? @"up!" : @"back!"];
}



- (NSString *)titleForCard:(Card *)card
{
    return card.chosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
}

- (NSMutableArray *)flipsHistory
{
    if (!_flipsHistory)_flipsHistory = [[NSMutableArray alloc]init];
    return _flipsHistory;
}



@end
