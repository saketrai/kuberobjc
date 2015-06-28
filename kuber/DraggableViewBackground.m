//
//  DraggableViewBackground.m
//  testing swiping
//
//  Created by Richard Kim on 8/23/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "DraggableViewBackground.h"
#import <Parse/Parse.h>

@implementation DraggableViewBackground{
    
    
    UIButton* menuButton;
    UIButton* messageButton;
    UIButton* checkButton;
    UIButton* xButton;
}
//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs
 const int MAX_BUFFER_SIZE = 2; //%%% max number of cards loaded at any given time, must be greater than 1
 const float CARD_HEIGHT = 300; //%%% height of the draggable card
 const float CARD_WIDTH = 290; //%%% width of the draggable card

@synthesize exampleCardLabels; //%%% all the labels I'm using as example data at the moment
@synthesize allCards;//%%% all the cards

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        [self setupView];
        self.imageArray= [[NSMutableArray alloc] init];
        self.exampleCardLabels= [[NSMutableArray alloc] init];
        //int i=0;

        self.loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        self.cardsLoadedIndex = 0;
        //[self loadCards];
        


    }
    return self;
}

//%%% sets up the extra buttons on the screen
-(void)setupView
{
#warning customize all of this.  These are just place holders to make it look pretty
    //self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1]; //the gray background colors
    //menuButton = [[UIButton alloc]initWithFrame:CGRectMake(17, 34, 22, 15)];
    //[menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    //messageButton = [[UIButton alloc]initWithFrame:CGRectMake(284, 34, 18, 18)];
    //[messageButton setImage:[UIImage imageNamed:@"messageButton"] forState:UIControlStateNormal];
    xButton = [[UIButton alloc]initWithFrame:CGRectMake(60, 520, 59, 59)];
    [xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(260, 520, 59, 59)];
    [checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    navbar.backgroundColor = [UIColor blueColor];
    
//    UINavigationItem *navItem = [[UINavigationItem alloc] init];
//    navItem.title = @"kubermarket";
//    navbar.items = @[ navItem ];
//
//    [self addSubview:navbar];
    [self addSubview:menuButton];
    [self addSubview:messageButton];
    [self addSubview:xButton];
    [self addSubview:checkButton];
}

#warning include own card customization here!
//%%% creates a card and returns it.  This should be customized to fit your needs.
// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)
-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)];
    draggableView.information.text = [exampleCardLabels objectAtIndex:index]; //%%% placeholder for card-specific information
    draggableView.cardImageView.image=[self.imageArray objectAtIndex:index];
    //draggableView.cardImageView.image=[UIImage imageNamed:@"ring.jpg"];
    draggableView.delegate = self;
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    //NSLog(@"exampleCardLabels is %lu",(unsigned long)[exampleCardLabels count]);

}

#warning include own action here!
//%%% action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [self.loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (self.cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [self.loadedCards addObject:[allCards objectAtIndex:self.cardsLoadedIndex]];
        self.cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[self.loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[self.loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
}

#warning include own action here!
//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [self.loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (self.cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [self.loadedCards addObject:[allCards objectAtIndex:self.cardsLoadedIndex]];
        self.cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[self.loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[self.loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }

}

//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    DraggableView *dragView = [self.loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    DraggableView *dragView = [self.loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
