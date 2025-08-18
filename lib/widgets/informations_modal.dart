import 'package:flutter/material.dart';

class InformationsWidget extends StatefulWidget {
  const InformationsWidget({super.key});

  @override
  State<InformationsWidget> createState() => _InformationsWidgetState();
}

class _InformationsWidgetState extends State<InformationsWidget> {
  DateTime time = DateTime(10);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 25, 50, 25),
      margin: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Color(0xFF0891B2).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Estimated waiting Time : ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4B5563),
                ),
              ),
              Text(
                "5",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Votre Rang : ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4B5563),
                ),
              ),
              Text(
                "155",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}
