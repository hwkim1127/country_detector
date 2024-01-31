import Flutter
import UIKit
#if canImport(CoreTelephony)
import CoreTelephony
#endif

public class CountryDetectorPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "country_detector", binaryMessenger: registrar.messenger())
        let instance = CountryDetectorPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isoCountryCode":
            result(getCountryCode())
        case "detectAll":
            var allCodes: [String: String] = [:]
            if let countryCodeFromSim = getCountryCodeFromSim() {
                allCodes["sim"] = countryCodeFromSim.uppercased()
            } else {
                allCodes["sim"] = ""
            }
            if let networkCountryCode = getNetworkCountryCode() {
                allCodes["network"] = networkCountryCode.uppercased()
            } else {
                allCodes["network"] = ""
            }
            allCodes["locale"] = NSLocale.current.regionCode ?? ""
            result(allCodes)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func getCountryCodeFromSim() -> String? {
#if canImport(CoreTelephony)
        if #available(iOS 12, *) {
            let networkInfos = CTTelephonyNetworkInfo()
            let carrier = networkInfos.serviceSubscriberCellularProviders?
                .map { $0.1 }
                .first { $0.isoCountryCode != nil }
            return carrier?.isoCountryCode
            // if let info = networkInfos.serviceSubscriberCellularProviders, let carrier1 = info["0000000100000001"], let carrier2 = info["0000000100000002"] {
            //     // print(carrier1.mobileCountryCode)
            //     // print(carrier1.isoCountryCode)
            //     // print(carrier2.mobileCountryCode)
            //     // print(carrier2.isoCountryCode)
            //     return carrier1?.isoCountryCode
            // }
        }
        return nil
#else
        return nil
#endif
    }
    
    func getNetworkCountryCode() -> String? {
#if canImport(CoreTelephony)
        let networkInfos = CTTelephonyNetworkInfo()
        return networkInfos.subscriberCellularProvider?.isoCountryCode
#else
        return nil
#endif
    }
    
    func getCountryCode() -> String {
        var countryCode = getCountryCodeFromSim() ?? ""
        if countryCode.isEmpty || countryCode == "--" {
            countryCode = getNetworkCountryCode() ?? ""
        }
        if countryCode.isEmpty || countryCode == "--" {
            countryCode = NSLocale.current.regionCode ?? ""
        }
        return countryCode.uppercased()
    }
}

