//
//  SightSkyVueWidget.swift
//  SightSkyVueWidget
//
//  Created by Augusto Simionato on 24/05/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct SightSkyVueWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(systemName: "cloud.fill")
                .foregroundColor(Color(red: 255, green: 255, blue: 255, opacity: 0.5))
                .font(.system(size: 25))
            
            Image(systemName: "cloud.fill")
                .foregroundColor(Color(red: 255, green: 255, blue: 255, opacity: 0.5))
                .font(.system(size: 40))
        }
        .frame(width: .infinity)
    }
}

struct SightSkyVueWidget: Widget {
    let kind: String = "SightSkyVueWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SightSkyVueWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("SightSkyVue")
        .description("Access weather information with one tap!")
        .supportedFamilies([.accessoryCircular])
    }
}

struct SightSkyVueWidget_Previews: PreviewProvider {
    static var previews: some View {
        SightSkyVueWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
