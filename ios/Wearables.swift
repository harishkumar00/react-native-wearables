import Foundation
import WatchConnectivity
import React

@objc(Wearables)
class Wearables: NSObject {
    
    var watchConnector = WatchConnector()
    
    @objc(getIsPaired:withRejecter:)
    func getIsPaired(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            resolve(self.watchConnector.session.isPaired)
        }
    }
    
    @objc(getIsWatchAppInstalled:withRejecter:)
    func getIsWatchAppInstalled(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            resolve(self.watchConnector.session.isWatchAppInstalled)
        }
    }
    
    @objc(sendMessage:withResolver:withRejecter:)
    func sendMessage(
        message: [String: Any], 
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        if watchConnector.session.isReachable {
            watchConnector.session.sendMessage(
                ["message": String("Harish")], 
                replyHandler: nil
            ) { (error) in
                print("Wearables, Error in sending message \(error.localizedDescription)")
            }
        } else {
            print("Wearables: Watch is not reachable")
        }
    }
}
