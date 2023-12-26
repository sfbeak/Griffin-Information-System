
export class NoteIdBean {
  noteId: string;

  constructor(noteId: string) {
    this.noteId = noteId;
  }
}

/**
 * Folder type enum.
 */
export enum FolderType {
  All = 'all',
  Longterm = 'longterm',
  Battle = 'battle',
  Article = 'article',
  Newworld = 'newworld',
  Personal = 'personal',
  OutofGIS = 'outofGIS'
}

/**
 * NotesInfo item information.
 */
export class NotesInfoBean {
  /**
   * Note Id.
   */
  noteId: string;

  /**
   * Note title.
   */
  title: string;

  /**
   * Folder type.
   */
  folder: FolderType;

  /**
   * Create time.
   */
  time: string;

  /**
   * Collect note.
   */
  isFavorite: boolean;

  /**
   * Note images.
   */
  imageArr: string[];

  /**
   * Note content.
   */
  content: string;

  /**
   * constructor.
   */
  constructor(noteId: string, title: string, folder: FolderType, time: string, isFavorite: boolean,
              content: string) {
    this.noteId = noteId;
    this.title = title;
    this.folder = folder;
    this.time = time;
    this.isFavorite = isFavorite;
    this.content = content;
  }
}

export const notesItemArr: NotesInfoBean[] = [
  new NotesInfoBean('1646121972443', '早晨锻炼身体', FolderType.Personal, '7:30:58', true,
    'Long run 3 km'),
  new NotesInfoBean('1646121972444', 'Breakfast', FolderType.Personal, '8:00:12', false,
    'Milk and bread'),
  new NotesInfoBean('1646121972445', 'Go to work', FolderType.Longterm, '8:30:36', false,
    'Take the 11th bus'),
  new NotesInfoBean('1646121972446', 'Lunches', FolderType.OutofGIS, '12:20:45', true,
    'Sweet and sour ribs potato shreds'),
  new NotesInfoBean('1646121972447', 'Computer Lessons', FolderType.Longterm, '3:30:06', true,
    'Learning HarmonyOS')
];

export const noteIdArray: NoteIdBean[] = [new NoteIdBean('1646121972443'), new NoteIdBean('1646121972444'),
  new NoteIdBean('1646121972445'), new NoteIdBean('1646121972446'), new NoteIdBean('1646121972447')];