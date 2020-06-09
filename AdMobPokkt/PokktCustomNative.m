#import "PokktCustomNative.h"
#import "SampleMediatedNativeAd.h"
#import <PersonalizedAdConsent/PersonalizedAdConsent.h>

/// Constant for Sample Ad Network custom event error domain.
static NSString *const customEventErrorDomain = @"com.google.CustomEvent";

@interface PokktCustomNative () <PokktNativeAdDelegate> {
  /// Native ad view options.
  GADNativeAdViewAdOptions *_nativeAdViewAdOptions;
    
    NSString *screenId;
    NSString *appId;
    NSString *securityKey;
    BOOL isDebug;
    NSString *thirdPartyId;
    
}

@end

@implementation PokktCustomNative

@synthesize delegate;

- (void)requestNativeAdWithParameter:(NSString *)serverParameter
                             request:(GADCustomEventRequest *)request
                             adTypes:(NSArray *)adTypes
                             options:(NSArray *)options
                  rootViewController:(UIViewController *)rootViewController {
  BOOL requestedUnified = [adTypes containsObject:kGADAdLoaderAdTypeUnifiedNative];

  // This custom event assumes you have implemented unified native advanced in your app as is done
  // in this sample.

  if (!requestedUnified) {
    NSString *description = @"You must request the unified native ad format.";
    NSDictionary *userInfo =
        @{NSLocalizedDescriptionKey : description, NSLocalizedFailureReasonErrorKey : description};
    NSError *error =
        [NSError errorWithDomain:@"com.google.mediation.sample" code:0 userInfo:userInfo];
    [self.delegate customEventNativeAd:self didFailToLoadWithError:error];
    return;
  }

  NSError *jsonError;
  NSData *objectData = [serverParameter dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                       options:NSJSONReadingMutableContainers
                                                         error:&jsonError];
  NSLog(@"Data recieved from server: %@", json);

  screenId = [json objectForKey:@"SCREEN"];
  appId = [json objectForKey:@"APPID"];
  securityKey = [json objectForKey:@"SECKEY"];
  isDebug = [[json objectForKey:@"DBG"] boolValue];
  thirdPartyId = [json objectForKey:@"TPID"];
  
  NSLog(@"AdMob Custom Native Network Initialised...");
  
  [PokktAds setPokktConfigWithAppId:appId securityKey:securityKey];
  [self setGDPR]; //TODO: call it later
  
  [PokktDebugger setDebug:isDebug];
  
  [PokktAds setThirdPartyUserId:thirdPartyId];
  
  [options enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      if ([obj isKindOfClass:GADNativeAdViewAdOptions.class]) {
          _nativeAdViewAdOptions = obj;
      }
  }];

  [PokktAds requestNativeAd:screenId withDelegate:self];
}

-(void)setGDPR
{
    PACConsentStatus status =  [[PACConsentInformation sharedInstance] consentStatus];
    PokktConsentInfo *consentInfo = [[PokktConsentInfo alloc] init];
    if (status == PACConsentStatusNonPersonalized)
    {
        consentInfo.isGDPRApplicable = true;
        consentInfo.isGDPRConsentAvailable = false;
    }
    else if (status == PACConsentStatusPersonalized)
    {
        consentInfo.isGDPRApplicable = true;
        consentInfo.isGDPRConsentAvailable = true;
    }
    
    [PokktAds setPokktConsentInfo:consentInfo];
}

// Indicates if the custom event handles user clicks. Return YES if the custom event should handle
// user clicks.
- (BOOL)handlesUserClicks {
  return NO;
}

- (BOOL)handlesUserImpressions {
  return NO;
}

#pragma mark SampleNativeAdLoaderDelegate implementation

- (void)nativeAdFailed:(NSString *)screenId error:(NSString *)errorMessage {
    NSError *error = [NSError errorWithDomain:customEventErrorDomain code:500 userInfo:nil];
    [self.delegate customEventNativeAd:self didFailToLoadWithError:error];
}

- (void)nativeAdReady:(NSString *)screenId withNativeAd:(PokktNativeAd *)pokktNativeAd {
    SampleMediatedNativeAd *mediatedAd =
        [[SampleMediatedNativeAd alloc] initWithSampleNativeAd:pokktNativeAd
                                         nativeAdViewAdOptions:_nativeAdViewAdOptions];
    [self.delegate customEventNativeAd:self didReceiveMediatedUnifiedNativeAd:mediatedAd];
}

@end
