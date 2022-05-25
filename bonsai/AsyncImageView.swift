//
//  AsyncImageView.swift
//  bonsai
//
//  Created by justyn on 2022-05-19.
//
import SwiftUI
import Foundation

struct ImageLoaderKey: EnvironmentKey {
    static let defaultValue = ImageLoader()
}

extension EnvironmentValues {
    var imageLoader: ImageLoader {
        get { self[ImageLoaderKey.self] }
        set { self[ImageLoaderKey.self ] = newValue}
    }
}
