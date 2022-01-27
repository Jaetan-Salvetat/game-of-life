class Game{
  static List<List<bool>> _array;

  static List<List<bool>> initArray(int row, int col){
    _array = List.generate(row, (i) => List.generate(col.round(), (j) => false));
    return _array;
  }

  static List<List<bool>> update(List<List<bool>> arr){
    var res = _array;
    for(int row = 0; row < arr.length; row++){
      for(int col = 0; col < arr[0].length; col++){
        if(arr[row][col] && _canSurvive(arr, row, col, true)){
          res[row][col] = true;
        }
        if(!arr[row][col] && _canSurvive(arr, row, col, false)){
          res[row][col] = true;
        }
      }
    }

    return res;
  }

  static List<List<bool>> reset(){
    return _array;
  }


  static bool _canSurvive(List<List<bool>> arr, int rowId, int colId, bool isAlive){
    int nbrCount = 0;
    int startRow = rowId == 0 ? 0 : -1;
    int endRow = rowId < arr.length-1 ? 2 : 1;
    int startCol = colId == 0 ? 0 : -1;
    int endCol = colId < arr[0].length-1 ? 2 : 1;

    for(int i = startRow; i < endRow; i++){
      int row = rowId + i;
      for(int j = startCol; j < endCol; j++){
        int col = colId + j;

        if(row == rowId && col == colId) continue;
        if(arr[row][col]) nbrCount++;
      }
    }

    if(nbrCount == 3 || nbrCount == 2 && isAlive) return true;
    if(nbrCount == 3 && !isAlive) return true;
    return false;
  }
}
