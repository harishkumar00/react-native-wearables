import Foundation
import WatchConnectivity

class WatchConnector: NSObject, WCSessionDelegate {
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Wearables: Session activation failed: \(error.localizedDescription)")
        } else {
            print("Wearables: Session activated with state: \(activationState.rawValue)")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Wearables: Session became inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Wearables: Session deactivated")
    }
}


