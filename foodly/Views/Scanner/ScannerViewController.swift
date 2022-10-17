//
//  ScannerViewController.swift
//  foodly
//
//  Created by Sergei Kulagin on 19.10.2022.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    // Настроить сессию
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.setupVideo()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.startSessionRunning()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.stopSessionRunning()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "scannedProduct") {
            let nav = segue.destination as! UINavigationController
            let scannedProduct = nav.topViewController as! ProductViewController
            scannedProduct.productCode = sender as! String
        }
    }
    
    func startSessionRunning() {
        self.view.layer.addSublayer(self.video)
        self.session.startRunning()
    }
    
    func stopSessionRunning() {
        session.stopRunning()
    }
    
    func setupVideo() {

        // Настроить устройство видео
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        // Настроить input
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            fatalError(error.localizedDescription)
        }
        // Настроить output
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        // Экран видео
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject{
            if object.type == AVMetadataObject.ObjectType.ean8 || object.type == AVMetadataObject.ObjectType.ean13 || object.type == AVMetadataObject.ObjectType.pdf417 {
                guard let stringValue = object.stringValue else {
                    return
                }
                let alert = UIAlertController(title: "Code", message: object.stringValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Incorrect", style: .default, handler: {(action) in
                    return
                }))
                alert.addAction(UIAlertAction(title: "Details", style: .default, handler: {(action) in
        //                    UIPasteboard.general.string = object.stringValue
        //                    session.stopRunning()
//                    print(stringValue)
                    let service = APIService()
                    var errorMsg = String()
                    service.getProduct(codeNumber: object.stringValue!, url: service.url) { [unowned self] result in
                        DispatchQueue.main.async {
                            switch result {
                            case .failure(let error):
                                errorMsg = error.localizedDescription
                                print("--------------------------------------------------------")
                                print("error: \(error.localizedDescription)")
                                print("--------------------------------------------------------")
                                let errorAlert = UIAlertController(title: "Error", message: "An error occurred while scanning.", preferredStyle: .alert)
                                errorAlert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {(action) in
                                    return
                                }))
                                self.present(errorAlert, animated: true, completion: nil)
                                break
                            case .success(let productResponse):
                                print("--------------------------------------------------------")
                                print("checking: \(productResponse)")
                                print("--------------------------------------------------------")
                                guard productResponse.data != nil else {
                                    let errorAlert = UIAlertController(title: "Product: \(object.stringValue!) was not found", message: "An error occurred while scanning.", preferredStyle: .alert)
                                    errorAlert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {(action) in
                                        return
                                    }))
                                    self.present(errorAlert, animated: true, completion: nil)
                                    break
                                }
                                guard productResponse.message == nil else {
                                    let errorAlert = UIAlertController(title: "Error", message: "\(productResponse.message)", preferredStyle: .alert)
                                    errorAlert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {(action) in
                                        return
                                    }))
                                    self.present(errorAlert, animated: true, completion: nil)
                                    break
                                }
                                self.performSegue(withIdentifier: "scannedProduct", sender: stringValue)
                                break
                            }
                        }
                    }
                }))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
