import 'dart:math';

import 'package:equiz/src/constants/memory_game.dart';
import 'package:equiz/src/core/widgets/bottom_navigator.dart';
import 'package:equiz/src/utils/routing.dart';
import 'package:flutter/material.dart';

import 'entity/card_entity.dart';
import 'widgets/board_game.dart';

List<CardImage> _getRandomCardItems(int count, int min, int max) {
  List<int> numbers = List.generate(max - min + 1, (index) => index + min);
  List<int> originalList = numbers.take(count).toList();
  List<int> clonedList = [];

  // Clone each item twice
  for (var item in originalList) {
    clonedList.add(item);
    clonedList.add(item);
  }

  // Shuffle the cloned list
  clonedList.shuffle(Random());

  return clonedList.map((imgIndex) {
    return CardImage(
        imgPath: 'assets/images/memory_game/vegetables/$imgIndex.png');
  }).toList();
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late String selectedTopic = 'Vegetables';
  late bool isDisabledOnTap = false;
  late List<CardImage> allCardItems = _getRandomCardItems(18, 1, 40);
  late int crossAxisCount = 0;
  late int rowCount = 0;
  late int previousSelectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      setState(() {
        crossAxisCount = 6;
        rowCount = 6;
      });
    } else {
      setState(() {
        crossAxisCount = 4;
        rowCount = 9;
      });
    }

    return Scaffold(
        appBar: selectedTopic != '' ? _buildAppBar() : null,
        body: _buildBody(),
        bottomNavigationBar: selectedTopic == ''
            ? const MyBottomNavigationBar(
                currentRouteName: RoutingUtils.gameRoute)
            : null);
  }

// body methods:--------------------------------------------------------------
  Widget _buildBody() {
    if (selectedTopic == '') {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: MemoryGame.topics.map((
            topic,
          ) {
            return _buildTopic(topic);
          }).toList());
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: _buildCardItem()),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            selectedTopic = '';
          });
        },
      ),
      title: Text('Memory Game - $selectedTopic'),
    );
  }

  Widget _buildTopic(
    String topic,
  ) {
    return Flexible(
      child: Card(
        color: Colors.blue,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.white.withAlpha(30),
          onTap: () {
            setState(() {
              selectedTopic = topic;
            });
          },
          child: SizedBox(
            height: 80,
            child: Center(
              child: Text(topic),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth = constraints.maxWidth / crossAxisCount;
        final double itemHeight =
            (constraints.maxHeight - kToolbarHeight) / rowCount;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: crossAxisCount,
              childAspectRatio: itemWidth / itemHeight),
          itemCount: allCardItems.length,
          itemBuilder: (context, selectedIndex) {
            return CustomCard(
              isDisabled: allCardItems[selectedIndex].isDisable,
              isDisabledOnTap: isDisabledOnTap ||
                  allCardItems[selectedIndex].isDisabledOnTap,
              child: allCardItems[selectedIndex],
              onTap: () async {
                allCardItems[selectedIndex].isVisible = true;
                allCardItems[selectedIndex].isDisabledOnTap = true;

                setState(() {
                  allCardItems = allCardItems;
                  isDisabledOnTap = previousSelectedIndex != -1;
                  previousSelectedIndex = previousSelectedIndex == -1
                      ? selectedIndex
                      : previousSelectedIndex;
                });

                if (isDisabledOnTap) {
                  await Future.delayed(
                      const Duration(milliseconds: 1000), () {});

                  // tap 2nd
                  if (allCardItems[selectedIndex].imgPath ==
                      allCardItems[previousSelectedIndex].imgPath) {
                    allCardItems[selectedIndex].isDisable = true;
                    allCardItems[previousSelectedIndex].isDisable = true;
                  } else {
                    allCardItems[selectedIndex].isVisible = false;
                    allCardItems[selectedIndex].isDisabledOnTap = false;

                    allCardItems[previousSelectedIndex].isVisible = false;
                    allCardItems[previousSelectedIndex].isDisabledOnTap = false;
                  }

                  setState(() {
                    allCardItems = allCardItems;
                    isDisabledOnTap = false;
                    previousSelectedIndex = -1;
                  });
                }
              },
            );
          },
        );
      },
    );
  }
}
