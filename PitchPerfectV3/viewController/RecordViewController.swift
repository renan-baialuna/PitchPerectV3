//
//  ViewController.swift
//  PitchPerfectV3
//
//  Created by Renan Baialuna on 18/12/20.
//  Copyright © 2020 Renan Baialuna. All rights reserved.
//

import UIKit

enum status: Int {
    case recording = 0, stopedRecording
}

enum recordStrings: String {
    case recording = "Recording in Progress"
    case toRecord = "Tap to Record"
}

enum segueString: String {
    case toReplay = "stopedRecording"
}



class RecordViewController: UIViewController {

    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configUI(.stopedRecording)
    }
    
    private func configUI(_ status: status) {
        switch status {
        case .recording:
            recordLabel.text = recordStrings.recording.rawValue
            stopRecordButton.isEnabled = true
            recordButton.isEnabled = false
        case .stopedRecording:
            recordLabel.text = recordStrings.toRecord.rawValue
            recordButton.isEnabled = true
            stopRecordButton.isEnabled = false
        }
    }
    
    @IBAction func startRecording(_ sender: Any) {
        configUI(.recording)
    }
    @IBAction func stopRecording(_ sender: Any) {
        performSegue(withIdentifier: segueString.toReplay.rawValue, sender: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueString.toReplay.rawValue {
            
        }
        
    }
    

}

