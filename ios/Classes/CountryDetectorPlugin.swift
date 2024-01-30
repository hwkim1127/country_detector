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
                allCodes["sim"] = countryCodeFromSim
            } else {
                allCodes["sim"] = ""
            }
            if let networkCountryCode = getNetworkCountryCode() {
                allCodes["network"] = networkCountryCode
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
        let networkInfos = CTTelephonyNetworkInfo()
        if #available(iOS 12, *) {
            let carrier = networkInfos.serviceSubscriberCellularProviders?
                .map { $0.1 }
                .first { $0.isoCountryCode != nil }
            return carrier?.isoCountryCode
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
        let countryCode = getCountryCodeFromSim() ?? getNetworkCountryCode() ?? ""
        return countryCode.isEmpty ? (NSLocale.current.regionCode ?? "") : countryCode
    }
}

