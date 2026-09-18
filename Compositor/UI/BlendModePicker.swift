import SwiftUI
import AppKit

struct BlendModePicker: NSViewRepresentable {
    let session: EditorSession
    func makeCoordinator() -> Coordinator { Coordinator(session: session) }
    func makeNSView(context: Context) -> NSPopUpButton {
        let button = NSPopUpButton(frame: .zero, pullsDown: false)
        // Localized titles; each item carries its mode, so nothing is looked up by title.
        for mode in LayerBlendMode.allCases {
            button.addItem(withTitle: mode.localizedName)
            button.lastItem?.representedObject = mode
        }
        button.menu?.delegate = context.coordinator
        button.target = context.coordinator
        button.action = #selector(Coordinator.choose(_:))
        button.setAccessibilityLabel(String(localized: "Blend mode"))
        // A capsule like the SwiftUI buttons and menus (`roundedControls`), which don't reach this AppKit pop-up.
        // Before macOS 26 AppKit has no border shape, so the pop-up keeps its standard bezel.
        if #available(macOS 26.0, *) { button.borderShape = .capsule }
        return button
    }
    func updateNSView(_ button: NSPopUpButton, context: Context) {
        button.isEnabled = session.canEditAppearance
        if !context.coordinator.tracking {
            Self.select(session.activeLayer?.blendMode ?? .normal, in: button)
        }
    }
    static func dismantleNSView(_ button: NSPopUpButton, coordinator: Coordinator) {
        if coordinator.tracking { coordinator.session.previewBlendMode(nil, for: nil) }
        button.menu?.delegate = nil
    }
    static func mode(of item: NSMenuItem?) -> LayerBlendMode? { item?.representedObject as? LayerBlendMode }
    static func select(_ mode: LayerBlendMode, in button: NSPopUpButton) {
        button.select(button.itemArray.first { Self.mode(of: $0) == mode })
    }
    final class Coordinator: NSObject, NSMenuDelegate {
        let session: EditorSession
        var tracking = false
        private var layerID: UUID?
        private var highlightedMode: LayerBlendMode?
        init(session: EditorSession) { self.session = session }
        func menuWillOpen(_ menu: NSMenu) {
            tracking = true
            layerID = session.activeLayerID
            highlightedMode = nil
        }
        func menu(_ menu: NSMenu, willHighlight item: NSMenuItem?) {
            let mode = BlendModePicker.mode(of: item)
            if let mode { highlightedMode = mode }
            session.previewBlendMode(mode, for: layerID)
        }
        func menuDidClose(_ menu: NSMenu) {
            tracking = false
            session.previewBlendMode(nil, for: nil)
        }
        @objc func choose(_ button: NSPopUpButton) {
            guard session.activeLayerID == layerID,
                  let mode = highlightedMode ?? BlendModePicker.mode(of: button.selectedItem) else { return }
            session.setLayerBlendMode(mode)
            BlendModePicker.select(mode, in: button)
            highlightedMode = nil
            session.refreshCanvasPreview?()
        }
    }
}
