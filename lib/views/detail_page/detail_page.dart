import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedImageIndex = 0;
  double textPositionX = 0; // Horizontal position
  double textPositionY = 0; // Vertical position
  double fontSize = 16; // Initial font size
  double containerWidth = 300; // Initial container width
  double containerHeight = 100; // Initial container height

  // Sample list of images (replace with your actual images)
  final List<String> imageOptions = [
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> festivalData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<String> images = List<String>.from(festivalData['images']);
    final List<String> quotes = List<String>.from(festivalData['quotes']);

    return Scaffold(
      appBar: AppBar(
        title: Text(festivalData['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                selectedImageIndex = (selectedImageIndex + 1) %
                    images.length; // Cycle through images
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the selected image with quotes on top
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 250, // Fixed height for the image
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(images[selectedImageIndex]),
                      fit: BoxFit.cover, // Use cover to maintain aspect ratio
                    ),
                  ),
                ),
                // Positioned quote container
                Positioned(
                  left: textPositionX,
                  top: textPositionY,
                  child: Container(
                    width: containerWidth, // Dynamic width
                    height: containerHeight, // Dynamic height
                    decoration: BoxDecoration(
                      color: Colors.black54, // Semi-transparent background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      quotes.isNotEmpty
                          ? quotes[0]
                          : "", // Display the first quote
                      style: TextStyle(fontSize: fontSize, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Display the festival description
            const SizedBox(height: 16),
            // Font Size Controls
            const Text(
              "Adjust Font Size:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (fontSize > 10) fontSize -= 2; // Decrease font size
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      fontSize += 2; // Increase font size
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Container Size Controls
            const Text(
              "Adjust Container Size:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (containerWidth > 100)
                        containerWidth -= 20; // Decrease width
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      containerWidth += 20; // Increase width
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() {
                      if (containerHeight > 50)
                        containerHeight -= 10; // Decrease height
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: () {
                    setState(() {
                      containerHeight += 10; // Increase height
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Position Controls
            const Text(
              "Adjust Quote Position:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_upward),
                  onPressed: () {
                    setState(() {
                      textPositionY -= 2; // Move up
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_downward),
                  onPressed: () {
                    setState(() {
                      textPositionY += 2; // Move down
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      textPositionX -= 2; // Move left
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      textPositionX += 2; // Move right
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Image Selector
            const Text(
              "Change Background Image:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownButton<int>(
              value: selectedImageIndex,
              onChanged: (value) {
                setState(() {
                  selectedImageIndex = value!; // Update the selected image
                });
              },
              items: List<DropdownMenuItem<int>>.generate(
                imageOptions.length,
                (index) => DropdownMenuItem(
                  value: index,
                  child: Text('Image ${index + 1}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
