#import <React/RCTBridgeModule.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface RCT_EXTERN_MODULE(Wearables, NSObject)

RCT_EXTERN_METHOD(getIsPaired:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getIsWatchAppInstalled:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(sendMessage:(NSDictionary *)message
                  withResolver:(RCTResponseSenderBlock)resolve
                  withRejecter:(RCTResponseErrorBlock)reject)

RCT_EXTERN_METHOD(sendMessageData:(NSString *)message
                  encoding:(NSNumber *)encoding
                  withResolver:(RCTResponseSenderBlock)resolve
                  withRejecter:(RCTResponseErrorBlock)reject)                 

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
