//
//  ViewController.swift
//  PitchPerfectV3
//
//  Created by Renan Baialuna on 18/12/20.
//  Copyright © 2020 Renan Baialuna. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    var audioRecorder: AVAudioRecorder!
    
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
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
       let recordingName = "recordedVoice.wav"
       let pathArray = [dirPath, recordingName]
       let filePath = URL(string: pathArray.joined(separator: "/"))

       let session = AVAudioSession.sharedInstance()
       try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

       try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
       audioRecorder.delegate = self
       audioRecorder.isMeteringEnabled = true
       audioRecorder.prepareToRecord()
       audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configUI(.stopedRecording)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueString.toReplay.rawValue {
            if let audioURL = sender as? URL,
               let destination = segue.destination as? PlaySoundViewController {
                    destination.audioURL = audioURL
            } else {
                fatalError()
            }
        }
    }
    

}

extension RecordViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: segueString.toReplay.rawValue, sender: audioRecorder.url)
        } else {
            print("unsucessifull recording")
        }
    }
}
