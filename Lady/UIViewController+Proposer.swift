//
//  UIViewController+Proposer.swift
//  Lady
//
//  Created by NIX on 15/7/11.
//  Copyright (c) 2015年 nixWork. All rights reserved.
//

import UIKit
import Proposer

extension PrivateResource {

    var proposeMessage: String {
        switch self {
        case .photos:
            return NSLocalizedString("Proposer need to access your Photos to choose photo.", comment: "")
        case .camera:
            return NSLocalizedString("Proposer need to access your Camera to take photo.", comment: "")
        case .microphone:
            return NSLocalizedString("Proposer need to access your Microphone to record audio.", comment: "")
        case .contacts:
            return NSLocalizedString("Proposer need to access your Contacts to match friends.", comment: "")
        case .reminders:
            return NSLocalizedString("Proposer need to access your Reminders to create reminder.", comment: "")
        case .calendar:
            return NSLocalizedString("Proposer need to access your Calendar to create event.", comment: "")
        case .location:
            return NSLocalizedString("Proposer need to get your Location to share to your friends.", comment: "")
        }
    }

    var noPermissionMessage: String {
        switch self {
        case .photos:
            return NSLocalizedString("Proposer can NOT access your Photos, but you can change it in iOS Settings.", comment: "")
        case .camera:
            return NSLocalizedString("Proposer can NOT access your Camera, but you can change it in iOS Settings.", comment: "")
        case .microphone:
            return NSLocalizedString("Proposer can NOT access your Microphone, but you can change it in iOS Settings.", comment: "")
        case .contacts:
            return NSLocalizedString("Proposer can NOT access your Contacts, but you can change it in iOS Settings.", comment: "")
        case .reminders:
            return NSLocalizedString("Proposer can NOT access your Reminders, but you can change it in iOS Settings.", comment: "")
        case .calendar:
            return NSLocalizedString("Proposer can NOT access your Calendar, but you can change it in iOS Settings.", comment: "")
        case .location:
            return NSLocalizedString("Proposer can NOT get your Location, but you can change it in iOS Settings.", comment: "")
        }
    }
}

extension UIViewController {

    private func showDialogWithTitle(title: String, message: String, cancelTitle: String, confirmTitle: String, withCancelAction cancelAction : (() -> Void)?, confirmAction: (() -> Void)?) {

        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                cancelAction?()
            }
            alertController.addAction(cancelAction)

            let confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                confirmAction?()
            }
            alertController.addAction(confirmAction)

            self.present(alertController, animated: true, completion: nil)
        }
    }

    func showProposeMessageIfNeedFor(resource: PrivateResource, andTryPropose propose: @escaping Propose) {

        if resource.isNotDeterminedAuthorization {
            showDialogWithTitle(title: NSLocalizedString("Notice", comment: ""), message: resource.proposeMessage, cancelTitle: NSLocalizedString("Not now", comment: ""), confirmTitle: NSLocalizedString("OK", comment: ""), withCancelAction: nil, confirmAction: {
                propose()
            })

        } else {
            propose()
        }
    }

    func alertNoPermissionToAccess(resource: PrivateResource) {

        showDialogWithTitle(title: NSLocalizedString("Sorry", comment: ""), message: resource.noPermissionMessage, cancelTitle: NSLocalizedString("Dismiss", comment: ""), confirmTitle: NSLocalizedString("Change it now", comment: ""), withCancelAction: nil, confirmAction: {
            UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
        })
    }
}
