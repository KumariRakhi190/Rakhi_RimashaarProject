//
//  OTPVerificationViewController.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 21/05/25.
//

import UIKit

class OTPVerificationViewController: UIViewController {

    @IBOutlet weak var firstOTPTextField: UITextField!
    @IBOutlet weak var secondOTPTextField: UITextField!
    @IBOutlet weak var thirdOTPTextField: UITextField!
    @IBOutlet weak var fourthOTPTextField: UITextField!
    @IBOutlet weak var fifthOTPTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resendButtonOultet: UIButton!
    
    private var timer: Timer?
    private var remainingSeconds = 30
    public var userID: Int?
    private var viewModel = OTPVerificationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        startCountdown()
        bindData()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func crossDidTapped(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resendCodeDidTapped(_ sender: Any) {
        
        // No API is provided to resend the OTP.
        
        
        remainingSeconds = 30
        resendButtonOultet.isEnabled = false
        resendButtonOultet.alpha = 0.1
        startCountdown()
    }
    
    @IBAction func conitnueDidTapped(_ sender: Any) {
        let otpFields:[String?] = [firstOTPTextField.text, secondOTPTextField.text, thirdOTPTextField.text, fourthOTPTextField.text, fifthOTPTextField.text]
        let otpValidationResult =  ValidationManager.validateOTPAndReturnDict (otpFields: otpFields)
        if let otp = otpValidationResult.dict {
            let param: [String: Any] = ["otp": otp,
                                        "user_id": userID ?? 4]
            Loader.show()
            viewModel.otpVerificationRequest(param: param)
        } else {
            Toast.show(message: "Please enter a valid 5-digit OTP")
        }
    }
    
    private func bindData(){
        viewModel.$isVerificationDone
            .sink { [weak self] isVerificationDone in
                guard let self = self else { return }
                if isVerificationDone {
                    let welcomeViewController = storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                    navigationController?.pushViewController(welcomeViewController, animated: true)
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
    
    private func startCountdown() {
        updateLabel()
        resendButtonOultet.isEnabled = false
        resendButtonOultet.alpha = 0.5

        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }

    private func updateLabel() {
        let timeText = String(format: "00:%02d sec", remainingSeconds)
        let fullText = "Resend a new code in \(timeText)"
        let attributedString = NSMutableAttributedString(string: fullText)

        if let range = fullText.range(of: timeText) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: nsRange)
        }

        timeLabel.attributedText = attributedString
    }
    
    private func initialSetUp() {
        firstOTPTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        secondOTPTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        thirdOTPTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        fourthOTPTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        fifthOTPTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func updateTimer() {
        remainingSeconds -= 1
        updateLabel()

        if remainingSeconds <= 0 {
            timer?.invalidate()
            timer = nil
            timeLabel.text = "You can now resend the code"
            resendButtonOultet.isEnabled = true
            resendButtonOultet.alpha = 1.0
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count >= 1 && text.count < 2 {
            print(text)
            switch textField {
            case firstOTPTextField: secondOTPTextField.becomeFirstResponder()
            case secondOTPTextField: thirdOTPTextField.becomeFirstResponder()
            case thirdOTPTextField: fourthOTPTextField.becomeFirstResponder()
            case fourthOTPTextField: fifthOTPTextField.becomeFirstResponder()
            case fifthOTPTextField: fifthOTPTextField.resignFirstResponder()
                default: break
            }
        } else if text.isEmpty {
            textField.text = ""
            switch textField {
            case firstOTPTextField: firstOTPTextField.becomeFirstResponder()
            case secondOTPTextField: firstOTPTextField.becomeFirstResponder()
            case thirdOTPTextField: secondOTPTextField.becomeFirstResponder()
            case fourthOTPTextField: thirdOTPTextField.becomeFirstResponder()
            case fifthOTPTextField: fourthOTPTextField.becomeFirstResponder()
                default: break
            }
        } else {
            if let lastCharacter = text.last {
                textField.text = String(lastCharacter)
                switch textField {
                case firstOTPTextField: secondOTPTextField.becomeFirstResponder()
                case secondOTPTextField: thirdOTPTextField.becomeFirstResponder()
                case thirdOTPTextField: fourthOTPTextField.becomeFirstResponder()
                case fourthOTPTextField: fifthOTPTextField.becomeFirstResponder()
                case fifthOTPTextField: fifthOTPTextField.resignFirstResponder()
                    default: break
                }
            }
        }
    }

}
