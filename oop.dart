import 'dart:io';

abstract class LibraryItem {
  int id;
  String title;
  int year;

  LibraryItem(this.id, this.title, this.year);

  @override
  String toString() => 'ID: $id, Title: $title, Year: $year';
}

class Book extends LibraryItem {
  String author;

  Book(int id, String title, int year, this.author) : super(id, title, year);

  @override
  String toString() => super.toString() + ', Author: $author';
}

class Magazine extends LibraryItem {
  int issueNumber;

  Magazine(int id, String title, int year, this.issueNumber) : super(id, title, year);

  @override
  String toString() => super.toString() + ', Issue Number: $issueNumber';
}

abstract class Loanable {
  void checkOut();
  void returnItem();
}

class LoanItem implements Loanable {
  bool isLoaned = false;

  @override
  void checkOut() {
    isLoaned = true;
    print('Item checked out.');
  }

  @override
  void returnItem() {
    isLoaned = false;
    print('Item returned.');
  }
}

class Library {
  List<LibraryItem> items = [];

  Library(String filePath) {
    _initializeFromFile(filePath);
  }

  void _initializeFromFile(String filePath) {
    final lines = File(filePath).readAsLinesSync();
    for (var line in lines) {
      final parts = line.split(',');
      if (parts[0] == 'Book') {
        items.add(Book(int.parse(parts[1]), parts[2], int.parse(parts[3]), parts[4]));
      } else if (parts[0] == 'Magazine') {
        items.add(Magazine(int.parse(parts[1]), parts[2], int.parse(parts[3]), int.parse(parts[4])));
      }
    }
  }

  void listItems() {
    for (var item in items) {
      print(item);
    }
  }
}

void main() {
  final library = Library('library_items.txt');
  library.listItems();

  // Demonstrate LoanItem usage
  LoanItem loanItem = LoanItem();
  loanItem.checkOut();
  loanItem.returnItem();
}
