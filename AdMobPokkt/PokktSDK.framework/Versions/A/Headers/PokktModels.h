#import <Foundation/Foundation.h>

typedef enum : int
{
    VIDEO = 0,
    BANNER = 1,
    INTERSTITIAL = 3,
    INGAME_BRANDING = 4
} AdFormatType;

/**
 * This is ad request configuration. Developer should supply this in almost every ad related method.
 */

@interface PokktAdConfig : NSObject

/*! @abstract screenName Screen name for which ad is requested. */

@property (nonatomic, retain) NSString* screenName;

/*! @abstract isRewarded rewarded or non rewarded ad request */

@property (nonatomic, assign) BOOL isRewarded;

/*! @abstract adFormat is a type for ad such as  0:video, 1: banner, 3: interstitial , default is 0 */

@property (nonatomic, assign) int adFormat;

@property (nonatomic, assign) int responseFormat;

@property (nonatomic, strong) id adCampaign;

@property (nonatomic, assign) BOOL isFullScreen;

@property (nonatomic, assign) BOOL isAdCached;

//- (NSString *) getKey;

@end

@interface PokktAdPlayerViewConfig : NSObject

/*! @abstract defaultSkipTime duration to skip ad, default is 0 */

@property (nonatomic, assign) int defaultSkipTime;

/*! @abstract shouldAllowSkip set YES or NO to skip ad, if 'YES' it will allow user to skip ad , default is YES */

@property (nonatomic, assign) BOOL shouldAllowSkip;

/*! @abstract shouldAllowMute set YES or NO to skip ad,if 'YES' it will allow user to Mute ad , default is YES */

@property (nonatomic, assign) BOOL shouldAllowMute;

/*! @abstract shouldConfirmSkip set YES or NO to skip ad, default is YES */

@property (nonatomic, assign) BOOL shouldConfirmSkip;

/*! @abstract skipConfirmMessage custom message for skip alert*/

@property (nonatomic, strong) NSString * skipConfirmMessage;

/*! @abstract skipConfirmYesLabel custom text for skip alert 'YES' Label*/

@property (nonatomic, strong) NSString * skipConfirmYesLabel;

/*! @abstract skipConfirmNoLabel custom text for skip alert 'NO' Label*/

@property (nonatomic, strong) NSString * skipConfirmNoLabel;

/*! @abstract skipTimerMessage custom message for remianing time to skip ad*/

@property (nonatomic, strong) NSString * skipTimerMessage;

/*! @abstract incentiveMessage custom message for remianing time to get reward*/

@property (nonatomic, strong) NSString * incentiveMessage;

/*! @abstract learnMoreMessage custom message for learn more text*/

@property (nonatomic, strong) NSString * learnMoreMessage;

/*! @abstract shouldCollectFeedback set YES or NO , If Yes it will allow user to send feedback for ad.*/

@property (nonatomic, assign) BOOL shouldCollectFeedback;

/*! @abstract isAudioEnabled set YES or NO to mute ad,if 'YES' ad will be mute. , default is NO */

@property (nonatomic, assign) BOOL isAudioEnabled;

@end

@interface PokktUserInfo : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *age;
@property (nonatomic, retain) NSString *sex;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *maritalStatus;
@property (nonatomic, retain) NSString *birthday;
@property (nonatomic, retain) NSString *mobileNumber;
@property (nonatomic, retain) NSString *emailAddress;
@property (nonatomic, retain) NSString *facebookId;
@property (nonatomic, retain) NSString *twitterHandle;
@property (nonatomic, retain) NSString *educationInformation;
@property (nonatomic, retain) NSString *nationality;
@property (nonatomic, retain) NSString *employmentStatus;
@property (nonatomic, retain) NSString *maturityRating;

@end

