import 'dart:math';

import 'package:equiz/src/constants/memory_game.dart';
import 'package:equiz/src/core/widgets/bottom_navigator.dart';
import 'package:equiz/src/utils/routing.dart';
import 'package:flutter/material.dart';

import 'widgets/board_game.dart';

/// Generates a list of `count` unique random numbers from `min` to `max` (inclusive)
List<int> _getRandomItems(int count, int min, int max) {
  // Create a list of numbers from `min` to `max`
  List<int> numbers = List.generate(max - min + 1, (index) => index + min);
  // Shuffle the list to randomize
  // numbers.shuffle(Random());
  // Take the first `count` numbers
  List<int> originalList = numbers.take(count).toList();

  List<int> clonedList = [];

  // Clone each item twice
  for (var item in originalList) {
    clonedList.add(item);
    clonedList.add(item);
  }

  // Shuffle the cloned list
  clonedList.shuffle(Random());

  return clonedList;
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late String selectedTopic = 'a';
  late List<int> showItems = [];
  late List<int> disabledItems = [];
  final List<int> allCardItems = _getRandomItems(18, 1, 40);
  late bool isDisabledOnTap = false;

  @override
  Widget build(BuildContext context) {
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
        late int crossAxisCount = 4;
        late int rowCount = 9;

        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          crossAxisCount = 6;
          rowCount = 6;
        }

        final double itemWidth = constraints.maxWidth / crossAxisCount;
        final double itemHeight =
            (constraints.maxHeight - kToolbarHeight) / rowCount;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? rowCount
                      : crossAxisCount,
              childAspectRatio: itemWidth / itemHeight),
          itemCount: allCardItems.length,
          itemBuilder: (context, index) {
            return CustomCard(
              isDisabled: disabledItems.contains(index),
              isDisabledOnTap: isDisabledOnTap,
              child: (showItems.contains(index))
                  ? Image.asset(
                      'assets/images/memory_game/${allCardItems[index]}.png',
                      fit: BoxFit.cover,
                    )
                  : null,
              onTap: () async {
                showItems.add(index);
                setState(() {
                  showItems = showItems;
                  isDisabledOnTap = showItems.length % 2 == 0;
                });

                if (showItems.length >= 2 && showItems.length % 2 == 0) {
                  final previousIndex = showItems[showItems.length - 2];
                  final currentIndex = showItems[showItems.length - 1];

                  if (allCardItems[previousIndex] ==
                      allCardItems[currentIndex]) {
                    disabledItems.add(previousIndex);
                    disabledItems.add(currentIndex);
                    setState(() {
                      disabledItems = disabledItems;
                      isDisabledOnTap = false;
                    });
                  } else {
                    await Future.delayed(
                        const Duration(milliseconds: 1000), () {});
                    showItems.removeLast();
                    showItems.removeLast();
                    setState(() {
                      showItems = showItems;
                      isDisabledOnTap = false;
                    });
                  }
                }
              },
            );
          },
        );
      },
    );
  }
}
