//
//  MZRoundButton.h
//  RoundButton
//
//  Created by Михаил Заславский on 02.12.15.
//  Copyright © 2015 Mikezs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, buttonStyle) {
    kMZButtonStyleCall,
    kMZButtonStyleCancel,
    kMZButtonStyleCallToDispetcher,
    kMZButtonStyleLetsGo
};

IB_DESIGNABLE
@interface MZRoundButton : UIButton

@property (nonatomic, assign) IBInspectable NSString* text;
@property (nonatomic, assign) IBInspectable UIColor* buttonColor;
#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSInteger style;
#else
@property (nonatomic, assign) buttonStyle style;
#endif

@end
