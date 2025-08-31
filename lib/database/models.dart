import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/database/Hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
enum TaskStatus {
  @HiveField(0)
  completed,

  @HiveField(1)
  pending,

  @HiveField(2)
  deleted,
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  TaskStatus status;

  Task({required this.title, this.status = TaskStatus.pending});
}

class SelectedItems extends ChangeNotifier {
  List<int> _selectedItemsList = [];

  List<int> get selectedItemsList => _selectedItemsList;

  void UpdateSelection(bool? value, int id) {
    if (value ?? false) {
      _selectedItemsList.add(id);
    } else {
      _selectedItemsList.remove(id);
    }
    notifyListeners();
  }

  void ClearSelectedItem() {
    _selectedItemsList.clear();
    notifyListeners();
  }

  bool IsSelected(int id) {
    if (_selectedItemsList.contains(id)) {
      return true;
    }
    return false;
  }
}

class SelectionMode extends ChangeNotifier {
  bool _selectionMode = false;
  bool _isAllTaskSelected = false;

  bool get selectionModeValue => _selectionMode;
  bool get isAllTaskSelected => _isAllTaskSelected;

  void ToggleSelectionMode(bool? value, BuildContext context) {
    if (value ?? false){
      _selectionMode = true;
      notifyListeners();
      return;
    }
    else{
      _selectionMode = false;
      ToggleAllTaskSelection(false, context);
    }


    Provider.of<SelectedItems>(context, listen: false).ClearSelectedItem();
    notifyListeners();
  }

  void ToggleAllTaskSelection(bool? value, BuildContext context) async {
    if (value ?? false) {
      _isAllTaskSelected = true;
      List<dynamic> ids = (await TaskManager.GetIds()).toList();
      final selectedItemsProvider = Provider.of<SelectedItems>(
        context,
        listen: false,
      );
      for (var id in ids) {
        selectedItemsProvider.UpdateSelection(true, id as int);
      }
      notifyListeners();
    } else {
      _isAllTaskSelected = false;
      Provider.of<SelectedItems>(context, listen: false).ClearSelectedItem();

      notifyListeners();
    }
  }
}
