//
//  ServerKeySigningParams.swift
//  beattheline
//
//  Created by Denis Angell on 8/6/20.
//  Copyright © 2020 Harp Angell. All rights reserved.
//

import Foundation
import JOSESwift

struct ServerKeySigningParams {
    
    public var keyType: String = "serverKey"
    public var key: SecKey?
    public var alg: SignatureAlgorithm = .ES256
    public var x5c: SecKey?
    
    init(key: SecKey, alg: SignatureAlgorithm, x5c: SecKey) {
        self.key = key
        self.alg = alg
        self.x5c = x5c
    }
}
