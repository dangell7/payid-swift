//
//  PayIDValidatorService.swift
//  Tabs
//
//  Created by Denis Angell on 8/5/20.
//  Copyright © 2020 Harp Angell. All rights reserved.
//

import web3swift
import XRPKit
import BigInt
import JOSESwift


protocol GenerateIdentityServiceDelegate: class {
    func generateIdentitySuccess()
    func generateIdentityFailure(error: Error?)
}

protocol ValidateIdentityServiceDelegate: class {
    func validateIdentitySuccess()
    func validateIdentityFailure(error: Error?)
}

struct UnsignedVerifiedAddress {
    public var payId: String?
    public var payIdAddress: PayIDAddress?
    
    init(payId: String, payIdAddress: PayIDAddress) {
        self.payId = payId
        self.payIdAddress = payIdAddress
    }
    
    func toDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["payId"] = payId
        dict["payIdAddress"] = payIdAddress?.toDict()
        return dict
    }
}

class PayIDValidatorService {
    weak var generateIdentityDelegate: GenerateIdentityServiceDelegate?
    weak var validateIdentityDelegate: ValidateIdentityServiceDelegate?
    
    
    func sign(payId: String, address: PayIDAddress, signingParams: Any) -> JWS? {
//      if let params = signingParams as? ServerKeySigningParams {
//        return signWithServerKey(payId, address, params)
//      }
        return signWithIdentityKey(
            payId: payId,
            address: address,
            signingParams: signingParams as! IdentityKeySigningParams
        )
    }
    
    func signWithIdentityKey(
        payId: String,
        address: PayIDAddress,
        signingParams: IdentityKeySigningParams
    ) -> JWS? {
        do {
            let unsigned: [String: Any] = UnsignedVerifiedAddress(
                payId: payId,
                payIdAddress: address
            ).toDict()
            
            print(try signingParams.key?.ecPublicKeyComponents())
            let signor = Signer(signingAlgorithm: .ES256, privateKey: signingParams.key)
            print(signor)
            
            let publicKey = try signingParams.key?.ecPublicKeyComponents()
            var protectedHeaders: [String: Any] = [:]
            protectedHeaders["name"] = "identityKey"
            protectedHeaders["alg"] = signingParams.alg.rawValue
            protectedHeaders["typ"] = "JOSE+JSON"
            protectedHeaders["b64"] = false
            protectedHeaders["crit"] = ["b64"]
            protectedHeaders["jwk"] = publicKey
            let header = try JWSHeader(parameters: protectedHeaders)
            guard let message = try? JSONSerialization.data(withJSONObject: unsigned, options: .prettyPrinted) else { return nil }
            let payload = Payload(message)
            let jws = try JWS(header: header, payload: payload, signer: signor!)
            
            return jws
        } catch {
            print(error)
            return nil
        }
    }
    
    func signWithServerKey(
        payId: String,
        address: PayIDAddress,
        signingParams: ServerKeySigningParams
    ) {
        print()
    }
    
    func generateIdentity(payId: String) {
        
    }
    
    func validateIdentity(payId: String) {
        
    }
}
