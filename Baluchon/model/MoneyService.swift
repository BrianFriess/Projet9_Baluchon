//
//  MoneyService.swift
//  Baluchon
//
//  Created by Brian Friess on 04/06/2021.
//

import Foundation

protocol MoneyServiceProtocol {
    func getMoney(completion : @escaping(Result<DataMoneyDecodable,MoneyError>) -> Void)
}

enum MoneyError : Error{
    case errorMoney
    case errorDownload
    case errorDecode
}

protocol UrlProtocol{
    var url : String { get }
}

struct UrlObject : UrlProtocol{
    var url = "http://data.fixer.io/api/latest?access_key=2abf4e43c6ec1902e28ad6aa3e3b47b4"
    
}

class MoneyService : MoneyServiceProtocol{
    
    //we create an UrlSession
    private var session : URLSession
    
    private var urlObject : UrlProtocol

    //we create an init for session
    init (session : URLSession, url : UrlProtocol){
        self.session = session
        self.urlObject = url
    }
    
    //this is our network call
    func getMoney(completion : @escaping(Result<DataMoneyDecodable,MoneyError>) -> Void){
        
        guard let moneyUrl = URL(string: urlObject.url) else{
            completion(.failure(.errorMoney))
            return
        }
        //we create our task with our moneyUrl
        let task = session.dataTask(with: moneyUrl) { (data, response, error) in
            DispatchQueue.main.async {
                // we check if our response is ok
                guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    completion(.failure(.errorDownload))
                    return
                }
                
                //we retrieve the data we need in the JSON
                guard let responseJSON = try? JSONDecoder().decode(DataMoneyDecodable.self, from : data) else{
                    completion(.failure(.errorDecode))
                    return
                }
                completion(.success(responseJSON))
            }
        }
        task.resume()
    }
}


struct DataMoneyDecodable : Decodable, Equatable{
    var rates : CurrencyDecodable?
}

struct CurrencyDecodable : Decodable, Equatable{
    
    //we use this function for return a value in our data
    func getValue(_ value : String) -> Double?{
        switch value{
        case "USD":
            return USD
        case "JPY":
            return JPY
        case "RUB":
            return RUB
        default:
            return 0.0
        }
    }
           var AED : Double?
           var AFN : Double?
           var ALL : Double?
           var AMD : Double?
           var ANG : Double?
           var AOA : Double?
           var ARS : Double?
           var AUD : Double?
           var AWG : Double?
           var AZN : Double?
           var BAM : Double?
           var BBD : Double?
           var BDT : Double?
           var BGN : Double?
           var BHD : Double?
           var BIF : Double?
           var BMD : Double?
           var BND : Double?
           var BOB : Double?
           var BRL : Double?
           var BSD : Double?
           var BTC : Double?
           var BTN : Double?
           var BWP : Double?
           var BYN : Double?
           var BYR : Double?
           var BZD : Double?
           var CAD : Double?
           var CDF : Double?
           var CHF : Double?
           var CLF : Double?
           var CLP : Double?
           var CNY : Double?
           var COP : Double?
           var CRC : Double?
           var CUC : Double?
           var CUP : Double?
           var CVE : Double?
           var CZK : Double?
           var DJF : Double?
           var DKK : Double?
           var DOP : Double?
           var DZD : Double?
           var EGP : Double?
           var ERN : Double?
           var ETB : Double?
           var EUR : Double?
           var FJD : Double?
           var FKP : Double?
           var GBP : Double?
           var GEL : Double?
           var GGP : Double?
           var GHS : Double?
           var GIP : Double?
           var GMD : Double?
           var GNF : Double?
           var GTQ : Double?
           var GYD : Double?
           var HKD : Double?
           var HNL : Double?
           var HRK : Double?
           var HTG : Double?
           var HUF : Double?
           var IDR : Double?
           var ILS : Double?
           var IMP : Double?
           var INR : Double?
           var IQD : Double?
           var IRR : Double?
           var ISK : Double?
           var JEP : Double?
           var JMD : Double?
           var JOD : Double?
           var JPY : Double?
           var KES : Double?
           var KGS : Double?
           var KHR : Double?
           var KMF : Double?
           var KPW : Double?
           var KRW : Double?
           var KWD : Double?
           var KYD : Double?
           var KZT : Double?
           var LAK : Double?
           var LBP : Double?
           var LKR : Double?
           var LRD : Double?
           var LSL : Double?
           var LTL : Double?
           var LVL : Double?
           var LYD : Double?
           var MAD : Double?
           var MDL : Double?
           var MGA : Double?
           var MKD : Double?
           var MMK : Double?
           var MNT : Double?
           var MOP : Double?
           var MRO : Double?
           var MUR : Double?
           var MVR : Double?
           var MWK : Double?
           var MXN : Double?
           var MYR : Double?
           var MZN : Double?
           var NAD : Double?
           var NGN : Double?
           var NIO : Double?
           var NOK : Double?
           var NPR : Double?
           var NZD : Double?
           var OMR : Double?
           var PAB : Double?
           var PEN : Double?
           var PGK : Double?
           var PHP : Double?
           var PKR : Double?
           var PLN : Double?
           var PYG : Double?
           var QAR : Double?
           var RON : Double?
           var RSD : Double?
           var RUB : Double?
           var RWF : Double?
           var SAR : Double?
           var SBD : Double?
           var SCR : Double?
           var SDG : Double?
           var SEK : Double?
           var SGD : Double?
           var SHP : Double?
           var SLL : Double?
           var SOS : Double?
           var SRD : Double?
           var STD : Double?
           var SVC : Double?
           var SYP : Double?
           var SZL : Double?
           var THB : Double?
           var TJS : Double?
           var TMT : Double?
           var TND : Double?
           var TOP : Double?
           var TRY : Double?
           var TTD : Double?
           var TWD : Double?
           var TZS : Double?
           var UAH : Double?
           var UGX : Double?
           var USD : Double?
           var UYU : Double?
           var UZS : Double?
           var VEF : Double?
           var VND : Double?
           var VUV : Double?
           var WST : Double?
           var XAF : Double?
           var XAG : Double?
           var XAU : Double?
           var XCD : Double?
           var XDR : Double?
           var XOF : Double?
           var XPF : Double?
           var YER : Double?
           var ZAR : Double?
           var ZMK : Double?
           var ZMW : Double?
           var ZWL : Double?
}
