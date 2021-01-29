//
//  MUFlipTransitioning.swift
//  NcSejima
//
//  Created by Damien Noël Dubuisson on 15/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//
// See: https://github.com/ColinEberhardt/VCTransitionsLibrary
// => ./AnimationControllers/CETurnAnimationController.m
//

import UIKit

open class MUFlipTransitioning: MUAnimatedTransitioning {
    public let isHorizontal: Bool

    public init(duration: TimeInterval, reverse: Bool = false, isHorizontal: Bool) {
        self.isHorizontal = isHorizontal
        super.init(duration: duration, reverse: reverse)
    }

    override open func animateTransition(using transitionContext: UIViewControllerContextTransitioning,
                                         from: UIViewController,
                                         to: UIViewController) {
        // Add the to.view to the container
        let containerView = transitionContext.containerView
        containerView.addSubview(to.view)

        // Add a perspective transform
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform

        // Give both VCs the same start frame
        let initialFrame = transitionContext.initialFrame(for: from)
        from.view.frame = initialFrame
        to.view.frame = initialFrame

        // Setup the rotation's matrix
        let factor: CGFloat = reverse ? 1.0 : -1.0
        let x: CGFloat = isHorizontal ? 0.0 : 1.0
        let y: CGFloat = isHorizontal ? 1.0 : 0.0

        // Flip the to VC halfway round - hiding it
        to.view.layer.transform = CATransform3DMakeRotation(factor * -CGFloat.pi / 2.0, x, y, 0.0)

        // Animate
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0.0,
                                options: UIView.KeyframeAnimationOptions(rawValue: 0),
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                // Rotate the from.view
                from.view.layer.transform = CATransform3DMakeRotation(factor * CGFloat.pi / 2.0, x, y, 0.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                // rotate the to.view
                to.view.layer.transform = CATransform3DMakeRotation(0.0, x, y, 0.0)
            })
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
