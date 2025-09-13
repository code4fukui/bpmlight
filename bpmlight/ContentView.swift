import SwiftUI
import AVFoundation

enum Waveform: String, CaseIterable, Identifiable {
    case linear = "Linear"
    case sine   = "Sine"
    var id: String { rawValue }
}

let fps = 30.0

struct ContentView: View {
    @State private var brightness: Float = 0.0
    @State private var timer: Timer? = nil
    @State private var freq: Float = 120.0
    @State private var mode: Waveform = .linear
    //@State private var t: Double = 0                 // 経過時間[s]

    func setBrightness(_ v: Float) {
        FlashlightManager.shared.setTorch(level: v)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text("bpmlight")
                .font(.title2)
            
            Slider(value: Binding(
                get: { Double(brightness) },
                set: { newValue in
                    brightness = Float(newValue)
                    FlashlightManager.shared.setTorch(level: brightness)
                }
            ), in: 0.0...1.0, step: 0.01)
            
            Text(String(format: "brightness: %.0f%%", brightness * 100.0))
                .font(.headline)
            
            HStack(spacing: 20) {
                Button("ON") {
                    brightness = 1.0
                    setBrightness(brightness)
                }
                Button("OFF") {
                    brightness = 0.0
                    setBrightness(brightness)
                }
            }
            
            Slider(value: Binding(
                get: { Double(freq) },
                set: { newValue in
                    freq = Float(newValue)
                }
            ), in: 0.0...300.0, step: 1)

            Text(String(format: "BPM: %.0f", freq))
                .font(.headline)

            // 波形選択（リニア / Sine）
            Picker("Waveform", selection: $mode) {
                ForEach(Waveform.allCases) { w in
                    Text(w.rawValue).tag(w)
                }
            }
            .pickerStyle(.segmented)

            HStack(spacing: 20) {
                Button("START") {
                    startTimer()
                }
                .buttonStyle(.bordered)
                //.buttonStyle(.borderedProminent)
                
                Button("STOP") {
                    stopTimer()
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .cornerRadius(10)
        }
        .padding()
    }
    func startTimer() {
        // すでに動いている場合は止めてから再スタート
        stopTimer()
        if brightness == 0.0 {
            brightness = 1.0
        }
        //t = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / fps, repeats: true) { _ in
            //t += 1.0 / fps
            tick()
        }
    }
    func tick() {
        let t = Date().timeIntervalSince1970
        switch (mode) {
        case .linear:
            let b = ((Double(freq) / 60.0) * t).truncatingRemainder(dividingBy: 1.0)
            setBrightness(Float(b) * brightness)
        case .sine:
            let b: Double = (sin(2.0 * Double.pi * (Double(freq) / 60.0) * t) + 1.0) / 2.0
            setBrightness(Float(b) * brightness)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }}

// フラッシュライト制御用のシングルトン
class FlashlightManager {
    static let shared = FlashlightManager()
    
    private init() {}
    
    func setTorch(level: Float) {
        guard let device = AVCaptureDevice.default(for: .video),
              device.hasTorch else {
            print("Torch未対応デバイス")
            return
        }
        
        do {
            try device.lockForConfiguration()
            if level == 0 {
                device.torchMode = .off
            } else {
                try device.setTorchModeOn(level: level) // 0.0~1.0
            }
            device.unlockForConfiguration()
        } catch {
            print("Torch制御エラー: \(error)")
        }
    }
}
