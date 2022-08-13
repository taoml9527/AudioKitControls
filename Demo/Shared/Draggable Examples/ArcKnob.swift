import SwiftUI
import DraggableControl

class ArcKnobModel: ObservableObject {
    @Published var volume = 0.0
}

struct ArcKnob: View {

    @StateObject var model = ArcKnobModel()
    var rangeDegrees = 270.0

    var body: some View {
        GeometryReader { geo in
            Draggable(layout: .relativeRectilinear(ySensitivity: 2), value1: .constant(0), value2: $model.volume) {
                ZStack(alignment: .center) {
                    Circle()
                        .trim(from: 45.0 / 360.0, to: 315.0 / 360.0)
                        .rotation(.degrees(-rangeDegrees))
                        .stroke(Color.gray ,style: StrokeStyle(lineWidth: geo.size.width / 10, lineCap: .round))
                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.8)
                        .foregroundColor(.red)

                    // Stroke value trim of knob
                    Circle()
                        .trim(from: 45 / 360.0, to: (45 + model.volume * rangeDegrees) / 360.0)
                        .rotation(.degrees(-rangeDegrees))
                        .stroke(.red, style: StrokeStyle(lineWidth: geo.size.width / 10, lineCap: .round))
                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.8)

                    Text("\(String(format: "%0.2f", model.volume))")
                        .font(.largeTitle)
                        .foregroundColor(.gray)

                }.contentShape(Rectangle())

            }
        }
    }
}


struct ArcKnob_Previews: PreviewProvider {
    static var previews: some View {
        ArcKnob()
    }
}