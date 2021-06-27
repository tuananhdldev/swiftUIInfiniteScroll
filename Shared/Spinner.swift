//
//  Spinner.swift
//  InfiniteScrollingSwiftUI
//
//  Created by Tuan Hoang Anh on 6/24/21.
//

import SwiftUI
#if !os(macOS)
import UIKit


struct Spinner: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    func makeUIView(context: Context) -> UIActivityIndicatorView{
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}
  
#endif

