import 'package:flutter/material.dart';
import 'package:gestionare_prod/models/listing.dart';
import 'package:gestionare_prod/providers/items_list.dart';
import 'package:gestionare_prod/providers/listings_providers.dart';
import 'package:gestionare_prod/widgets/added_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/new_item.dart';

class AddListingScreen extends StatefulWidget {
  static const routeName = '/add-listing-screen';

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  // current date for calendar
  DateTime _selectedDate = DateTime.now();

  // loading spinner logic
  var _isLoading = false;

  // temp listing
  // ignore: prefer_final_fields
  var _tempListing = Listing(
    id: '',
    title: '',
    dateTime: DateTime.now(),
    amount: 0,
    itemList: [],
  );

  // clear the memory regarding the controller
  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  // save form method
  Future<void> _saveForm() async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _form.currentState?.validate();
    if (isValid == false || isValid == null) {
      return;
    }
    _form.currentState?.save();
    try {
      // adding listing to db logic here ->
      await Provider.of<ListingProviders>(context, listen: false)
          .addListing(_tempListing);
    } catch (error) {
      await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('An error occured'),
                content: const Text('Something went wrong'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Okay'),
                  ),
                ],
              ));
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  // calendar picker for user
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((chosenDate) {
      if (chosenDate == null) {
        return;
      } else {
        _selectedDate = chosenDate;
      }
    });
  }

  // modal bottoom sheet when entering new item in the list
  void _startAddNewItem(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) => const NewItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Listing'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              // TODO: move form widget in separate file
              child: Form(
                key: _form,
                // title of the listing that will show in the list
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        // gets the introduced string
                        onSaved: (title) {
                          if (title != null) {
                            _tempListing = Listing(
                              id: _tempListing.id,
                              title: title,
                              dateTime: _tempListing.dateTime,
                              amount: _tempListing.amount,
                              itemList: _tempListing.itemList,
                            );
                          }
                        },
                        validator: (value) {
                          if (value == '') {
                            return 'Please provide a value';
                          }
                          return null;
                        },
                      ),
                      // calendar picker for app
                      Container(
                        // color: Colors.red,
                        height: 70,
                        child: Row(
                          children: [
                            Text(_selectedDate == null
                                ? 'No date chosen !'
                                : DateFormat.yMMMd().format(_selectedDate)),
                            MaterialButton(
                              onPressed: _presentDatePicker,
                              child: const Text(
                                'Choose date',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // here will come the list of items
                      Container(
                        height: (deviceSize.height - kToolbarHeight) / 2,
                        // scrollable list of items
                        child: Consumer<ItemListProvider>(
                          builder: (context, itemData, _) => ListView.builder(
                            itemBuilder: (context, index) => AddedItem(
                              itemInfo: itemData.itemsList[index],
                            ),
                            itemCount: itemData.itemsList.length,
                          ),
                        ),
                      ),
                      // TODO: insert sum money paid logic here -> this will update with the new changes (setState) when adding a new item
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Total amount paid money: '),
                      ),
                      // TODO: insert potential money logic here -> this will update with the new changes (setState) when adding a new item
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Potential money win: '),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: ElevatedButton(
        // pressing the button shows the modal bottom sheet for adding a new item
        onPressed: () => _startAddNewItem(context),
        child: const Text('Add new item'),
      ),
    );
  }
}
