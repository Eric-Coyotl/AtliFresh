//
//  ImagePicker.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 10/21/23.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var didSelectImage: Bool
    
    @EnvironmentObject private var vm: LocationsViewModel
        
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else {
                print("No Image Found")
                return
            }
                   
            print(image.size)
            parent.selectedImage = image
            parent.vm.showImagePicker = false
            parent.vm.showUploadView = true
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
            parent.vm.showImagePicker = false
        }
    }
}
