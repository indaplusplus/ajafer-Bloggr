//
//  ViewControllerExtension.swift
//  Blog
//
//  Created by Adam Jafer on 2017-11-01.
//  Copyright © 2017 Adam Jafer. All rights reserved.
//

import UIKit

extension UIViewController {
    func show(error: String) {
        let alertController = UIAlertController(title: "Tyvärr", message: error, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Avbryt", style: .cancel, handler: nil)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
}

