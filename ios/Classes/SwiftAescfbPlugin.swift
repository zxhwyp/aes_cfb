import Flutter
import UIKit
import CryptoSwift

public class SwiftAescfbPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "aescfb", binaryMessenger: registrar.messenger())
    let instance = SwiftAescfbPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let arguments = (call.arguments as? Dictionary<String, String>) ?? [String: String]()
    let value = arguments["value"]
    let key = arguments["key"]

    switch call.method {
    case "encrypt":
        let resultValue = try! value?.aesEncrypt(key: key!)
        result(resultValue)
        break
    case "dencrypt":
        let resultValue = try! value?.aesDecrypt(key: key!)
        result(resultValue)
        break
    default:result(nil)
        break
        
    }
  }
}


extension String {

func aesEncrypt(key: String) throws -> String {

    let data: Array<UInt8> = (self.data(using: .utf8)?.bytes)!
    let key: Array<UInt8> = (key.data(using: .utf8)?.bytes)!
    let iv: Array<UInt8> = Array(key.prefix(16))

    do {
        let encrypted = try AES(key: key, blockMode: CFB(iv: iv), padding: .noPadding).encrypt(data)
        let encryptedData = Data(encrypted)
        let decrypted = try AES(key: key, blockMode: CFB(iv: iv), padding: .noPadding).decrypt(encrypted)
        let decryptedData = Data(decrypted)
        let str = String.init(data: decryptedData, encoding: .utf8)
        print(str ?? String())
        return encryptedData.base64EncodedString()

    } catch {
        print(error)
        return "error"
    }
}

func aesDecrypt(key: String) throws -> String {

    let data: Array<UInt8> = (Data(base64Encoded: self)?.bytes)!
    let key: Array<UInt8> = (key.data(using: .utf8)?.bytes)!
    let iv: Array<UInt8> = Array(key.prefix(16))



    do {
        let decrypted = try AES(key: key, blockMode: CFB(iv: iv), padding: .noPadding).decrypt(data)
        let decryptedData = Data(decrypted)
        guard let value = String.init(data: decryptedData, encoding: .utf8) else {
            return "error"
        }
        return value

    } catch {
        print(error)
        return "error"
        }
    }
}
