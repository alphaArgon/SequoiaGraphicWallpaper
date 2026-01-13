import AppKit
import ImageIO


let monterey = CGImageSourceCreateWithURL(URL(filePath: "./Monterey Graphic.heic") as CFURL, nil)!
assert(CGImageSourceGetCount(monterey) == 8)

let sequoia  = CGImageDestinationCreateWithURL(URL(filePath: "./Sequoia Graphic.heic") as NSURL,
                                               "public.heic" as CFString, 8, nil)!

let quality = [kCGImageDestinationLossyCompressionQuality: 1] as CFDictionary

for (i, name) in [
    "Sequoia.solarNoon.jpg",
    "Sequoia.solarMidnight.jpg",
    "Sequoia.dawn.jpg",
    "Sequoia.sunrise.jpg",
    "Sequoia.midMorning.jpg",
    "Sequoia.lateAfternoon.jpg",
    "Sequoia.sunset.jpg",
    "Sequoia.dusk.jpg",
].enumerated() {
    let image = NSImage(contentsOfFile: "./P3/" + name)!
    CGImageDestinationAddImageAndMetadata(sequoia, image.cgImage(forProposedRect: nil, context: nil, hints: nil)!,
                                          CGImageSourceCopyMetadataAtIndex(monterey, i, nil),
                                          quality)
}

CGImageDestinationFinalize(sequoia)
Thread.sleep(forTimeInterval: 5)
