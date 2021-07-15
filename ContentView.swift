//
//  ContentView.swift
//  RX Identify
//
//  Created by Danny Kong on 7/1/21.
//
import Foundation
import SwiftUI
import UIKit
import Vision
import VisionKit

struct ContentView: View {
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var pillData: Pill?
    @ObservedObject var myRequest: TextRequest = TextRequest.sharedInstance
    @State var mainText = "Description..."
    @State var mainImage = "charizard"
    
    var body: some View {
        GeometryReader{ geo in
            VStack{
                
                Image(uiImage: self.image)
                
                    .resizable()
                    .scaledToFit()
                    .frame(width:geo.size.width, height: geo.size.height*0.33,alignment: .center)
                
                ScrollView {
                    Text(mainText)
                        .fixedSize(horizontal: false, vertical: true)
                }.padding()
                
                HStack {
                    Button("SCAN", action:{
                       
                        myRequest.recognizeText(image: self.image)
                        mainText = myRequest.text
                       
                    })
                    .background(Color.blue)
                    .foregroundColor(.black)
                    .cornerRadius(5)
                    Spacer()
                    Button(action: {
                        self.isShowPhotoLibrary = true
                    }) {
                        Image(systemName: "camera")
                    }
                }
                .padding()
                .font(.title)
                
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(selectedImage: self.$image, sourceType: .camera)
            }
        }
    }
} 


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


