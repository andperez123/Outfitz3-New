import SwiftUI

struct GeneratedOutfitsView: View {
    let generatedImages: [String]
    let generatedText: String
    let occasion: String
    let style: String
    let colors: String
    let additionalPreferences: String
    let mainClothingPiece: String
    let details: String
    let accessories: String

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    // Title Section
                    Text("Check Your Fitz")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    // Image Section
                    ForEach(generatedImages, id: \.self) { imageUrl in
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.9) // Maintain some padding from edges
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                                .padding(.horizontal)
                        } placeholder: {
                            ProgressView()
                        }
                    }

                    // Description Section
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(parseGeneratedText(generatedText), id: \.self) { textPart in
                            if textPart.starts(with: "Title: ") {
                                Text(textPart.replacingOccurrences(of: "Title: ", with: ""))
                                    .font(.largeTitle)
                                    .bold()
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.white.opacity(0.2))
                                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    )
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.top, 5)
                            } else if textPart.contains(":") {
                                let parts = textPart.split(separator: ":", maxSplits: 1).map(String.init)
                                VStack(alignment: .leading) {
                                    Text(parts[0])
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(parts[1])
                                        .padding(.top, 2)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white.opacity(0.2))
                                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                )
                                .padding(.horizontal)
                                .padding(.top, 5)
                            } else {
                                Text(textPart)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.white.opacity(0.2))
                                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    )
                                    .padding(.horizontal)
                                    .padding(.top, 5)
                            }
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }

    private func parseGeneratedText(_ text: String) -> [String] {
        // Split the text into parts based on markdown formatting (e.g., **title**, **description**)
        let lines = text.split(separator: "\n").map(String.init)
        var formattedLines: [String] = []

        for line in lines {
            let formattedLine = line.replacingOccurrences(of: "**", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
            if !formattedLine.isEmpty && !formattedLine.contains("Outfit Title:") {
                formattedLines.append(formattedLine)
            }
        }

        //print("=========================================")
        //print("Parsed Generated Text:")
        //formattedLines.forEach { print($0) }
        //print("=========================================")

        return formattedLines
    }
}

struct GeneratedOutfitsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratedOutfitsView(
            generatedImages: ["https://example.com/image.png"],
            generatedText: """
**Outfit Title: Radiant Elegance**

**Dress:** A floor-length A-line gown in a rich royal blue satin fabric, featuring a sweetheart neckline and a fitted bodice that elegantly flows into a voluminous skirt, exuding an air of timeless sophistication.

**Accessories:** Bold statement earrings adorned with vibrant gemstones in shades of fuchsia and gold, adding a touch of drama and brilliance that perfectly complements the gown.

**Shoes:** Strappy metallic gold heels that add a hint of glamour while providing a subtle shine, elevating the overall look without overpowering it.

**Clutch:** A sleek, structured clutch in a bright coral hue with gold accents, offering a chic contrast to the blue gown and providing just enough space for essentials
""",
            occasion: "Formal evening gala",
            style: "Classic and timeless",
            colors: "Bright and Bold Colors",
            additionalPreferences: "I prefer breathable fabrics and comfort.",
            mainClothingPiece: "Elegant dress",
            details: "Delicate lace and flowing fabric",
            accessories: "Statement earrings"
        )
    }
}
