//
//  MZRoundButton.m
//  RoundButton
//
//  Created by Михаил Заславский on 02.12.15.
//  Copyright © 2015 Mikezs. All rights reserved.
//

#import "MZRoundButton.h"

const NSInteger kDefaultCenterRoundedViewSideSize = 72;
const NSInteger kDefaultImageViewSize = 38;
const NSInteger kDefaultLabelHeight = 30;

#define kCallFillColor  [UIColor colorWithRed:0.298 green:0.851 blue:0.392 alpha:1];
#define kCancelFillColor [UIColor colorWithRed:1.000 green:0.584 blue:0.000 alpha:1];


@interface MZRoundButton ()
@property (nonatomic, strong) UIView *buttonRoundView;
@property (nonatomic, strong) UILabel *buttonLabel;
@property (nonatomic, strong) UIImageView *buttonImageView;
@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation MZRoundButton
-(void)setStyle:(buttonStyle)style
{
    _style=style;
}

-(void)setButtonColor:(UIColor *)buttonColor
{
    _buttonColor=buttonColor;
}

-(void)setText:(NSString *)text
{
    
    _text=text;
}

-(void)updateUI
{
    switch (self.style) {
            
        case kMZButtonStyleCall:
        {
            self.buttonLabel.text=self.text?self.text:@"Позвонить";
            self.buttonRoundView.backgroundColor=self.buttonColor?self.buttonColor:kCallFillColor;
            [self.buttonImageView setImage:[UIImage imageNamed:@"call"
                                                      inBundle:[NSBundle bundleForClass:[self class]]
                                 compatibleWithTraitCollection:nil]];
        }
            break;
        case kMZButtonStyleCancel:
        {
            self.buttonLabel.text=self.text?self.text:@"Отменить";
            self.buttonRoundView.backgroundColor=self.buttonColor?self.buttonColor:kCancelFillColor;
            [self.buttonImageView setImage:[UIImage imageNamed:@"delete"
                                                      inBundle:[NSBundle bundleForClass:[self class]]
                                 compatibleWithTraitCollection:nil]];
        }
            break;
        case kMZButtonStyleCallCenter:
        {
            self.buttonLabel.text=self.text?self.text:@"Заказать по телефону";
            self.buttonRoundView.backgroundColor=self.buttonColor?self.buttonColor:kCallFillColor;
            [self.buttonImageView setImage:[UIImage imageNamed:@"call"
                                                      inBundle:[NSBundle bundleForClass:[self class]]
                                 compatibleWithTraitCollection:nil]];
        }
            break;
        case kMZButtonStyleLetsGo:
        {
            self.buttonLabel.text=self.text?self.text:@"Поехали";
            self.buttonRoundView.backgroundColor=self.buttonColor?self.buttonColor:kCallFillColor;
            [self.buttonImageView setImage:[UIImage imageNamed:@"checkmark"
                                                      inBundle:[NSBundle bundleForClass:[self class]]
                                 compatibleWithTraitCollection:nil]];
        }
            break;
            
        default:
            break;
    }
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
#if !TARGET_INTERFACE_BUILDER
        [self commonInit]; //Run time
#endif
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //updating to right frames
    self.buttonLabel.frame = CGRectMake(0, CGRectGetMaxY(self.bounds)-kDefaultLabelHeight, CGRectGetWidth(self.bounds), kDefaultLabelHeight);
    self.buttonRoundView.frame=CGRectMake(CGRectGetMidX(self.bounds)-kDefaultCenterRoundedViewSideSize/2, CGRectGetMidY(self.bounds)-kDefaultCenterRoundedViewSideSize/2-10, kDefaultCenterRoundedViewSideSize, kDefaultCenterRoundedViewSideSize);
    self.buttonImageView.frame=CGRectMake(CGRectGetMidX(self.bounds)-kDefaultCenterRoundedViewSideSize/2, CGRectGetMidY(self.bounds)-kDefaultCenterRoundedViewSideSize/2, kDefaultImageViewSize, kDefaultImageViewSize);
    [self.buttonImageView setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.buttonRoundView.frame))];
    [self.activityIndicatorView setCenter:self.buttonImageView.center];
}
- (void)commonInit
{
    CGRect frame=self.frame;
    
    //buttonLabel
    if(!self.buttonLabel)
    {
        self.buttonLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(frame)-kDefaultLabelHeight, CGRectGetWidth(frame), kDefaultLabelHeight)];
        self.buttonLabel.textAlignment= NSTextAlignmentCenter;
        self.buttonLabel.text=self.text;
        self.buttonLabel.font=[UIFont fontWithName:@"Helvetica-Light" size:15];
        self.buttonLabel.textColor=[UIColor colorWithWhite:0.000 alpha:0.711];
        self.buttonLabel.userInteractionEnabled=NO;
        [self addSubview:self.buttonLabel];
    }
    //buttonRoundView
    if(!self.buttonRoundView)
    {
        self.buttonRoundView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMidX(frame)-kDefaultCenterRoundedViewSideSize/2, CGRectGetMidY(frame)-kDefaultCenterRoundedViewSideSize/2-5, kDefaultCenterRoundedViewSideSize, kDefaultCenterRoundedViewSideSize)];
        self.buttonRoundView.layer.cornerRadius=kDefaultCenterRoundedViewSideSize/2;
        self.buttonRoundView.layer.masksToBounds=YES;
        self.buttonRoundView.userInteractionEnabled=NO;
        [self addSubview:self.buttonRoundView];
    }
    //imageView
    if(!self.buttonImageView)
    {
        self.buttonImageView=[[UIImageView alloc]initWithFrame:self.buttonRoundView.frame];
        [self addSubview:self.buttonImageView];
        self.buttonImageView.userInteractionEnabled=NO;
    }
    [self updateUI];
}

//---------------------------------------------------------------------

- (void)prepareForInterfaceBuilder
{
    [self commonInit];
}
//---------------------------------------------------------------------

- (void)awakeFromNib
{
    [self commonInit];
}
- (void)setShowsActivityIndicator:(BOOL)showsActivityIndicator {
    if (_showsActivityIndicator == showsActivityIndicator)
        return;
    
    _showsActivityIndicator = showsActivityIndicator;
    
    if (showsActivityIndicator) {
        [self.buttonImageView setHidden:YES];
        self.userInteractionEnabled = NO;
        self.titleLabel.alpha = 0;
        [self.activityIndicatorView removeFromSuperview];
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.activityIndicatorView.hidesWhenStopped = YES;
        [self addSubview:self.activityIndicatorView];
        [self.activityIndicatorView startAnimating];
    } else {
        [self.buttonImageView setHidden:NO];
        self.userInteractionEnabled = YES;
        self.titleLabel.alpha = 1;
        [self.activityIndicatorView removeFromSuperview];
    }
}
@end
