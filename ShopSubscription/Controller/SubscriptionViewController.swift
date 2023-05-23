//
//  SubscriptionViewController.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-20.
//

import UIKit

class SubscriptionViewController: UIViewController {
    
    var customer = Customer()

    var pickedDay = "Понедельник"
    var pickedTime = "День"
    var pickedPeriod = "1 месяц"
    let daysOfWeek = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    let times = ["День", "Обед", "Вечер"]
    let periods = ["1 месяц", "3 месяца", "6 месяцев", "1 год", "2 года"]

    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var timePicker: UIPickerView!
    
    @IBOutlet weak var periodPicker: UIPickerView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var streetFiled: UITextField!
    @IBOutlet weak var apartmentField: UITextField!
    
    @IBOutlet weak var entranceField: UITextField!
    @IBOutlet weak var floorField: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayPicker.delegate = self
        dayPicker.dataSource = self
        timePicker.delegate = self
        timePicker.dataSource = self
        periodPicker.delegate = self
        periodPicker.dataSource = self
        errorMessage.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func subscribe(_ sender: UIButton) {
        if let unwrappedName = nameField.text {
            customer.name = unwrappedName
        }
        if let unwrappedPhone = phoneNumberField.text {
            customer.phoneNumber = unwrappedPhone
        }
        if let unwrappedCity = cityField.text {
            customer.city = unwrappedCity
        }
        if let unwrappedStreet = streetFiled.text {
            customer.street = unwrappedStreet
        }
        if let unwrappedApartment = apartmentField.text {
            customer.apartmentNumber = unwrappedApartment
        }
        if let unwrappedEntrance = entranceField.text {
            customer.entranceNumber = unwrappedEntrance
        }
        if let unwrappedFloor = floorField.text {
            customer.floorNumber = unwrappedFloor
        }
        
        if nameField.text == "" || phoneNumberField.text == "" || cityField.text == "" || streetFiled.text == "" || apartmentField.text == "" || entranceField.text == "" || floorField.text == "" || !isNumbers(text: customer.phoneNumber) || !isNumbers(text: customer.apartmentNumber) || !isNumbers(text: customer.entranceNumber) || !isNumbers(text: customer.floorNumber){
            
            errorMessage.isHidden = false
        } else {
            errorMessage.isHidden = true
        }
        customer.day = pickedDay
        customer.time = pickedTime
        customer.period = pickedPeriod
        print(customer)
        
    }
    func isNumbers(text: String) -> Bool {
        let numbersSet = NSCharacterSet(charactersIn: "123456789")
        let textCharacterSet = NSCharacterSet(charactersIn: text)
        
        return numbersSet.isSuperset(of: textCharacterSet as CharacterSet)
    }
    
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension SubscriptionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == dayPicker {
            return daysOfWeek.count
        }
        if pickerView == timePicker {
            return times.count
        }
        if pickerView == periodPicker {
            return periods.count
        }
        return 1
    }
    
    

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "Helvetica Neue", size: 15)
        label.textAlignment = .center
        
        if pickerView == dayPicker {
            label.text =  daysOfWeek[row]
        }
        if pickerView == timePicker{
            label.text =  times[row]
       }
        if pickerView == periodPicker {
            label.text =  periods[row]
        }
        return label
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dayPicker {
            pickedDay = daysOfWeek[row]
        }
        if pickerView == timePicker {
            pickedTime = times[row]
        }
        if pickerView == timePicker {
            pickedPeriod = periods[row]
        }
    }
    
}
