//
//  SignUPViewController.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 22/05/25.
//

import UIKit

class SignUPViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneEmailTextField: UITextField!
    
    let viewModel = SignUPViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        firstNameTextField.setLeftRightPadding(left: 15, right: 15)
    }

    @IBAction func getOTPDidTapped(_ sender: Any) {
        guard validateForm() else { return }
        
        var parameters: [String: Any] = [
            "app_version": "1.0",
            "device_model": "iPhone",
            "device_token": "",
            "device_type": "A", // I for iOS
            "dob": "",
            "first_name": firstNameTextField.text?.trimmed() ?? "",
            "gender": "",
            "last_name": lastNameTextField.text?.trimmed() ?? "",
            "newsletter_subscribed": 0,
            "os_version": UIDevice.current.systemVersion,
            "password": "",
            "phone_code": "965",
            "lang": "en"
        ]
        
        // Determine whether input is email or phone
        
        let contactInput = phoneEmailTextField.text?.trimmed() ?? ""
        if ValidationManager.isValidEmail(contactInput) {
            parameters["email"] = contactInput
            parameters["phone"] = ""
        } else {
            parameters["phone"] = contactInput
            parameters["email"] = ""
        }
        Loader.show()
        viewModel.registerNewUserRequest(param: parameters)
    }
    
    func bindData() {
//        viewModel.$isLoading
//            .sink { isLoading in
//                if isLoading {
//                    // Show loader
//                } else {
//                    // Hide loader
//                }
//            }
//            .store(in: &viewModel.cancellables)

        viewModel.$registeredUserID
            .sink { [weak self] userID in
                guard let self = self else { return }
                if userID != nil {
                    // Navigate to OTP Screen with:
                    navigateToOTPScreen(userID: userID)
                }
            }
            .store(in: &viewModel.cancellables)

        viewModel.$errorMessage
            .sink { message in
                if let message = message {
                    Toast.show(message: message)
                }
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func navigateToOTPScreen(userID: Int?){
        let optVerificationViewController = self.storyboard?.instantiateViewController(withIdentifier: "OTPVerificationViewController") as! OTPVerificationViewController
        optVerificationViewController.userID = userID
        self.navigationController?.pushViewController(optVerificationViewController, animated: true)
    }
    
    func validateForm() -> Bool {
        if let message = ValidationManager.validateFirstName(firstNameTextField.text?.trimmed() ?? "") {
            viewModel.errorMessage = message
            return false
        }

        if let message = ValidationManager.validateLastName(lastNameTextField.text?.trimmed() ?? "") {
            viewModel.errorMessage = message
            return false
        }

        if let message = ValidationManager.validateContactInput(phoneEmailTextField.text?.trimmed() ?? "") {
            viewModel.errorMessage = message
            return false
        }

//        if let msg = ValidationManager.validatePassword(password) {
//            viewModel.errorMessage = message
//            return false
//        }

        return true
    }


}
