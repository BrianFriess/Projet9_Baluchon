//
//  FakeResponseDataMoney.swift
//  BaluchonTests
//
//  Created by Brian Friess on 22/06/2021.
//

import Foundation

@testable import Baluchon

class FakeResponseDataMoney{
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "http://data.fixer.io")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    

    static let responseKO = HTTPURLResponse(
        url: URL(string: "http://data.fixer.io")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class MoneyError: Error {}
    static let error = MoneyError()
    
    static var moneyCorrectData: Data?{
        let bundle = Bundle(for: FakeResponseDataMoney.self)
        let url = bundle.url(forResource: "money", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let moneyIncorrectData = "erreur".data(using: .utf8)!
    
    static let moneyData : DataMoneyDecodable = .init(rates: .init(AED: 4.373455, AFN: 93.456215, ALL: 122.694994, AMD: 610.881538, ANG: 2.136907, AOA: 773.56304, ARS: 113.706639, AUD: 1.582098, AWG: 2.143746, AZN: 2.037781, BAM: 1.957703, BBD: 2.403771, BDT: 100.945384, BGN: 1.9567, BHD: 0.448853, BIF: 2357.465605, BMD: 1.190639, BND: 1.603034, BOB: 8.220165, BRL: 5.965934, BSD: 1.190474, BTC: 3.786534e-5, BTN: 88.506282, BWP: 12.996817, BYN: 3.022592, BYR: 23336.528215, BZD: 2.399667, CAD: 1.473351, CDF: 2380.088025, CHF: 1.095709, CLF: 0.032362, CLP: 892.97934, CNY: 7.716768, COP: 4508.95063, CRC: 737.197015, CUC: 1.190639, CUP: 31.551939, CVE: 110.69368, CZK: 25.51754, DJF: 211.939012, DKK: 7.436491, DOP: 67.925925, DZD: 159.522133, EGP: 18.66839, ERN: 17.861968, ETB: 51.578828, EUR: 1, FJD: 2.476223, FKP: 0.843976, GBP: 0.855552, GEL: 3.750527, GGP: 0.843976, GHS: 6.917341, GIP: 0.843976, GMD: 60.90154, GNF: 11715.889442, GTQ: 9.208481, GYD: 248.845408, HKD: 9.247278, HNL: 28.635116, HRK: 7.502339, HTG: 108.364868, HUF: 350.994483, IDR: 17240.157879, ILS: 3.882281, IMP: 0.843976, INR: 88.56748, IQD: 1740.119183, IRR: 50131.863593, ISK: 146.413199, JEP: 0.843976, JMD: 178.71199, JOD: 0.844154, JPY: 131.893071, KES: 128.330766, KGS: 100.685695, KHR: 4845.90164, KMF: 491.674514, KPW: 1071.575692, KRW: 1354.500902, KWD: 0.358763, KYD: 0.992149, KZT: 509.157158, LAK: 11287.259322, LBP: 1820.702191, LKR: 236.604782, LRD: 203.986293, LSL: 16.942814, LTL: 3.515648, LVL: 0.720206, LYD: 5.363839, MAD: 10.610379, MDL: 21.429804, MGA: 4476.803122, MKD: 61.684019, MMK: 1959.503939, MNT: 3388.557093, MOP: 9.522011, MRO: 425.057988, MUR: 48.756882, MVR: 18.407707, MWK: 940.605232, MXN: 24.49508, MYR: 4.938176, MZN: 75.141051, NAD: 16.942478, NGN: 489.805244, NIO: 41.969599, NOK: 10.210826, NPR: 141.610492, NZD: 1.700822, OMR: 0.458412, PAB: 1.190574, PEN: 4.728626, PGK: 4.179195, PHP: 58.015683, PKR: 187.890518, PLN: 4.523202, PYG: 8058.447148, QAR: 4.335062, RON: 4.926272, RSD: 117.672588, RUB: 87.063939, RWF: 1172.779607, SAR: 4.465028, SBD: 9.521343, SCR: 18.46571, SDG: 523.286732, SEK: 10.126428, SGD: 1.60291, SHP: 0.843976, SLL: 12215.957939, SOS: 696.523464, SRD: 25.067124, STD: 24299.155393, SVC: 10.417273, SYP: 1497.635624, SZL: 16.942383, THB: 37.789693, TJS: 13.577291, TMT: 4.179144, TND: 3.296286, TOP: 2.680784, TRY: 10.317007, TTD: 8.09168, TWD: 33.376356, TZS: 2761.092015, UAH: 32.586178, UGX: 4232.27382, USD: 1.190639, UYU: 52.177923, UZS: 12627.919398, VEF: 254594643716.78604, VND: 27417.444055, VUV: 129.113872, WST: 3.00276, XAF: 656.585216, XAG: 0.046273, XAU: 0.000671, XCD: 3.217762, XDR: 0.834198, XOF: 657.827539, XPF: 119.719008, YER: 297.659389, ZAR: 17.076683, ZMK: 10717.179505, ZMW: 26.887416, ZWL: 383.386215))
   
}


struct UrlObjectMock : UrlProtocol{
    var url : String
    
    init (url : String){
        self.url = url
    }
}
