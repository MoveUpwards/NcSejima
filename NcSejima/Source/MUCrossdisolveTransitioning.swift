//
//  MUCrossdisolveTransitioning.swift
//  NcSejima
//
//  Created by Damien Noël Dubuisson on 12/11/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//
// See: https://github.com/ColinEberhardt/VCTransitionsLibrary
// => ./AnimationControllers/CECrossfadeAnimationController.m
//

import UIKit

open class MUCrossdisolveTransitioning: MUAnimatedTransitioning {
    override open func animateTransition(using transitionContext: UIViewControllerContextTransitioning,
                                         from: UIViewController,
                                         to: UIViewController) {
        // Add the to.view to the container
        let containerView = transitionContext.containerView
        to.view.frame = transitionContext.finalFrame(for: to)
        containerView.addSubview(to.view)
        containerView.sendSubviewToBack(to.view)

        // Animate
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            from.view.alpha = 0.0
        }, completion: { _ in
            let didComplete = !transitionContext.transitionWasCancelled
            from.view.alpha = 1.0
            if didComplete {
                // Reset from.view to its original state
                from.view.removeFromSuperview()
            }
            transitionContext.completeTransition(didComplete)
        })
    }
}
