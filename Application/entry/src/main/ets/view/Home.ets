import StyleConstants from '../common/constants/StyleConstants';
import CommonConstants from '../common/constants/CommonConstants';
import MemoItem from './MemoItem';
import NotesDataModel from '../model/NotesDataModel';
import { FolderType, NotesInfoBean,notesItemArr} from '../viewmodel/NotesInfoViewModel';
import MainTypeViewModel from '../viewmodel/MainTypeViewModel';
import MainTypeModel from '../viewmodel/MainTypeModel';
import Logger from '../common/utils/Logger';
import dataStorage from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';
@Component
export default struct Home {
  @State MaintabBarArray: MainTypeModel[] = MainTypeViewModel.getDefaultTypeList();
  @State currentIndex: number = 0;
  @State allNotes: Array<NotesInfoBean> = [];
  @State selectNotes: Array<NotesInfoBean> = this.allNotes.sort();
  @State noteItem: NotesInfoBean = notesItemArr[0];
  @State folderType: Resource = $r('app.string.notes_all');
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  @Builder MyMenu(){
    Menu() {
      MenuItem({ content: $r('app.string.notes_all') })
        .onChange((selected) => {
          if(selected) {
            this.folderType = $r('app.string.notes_all');
            this.selectNotes = this.allNotes;
          }
        })
      MenuItem({ content: $r('app.string.notes_longterm') })
        .onChange((selected) => {
          if(selected){
            this.folderType = $r('app.string.notes_longterm');
            this.selectNotes = NotesDataModel.getSelectNotes(FolderType.Longterm, this.allNotes);
          }
        })
      MenuItem({ content: $r('app.string.notes_battle') })
        .onChange((selected) => {
          if(selected) {
            this.folderType = $r('app.string.notes_battle');
            this.selectNotes = NotesDataModel.getSelectNotes(FolderType.Battle, this.allNotes);
          }
        })
      MenuItem({ content: $r('app.string.notes_article') })
        .onChange((selected) => {
          if(selected){
            this.folderType = $r('app.string.notes_article');
            this.selectNotes = NotesDataModel.getSelectNotes(FolderType.Article, this.allNotes);
          }
        })
      MenuItem({ content: $r('app.string.notes_newworld') })
        .onChange((selected) => {
          if(selected){
            this.folderType = $r('app.string.notes_newworld');
            this.selectNotes = NotesDataModel.getSelectNotes(FolderType.Newworld, this.allNotes);
          }
        })
      MenuItem({ content: $r('app.string.notes_personal') })
        .onChange((selected) => {
          if(selected){
            this.folderType = $r('app.string.notes_personal');
            this.selectNotes = NotesDataModel.getSelectNotes(FolderType.Personal, this.allNotes);
          }
        })
      MenuItem({ content: $r('app.string.notes_outofGIS') })
        .onChange((selected) => {
          if(selected){
            this.folderType = $r('app.string.notes_outofGIS');
            this.selectNotes = NotesDataModel.getSelectNotes(FolderType.OutofGIS, this.allNotes);
          }
        })
    }
  }

