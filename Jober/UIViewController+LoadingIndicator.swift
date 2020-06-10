//
//  UIViewController+LoadingIndicator.swift
//  Jober
//
//  Created by Denis Sychev on 28/04/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import UIKit

var vSpinner: UIView?

extension UIViewController {
    func showSpinner(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        let activityIndicator = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
