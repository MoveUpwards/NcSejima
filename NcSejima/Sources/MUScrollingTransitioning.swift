//
//  MUScrollingTransitioning.swift
//  NcSejima
//
//  Created by Damien Noël Dubuisson on 23/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

public enum MUScrollingTransitioningDirection {
    case rightToLeft
    case leftToRight
    case bottomToTop
    case topToBottom
}

open class MUScrollingTransitioning: MUAnimatedTransitioning {
    public let direction: MUScrollingTransitioningDirection

    public init(duration: TimeInterval, reverse: Bool = false, direction: MUScrollingTransitioningDirection) {
        self.direction = direction
        super.init(duration: duration, reverse: reverse)
    }

    override open func animateTransition(using transitionContext: UIViewControllerContextTransitioning,
                                         from: UIViewController,
                                         to: UIViewController) {
        var width = to.view.bounds.width
        var height = to.view.bounds.height

        switch direction {
        case .rightToLeft:
            height = 0.0
        case .leftToRight:
            width *= -1.0
            height = 0.0
        case .bottomToTop:
            width = 0.0
        case .topToBottom:
            width = 0.0
            height *= -1.0
        }

        if reverse {
            width *= -1.0
            height *= -1.0
        }

        transitionContext.containerView.addSubview(to.view)
        to.view.transform = CGAffineTransform(translationX: width, y: height)

        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 1.2,
                       initialSpringVelocity: 2.5,
                       options: .overrideInheritedOptions,
                       animations: {
                        to.view.transform = .identity
                        from.view.transform = CGAffineTransform(translationX: -width, y: -height)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            from.view.transform = .identity
        })
    }
}
