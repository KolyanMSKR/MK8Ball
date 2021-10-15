//
//  MainViewController.swift
//  MK8Ball
//
//  Created by Mykola Korotun on 15.10.2021.
//

import UIKit

class MainViewController: UIViewController {

    private enum Constants {
        static let answersURL = "https://8ball.delegator.com/magic/JSON/qwerty"
    }

    @IBOutlet private weak var answerLabel: UILabel!

    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if let url = URL(string: Constants.answersURL) {
                let request = URLRequest(url: url)
                networkService.fetchJSONData(request: request, modelType: Answer.self) { response in
                    if let response = response {
                        self.answerLabel.text = response.magic.answer
                    }
                }
            }
        }
    }

}

