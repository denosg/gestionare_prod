import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: IconButton(
        splashRadius: 40,
        // TODO: go to add new listing screen
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
    );
  }
}
