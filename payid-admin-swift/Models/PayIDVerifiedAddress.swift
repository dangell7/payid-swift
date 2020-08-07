//
//  PayIDIdentifier.swift
//  Tabs
//
//  Created by Denis Angell on 8/5/20.
//  Copyright © 2020 Harp Angell. All rights reserved.
//

import Foundation

struct PayIDVerifiedAddress {
    
    public var signatures: [PayIDSignature] = []
    public var payload: String?
    
    init() {}
    
    func toDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["signatures"] = signatures
        dict["payload"] = payload
        return dict
    }
    
    static func fromDictionary(_ dictionary: [String: Any]) -> PayIDVerifiedAddress {
        guard let payload = dictionary["payload"] as? String else {
                return PayIDVerifiedAddress() // bad code shouldnt do this.
        }
        var vAddress = PayIDVerifiedAddress()
        var signatureCollection: [PayIDSignature] = []
        if let signatureList = dictionary["signatures"] as? [[String: AnyObject]] {
            for sugnatureDict in signatureList {
                let signature = PayIDSignature.fromDictionary(sugnatureDict)
                signatureCollection.append(signature)
            }
        }
        vAddress.signatures = signatureCollection
        vAddress.payload = payload
        return vAddress
    }
    
    public func isKindaEqual(to vAddress: PayIDVerifiedAddress) -> Bool {
        return payload == vAddress.payload
    }
}
