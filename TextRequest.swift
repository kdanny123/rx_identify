//
//  TextRequest.swift
//  RX Identify
//
//  Created by Danny Kong on 7/7/21.
//

import Foundation
import Vision
import VisionKit


class TextRequest: ObservableObject {
    @Published var text: String = ""
    static let sharedInstance = TextRequest()
    
    
    func recognizeText(image: UIImage?) {
        
        guard let cgImage = image?.cgImage else {
            self.text = "Unable to capture image input"
            print("Unable to capture image input")
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest {request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                DispatchQueue.main.async {
                    
                }
                return
            }
            
            let recognizedStrings = observations.compactMap({observation in
                return observation.topCandidates(1).first?.string
            }).joined()
            
            self.text = recognizedStrings
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        do {
            try requestHandler.perform([request])
        } catch {
            print(error)
        }
        
        
    }
}
