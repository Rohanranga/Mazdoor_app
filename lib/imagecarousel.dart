import 'package:flutter/material.dart';
import 'package:mazdoor_user/phone/mobile.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final List<String> images = [
    'images/5.jpg',
    'images/3.png',
    'images/4.png',
  ];

  final List<String> titles = [
    'Need reliable Blue collar worker? We’re here to help',
    'Book trusted home repair experts for quick, quality service today!',
    'Find certified professionals for hassle-free home repairs anytime, anywhere!',
  ];

  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content (image carousel and other elements)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 300,
                              child: Image.asset(images[index], fit: BoxFit.contain),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),

                        // Bottom-left image for the first and third slide
                        if (index == 0)
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Image.asset(
                              'images/tv.png', // Replace with your bottom-left image path
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),

                        // Top-left image for the second slide
                        if (index == 1)
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Image.asset(
                              'images/papercutter.png', // Replace with your top-left image path
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        if (index == 2)
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Image.asset(
                              'images/fridge.png', // Replace with your top-left image path
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),

              // Dots indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    width: currentIndex == index ? 12.0 : 8.0,
                    height: currentIndex == index ? 12.0 : 8.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index ? Colors.orange : Colors.grey,
                    ),
                  );
                }),
              ),
              SizedBox(height: 10), // Adjust space between dots and arrow

              // Forward arrow button (orange)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (currentIndex != images.length - 1)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (currentIndex < images.length - 1) {
                              currentIndex++;
                              _pageController.animateToPage(
                                currentIndex,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // Skip button in bottom right corner
          Positioned(
            bottom: 16,
            right: 16,
            child: currentIndex != images.length - 1
                ? GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = images.length - 1; // Go to last slide
                  _pageController.animateToPage(
                    currentIndex,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange[300], // Light orange background
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.black, // Black foreground text
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
                : Container(), // Empty container if on the last slide
          ),

          // Next button for the last slide
          if (currentIndex == images.length - 1)
            Positioned(
              bottom: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  // Navigate to the next screen when "Next" is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Mobile()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange[300], // Light orange background
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.black, // Black foreground text
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
