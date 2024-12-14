import Foundation
import WatchConnectivity
import React

@objc(Wearables)
class Wearables: NSObject, WCSessionDelegate {
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Wearable: Session activation failed: \(error.localizedDescription)")
        } else {
            print("Wearable: Session activated with state: \(activationState.rawValue)")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Wearable: Session became inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Wearable: Session deactivated")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Wearable: Message Received from Watch")
    }
    
    @objc(getIsPaired:withRejecter:)
    func getIsPaired(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        if WCSession.default.isPaired {
            resolve(true)
        } else {
            resolve(false)
        }
    }
    
    @objc(getIsWatchAppInstalled:withRejecter:)
    func getIsWatchAppInstalled(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        if WCSession.default.isWatchAppInstalled {
            resolve(true)
        } else {
            resolve(false)
        }
    }
    
    @objc(sendMessage:withResolver:withRejecter:)
    func sendMessage(message: [String: Any], resolve: @escaping RCTResponseSenderBlock, reject: @escaping RCTResponseErrorBlock) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(message, replyHandler: { response in
                resolve([response])
            }, errorHandler: { error in
                reject(error)
            })
        } else {
            let error = NSError(domain: "Wearables", code: 0, userInfo: [NSLocalizedDescriptionKey: "Watch is not reachable"])
            reject(error)
        }
    }
    
    @objc(sendMessageData:encoding:withResolver:withRejecter:)
    func sendMessageData(message: String, encoding: NSNumber, resolve: @escaping RCTResponseSenderBlock, reject: @escaping RCTResponseErrorBlock) {
        if let data = message.data(using: .utf8) {
            if WCSession.default.isReachable {
                WCSession.default.sendMessageData(data, replyHandler: { response in
                    resolve([response])
                }, errorHandler: { error in
                    reject(error)
                })
            } else {
                let error = NSError(domain: "Wearables", code: 0, userInfo: [NSLocalizedDescriptionKey: "Watch is not reachable"])
                reject(error)
            }
        } else {
            let error = NSError(domain: "Wearables", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode message data"])
            reject(error)
        }
    }
    
    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }
}

