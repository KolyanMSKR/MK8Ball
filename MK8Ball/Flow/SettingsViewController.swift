//
//  SettingsViewController.swift
//  MK8Ball
//
//  Created by Mykola Korotun on 15.10.2021.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    @IBOutlet private weak var answerTextField: UITextField!
    @IBOutlet private weak var answersTableView: UITableView!

    private let coreDataStack = CoreDataStack()
    private var answers: [NSManagedObject] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAnswers()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

}

//MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = answers[indexPath.row].value(forKey: "answer") as? String
        return cell
    }

}

private extension SettingsViewController {

    func setupTableView() {
        answersTableView.dataSource = self
    }

    func fetchAnswers() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Phrase")
        do {
            answers = try coreDataStack.persistentContainer.viewContext.fetch(fetchRequest)
            answersTableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    @IBAction private func addAnswerAction() {
        let managedContext = coreDataStack.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Phrase", in: managedContext)!
        let phrase = NSManagedObject(entity: entity, insertInto: managedContext)
        guard let text = answerTextField.text else { return }
        phrase.setValue(text, forKey: "answer")

        do {
            try managedContext.save()
            answers.append(phrase)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
