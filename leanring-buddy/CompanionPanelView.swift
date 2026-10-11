import AVFoundation
import Speech
import SwiftUI

struct CompanionPanelView: View {
    @ObservedObject var companionManager: CompanionManager
    @State private var question = ""
    @State private var includeScreen = true

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Image(systemName: "cursorarrow.rays").foregroundColor(DS.Colors.blue400)
                Text("Clicky Personal").font(.headline)
                Spacer()
                Text(statusText).font(.caption).foregroundColor(.secondary)
            }
            Divider()
            Text("Hold Shift + Control + Space to talk.").font(.subheadline)
            Text("Your Codex account. Mac dictation and voice.")
                .font(.caption).foregroundColor(.secondary)
            if !companionManager.allPermissionsGranted {
                VStack(spacing: 6) {
                    permissionRow("Microphone", granted: companionManager.hasMicrophonePermission) {
                        if AVCaptureDevice.authorizationStatus(for: .audio) == .notDetermined {
                            AVCaptureDevice.requestAccess(for: .audio) { _ in }
                        } else { openSettings("Privacy_Microphone") }
                    }
                    permissionRow("Speech recognition", granted: companionManager.hasSpeechRecognitionPermission) {
                        if SFSpeechRecognizer.authorizationStatus() == .notDetermined {
                            companionManager.requestSpeechPermission()
                        } else { openSettings("Privacy_SpeechRecognition") }
                    }
                    permissionRow("Screen recording", granted: companionManager.hasScreenRecordingPermission) {
                        WindowPositionManager.requestScreenRecordingPermission()
                    }
                    permissionRow("Accessibility", granted: companionManager.hasAccessibilityPermission) {
                        WindowPositionManager.requestAccessibilityPermission()
                    }
                }
                Text("Screen images go to Codex only when you ask with screen context. Apple dictation uses on-device recognition when available.")
                    .font(.caption).foregroundColor(.secondary)
            }
            if companionManager.allPermissionsGranted {
                Toggle("Show blue companion", isOn: Binding(
                    get: { companionManager.isOverlayVisible },
                    set: { value in
                        if value {
                            companionManager.setClickyCursorEnabled(true)
                            companionManager.triggerOnboarding()
                        } else { companionManager.setClickyCursorEnabled(false) }
                    }
                )).toggleStyle(.switch)
            }
            Divider()
            TextField("Or type a question", text: $question)
                .textFieldStyle(.roundedBorder).onSubmit { ask() }
            Toggle("Include my screens", isOn: $includeScreen)
                .disabled(!companionManager.hasScreenRecordingPermission).font(.caption)
            HStack {
                Button("Ask Codex") { ask() }
                    .disabled(question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isBusy)
                Button("Stop") { companionManager.stopCurrentResponse() }.disabled(!isBusy)
                Spacer()
                Button("Test Mac voice") { Task { await companionManager.testMacVoice() } }
                    .disabled(isBusy)
            }
            if let error = companionManager.lastError {
                Text(error).foregroundColor(.red).font(.caption).textSelection(.enabled)
            }
            if !companionManager.lastResponse.isEmpty {
                ScrollView {
                    Text(companionManager.lastResponse).font(.subheadline).textSelection(.enabled)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxHeight: 120)
            }
            Spacer(minLength: 0)
            Divider()
            HStack {
                Button("Open source folder") {
                    if let path = Bundle.main.object(forInfoDictionaryKey: "PersonalSourcePath") as? String {
                        NSWorkspace.shared.open(URL(fileURLWithPath: path))
                    }
                }
                Spacer()
                Button("Quit") { NSApp.terminate(nil) }
            }.font(.caption)
        }
        .padding(18).frame(width: 380, height: 640)
        .foregroundColor(DS.Colors.textPrimary)
        .background(RoundedRectangle(cornerRadius: 12).fill(DS.Colors.background))
    }

    private var isBusy: Bool { companionManager.voiceState != .idle }
    private var statusText: String {
        switch companionManager.voiceState {
        case .idle: return companionManager.allPermissionsGranted ? "Ready" : "Setup"
        case .listening: return "Listening"
        case .processing: return "Thinking"
        case .responding: return "Speaking"
        }
    }
    private func ask() {
        guard !isBusy else { return }
        companionManager.submitTypedQuestion(question, includeScreen: includeScreen && companionManager.hasScreenRecordingPermission)
        question = ""
    }
    private func openSettings(_ pane: String) {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?\(pane)") {
            NSWorkspace.shared.open(url)
        }
    }
    private func permissionRow(_ title: String, granted: Bool, action: @escaping () -> Void) -> some View {
        HStack {
            Text(title).font(.subheadline)
            Spacer()
            if granted {
                Label("Granted", systemImage: "checkmark.circle.fill").font(.caption).foregroundColor(.green)
            } else {
                Button("Grant \(title)", action: action).font(.caption)
            }
        }
    }
}
