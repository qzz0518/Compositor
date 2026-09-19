# Compositor

> **macOS 15 compatible fork** of [robbietilton/Compositor](https://github.com/robbietilton/Compositor). Upstream requires macOS 26.5; this fork runs on **macOS 15 (Sequoia) and later**.
>
> **Download:** [Compositor.dmg](https://github.com/qzz0518/Compositor/releases/latest/download/Compositor.dmg), signed and notarized. In-app updates come from this fork's releases, not upstream's. **下载：** 同上链接，已签名并公证，App 内的自动更新来自本 fork。
>
> - **Deployment target** lowered from macOS 26.5 to 15.0. Upstream uses only three macOS 26 APIs, all cosmetic: `NSPopUpButton.borderShape`, `ToolbarSpacer` and `sharedBackgroundVisibility`. They're now behind `#available(macOS 26.0, *)`. On macOS 15 the blend-mode pop-up keeps the standard bezel and the toolbar uses the system spacing; all editing features are unchanged.
> - **App icon** redrawn to the standard macOS template: an 824 × 824 rounded rectangle with a drop shadow, centered on a 1024 canvas. Upstream ships a full-bleed square, which macOS 26 masks itself but earlier versions show as an oversized square in the Dock and Finder.
> - **Builds with Xcode 26.3**: two expressions that timed out the type checker are split up.
> - **Simplified Chinese localization**: menus, panels, tools, status-bar hints, undo names, alerts and default layer names, in a string catalog (`Compositor/Localizable.xcstrings`). The app follows the system language. Terminology follows Photoshop's Simplified Chinese UI.
>
> **Fork 说明**：上游最低要求 macOS 26.5，本 fork 支持 **macOS 15 及以上**。上游只用到 3 个 macOS 26 专属的外观 API，现已加上版本判断：在 15 上混合模式下拉框保持标准样式，工具栏用系统默认间距，编辑功能不变。图标改为标准 macOS 模板（四周留边、带阴影），修复在旧系统上显示成超大方块的问题。另外新增**简体中文界面**（菜单、面板、工具、状态栏提示、撤销项、提示框、默认图层名），跟随系统语言切换，术语参照 Photoshop 中文版。

Adobe Photoshop costs too much and tools like GIMP don’t feel familiar enough for me to stay in flow. That’s why I built Compositor.

The goal was to create a full-featured image editor that is completely free and open source. I use Photoshop for compositing and post-processing, so Compositor is built around that workflow - with the tools needed to create a pixel-perfect final image.

Because it’s open source, you can download the Xcode project and add, remove, or modify any feature to fit your workflow.

## Features

### Layers
- Layers and folders, with blend modes and opacity
- Layer masks: paint, fill, invert, blur and feather them; link or unlink them to transform a mask on its own
- Clipping masks and folder masks
- Adjustment layers: Hue/Saturation, Levels, Curves, Exposure, Gradient Map and Grain
- Merge Down, Merge Layers and Merge Group (⌘E)
- Duplicate, rename inline, reorder and nest by drag and drop; Option-drag to duplicate
- Drag layers between open projects

### Transform
- Non-destructive move, scale, rotate and flip — images keep their full resolution however small you make them
- Free distort (⌘-drag a handle), with Shift to lock to an axis
- Transform several layers, or a whole folder, together
- Snapping to canvas and layer edges and centers, with guides
- Exact values for position, size, scale and angle, stepped with the arrow keys
- Flip Layer and Flip Canvas, horizontal and vertical

### Selections
- Rectangle and Ellipse Marquee, Freehand and Polygonal Lasso, and Magic Wand
- Add to and subtract from selections, move the outline, or move and duplicate the pixels inside
- Load a layer's pixels or a mask as a selection
- Content-Aware Fill, which can also extend an image past its edges

### Painting and retouching
- Brush with size, hardness and opacity, and Shift for straight lines
- Spot Healing Brush (content-aware)
- Clone Stamp, aligned or not, sampling one layer or all of them
- Blur tool, on pixels or masks
- Gradient tool and Shape tool (rectangles, rounded rectangles and ellipses)
- Eyedropper and a full color picker

### Adjustments and filters
- Levels (with Auto), Curves, Hue/Saturation, Exposure, Gradient Map, Grain and Invert
- Gaussian Blur and Motion Blur that spread past a layer's edges
- Add Noise, Lens Correction and Remove Background
- Live previews, limited to the selection when there is one

### Canvas and files
- Multiple projects in tabs
- Crop with snapping, and Option for symmetric cropping
- Canvas Size and Image Size
- Sharp high-quality downsampling when zoomed out, and a pixel grid when zoomed in
- Import JPEG, PNG, HEIC and TIFF — including dropped screenshots and images from other apps
- Export JPEG with a live preview (⇧⌥⌘S); Copy Merged
- Photoshop-style keyboard shortcuts throughout

## Requirements

- macOS 15 or later (upstream: macOS 26.5)
- Xcode 26 (to build from source; tested with 26.3)

## Building

Open `Compositor.xcodeproj` and run the **Compositor** scheme.

## Releasing

`scripts/release.sh` builds a Release version, signs it with Developer ID, notarizes and staples it, and packages it into `dist/Compositor-<version>.dmg`.

It needs, all kept outside this repository:

- a **Developer ID Application** certificate in the login keychain
- notarization credentials saved with `xcrun notarytool store-credentials "compositor-notary" …`
- [`create-dmg`](https://github.com/create-dmg/create-dmg) (`brew install create-dmg`)

## License

MIT — see [LICENSE](LICENSE).
