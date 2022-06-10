//
//  TouchLocatingView.swift
//  bonsai
//
//  Created by justyn on 2022-05-24.
//
import SwiftUI
import UIKit
import Foundation

struct TouchLocatingView: UIViewRepresentable {
    struct TouchType: OptionSet {
        let rawValue: Int

        static let started = TouchType(rawValue: 1 << 0)
        static let moved = TouchType(rawValue: 1 << 1)
        static let ended = TouchType(rawValue: 1 << 2)
        static let all: TouchType = [.started, .moved, .ended]
    }

    var onUpdate: (CGPoint) -> Void
    var types = TouchType.all
    var limitToBounds = true

    func makeUIView(context: Context) -> TouchLocatingUIView {
        let view = TouchLocatingUIView()
        view.onUpdate = onUpdate
        view.touchTypes = types
        view.limitToBounds = limitToBounds
        return view
    }

    func updateUIView(_ uiView: TouchLocatingUIView, context: Context) {
    }


}

struct TouchLocater: ViewModifier {
    var type: TouchLocatingView.TouchType = .all
    var limitToBounds = true
    let perform: (CGPoint) -> Void

    func body(content: Content) -> some View {
        content
            .overlay(
                TouchLocatingView(onUpdate: perform, types: type, limitToBounds: limitToBounds)
            )
    }
}

