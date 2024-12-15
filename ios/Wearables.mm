#import <React/RCTBridgeModule.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface RCT_EXTERN_MODULE(Wearables, NSObject)

RCT_EXTERN_METHOD(getIsPaired:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getIsWatchAppInstalled:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(sendMessage:(NSDictionary *)message
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
