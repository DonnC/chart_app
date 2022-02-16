import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key,required this.title,required this.value}) : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 80,
        child: Card(
          elevation: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
              Text(
               title,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
