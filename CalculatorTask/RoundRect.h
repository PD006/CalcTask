//
//  RoundRect.h
//  CalculatorTask
//
//  Created by Pratibha on 04/01/19.
//  Copyright © 2019 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface RoundRect : UIButton

@property IBInspectable CGFloat cornerRadius;
@property IBInspectable UIColor *borderColor;
@property IBInspectable CGFloat borderWidth;
@end

NS_ASSUME_NONNULL_END
