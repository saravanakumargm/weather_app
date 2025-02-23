import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          SizedBox(height: 12,),
          Icon(icon, size: 32,),
          SizedBox(height: 14,),
          Text(label),
          SizedBox(height: 14,),
          Text(value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
