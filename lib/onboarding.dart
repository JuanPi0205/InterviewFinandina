import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interview_finandina/components/onboardingData.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = onboardingData();
  final pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.toInt();
        print("----->este es el total de items: \${controller.items.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              body(),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              height: 64,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: Colors.white.withOpacity(0.1),
              ),
              width: double.infinity,
              child: currentIndex == controller.items.length - 1 ? AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: ElevatedButton(
                  onPressed: () {
                    print("----->este es el total de items: \${controller.items.length}");
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.white,
                    minimumSize:
                    Size(MediaQuery.of(context).size.width, 54),
                  ),
                  child: const Text(
                    "Libera tu banca",
                    style: TextStyle(
                      color: Color(0xFF7C24DB),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,),
                    textAlign: TextAlign.center,

                  ),
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                    child: const Text("Saltar",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.items.length,
                            (dotIndex) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentIndex == dotIndex ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: currentIndex == dotIndex
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (currentIndex < controller.items.length - 1) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed('/home');
                      }
                    },
                    child: const Icon(Icons.arrow_forward, size: 24),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Body
  Widget body() {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
            print("actual index------->${currentIndex}");
          });
        },
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          final item = controller.items[index];
          bool isSvg = item.image.endsWith('.svg');

          if (index == 0) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SvgPicture.asset(
                      item.backgroundImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 48),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 60.9),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 60.9),
                                    child: SvgPicture.asset(
                                      item.image,
                                      width:  77,
                                      height: 77,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                  const SizedBox(height: 23.89), // Space above the logo
                                  // RichText for formatted text
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      children: [
                                        const TextSpan(text: "Con ", style: TextStyle(fontSize: 24)),
                                        const TextSpan(
                                          text: "Banco Finandina",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                        ),
                                        const TextSpan(text: " tienes el poder de ser libre", style: TextStyle(fontSize: 24)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 55),
                                child: Column(
                                  children: const [
                                    Text(
                                      "Descubre lo que puedes hacer con tu",
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                    Text(
                                      "App Banco Finandina",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 64),
                    ],
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  item.backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 60.9),
                  if (index != 0)
                    SvgPicture.asset(
                      item.logo,
                      width: 37.53,
                      height: 37.53,
                      alignment: Alignment.center,
                    ),
                  SizedBox(height: index == 1 ? 60.9 : index == 2 ? 78.53 : index == 3 ? 69.05 : index == 4 ? 10.92 : index == 5 ? 32.94 : 42.92,),
                  isSvg
                      ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: SvgPicture.asset(
                      item.image,
                      width: index == 3 ? 375 : 295,
                      height: index == 3 ? 385 : 275,
                      alignment: index == 0
                          ? Alignment.topCenter
                          : Alignment.center,
                    ),
                  )
                      : Padding(
                    padding: EdgeInsets.only(left: index == 1 ? 40 : index == 2 ? 62.53 : index == 3 || index == 5 || index == 6 ? 0: 16.86, top: index == 1 ? 80.57 : index == 2 ? 49.04 : index == 3 ? 0 : index == 4 ? 32.94 : 42.92 ),
                    child: Image.asset(
                      item.image,
                      width: index == 1 ? 295 : index == 3 || index == 5 || index == 6 ? MediaQuery.of(context).size.width : 342,
                      height: index == 1 ? 275.93 : index == 3 || index == 5 || index == 6 ? 385 : 344,
                      alignment: index == 0 ? Alignment.topCenter : index == 5 ? Alignment.centerRight : index == 6 ? Alignment.centerRight : Alignment.center,
                    ),
                  ),
                  SizedBox(height: index == 2 ? 0:26),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      item.tittle,
                      style: const TextStyle(
                          fontSize: 28,
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  SizedBox(height: index == 0 ? 251 : 10),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: index == 2 ? 10: index == 3 ? 5 : index == 4 ? 20 : 30),
                    child: Text(
                      item.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
