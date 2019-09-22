//
//  ViewController.swift
//  FoodTrackerApp
//
//  Created by Sharetrip-iOS on 9/22/19.
//  Copyright © 2019 Tbbd iOS. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var mealTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mealTextField.delegate = self
        // Enable the Save button only if the text field has a valid Meal name.

        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            mealTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        updateSaveButtonState()
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text

    }

    //MARK: Navigations

    @IBAction func cancel(_ sender: UIBarButtonItem) {
       // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
           let isPresentingInAddMealMode = presentingViewController is UINavigationController

           if isPresentingInAddMealMode {
               dismiss(animated: true, completion: nil)
           }
           else if let owningNavigationController = navigationController{
               owningNavigationController.popViewController(animated: true)
           }
           else {
               fatalError("The MealViewController is not inside a navigation controller.")
           }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

           // Configure the destination view controller only when the save button is pressed.
           guard let button = sender as? UIBarButtonItem, button === saveButton else {
               os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
               return
           }

           let name = mealTextField.text ?? ""
           let photo = photoImageView.image
           let rating = ratingControl.rating

           // Set the meal to be passed to MealTableViewController after the unwind segue.
           meal = Meal(name: name, photo: photo!, rating: rating)
    }


    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        mealTextField.resignFirstResponder()

        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary

        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }


    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        photoImageView.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)

    }

    //MARK: Private Methods

    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = mealTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }


}

