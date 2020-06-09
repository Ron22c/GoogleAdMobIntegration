#import "SampleMediatedNativeAd.h"

@interface SampleMediatedNativeAd ()
@property(nonatomic, strong) PokktNativeAd *sampleAd;
@property(nonatomic, copy) NSArray *mappedImages;
@property(nonatomic, strong) GADNativeAdImage *mappedIcon;
@property(nonatomic, copy) NSDictionary *extras;
@property(nonatomic, strong) GADNativeAdViewAdOptions *nativeAdViewAdOptions;
@property(nonatomic, strong) UIView *mediaView;


@end

@implementation SampleMediatedNativeAd

- (instancetype)initWithSampleNativeAd:(PokktNativeAd *)sampleNativeAd
                 nativeAdViewAdOptions:(nullable GADNativeAdViewAdOptions *)nativeAdViewAdOptions {
  if (!sampleNativeAd) {
    return nil;
  }

  self = [super init];
  if (self) {
    _sampleAd = sampleNativeAd;
    _mediaView = _sampleAd.getMediaView;
    _nativeAdViewAdOptions = nativeAdViewAdOptions;

    // The sample SDK provides an AdChoices view (SampleAdInfoView). If your SDK provides image
    // and clickthrough URLs for its AdChoices icon instead of an actual UIView, the adapter is
    // responsible for downloading the icon image and creating the AdChoices icon view.
  }
  return self;
}

- (BOOL)hasVideoContent {
  return self.sampleAd.getMediaView != nil;
}

- (UIView *)mediaView {
  return _mediaView;
}

- (NSString *)advertiser {
  return @"adv";
}

- (NSString *)headline {
  return @"headline";
}

- (NSArray *)images {
  return self.mappedImages;
}

- (NSString *)body {
  return @"body";
}

- (GADNativeAdImage *)icon {
  return self.mappedIcon;
}

- (NSString *)callToAction {
    return @"action";
}

- (NSString *)store {
  return @"store";
}

- (NSString *)price {
  return @"price";
}

- (NSDictionary *)extraAssets {
  return self.extras;
}

- (NSDecimalNumber *)starRating {
  return nil;
}


// Because the Sample SDK has click and impression tracking via methods on its native ad object
// which the developer is required to call, there's no need to pass it a reference to the UIView
// being used to display the native ad. So there's no need to implement
// mediatedNativeAd:didRenderInView:viewController:clickableAssetViews:nonClickableAssetViews here.
// If your mediated network does need a reference to the view, this method can be used to provide
// one.
// You can also access the clickable and non-clickable views by asset key if the mediation network
// needs this information.
- (void)didRenderInView:(UIView *)view
       clickableAssetViews:
           (NSDictionary<GADUnifiedNativeAssetIdentifier, UIView *> *)clickableAssetViews
    nonclickableAssetViews:
        (NSDictionary<GADUnifiedNativeAssetIdentifier, UIView *> *)nonclickableAssetViews
            viewController:(UIViewController *)viewController {
  // This method is called when the native ad view is rendered. Here you would pass the UIView back
  // to the mediated network's SDK.
  // Playing video using SampleNativeAd's playVideo method
  [_sampleAd getMediaView];
}

- (void)didUntrackView:(UIView *)view {
  // This method is called when the mediatedNativeAd is no longer rendered in the provided view.
  // Here you would remove any tracking from the view that has mediated native ad.
}

- (void)didRecordImpression {
  if (self.sampleAd) {
      NSLog(@"didRecordImpression");
  }
}

- (void)didRecordClickOnAssetWithName:(GADUnifiedNativeAssetIdentifier)assetName
                                 view:(UIView *)view
                       viewController:(UIViewController *)viewController {
  if (self.sampleAd) {
    NSLog(@"didRecordClickOnAssetWithName");
  }
}

@end
