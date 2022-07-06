//
//  idkwhattonamethiswidget.swift
//  idkwhattonamethiswidget
//
//  Created by Alexis Jost on 05.07.22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct idkwhattonamethiswidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily{
        case .accessoryInline:
                Text("Alexis")
            
        case .accessoryCircular:
                Text("sus")
            
        case .accessoryRectangular:
                Text("Make sure to work on your app!")
            
        default:
            Text("Not implemented")
        }
    }
}

@main
struct idkwhattonamethiswidget: Widget {
    let kind: String = "idkwhattonamethiswidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            idkwhattonamethiswidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

struct idkwhattonamethiswidget_Previews: PreviewProvider {
    static var previews: some View {
        idkwhattonamethiswidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
            .previewDisplayName("InLine")
        idkwhattonamethiswidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("Circular")
        idkwhattonamethiswidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            .previewDisplayName("Rectangular")
    }
}
