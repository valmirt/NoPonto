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
        //        groupImage.setHidden(true)
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
            item.title = weight.description
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
    }
    
    @IBAction func onPickerWeightChange(_ value: Int) {
    }
    
    @IBAction func onPickerTemperatureChange(_ value: Int) {
    }
    
    @IBAction func onModeChange(_ value: Bool) {
    }
}
