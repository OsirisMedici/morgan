import AppKit
import AVFoundation

/// Opt-in smoke test, using a synthetic screen with no personal data.
@MainActor
enum PersonalSmokeTests {
    static func run() async {
        do {
            let none = CompanionManager.parsePointingCoordinates(from: "Hello. [POINT:none]")
            guard none.coordinate == nil, none.spokenText == "Hello." else {
                throw PersonalClickyError(message: "POINT:none parsing failed")
            }
            let secondary = CompanionManager.parsePointingCoordinates(from: "Here. [POINT:400,300:crop:screen2]")
            guard secondary.coordinate == CGPoint(x: 400, y: 300), secondary.screenNumber == 2 else {
                throw PersonalClickyError(message: "Multi-monitor tag parsing failed")
            }
            print("PASS: POINT parser, speech text separation, secondary-screen tag")

            guard let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: 1280, pixelsHigh: 720,
                bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
                colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0),
                let context = NSGraphicsContext(bitmapImageRep: bitmap) else {
                throw PersonalClickyError(message: "Synthetic screen allocation failed")
            }
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current = context
            NSColor.white.setFill()
            NSRect(x: 0, y: 0, width: 1280, height: 720).fill()
            NSColor.systemPurple.setFill()
            NSRect(x: 920, y: 550, width: 240, height: 110).fill()
            NSString(string: "CROP").draw(at: NSPoint(x: 970, y: 582), withAttributes: [
                .font: NSFont.boldSystemFont(ofSize: 38), .foregroundColor: NSColor.white
            ])
            NSString(string: "Practice editor").draw(at: NSPoint(x: 80, y: 630), withAttributes: [
                .font: NSFont.systemFont(ofSize: 36), .foregroundColor: NSColor.black
            ])
            context.flushGraphics()
            NSGraphicsContext.restoreGraphicsState()
            guard let jpeg = bitmap.representation(using: .jpeg, properties: [:]) else {
                throw PersonalClickyError(message: "Synthetic screen generation failed")
            }
            let client = CodexCLIClient()
            let answer = try await client.analyzeImageStreaming(
                images: [(jpeg, "screen 1, primary focus, image dimensions: 1280x720 pixels")],
                systemPrompt: "Answer in one short sentence. Append [POINT:x,y:label] with integer screenshot coordinates, origin top left. Point to the center of the requested button. Do not use tools.",
                userPrompt: "Where is the purple CROP button?", onTextChunk: { _ in })
            let point = CompanionManager.parsePointingCoordinates(from: answer.text)
            guard let coordinate = point.coordinate,
                  (900...1180).contains(coordinate.x), (40...200).contains(coordinate.y),
                  !point.spokenText.isEmpty else {
                throw PersonalClickyError(message: "Codex image grounding failed: \(answer.text)")
            }
            print("PASS: Existing Codex account answered synthetic screenshot in \(Int(answer.duration))s")
            print("PASS: Located Crop button at \(Int(coordinate.x)),\(Int(coordinate.y))")

            let voice = MacVoiceClient()
            try await voice.speakText("Morgan is connected to Codex. The Mac voice test is complete.")
            guard !voice.isPlaying else { throw PersonalClickyError(message: "Voice remained busy") }
            print("PASS: Mac speech playback completed")
            print("MORGAN_SMOKE_TEST_PASSED")
            NSApp.terminate(nil)
        } catch {
            print("MORGAN_SMOKE_TEST_FAILED: \(error.localizedDescription)")
            exit(1)
        }
    }
}
