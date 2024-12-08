import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "a-font" asset catalog image resource.
    static let aFont = ImageResource(name: "a-font", bundle: resourceBundle)

    /// The "a-large" asset catalog image resource.
    static let aLarge = ImageResource(name: "a-large", bundle: resourceBundle)

    /// The "a-small" asset catalog image resource.
    static let aSmall = ImageResource(name: "a-small", bundle: resourceBundle)

    /// The "arrow-back" asset catalog image resource.
    static let arrowBack = ImageResource(name: "arrow-back", bundle: resourceBundle)

    /// The "blue-marker" asset catalog image resource.
    static let blueMarker = ImageResource(name: "blue-marker", bundle: resourceBundle)

    /// The "bookmark" asset catalog image resource.
    static let bookmark = ImageResource(name: "bookmark", bundle: resourceBundle)

    /// The "border-dashed-pattern" asset catalog image resource.
    static let borderDashedPattern = ImageResource(name: "border-dashed-pattern", bundle: resourceBundle)

    /// The "btn-navbar-share" asset catalog image resource.
    static let btnNavbarShare = ImageResource(name: "btn-navbar-share", bundle: resourceBundle)

    /// The "colors-marker" asset catalog image resource.
    static let colorsMarker = ImageResource(name: "colors-marker", bundle: resourceBundle)

    /// The "green-marker" asset catalog image resource.
    static let greenMarker = ImageResource(name: "green-marker", bundle: resourceBundle)

    /// The "icon-camera" asset catalog image resource.
    static let iconCamera = ImageResource(name: "icon-camera", bundle: resourceBundle)

    /// The "icon-font-big" asset catalog image resource.
    static let iconFontBig = ImageResource(name: "icon-font-big", bundle: resourceBundle)

    /// The "icon-font-small" asset catalog image resource.
    static let iconFontSmall = ImageResource(name: "icon-font-small", bundle: resourceBundle)

    /// The "icon-logo" asset catalog image resource.
    static let iconLogo = ImageResource(name: "icon-logo", bundle: resourceBundle)

    /// The "icon-menu-horizontal" asset catalog image resource.
    static let iconMenuHorizontal = ImageResource(name: "icon-menu-horizontal", bundle: resourceBundle)

    /// The "icon-menu-vertical" asset catalog image resource.
    static let iconMenuVertical = ImageResource(name: "icon-menu-vertical", bundle: resourceBundle)

    /// The "icon-moon" asset catalog image resource.
    static let iconMoon = ImageResource(name: "icon-moon", bundle: resourceBundle)

    /// The "icon-navbar-close" asset catalog image resource.
    static let iconNavbarClose = ImageResource(name: "icon-navbar-close", bundle: resourceBundle)

    /// The "icon-navbar-font" asset catalog image resource.
    static let iconNavbarFont = ImageResource(name: "icon-navbar-font", bundle: resourceBundle)

    /// The "icon-navbar-search" asset catalog image resource.
    static let iconNavbarSearch = ImageResource(name: "icon-navbar-search", bundle: resourceBundle)

    /// The "icon-navbar-share" asset catalog image resource.
    static let iconNavbarShare = ImageResource(name: "icon-navbar-share", bundle: resourceBundle)

    /// The "icon-navbar-toc" asset catalog image resource.
    static let iconNavbarToc = ImageResource(name: "icon-navbar-toc", bundle: resourceBundle)

    /// The "icon-navbar-tts" asset catalog image resource.
    static let iconNavbarTts = ImageResource(name: "icon-navbar-tts", bundle: resourceBundle)

    /// The "icon-sun" asset catalog image resource.
    static let iconSun = ImageResource(name: "icon-sun", bundle: resourceBundle)

    /// The "ios-arrow-forward" asset catalog image resource.
    static let iosArrowForward = ImageResource(name: "ios-arrow-forward", bundle: resourceBundle)

    /// The "knob" asset catalog image resource.
    static let knob = ImageResource(name: "knob", bundle: resourceBundle)

    /// The "man-speech-icon" asset catalog image resource.
    static let manSpeechIcon = ImageResource(name: "man-speech-icon", bundle: resourceBundle)

    /// The "next-icon" asset catalog image resource.
    static let nextIcon = ImageResource(name: "next-icon", bundle: resourceBundle)

    /// The "no-marker" asset catalog image resource.
    static let noMarker = ImageResource(name: "no-marker", bundle: resourceBundle)

    /// The "pause-icon" asset catalog image resource.
    static let pauseIcon = ImageResource(name: "pause-icon", bundle: resourceBundle)

    /// The "pink-marker" asset catalog image resource.
    static let pinkMarker = ImageResource(name: "pink-marker", bundle: resourceBundle)

    /// The "play-icon" asset catalog image resource.
    static let playIcon = ImageResource(name: "play-icon", bundle: resourceBundle)

    /// The "prev-icon" asset catalog image resource.
    static let prevIcon = ImageResource(name: "prev-icon", bundle: resourceBundle)

    /// The "share-marker" asset catalog image resource.
    static let shareMarker = ImageResource(name: "share-marker", bundle: resourceBundle)

    /// The "triple-dot" asset catalog image resource.
    static let tripleDot = ImageResource(name: "triple-dot", bundle: resourceBundle)

    /// The "underline-marker" asset catalog image resource.
    static let underlineMarker = ImageResource(name: "underline-marker", bundle: resourceBundle)

    /// The "yellow-marker" asset catalog image resource.
    static let yellowMarker = ImageResource(name: "yellow-marker", bundle: resourceBundle)

}

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog color resource name.
    fileprivate let name: Swift.String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog image resource name.
    fileprivate let name: Swift.String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif