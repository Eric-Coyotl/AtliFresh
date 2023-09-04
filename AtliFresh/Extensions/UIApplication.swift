//
//  UIApplication.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 8/31/23.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
