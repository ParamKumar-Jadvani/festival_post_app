import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedImageIndex = 0;
  double fontSize = 16;
  double containerWidth = 300;
  double containerHeight = 100;
  Color textColor = Colors.black;
  Color backgroundColor = Colors.white;
  TextAlign textAlign = TextAlign.center;
  bool useImageBackground = true;
  String selectedQuote = '';
  String customQuote = '';
  bool useCustomQuote = false;
  String selectedFontFamily = 'Roboto';

  // Track the position of the text container
  Offset containerPosition = const Offset(50, 50);
  Offset dragStartPosition = Offset.zero;

  late List<String> imageOptions = [
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/image3.jpg',
  ];

  final List<String> inbuiltQuotes = [
    "Festival Quote 1",
    "Festival Quote 2",
    "Festival Quote 3",
  ];

  final List<String> fontFamilies = [
    'Roboto',
    'Arial',
    'Courier New',
    'Georgia',
    'Times New Roman',
  ];

  void _openColorPicker(Color currentColor, bool isTextColor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick a Color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                setState(() {
                  if (isTextColor) {
                    textColor = color;
                  } else {
                    backgroundColor = color;
                  }
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.7,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> festivalData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    imageOptions = List<String>.from(festivalData['images']);
    final List<String> quotes = List<String>.from(festivalData['quotes']);

    return Scaffold(
      appBar: AppBar(
        title: Text(festivalData['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the selected image or background color
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: useImageBackground
                        ? DecorationImage(
                            image: AssetImage(imageOptions[selectedImageIndex]),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: useImageBackground
                        ? Colors.transparent
                        : backgroundColor,
                  ),
                ),
                // Movable text container
                Positioned(
                  left: containerPosition.dx,
                  top: containerPosition.dy,
                  child: GestureDetector(
                    onPanStart: (details) {
                      dragStartPosition = details.localPosition;
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        containerPosition = Offset(
                          containerPosition.dx + details.delta.dx,
                          containerPosition.dy + details.delta.dy,
                        );
                      });
                    },
                    child: Container(
                      width: containerWidth,
                      height: containerHeight,
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          useCustomQuote
                              ? customQuote
                              : selectedQuote.isNotEmpty
                                  ? selectedQuote
                                  : quotes[0],
                          style: TextStyle(
                            fontSize: fontSize,
                            color: textColor,
                            fontFamily: selectedFontFamily,
                          ),
                          textAlign: textAlign,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Background Picker: Color or Image
            const Text(
              "Background Options:",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      useImageBackground = true; // Use image background
                    });
                  },
                  child: const Text("Image Background"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      useImageBackground = false; // Use color background
                    });
                  },
                  child: const Text("Color Background"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // If using image background, show the image selection
            if (useImageBackground)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Image:",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageOptions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedImageIndex == index
                                    ? Colors.blue
                                    : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(imageOptions[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

            // Color Picker for background if using color background
            if (!useImageBackground)
              ElevatedButton(
                onPressed: () => _openColorPicker(backgroundColor, false),
                child: const Text("Pick Background Color"),
              ),

            const SizedBox(height: 16),

            // Editable section: make this part scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Font Size Controls
                    const Text(
                      "Adjust Font Size:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (fontSize > 10) fontSize -= 2;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              fontSize += 2;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Container Size Controls with Titles
                    const Text(
                      "Adjust Text Container Size:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text("Width:"),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (containerWidth > 100)
                                        containerWidth -= 20;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      containerWidth += 20;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Height:"),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  onPressed: () {
                                    setState(() {
                                      if (containerHeight > 50)
                                        containerHeight -= 10;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle),
                                  onPressed: () {
                                    setState(() {
                                      containerHeight += 10;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Text Alignment Controls
                    const Text(
                      "Select Text Alignment:",
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              textAlign = TextAlign.start;
                            });
                          },
                          child: const Text("Start"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              textAlign = TextAlign.center;
                            });
                          },
                          child: const Text("Center"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              textAlign = TextAlign.end;
                            });
                          },
                          child: const Text("End"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Text Color Picker
                    ElevatedButton(
                      onPressed: () => _openColorPicker(textColor, true),
                      child: const Text("Pick Text Color"),
                    ),
                    const SizedBox(height: 16),

                    // Font Family Selection
                    const Text(
                      "Select Font Family:",
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton<String>(
                      value: selectedFontFamily,
                      onChanged: (value) {
                        setState(() {
                          selectedFontFamily = value!;
                        });
                      },
                      items: fontFamilies.map((font) {
                        return DropdownMenuItem(
                          value: font,
                          child: Text(font),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Custom Quote Input or Inbuilt Quote Selection
                    const Text(
                      "Quote Options:",
                      style: TextStyle(fontSize: 16),
                    ),
                    SwitchListTile(
                      title: const Text("Use Custom Quote"),
                      value: useCustomQuote,
                      onChanged: (value) {
                        setState(() {
                          useCustomQuote = value;
                        });
                      },
                    ),
                    if (useCustomQuote)
                      TextField(
                        decoration: const InputDecoration(
                          labelText: "Enter Custom Quote",
                        ),
                        onChanged: (value) {
                          setState(() {
                            customQuote = value;
                          });
                        },
                      )
                    else
                      DropdownButton<String>(
                        value: selectedQuote.isNotEmpty
                            ? selectedQuote
                            : inbuiltQuotes[0],
                        onChanged: (value) {
                          setState(() {
                            selectedQuote = value!;
                          });
                        },
                        items: inbuiltQuotes.map((quote) {
                          return DropdownMenuItem(
                            value: quote,
                            child: Text(quote),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
