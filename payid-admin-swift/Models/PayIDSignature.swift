//
//  PayIDSignature.swift
//  Tabs
//
//  Created by Denis Angell on 8/5/20.
//  Copyright © 2020 Harp Angell. All rights reserved.
//

import Foundation

struct PayIDSignature {
    
    public var protected: String?
    public var signature: String?
    
    init() {}
    
    func toDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["protected"] = protected
        dict["signature"] = signature
        return dict
    }
    
    static func fromDictionary(_ dictionary: [String: Any]) -> PayIDSignature {
        guard let protected = dictionary["protected"] as? String,
            let signature = dictionary["signature"] as? String else {
                return PayIDSignature() // bad code shouldnt do this.
        }
        var sig = PayIDSignature()
        sig.protected = protected
        sig.signature = signature
        return sig
    }
    
    public func isKindaEqual(to sig: PayIDSignature) -> Bool {
        return protected == sig.protected &&
            signature == sig.signature
    }
}
