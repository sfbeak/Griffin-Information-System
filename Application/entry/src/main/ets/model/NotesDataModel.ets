import common from '@ohos.app.ability.common';
import dataStorage from '@ohos.data.preferences';
import { FolderType, noteIdArray, NotesInfoBean, notesItemArr } from '../viewmodel/NotesInfoViewModel';
import Logger from '../common/utils/Logger';
import CommonConstants from '../common/constants/CommonConstants';

class NotesDataModel {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  async saveDefaultData() {
    try {
      let preferences = await dataStorage.getPreferences(this.context, CommonConstants.PREFERENCE_INSTANCE_NAME);
      let isExist = await preferences.has(CommonConstants.PREFERENCE_NOTE_KEY);
      if (!isExist) {
        preferences.put(CommonConstants.PREFERENCE_NOTE_KEY, JSON.stringify(noteIdArray));
        preferences.flush();
        notesItemArr.forEach((item: NotesInfoBean) => {
          let notes: NotesInfoBean = item;
          let res = preferences.put(item.noteId, JSON.stringify(notes));
          preferences.flush();
          res.then(() => {
            Logger.info('Put the value successfully.' + item.noteId);
          }).catch((err: Error) => {
            Logger.error(`Put the value failed with err: ${err}`);
          })
        })
      }
    } catch (err) {
      Logger.error(`Failed to get preferences. Error = ${err}`);
    }
  }

  getSelectNotes(flag: FolderType, allNotes: Array<NotesInfoBean>): Array<NotesInfoBean> {
    return allNotes.filter((item: NotesInfoBean) => item.folder === flag);
  }
  getfavouriteNotes( allNotes: Array<NotesInfoBean>): Array<NotesInfoBean> {
    return allNotes.filter((item: NotesInfoBean) => item.isFavorite===true);
  }
}

const NotesData = new NotesDataModel();

export default NotesData;