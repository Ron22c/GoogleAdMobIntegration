#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PokktModels.h"


@protocol PokktAdDelegate <NSObject>
/**
 * Caching
 **/
- (void)adCachingResult:(NSString *)screenId isSuccess:(BOOL)success withReward:(double)reward errorMessage:(NSString *)errorMessage;

/**
 * Ad Display
 **/
- (void)adDisplayResult:(NSString *)screenId isSuccess:(BOOL)success errorMessage:(NSString *)errorMessage;

/**
 * Ad Closed
 **/
- (void)adClosed:(NSString *)screenId adCompleted:(BOOL)adCompleted;

/**
 * Ad Interaction
 **/
- (void)adClicked:(NSString *)screenId;

- (void)adGratified:(NSString *)screenId withReward:(double)reward;

@end


@class PokktNativeAd;
@protocol PokktNativeAdDelegate <NSObject, PokktAdDelegate>

- (void)nativeAdReady:(NSString *)screenId withNativeAd:(PokktNativeAd *)pokktNativeAd;

- (void)nativeAdFailed:(NSString *)screenId error:(NSString *)errorMessage;

@end


@protocol PokktBannerAdDelegate <NSObject, PokktAdDelegate>

- (void)bannerExpanded:(NSString *)screenId;

- (void)bannerResized:(NSString *)screenId;

- (void)bannerCollapsed:(NSString *)screenId;

@end


@interface PokktNativeAd : NSObject

- (instancetype)initWithAd:(id)ad;

- (UIView *)getMediaView;

- (void)destroy;

@end


@interface PokktBannerView : UIView

- (void)loadBanner:(NSString *)screenId rootViewController:(UIViewController *)rootViewController;

- (void)destroyBanner;

@end


@interface PokktConsentInfo : NSObject

@property (nonatomic) BOOL isGDPRApplicable;

@property (nonatomic) BOOL isGDPRConsentAvailable;

@end


@interface PokktAds : NSObject
/**
 * Mandatory APIs
 **/
+ (void)setPokktConfigWithAppId:(NSString *)appId securityKey:(NSString *)securityKey;
/**
 * Ads APIs
 **/
+ (BOOL)isAdCached:(NSString *)screenId;

+ (void)cacheAd:(NSString *)screenId withDelegate:(id<PokktAdDelegate>)delegate;

+ (void)showAd:(NSString *)screenId withViewController:(UIViewController *)viewController withDelegate:(id<PokktAdDelegate>)delegate;

+ (void)showAd:(NSString *)screenId withViewController:(UIViewController *)viewController bannerContainer:(PokktBannerView *)bannerView withDelegate:(id<PokktBannerAdDelegate>)delegate;

+ (void)requestNativeAd:(NSString *)screenId withDelegate:(id<PokktNativeAdDelegate>)delegate;

+ (void)destroyBanner:(PokktBannerView *)bannerContainer;


/**
 * Consent/GDPR APIs
 **/
+(void) setPokktConsentInfo:(PokktConsentInfo*) consentObject;

+(PokktConsentInfo*) getPokktConsentInfo;


/**
 * Optional Params and Configs APIs
 **/
+(NSString*) getSDKVersion;

+(void) setThirdPartyUserId:(NSString*) userId;

+(void) setCallbackExtraParam:(NSDictionary*) extraParam;

+(void) setUserDetails:(PokktUserInfo*) userInfo;

+(void) setPokktAdPlayerViewConfig:(PokktAdPlayerViewConfig*) adPlayerViewConfig;

@end


/**
 * Debugging
 **/
@interface PokktDebugger : NSObject

+(BOOL) isDebugEnabled;

+(void) setDebug:(BOOL) isDebug;

+(void) showToast:(NSString*) message
   viewController:(UIViewController*) viewController;

+(void) printLog:(NSString*) message;

@end
