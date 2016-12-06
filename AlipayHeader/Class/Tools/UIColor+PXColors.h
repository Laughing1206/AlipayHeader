//
//  UIColor+PXColors.h
//  AppFlash
//
//  Created by 李欢欢 on 2016/12/6.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The UIColor+PXColors category extends UIColor to allow colors to be specified by SVG color name, hex strings,
 *  and hex values. Additionally, HSL color space conversions have been added
 */
@interface UIColor (PXColors)

/**
 *  Return a UIColor from an SVG color name
 *
 *   name The color name
 */
+ (UIColor *)colorFromName:(NSString *)name;

/**
 *  Return a UIColor using the HSL color space
 *
 *   hue The color's hue
 *   saturation The color's saturation
 *   lightness The color's lightness
 */
+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness;

/**
 *  Return a UIColor using the HSL color space and an alpha value
 *
 *   hue The color's hue
 *   saturation The color's saturation
 *   lightness The color's lightness
 *   alpha The color's alpha value
 */
+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

/**
 *  Return a UIColor from a 3- or 6-digit hex string
 *
 *   hexString The hex color string value
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 *  Return a UIColor from a 3- or 6-digit hex string and an alpha value
 *
 *   hexString The hex color string value
 *   alpha The color's alpha value
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString withAlpha:(CGFloat)alpha;

/**
 *  Return a UIColor from a RGBA int
 *
 *   value The int value
 */
+ (UIColor *)colorWithRGBAValue:(uint)value;

/**
 *  Return a UIColor from a ARGB int
 *
 *   value The int value
 */
+ (UIColor *)colorWithARGBValue:(uint)value;

/**
 *  Return a UIColor from a RGB int
 *
 *   value The int value
 */
+ (UIColor *)colorWithRGBValue:(uint)value;

/**
 *  Convert this color to HSLA
 *
 *   hue A float pointer that will be set by this conversion
 *   saturation A float pointer that will be set by this conversion
 *   lightness A float pointer that will be set by this conversion
 *   alpha A float pointer that will be set by this conversion
 */
- (BOOL)getHue:(CGFloat *)hue saturation:(CGFloat *)saturation lightness:(CGFloat *)lightness alpha:(CGFloat *)alpha;

/**
 *  Determine if this color is opaque. Essentially, this returns true if the alpha channel is 1.0
 */
- (BOOL)isOpaque;

/**
 *  Adds percent to the lightness channel of this color
 */
- (UIColor *)darkenByPercent:(CGFloat)percent;

/**
 *  Subtracts percent from the lightness channel of this color
 */
- (UIColor *)lightenByPercent:(CGFloat)percent;

+ (UIColor *)randomColor;

@end
