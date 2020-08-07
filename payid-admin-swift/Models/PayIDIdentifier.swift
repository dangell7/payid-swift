//
//  PayIDIdentifier.swift
//  Tabs
//
//  Created by Denis Angell on 8/5/20.
//  Copyright © 2020 Harp Angell. All rights reserved.
//

import Foundation

struct PayIDIdentifier {
    
    public var payId: String?
    public var addresses: [PayIDAddress] = []
    public var verifiedAddresses: [PayIDVerifiedAddress] = []
    
    init() {}
    
    func toDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["payId"] = payId
        dict["addresses"] = addresses
        dict["verifiedAddresses"] = verifiedAddresses
        return dict
    }
    
    static func fromDictionary(_ dictionary: [String: Any]) -> PayIDIdentifier {
        guard let payId = dictionary["payId"] as? String else {
                return PayIDIdentifier() // bad code shouldnt do this.
        }
        var identifier = PayIDIdentifier()
        identifier.payId = payId
        var addressCollection: [PayIDAddress] = []
        if let addressArray = dictionary["addresses"] as? [[String: AnyObject]] {
            for addressDict in addressArray {
                addressCollection.append(PayIDAddress.fromDictionary(addressDict))
            }
        }
        identifier.addresses = addressCollection
        var vAddressCollection: [PayIDVerifiedAddress] = []
        if let vAddressArray = dictionary["verifiedAddresses"] as? [[String: AnyObject]] {
            for vAddressDict in vAddressArray {
                vAddressCollection.append(PayIDVerifiedAddress.fromDictionary(vAddressDict))
            }
        }
        identifier.verifiedAddresses = vAddressCollection
        return identifier
    }
    
    public func isKindaEqual(to identifier: PayIDIdentifier) -> Bool {
        return payId == identifier.payId
    }
}
