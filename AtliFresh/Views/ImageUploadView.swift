//
//  ImageUploadView.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 11/3/23.
//

import SwiftUI
import Mantis

struct ImageUploadView: View {
    @EnvironmentObject private var vm: LocationsViewModel

    let creamColor = Color("BackColor")
    let accentColor = Color("AccentColor")
    
    @State private var showCamera = false
    @State private var showingCropper = false

    @Binding var cropImage: UIImage?
    
    @State private var cropShapeType: Mantis.CropShapeType = .rect
    @State private var presetFixedRatioType: Mantis.PresetFixedRatioType = .canUseMultiplePresetFixedRatio()
    @State private var cropperType: ImageCropperType = .noRotaionDial

    var body: some View {
        ZStack{
            Color(UIColor.systemBackground).ignoresSafeArea()
            createImageHolder()
        }
        .sheet(isPresented: $showingCropper) {
            ImageCropper(image: $cropImage, cropShapeType: $cropShapeType, presetFixedRatioType: $presetFixedRatioType , type: $cropperType)
                .ignoresSafeArea(.all)
        }
        .fullScreenCover(isPresented: $showCamera){
            CameraView(image: $cropImage)
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    @State var image: UIImage? = UIImage(named: "sea-town-1")!
    return ImageUploadView(cropImage: $image)
        .environmentObject(LocationsViewModel())

}

extension ImageUploadView{
    func createImageHolder() -> some View {
        VStack {
            Spacer()
            Image(uiImage: cropImage!)
                .resizable().aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 350, alignment: .center)
            VStack {
                Button {
                } label: {
                    Text("Upload Image")
                }
                .buttonStyle(ThemeButton(
                    backColor: Color("AccentColor"),
                textColor: Color(UIColor.systemBackground),
                    buttonWidth: 220))
                
                labelDivider(label: "or",
                             horizontalPadding: 10,
                             color: Color.primary)
                .padding(.horizontal, 20)
                HStack{
                    Group{
                        Button {
                            showCamera = true
                        } label: {
                            Text("Retake Image")
                        }
                        Button {
                            showingCropper = true
                        } label: {
                            Text("Crop Image")
                        }
                    }
                    .buttonStyle(ThemeButton(
                        backColor: Color("BackColor"),
                        textColor: Color(UIColor.systemBrown),
                    buttonWidth: 170))
                }
                Button {
                    vm.showUploadView = false
                } label: {
                    Text("Cancel")
                        .font(.title2)
                }
                .padding(.top, 60)
            }
            Spacer()
        }
    }
}
