typedef Sort = int Function(dynamic a, dynamic b);
typedef SortF = Sort Function(String sortField);

SortF alphabetic = (String sortField) => (a, b) {
      return a[sortField].toLowerCase().compareTo(b[sortField].toLowerCase());
    };

SortF number = (String sortField) => (a, b) {
      return a[sortField].compareTo(b[sortField]);
    };
