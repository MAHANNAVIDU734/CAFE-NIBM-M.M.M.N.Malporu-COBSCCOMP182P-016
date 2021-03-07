// The MIT License (MIT)
// Copyright © 2020 Ivan Vorobei (hello@ivanvorobei.by)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(iOS) && SPPERMISSION_BLUETOOTH

import UIKit
import CoreBluetooth

class SPBluetoothPermission: NSObject, SPPermissionProtocol {
    
    typealias SPBluetoothPermissionHandler = ()->()?
    private var completion: SPBluetoothPermissionHandler?
    private var manager: CBCentralManager?
    
    var isAuthorized: Bool {
        if #available(iOS 13.0, *) {
            return CBCentralManager().authorization == .allowedAlways
        }
        return CBPeripheralManager.authorizationStatus() == .authorized
    }
    
    var isDenied: Bool {
        if #available(iOS 13.0, *) {
            return CBCentralManager().authorization == .denied
        }
        return CBPeripheralManager.authorizationStatus() == .denied
    }
    
    func request(completion: @escaping ()->()?) {
        self.completion = completion
        self.manager = CBCentralManager(delegate: self, queue: nil, options: [:])
    }
}

extension SPBluetoothPermission: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if #available(iOS 13.0, *) {
            switch central.authorization {
            case .notDetermined:
                break
            default:
                self.completion?()
            }
        } else {
            switch CBPeripheralManager.authorizationStatus() {
            case .notDetermined:
                break
            default:
                self.completion?()
            }
        }
    }
    
}

#endif
