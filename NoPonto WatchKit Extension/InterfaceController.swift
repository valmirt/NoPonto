//
//  InterfaceController.swift
//  NoPonto WatchKit Extension
//
//  Created by Valmir Junior on 29/10/20.
//

import WatchKit


final class InterfaceController: WKInterfaceController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var timer: WKInterfaceTimer!
    @IBOutlet weak var buttonTimer: WKInterfaceButton!
    @IBOutlet weak var labelWeight: WKInterfaceLabel!
    @IBOutlet weak var groupText: WKInterfaceGroup!
    @IBOutlet weak var groupImage: WKInterfaceGroup!
    @IBOutlet weak var labelCook: WKInterfaceLabel!
    @IBOutlet weak var sliderCook: WKInterfaceSlider!
    @IBOutlet weak var pickerWeight: WKInterfacePicker!
    @IBOutlet weak var pickerTemperature: WKInterfacePicker!
    @IBOutlet weak var labelTemperature: WKInterfaceLabel!
    
    //MARK: - Properties
    var kg: Double = 0.1
    var meatTemperature = MeatTemperature.rare
    var increment = 0.1
    var timeRunning = false
    var maxKg = 2.0
    
    //MARK: - SuperMethods
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        groupImage.setHidden(true)
        setupPickers()
        updateConfiguration()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //MARK: - Methods
    func setupPickers() {
        //Picker quantidade
        var weightItems: [WKPickerItem] = []
        for weight in stride(from: 0.1, through: maxKg, by: increment) {
            let item = WKPickerItem()
            item.title = String(format: "%0.1f", weight)
            weightItems.append(item)
        }
        
        pickerWeight.setItems(weightItems)
        pickerWeight.setSelectedItemIndex(0)
        
        //Picker temperatura
        var temperature: [WKPickerItem] = []
        for imageIndex in 1...4 {
            let item = WKPickerItem()
            item.contentImage = WKImage(imageName: "temp-\(imageIndex)")
            temperature.append(item)
        }
        pickerTemperature.setItems(temperature)
        pickerTemperature.setSelectedItemIndex(0)
    }
    
    func updateConfiguration() {
        labelCook.setText(meatTemperature.stringValue)
        labelTemperature.setText(meatTemperature.stringValue)
        pickerTemperature.setSelectedItemIndex(meatTemperature.rawValue)
        sliderCook.setValue(Float(meatTemperature.rawValue))
        labelWeight.setText("Total: \(String(format: "%0.1f", kg)) kg")
        let index = Int((kg * 10) - 1)
        pickerWeight.setSelectedItemIndex(index)
    }
    
    //MARK: - IBActions
    @IBAction func minus() {
        if kg > 0.1 {
            kg -= increment
            updateConfiguration()
        }
    }
    
    @IBAction func plus() {
        if kg < maxKg {
            kg += increment
            updateConfiguration()
        }
    }
    
    @IBAction func toggleTimer() {
        if timeRunning {
            timer.stop()
            timer.setDate(Date(timeIntervalSinceNow: 0))
            buttonTimer.setTitle("Iniciar Timer")
        } else {
            let time = meatTemperature.cookTime(for: kg)
            timer.setDate(Date(timeIntervalSinceNow: time))
            timer.start()
            buttonTimer.setTitle("Parar Timer")
        }
        timeRunning.toggle()
    }
    
    @IBAction func onSliderChange(_ value: Float) {
        if let newMeatTemperature = MeatTemperature(rawValue: Int(value)) {
            meatTemperature = newMeatTemperature
            updateConfiguration()
        }
    }
    
    @IBAction func onPickerWeightChange(_ value: Int) {
        kg = Double(value + 1) * increment
        updateConfiguration()
    }
    
    @IBAction func onPickerTemperatureChange(_ value: Int) {
        if let newMeatTemperature = MeatTemperature(rawValue: value) {
            meatTemperature = newMeatTemperature
            updateConfiguration()
        }
    }
    
    @IBAction func onModeChange(_ value: Bool) {
        groupImage.setHidden(!value)
        groupText.setHidden(value)
    }
}
