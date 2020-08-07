//
//  payid_admin_swiftTests.swift
//  payid-admin-swiftTests
//
//  Created by Denis Angell on 8/5/20.
//  Copyright © 2020 Angell Enterprises. All rights reserved.
//

import XCTest
@testable import payid_admin_swift
import JOSESwift

extension String {
    public static let payId = "denis$virtualtabs.org"
    public static let paymentNetwork = "ETH"
    public static let environment = "ROPSTEN"
    public static let addressDetailsType = "CryptoAddressDetails"
    public static let ethAddress = ""
}

class payid_admin_swiftTests: XCTestCase {
    
    var payIDService = PayIDValidatorService()
    var address: PayIDAddress = PayIDAddress(
        paymentNetwork: .paymentNetwork,
        environment: PayIDEnvironment(rawValue: .environment)!,
        addressDetailsType: PayIDAddressType(rawValue: .addressDetailsType)!,
        addressDetails: ["address": .ethAddress]
    )
    
    func testGenerateETHPayIDIdentityKey() {
        do {
            print()
//            let params = IdentityKeySigningParams(privateKey: pk, alg: .ES256)
//            print(try params.key?.ecPublicKeyComponents())
//            let jws = payIDService.sign(payId: .payId, address: address, signingParams: params)
            

    //        let expectedPayload = "{"payId":"alice$payid.example","payIdAddress":{"environment":"TESTNET","paymentNetwork":"XRPL","addressDetailsType":"CryptoAddressDetails","addressDetails":{"address":"rP3t3JStqWPYd8H88WfBYh3v84qqYzbHQ6"}}}"

    //        XCTAssertEqual(jws.payload, expectedPayload)
    //        XCTAssertEqual(jws.signatures.length, 1)
    //        XCTAssertTrue(verifySignedAddress(payId, jws))
        } catch {
            print(error)
        }
        
    }

//    func testSignedPayIDReturnsJWS() {
//        let key = ECPublicKey(crv: .P256, x: "", y: "")
//        let params = IdentityKeySigningParams(key: key, alg: .ES256)
//        let jws = payIDService.sign(payId, address, params)
//
////        let expectedPayload = "{"payId":"alice$payid.example","payIdAddress":{"environment":"TESTNET","paymentNetwork":"XRPL","addressDetailsType":"CryptoAddressDetails","addressDetails":{"address":"rP3t3JStqWPYd8H88WfBYh3v84qqYzbHQ6"}}}"
//
//        XCTAssertEqual(jws.payload, expectedPayload)
//        XCTAssertEqual(jws.signatures.length, 1)
////        XCTAssertTrue(verifySignedAddress(payId, jws))
//    }

}