  @Builder MainTabBuilder(index: number) {
    Column() {
      Text(this.MaintabBarArray[index].name)
        .height('100%')
        .fontSize(this.currentIndex === index ? '24fp' : '18fp')
        .fontWeight(this.currentIndex === index ? 700 : 400)
        .fontColor('#182431')
    }
    .padding({ left: '8vp', right: '8vp' })
    .margin({
      left: index === 0 ? '8vp' : 0,
      right: index === this.MaintabBarArray.length - 1 ? '8vp' : 0
    })
  }
  build() {
    Stack() {
      Tabs() {
        TabContent() {
          Column() {
            Column() {
              Row() {
                Row() {
                  Text(this.folderType)
                    .fontSize($r('app.float.font_size_large'))
                    .fontWeight(FontWeight.Normal)
                    .textAlign(TextAlign.Start)
                  Image($r('app.media.ic_arrow_down'))
                    .objectFit(ImageFit.Contain)
                    .height($r('app.float.arrow_down_height'))
                    .width($r('app.float.arrow_down_width'))
                    .margin({ left: $r('app.float.arrow_down_title_margin') })
                }
                .bindMenu(this.MyMenu)
              }
              .width(StyleConstants.CONTENT_WIDTH)
              .justifyContent(FlexAlign.SpaceBetween)
            }
            List({ space: StyleConstants.MEMO_LIST_SPACE }) {
              ForEach(this.selectNotes, (item: NotesInfoBean) => {
                ListItem() {
                  MemoItem({ noteItem: item })
                }
              }, (item: NotesInfoBean) => JSON.stringify(item))
            }
            .margin({ top: $r('app.float.list_container_margin') })
            .height(StyleConstants.NOTE_CONTENT_HEIGHT)
            .width(StyleConstants.FULL_WIDTH)
          }
          .backgroundColor($r('app.color.page_background'))
          .height(StyleConstants.FULL_HEIGHT)
        }
        .tabBar(this.MainTabBuilder(0))

        TabContent(){
          List({ space: StyleConstants.MEMO_LIST_SPACE }) {
            ForEach(this.selectNotes, (item: NotesInfoBean) => {
              ListItem() {
                MemoItem({ noteItem: item })
              }
            }, (item: NotesInfoBean) => JSON.stringify(item))
          }
          .margin({ top: '-55vp' })
          .height(StyleConstants.NOTE_CONTENT_HEIGHT)
          .width(StyleConstants.FULL_WIDTH)
        }
        .tabBar(this.MainTabBuilder(1))
        .backgroundColor($r('app.color.page_background'))

        TabContent(){

          List({ space: StyleConstants.MEMO_LIST_SPACE }) {
            ForEach(NotesDataModel.getfavouriteNotes(this.allNotes), (item: NotesInfoBean) => {
              ListItem() {
                MemoItem({ noteItem: item })
              }
            }, (item: NotesInfoBean) => JSON.stringify(item))
          }
          .margin({ top: '-55vp' })
          .height(StyleConstants.NOTE_CONTENT_HEIGHT)
          .width(StyleConstants.FULL_WIDTH)

        }
        .tabBar(this.MainTabBuilder(2))
        .backgroundColor($r('app.color.page_background'))
      }
      .barHeight('46vp')
      .height('100%')
      .barMode(BarMode.Scrollable)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .vertical(false)

      Navigator({ target: 'pages/NotesDetail', type: NavigationType.Replace }) {
        Row() {
          Image($r('app.media.ic_add'))
            .objectFit(ImageFit.Contain)
            .height($r('app.float.note_add_size'))
            .aspectRatio(1)
        }
        .margin({ right: $r('app.float.note_add_margin') })
      }
      .params({
        notesInfo: {
          'noteId': new Date().getTime().toString(),
          'title': '',
          'folder': FolderType.OutofGIS,
          'content': '',
          'imageArr': [],
          'time': new Date().toTimeString().split(' ')[0],
          'isFavorite': false
        },
        operationType: CommonConstants.ADD_NOTE
      })
    }
    .width('95%')
    .height('100%')
    .alignContent(Alignment.BottomEnd)
    .backgroundColor('white')
  }
  onPageShow() {
    this.getAllNotes();
  }
  async getAllNotes() {
    await NotesDataModel.saveDefaultData();
    try {
      let preferences = await dataStorage.getPreferences(this.context, CommonConstants.PREFERENCE_INSTANCE_NAME);
      let noteIds = await preferences.get(CommonConstants.PREFERENCE_NOTE_KEY, '');
      while (this.allNotes.length >= 1) {
        this.allNotes.pop();
      }
      JSON.parse(noteIds.toString()).forEach(async (item: NotesInfoBean) => {
        let note = await preferences.get(item.noteId, '');
        this.allNotes.push(JSON.parse(note.toString()));
      })
    } catch (err) {
      Logger.error('Get the value of noteIdArr failed with err:', err);
    }
  }
}
