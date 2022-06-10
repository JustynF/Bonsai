//
//  TouchLocatingUIView.swift
//  bonsai
//
//  Created by justyn on 2022-05-30.
//

import UIKit



class TouchLocatingUIView: UIView {
    // Internal copies of our settings
    var onUpdate: ((CGPoint) -> Void)?
    var touchTypes: TouchLocatingView.TouchType = .all
    var limitToBounds = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
    }

    // init for storyboards
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isUserInteractionEnabled = true
    }

    // Triggered when a touch starts.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        send(location, forEvent: .started)
    }

    // Triggered when an existing touch moves.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        send(location, forEvent: .moved)
    }

    // Triggered when the user lifts a finger.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        send(location, forEvent: .ended)
    }


    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        send(location, forEvent: .ended)
    }

    // Send a touch location only if the user asked for it
    func send(_ location: CGPoint, forEvent event: TouchLocatingView.TouchType) {
        guard touchTypes.contains(event) else {
            return
        }

        if limitToBounds == false || bounds.contains(location) {
            onUpdate?(CGPoint(x: round(location.x), y: round(location.y)))
        }
    }
}
