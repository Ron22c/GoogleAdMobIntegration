//
//  ViewController.m
//  AdMobPokkt
//
//  Created by Ranajit Chandra on 09/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "ExampleUnifiedNativeAdView.h"


@interface ViewController ()<GADInterstitialDelegate,
                                GADUnifiedNativeAdLoaderDelegate>
@property(nonatomic, weak) IBOutlet UIView *nativeAdPlaceholder;
@property(weak, nonatomic)  NSString *txtAdUnitNative;
@property(nonatomic, strong) GADAdLoader *adLoader;


@end

@implementation ViewController

- (void)viewDidLoad {
    _txtAdUnitNative = @"ca-app-pub-6776391977517404/3813531704";
    [super viewDidLoad];
    [self refreshNativeAd:nil];

}

- (IBAction)refreshNativeAd:(id)sender {
  GADNativeAdViewAdOptions *adViewOptions = [[GADNativeAdViewAdOptions alloc] init];
//  adViewOptions.preferredAdChoicesPosition = GADAdChoicesPositionTopRightCorner;

  self.adLoader = [[GADAdLoader alloc] initWithAdUnitID:_txtAdUnitNative
                                     rootViewController:self
                                                adTypes:@[ kGADAdLoaderAdTypeUnifiedNative ]
                                                options:@[ adViewOptions ]];
  self.adLoader.delegate = self;
  GADRequest *request=[GADRequest request];
  request.testDevices=@[kGADSimulatorID];
  [self.adLoader loadRequest:request];
}

- (void)replaceNativeAdView:(UIView *)nativeAdView inPlaceholder:(UIView *)placeholder {
  // Remove anything currently in the placeholder.
  NSArray *currentSubviews = [placeholder.subviews copy];
  for (UIView *subview in currentSubviews) {
    [subview removeFromSuperview];
  }

  if (!nativeAdView) {
    return;
  }

  // Add new ad view and set constraints to fill its container.
  [placeholder addSubview:nativeAdView];
  nativeAdView.translatesAutoresizingMaskIntoConstraints = NO;

  NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(nativeAdView);
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nativeAdView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewDictionary]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nativeAdView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewDictionary]];
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(GADUnifiedNativeAd *)nativeAd {
  NSLog(@"%s, %@", __PRETTY_FUNCTION__, nativeAd);

  // Create and place ad in view hierarchy.
  ExampleUnifiedNativeAdView *nativeAdView =
      [[NSBundle mainBundle] loadNibNamed:@"ExampleUnifiedNativeAdView" owner:nil options:nil]
          .firstObject;

  nativeAdView.nativeAd = nativeAd;
  UIView *placeholder = self.nativeAdPlaceholder;
  ;
  NSString *awesomenessKey = _txtAdUnitNative;

  [self replaceNativeAdView:nativeAdView inPlaceholder:placeholder];

  nativeAdView.mediaView.contentMode = UIViewContentModeScaleAspectFit;
  nativeAdView.mediaView.hidden = NO;
  [nativeAdView.mediaView setMediaContent:nativeAd.mediaContent];
  // Populate the native ad view with the native ad assets.
  // Some assets are guaranteed to be present in every native ad.
  ((UILabel *)nativeAdView.headlineView).text = nativeAd.headline;
  ((UILabel *)nativeAdView.bodyView).text = nativeAd.body;
  [((UIButton *)nativeAdView.callToActionView) setTitle:nativeAd.callToAction
                                               forState:UIControlStateNormal];

  // These assets are not guaranteed to be present, and should be checked first.
  ((UIImageView *)nativeAdView.iconView).image = nativeAd.icon.image;
  if (nativeAd.icon != nil) {
    nativeAdView.iconView.hidden = NO;
  } else {
    nativeAdView.iconView.hidden = YES;
  }

  ((UILabel *)nativeAdView.storeView).text = nativeAd.store;
  if (nativeAd.store) {
    nativeAdView.storeView.hidden = NO;
  } else {
    nativeAdView.storeView.hidden = YES;
  }

  ((UILabel *)nativeAdView.priceView).text = nativeAd.price;
  if (nativeAd.price) {
    nativeAdView.priceView.hidden = NO;
  } else {
    nativeAdView.priceView.hidden = YES;
  }

  ((UILabel *)nativeAdView.advertiserView).text = nativeAd.advertiser;
  if (nativeAd.advertiser) {
    nativeAdView.advertiserView.hidden = NO;
  } else {
    nativeAdView.advertiserView.hidden = YES;
  }

  // If the ad came from the Sample SDK, it should contain an extra asset, which is retrieved here.
  NSString *degreeOfAwesomeness = nativeAd.extraAssets[awesomenessKey];

  if (degreeOfAwesomeness) {
    nativeAdView.degreeOfAwesomenessView.text = degreeOfAwesomeness;
    nativeAdView.degreeOfAwesomenessView.hidden = NO;
  } else {
    nativeAdView.degreeOfAwesomenessView.hidden = YES;
  }

  // In order for the SDK to process touch events properly, user interaction should be disabled.
  nativeAdView.callToActionView.userInteractionEnabled = NO;
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(GADRequestError *)error {
  NSLog(@"%@ failed with error: %@", adLoader, error.localizedDescription);
}

@end
