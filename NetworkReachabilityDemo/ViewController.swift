//
//  ViewController.swift
//  NetworkReachabilityDemo
//
//  Created by Obinna on 26/09/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var connectionStatusLabel: UILabel!
    @IBOutlet weak var networkTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkStatusChanged()
    }
    
    /// The network status closure. 
    func networkStatusChanged() {
        NetworkReachability.shared.netStatusChangeHandler = { [weak self] in
            guard let self = self else { return }
            
            if NetworkReachability.shared.isConnected {
                if let networkType = NetworkReachability.shared.interfaceType {
                    switch networkType {
                    case .cellular:
                        self.updateUIForConnected("You are connected to your mobile data")
                    case .wifi:
                        self.updateUIForConnected("You are connected with Wi-Fi")
                    case .wiredEthernet:
                        self.updateUIForConnected("You are connected with Ethernet")
                    default:
                        print("You are connected to some other type of network.")
                    }
                }
            } else {
                // Handle network disconnected state
                self.updateUIForDisconnected()
            }
        }
    }
    
    // Function to update the UI when the network is connected.
    func updateUIForConnected(_ networkTypeString: String) {
        DispatchQueue.main.async {
            self.connectionStatusLabel.text = "🟢 Connected"
            self.networkTypeLabel.text = networkTypeString
        }
    }
    
    // Function to update the UI when the network is disconnected.
    func updateUIForDisconnected() {
        DispatchQueue.main.async {
            self.connectionStatusLabel.text = "🔴 Disconnected"
            self.networkTypeLabel.text = "No network connection"
        }
    }
}
