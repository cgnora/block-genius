import 'dart:math';
import 'package:block_genius/data.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Block Genius',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Block Genius'),
        centerTitle: true,
        backgroundColor: Colors.yellow[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: (width / 200).floor(),
          children: all.map((e) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuizPage(title: e.name, list: e.list)));
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/${e.img}.png'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    FittedBox(child: Text(e.name)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String title;
  final List list;
  const QuizPage({
    super.key,
    required this.title,
    required this.list,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

dynamic shuffleAnswers(list) {
  dynamic currentIndex = list.length;
  while (currentIndex != 0) {
    dynamic randomIndex = (Random().nextInt(list.length)).floor();
    currentIndex--;

    dynamic temp = list[currentIndex];
    list[currentIndex] = list[randomIndex];
    list[randomIndex] = temp;
  }
  return list;
}

class _QuizPageState extends State<QuizPage> {
  late List answers = shuffleAnswers(List.from(widget.list));
  late final int total = widget.list.length;
  List input = [];
  List process = [];
  List output = [];
  int score = 0;

  void removeAll(data) {
    setState(() {
      input.remove(data);
      process.remove(data);
      output.remove(data);
      answers.remove(data);
      data.status = AnswerStatus.pending;
    });
  }

  void checkAnswer() {
    score = 0;
    List lists = [input, process, output];
    List answerType = [AnswerType.input, AnswerType.process, AnswerType.output];
    for (var index in [0, 1, 2]) {
      List currentList = lists[index];
      for (var e in currentList) {
        if (e.type == answerType[index]) {
          score++;
          setState(() {
            e.status = AnswerStatus.correct;
          });
        } else {
          setState(() {
            e.status = AnswerStatus.wrong;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text('Kuiz - ${widget.title}')),
        backgroundColor: Colors.yellow[100],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                score = 0;
                setState(() {
                  input = [];
                  process = [];
                  output = [];
                  answers = shuffleAnswers(List.from(widget.list));
                });
              },
              icon: const Icon(Icons.refresh),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: OutlinedButton(
              onPressed: () {
                String text = '';
                if (answers.isNotEmpty) {
                  text = 'Answer correctly!';
                } else {
                  checkAnswer();
                  text = 'Score: $score / $total';
                }
                var snackbar = SnackBar(content: Text(text));
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
              },
              child: const Text('Submit'),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.yellow[50],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: Row(
                        children: [
                          QuizFlexbox(
                            title: 'Input',
                            list: input,
                            onAccept: (data) {
                              removeAll(data);
                              input.add(data);
                            },
                          ),
                          const VerticalDivider(
                            color: Colors.red,
                            width: 20,
                          ),
                          QuizFlexbox(
                            title: 'Proses',
                            list: process,
                            onAccept: (data) {
                              removeAll(data);
                              process.add(data);
                            },
                          ),
                          const VerticalDivider(
                            color: Colors.red,
                            width: 20,
                          ),
                          QuizFlexbox(
                            title: 'Output',
                            flex: 1,
                            list: output,
                            onAccept: (data) {
                              removeAll(data);
                              output.add(data);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (width > 600)
                    SizedBox(
                      width: 150,
                      child: AnswerList(
                        list: answers,
                        onAccept: (data) {
                          removeAll(data);
                          answers.add(data);
                        },
                      ),
                    ),
                ],
              ),
            ),
            if (width <= 600)
              SizedBox(
                height: 60,
                child: AnswerList(
                  list: answers,
                  horizontal: true,
                  onAccept: (data) {
                    removeAll(data);
                    answers.add(data);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AnswerList extends StatefulWidget {
  final List list;
  final dynamic onAccept;
  final bool horizontal;
  const AnswerList({
    super.key,
    required this.list,
    required this.onAccept,
    this.horizontal = false,
  });

  @override
  State<AnswerList> createState() => _AnswerListState();
}

class _AnswerListState extends State<AnswerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: widget.horizontal
          ? const EdgeInsets.only(top: 10)
          : const EdgeInsets.only(left: 10),
      child: DottedBorder(
        dashPattern: const [10],
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return ListView(
              scrollDirection:
                  widget.horizontal ? Axis.horizontal : Axis.vertical,
              children: widget.list.map((e) {
                return Draggable(
                  data: e,
                  feedback: AnswerBox(text: e.val),
                  childWhenDragging: Container(),
                  child: AnswerBox(text: e.val),
                );
              }).toList(),
            );
          },
          onAcceptWithDetails: widget.onAccept,
        ),
      ),
    );
  }
}

class QuizFlexbox extends StatefulWidget {
  final String title;
  final int flex;
  final List list;
  final dynamic onAccept;
  const QuizFlexbox({
    super.key,
    required this.title,
    this.flex = 1,
    required this.list,
    required this.onAccept,
  });

  @override
  State<QuizFlexbox> createState() => _QuizFlexboxState();
}

class _QuizFlexboxState extends State<QuizFlexbox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Column(
        children: [
          Container(
            height: 25,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(4),
                child: DottedBorder(
                  color: Colors.green,
                  dashPattern: const [10],
                  child: DragTarget(
                    onAcceptWithDetails: widget.onAccept,
                    builder: (context, candidateData, rejectedData) {
                      return ListView(
                        children: widget.list.map((e) {
                          return Draggable(
                            data: e,
                            feedback: AnswerBox(text: e.val),
                            childWhenDragging: Container(),
                            child: AnswerBox(
                              text: e.val,
                              color: e.status == AnswerStatus.correct
                                  ? Colors.green
                                  : (e.status == AnswerStatus.wrong
                                      ? Colors.red
                                      : Colors.black),
                            ),
                          );
                        }).toList(),
                      );
                    },
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

class AnswerBox extends StatefulWidget {
  final String text;
  final Color color;
  const AnswerBox({super.key, required this.text, this.color = Colors.black});

  @override
  State<AnswerBox> createState() => _AnswerBoxState();
}

class _AnswerBoxState extends State<AnswerBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 50,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(color: widget.color), color: Colors.white),
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.black, fontSize: 12),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
