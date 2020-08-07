//
//  IdentityKeyParams.swift
//  beattheline
//
//  Created by Denis Angell on 8/6/20.
//  Copyright © 2020 Harp Angell. All rights reserved.
//

import Foundation

//
//  PayIDSignature.swift
//  Tabs
//
//  Created by Denis Angell on 8/5/20.
//  Copyright © 2020 Harp Angell. All rights reserved.
//

import Foundation
import JOSESwift

struct IdentityKeySigningParams {
    
    public var keyType: String = "identityKey"
    public var key: SecKey? // SecKey
    public var alg: SignatureAlgorithm = .ES256
    
    init(privateKey: Data, alg: SignatureAlgorithm) {
        self.key = decodeSecKeyFromBase64(encodedKey: privateKey.base64EncodedString(), isPrivate: true)
        self.alg = alg
    }
    
    // Extract secKey from encoded string - defaults to extracting public keys
    func decodeSecKeyFromBase64(encodedKey: String, isPrivate: Bool = false) -> SecKey? {
        var keyClass = kSecAttrKeyClassPublic
        if isPrivate {
            keyClass = kSecAttrKeyClassPrivate
        }
        let attributes: [String:Any] =
        [
            kSecAttrKeyClass as String: keyClass,
            kSecAttrKeyType as String: kSecAttrKeyTypeEC,
            kSecAttrKeySizeInBits as String: 2048,
        ]

        guard let secKeyData = Data.init(base64Encoded: encodedKey) else {
            print("Error: invalid encodedKey, cannot extract data")
            return nil
        }
        guard let secKey = SecKeyCreateWithData(secKeyData as CFData, attributes as CFDictionary, nil) else {
            print("Error: Problem in SecKeyCreateWithData()")
            return nil
        }

        return secKey
    }
    
}
