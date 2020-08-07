//
//  PayIDAddress.swift
//  Tabs
//
//  Created by Denis Angell on 8/5/20.
//  Copyright © 2020 Harp Angell. All rights reserved.
//

import Foundation

enum PayIDEnvironment: String {
    case TESTNET
    case ROPSTEN
    case MAINNET
}

enum PayIDAddressType: String {
    case CryptoAddressDetails
}

struct PayIDAddress {
    
    public var paymentNetwork: String?
    public var environment: PayIDEnvironment = .TESTNET
    public var addressDetailsType: PayIDAddressType = .CryptoAddressDetails
    public var addressDetails: [String: String] = [:]
    
    init() {}
    
    init(
        paymentNetwork: String,
        environment: PayIDEnvironment,
        addressDetailsType: PayIDAddressType,
        addressDetails:[String: String]
    ) {
        self.paymentNetwork = paymentNetwork
        self.environment = environment
        self.addressDetailsType = addressDetailsType
        self.addressDetails = addressDetails
    }
    
    func toDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["paymentNetwork"] = paymentNetwork
        dict["environment"] = environment.rawValue
        dict["addressDetailsType"] = addressDetailsType.rawValue
        dict["addressDetails"] = addressDetails
        return dict
    }
    
    static func fromDictionary(_ dictionary: [String: Any]) -> PayIDAddress {
        guard let paymentNetwork = dictionary["paymentNetwork"] as? String,
            let environmentString = dictionary["environment"] as? String,
            let addressDetailsTypeString = dictionary["addressDetailsType"] as? String else {
                return PayIDAddress() // bad code shouldnt do this.
        }
        var address = PayIDAddress()
        address.paymentNetwork = paymentNetwork
        address.environment = PayIDEnvironment(rawValue: environmentString)!
        address.addressDetailsType = PayIDAddressType(rawValue: addressDetailsTypeString)!
        if let addressDetails = dictionary["addressDetails"] as? [String: String] {
            address.addressDetails = addressDetails
        }
        return address
    }
    
    public func isKindaEqual(to address: PayIDAddress) -> Bool {
        return paymentNetwork == address.paymentNetwork &&
            environment == address.environment &&
            addressDetailsType == address.addressDetailsType &&
            addressDetails == address.addressDetails
    }
}
