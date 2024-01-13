import 'package:floor/floor.dart';
import 'package:hyrule/domain/models/entry.dart';

@dao
abstract class EntryDao {
  @Query("SELECT * FROM ENTRY")
  Future<List<Entry>> getAllEntries();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(Entry entry);

  @delete
  Future<void> remove(Entry entry);
}
