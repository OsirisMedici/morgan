import AVFoundation
import Foundation

/// Uses installed Mac voices. Playback is local and needs no speech API key.
@MainActor
final class MacVoiceClient: NSObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    private var completion: CheckedContinuation<Void, Error>?
    private var activeUtterance: AVSpeechUtterance?
    private(set) var isPlaying = false

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speakText(_ text: String) async throws {
        stopPlayback()
        try Task.checkCancellation()
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        activeUtterance = utterance
        isPlaying = true
        try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                completion = continuation
                synthesizer.speak(utterance)
            }
        } onCancel: {
            Task { @MainActor [weak self] in self?.stopPlayback() }
        }
    }

    func stopPlayback() {
        let previous = completion
        completion = nil
        activeUtterance = nil
        isPlaying = false
        synthesizer.stopSpeaking(at: .immediate)
        previous?.resume(throwing: CancellationError())
    }

    nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        Task { @MainActor [weak self] in self?.finishPlayback(utterance) }
    }

    private func finishPlayback(_ utterance: AVSpeechUtterance) {
        guard activeUtterance === utterance else { return }
        activeUtterance = nil
        isPlaying = false
        let previous = completion
        completion = nil
        previous?.resume()
    }
}
