# GIS留言板（ArkTS）实现
## 介绍
GIS匿名版是一个角色扮演互动社区，此软件可以提供结交朋友，语C娱乐等功能，本项目还在开发中，当前版本为测试版本，不代表最终品质。
### 软件架构
![](Application/screenshots/20ebe951fb0dcaa2522d9bb59ab17c20.png)

本篇只对核心代码进行讲解，对于完整代码，在github,gitee与Atomgit源码中提供下载方式。
```
├──entry/src/main/ets              
├─common
│  │  Constants.ts
│  │  CountryViewModel.ets
│  │  Log.ts
│  │  
│  ├─constants
│  │      CommonConstants.ets
│  │      StyleConstants.ets
│  │      
│  ├─database
│  │      PreferencesUtil.ets
│  │      
│  └─utils
│          Format.ets
│          GlobalContext.ets
│          Logger.ets
│          
├─components
│  │  AuthDialog.ets
│  │  AuthResult.ets
│  │  CommonActionButton.ets
│  │  HomeButton.ets
│  │  
│  └─image-picker
│          Image.ts
│          ImagePicker.ets
│          
├─entryability
│      EntryAbility.ts
│      
├─entryformability
│      EntryFormAbility.ts
│      
├─giswidget
│  └─pages
│          GISwidgetCard.ets
│          
├─model
│      NotesDataModel.ets
│      
├─pages
│      About.ets
│      Forget.ets
│      Invite.ets
│      Login.ets
│      MainPage(Broken).ets
│      MainPage.ets
│      NotesDetail.ets
│      NotesView.ets
│      Register.ets
│      Settings.ets
│      ViewNotesDetail.ets
│      
├─services
│      AgcConfig.ts
│      Auth.ts
│      Function.ts
│      Storage.ts
│      
├─typings
│      enum.d.ets
│      
├─view
│      BottomBar.ets
│      ChatItemComponent.ets
│      ConfirmDialog.ets
│      Home.ets
│      LoginedProfile.ets
│      MemoItem.ets
│      Messages.ets
│      Profile.ets
│      TitleBarComponent.ets
│      
└─viewmodel
        ChatData.ets
        ItemDirection.ets
        MainTypeModel.ets
        MainTypeViewModel.ets
        NewsTypeModel.ets
        NewsTypeViewModel.ets
        NotesInfoViewModel.ets
        SetViewModel.ets
```

## 主页面
![](Application/screenshots/1.png)

点击加号即可发帖

![](Application/screenshots/2.png)

输入完成后点击返回，保存发帖，如收藏了可在收藏夹内可见。

![](Application/screenshots/3.png)

![](Application/screenshots/15.png)

发帖完毕后可以等待别人回帖，要是有人回帖了会出现在消息-回复中。点击全部已读可忽略消息。

![](Application/screenshots/4.png)

要是遇到bug可向客服反馈。

![](Application/screenshots/5.png)

![](Application/screenshots/6.png)

进入我的后，点击登录即可登录，未登录状态下邀请码与退出登录不可按，会提示未登录，登录后可按可实现对应功能。

![](Application/screenshots/7.png)

![](Application/screenshots/8.png)

![](Application/screenshots/9.png)

![](Application/screenshots/10.png)

登录成功后显示用户名

![](Application/screenshots/11.png)

![](Application/screenshots/12.png)

![](Application/screenshots/13.png)

![](Application/screenshots/14.png)

点击退出登录返回主页面并退出登录。



主界面：
```
import Messages from "../view/Messages"
import Profile from "../view/Profile"
import LoginedProfile from "../view/LoginedProfile"
import router from '@ohos.router';
import StyleConstants from '../common/constants/StyleConstants';
import CommonConstants from '../common/constants/CommonConstants';
import MemoItem from '../view/MemoItem';
import NotesDataModel from '../model/NotesDataModel';
import { FolderType, NotesInfoBean,notesItemArr} from '../viewmodel/NotesInfoViewModel';
import MainTypeViewModel from '../viewmodel/MainTypeViewModel';
import MainTypeModel from '../viewmodel/MainTypeModel';
import Logger from '../common/utils/Logger';
import dataStorage from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';
@Entry
@Component
struct MainPage {
  @State src: string = router.getParams()?.['src'];
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
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
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
      .tabBar('首页')

      TabContent() {
        Messages()
      }
      .tabBar('消息')

      TabContent() {
        if (this.src === 'Logined') {
          LoginedProfile()
        } else {
          Profile()
        }
      }
      .tabBar("我的")
    }
    .scrollable(false)
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
```

发帖界面

```
import router from '@ohos.router';
import StyleConstants from '../common/constants/StyleConstants';
import CommonConstants from '../common/constants/CommonConstants';
import ConfirmDialog from '../view/ConfirmDialog';
import { FolderType, noteIdArray, NoteIdBean, NotesInfoBean } from '../viewmodel/NotesInfoViewModel';
import formatTime from '../common/utils/Format';
import BottomBar from '../view/BottomBar';

@Entry
@Component
struct NotesDetail {
  @State notesInfo: NotesInfoBean = (router.getParams() as Record<string, NotesInfoBean>)['notesInfo'];
  @State operationType: string = (router.getParams() as Record<string, string>)['operationType'];
  @State imageArr: string[] = this.notesInfo.imageArr;
  @State noteIdArray: NoteIdBean[] = noteIdArray;
  @State @Watch('onChangeCollect') isFavorite: boolean = this.notesInfo.isFavorite;
  @State notesFolder: FolderType = this.notesInfo.folder;
  @State isDataChanged: boolean = false;
  @State isCollectChange: boolean = false;

  @Builder MyMenu() {
    Menu() {
      MenuItem({ content: $r('app.string.notes_longterm') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.Longterm;
        })
      MenuItem({ content: $r('app.string.notes_battle') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.Battle;
        })
      MenuItem({ content: $r('app.string.notes_article') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.Article;
        })
      MenuItem({ content: $r('app.string.notes_newworld') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.Newworld;
        })
      MenuItem({ content: $r('app.string.notes_personal') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.Personal;
        })
      MenuItem({ content: $r('app.string.notes_outofGIS') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.OutofGIS;
        })
    }
  }
  scroller: Scroller = new Scroller();
  saveDialogController: CustomDialogController = new CustomDialogController({
    builder: ConfirmDialog({
      notesInfo: $notesInfo,
      operationType: $operationType,
      noteIdArray: $noteIdArray,
      type: CommonConstants.SAVE_DIALOG
    }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: $r('app.float.dialog_offset_x'), dy: $r('app.float.dialog_margin_bottom') }
  });

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_public_back'))
          .width($r('app.float.back_icon_size'))
          .aspectRatio(1)
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            if (this.isDataChanged || this.notesFolder !== this.notesInfo.folder || this.isCollectChange) {
              this.saveDialogController.open();
            } else {
              router.replaceUrl({
                url: 'pages/MainPage'
              });
            }
          })
        Text($r('app.string.back_text'))
          .fontSize($r('app.float.font_size_normal'))
          .margin({ left: $r('app.float.back_icon_margin') })
      }
      .height($r('app.float.top_bar_container_height'))
      .width(StyleConstants.FULL_WIDTH)
      .padding({ left: $r('app.float.notes_container_padding') })
      Stack({ alignContent: Alignment.Bottom }) {
        Scroll(this.scroller) {
          Column() {
            TextInput({
              text: this.notesInfo.title != '' ? this.notesInfo.title : '',
              placeholder: this.notesInfo.title != '' ? '' : $r('app.string.note_title_placeholder')
            })
              .width(StyleConstants.TEXT_INPUT_WIDTH)
              .height($r('app.float.text_input_height'))
              .fontSize($r('app.float.font_size_larger'))
              .placeholderFont({ size: $r('app.float.font_size_larger') })
              .placeholderColor($r('app.color.placeholder_color'))
              .backgroundColor($r('app.color.white_color'))
              .onChange((value: string) => {
                if (value !== this.notesInfo.title) {
                  this.notesInfo.title = value;
                  this.isDataChanged = true;
                }
              })
            Row() {
              Text(this.notesInfo.time)
                .fontSize($r('app.float.font_size_smaller'))
                .fontColor($r('app.color.font_color_gray'))
              Row() {
                Text(this.notesInfo.folder === FolderType.Personal ?
                $r('app.string.notes_longterm') : $r('app.string.notes_battle') )
                  .fontSize($r('app.float.font_size_little'))
                  .fontColor($r('app.color.placeholder_color'))
                  .textAlign(TextAlign.Center)
                Image($r('app.media.ic_public_spinner_small'))
                  .width($r('app.float.ic_public_spinner_width'))
                  .height($r('app.float.ic_public_spinner_height'))
                  .objectFit(ImageFit.Contain)
              }
              .bindMenu(this.MyMenu)
              .height($r('app.float.select_bar_height'))
              .width($r('app.float.select_bar_width'))
              .borderRadius($r('app.float.select_bar_border_radius'))
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .margin({ left: $r('app.float.select_bar_margin_left') })
              .backgroundColor($r('app.color.select_bar_background_color'))
            }
            .height($r('app.float.select_bar_height'))
            .margin({ bottom: $r('app.float.select_bar_margin_bottom') })
            .width(StyleConstants.CONTENT_WIDTH)
            TextArea({
              text: this.notesInfo.content !== '' ? this.notesInfo.content : '',
              placeholder: this.notesInfo.content !== '' ? '' : $r('app.string.note_content_placeholder')
            })
              .onChange((value: string) => {
                if (value !== this.notesInfo.content) {
                  this.notesInfo.content = value;
                  this.isDataChanged = true;
                }
              })
              .width(StyleConstants.CONTENT_WIDTH)
              .fontSize($r('app.float.font_size_normal'))
              .placeholderFont({ size: $r('app.float.font_size_normal') })
              .placeholderColor($r('app.color.placeholder_color'))
              .backgroundColor($r('app.color.select_bar_background_color'))
              .padding({ bottom: $r('app.float.text_area_padding_bottom') })
            ForEach(this.imageArr, (item: string) => {
              Image($rawfile(item))
                .height($r('app.float.note_picture_height'))
                .width(StyleConstants.CONTENT_WIDTH)
                .objectFit(ImageFit.Fill)
                .margin({ top: $r('app.float.image_Space') })
            }, (item: string) => JSON.stringify(item))
          }
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
        .align(Alignment.Top)
        .height(StyleConstants.FULL_HEIGHT)
        .margin({ bottom: $r('app.float.top_bar_container_height') })

        BottomBar({
          imageArr: $imageArr,
          notesInfo: $notesInfo,
          operationType: $operationType,
          noteIdArray: $noteIdArray,
          isDataChanged: $isDataChanged,
          isFavorite: $isFavorite
        })
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .padding({ bottom: $r('app.float.top_bar_container_height') })
      .backgroundColor($r('app.color.white_color'))
    }
    .height(StyleConstants.FULL_HEIGHT)
    .backgroundColor($r('app.color.white_color'))
  }

  onPageShow() {
    this.notesInfo.time = formatTime();
  }

  onChangeCollect() {
    this.isCollectChange = !this.isCollectChange;
  }

  onBackPress() {
    if (this.isDataChanged || this.notesFolder !== this.notesInfo.folder || this.isCollectChange) {
      this.saveDialogController.open();
    } else {
      router.replaceUrl({
        url: 'pages/MainPage'
      });
    }
    return true;
  }
}
```

看帖界面

```
import router from '@ohos.router';
import StyleConstants from '../common/constants/StyleConstants';
import CommonConstants from '../common/constants/CommonConstants';
import ConfirmDialog from '../view/ConfirmDialog';
import { FolderType, noteIdArray, NoteIdBean, NotesInfoBean } from '../viewmodel/NotesInfoViewModel';
import formatTime from '../common/utils/Format';
import {ChatMode} from '../typings/enum'
interface List {
  name:string
  content:string
}
@Entry
@Component
struct NotesDetail {
  @State notesInfo: NotesInfoBean = (router.getParams() as Record<string, NotesInfoBean>)['notesInfo'];
  @State operationType: string = (router.getParams() as Record<string, string>)['operationType'];
  @State imageArr: string[] = this.notesInfo.imageArr;
  @State noteIdArray: NoteIdBean[] = noteIdArray;
  @State @Watch('onChangeCollect') isFavorite: boolean = this.notesInfo.isFavorite;
  @State notesFolder: FolderType = this.notesInfo.folder;
  @State isDataChanged: boolean = false;
  @State isCollectChange: boolean = false;
  @State text:string=''
  @State contentList:List[]=[]
  @State chatMode:ChatMode=ChatMode.One
  @Builder bottoms() {
    Row({space:20}) {
      Flex({justifyContent:FlexAlign.SpaceBetween}){
        TextInput({placeholder:'输入',text:this.text}).height(40).width('70%')
          .onChange((value:string)=>{1
            this.text=value.trim()
          })
          Button('发送').backgroundColor($r('app.color.login_button_color'))
            .onClick(()=>{
              this.contentList.push({
                name:'admin',
                content:this.text
              })
              this.text=''
            })

      }

    }.height(60).width('100%')
  }
  @Builder getListAll(item:List){
    Flex({justifyContent:FlexAlign.Start,alignItems:ItemAlign.Center,}){
      Image($r('app.media.user_dark')).width(10).height(10).borderRadius(50).margin({right:10,left:10})
      Column(){
        Row(){
          Text(item.content).fontSize(18).fontWeight(FontWeight.Bold)
        }
        .constraintSize({minWidth:100,minHeight:60})
        .padding({left:10,right:10})
        .borderRadius(20)
      }

    }
    .width('100%').padding({right:10,left:10,top:20,bottom:20})
  }
  @Builder getListOne(item:List){
    Flex({justifyContent:FlexAlign.Start,alignItems:ItemAlign.Center}){
      Image($r('app.media.user_dark')).width(50).height(50).borderRadius(50).margin({right:10,left:10})
      Row(){
        Text(item.content).fontSize(18).fontWeight(FontWeight.Bold)
      }
      .constraintSize({minWidth:100,minHeight:60})
      .padding({left:10,right:10})
      .borderRadius(20)
    }
    .width('100%').padding({right:10,left:10,bottom:5})
  }
  @Builder MyMenu() {
    Menu() {
      MenuItem({ content: $r('app.string.notes_longterm') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.Longterm;
        })
      MenuItem({ content: $r('app.string.notes_battle') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.Battle;
        })
      MenuItem({ content: $r('app.string.notes_article') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.Article;
        })
      MenuItem({ content: $r('app.string.notes_newworld') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.Newworld;
        })
      MenuItem({ content: $r('app.string.notes_personal') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.Personal;
        })
      MenuItem({ content: $r('app.string.notes_outofGIS') })
        .onChange(() => {
          this.notesInfo.folder = FolderType.OutofGIS;
        })
    }
  }
  scroller: Scroller = new Scroller();
  saveDialogController: CustomDialogController = new CustomDialogController({
    builder: ConfirmDialog({
      notesInfo: $notesInfo,
      operationType: $operationType,
      noteIdArray: $noteIdArray,
      type: CommonConstants.SAVE_DIALOG
    }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: $r('app.float.dialog_offset_x'), dy: $r('app.float.dialog_margin_bottom') }
  });

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_public_back'))
          .width($r('app.float.back_icon_size'))
          .aspectRatio(1)
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            if (this.isDataChanged || this.notesFolder !== this.notesInfo.folder || this.isCollectChange) {
              this.saveDialogController.open();
            } else {
              router.replaceUrl({
                url: 'pages/MainPage'
              });
            }
          })
        Text($r('app.string.back_text'))
          .fontSize($r('app.float.font_size_normal'))
          .margin({ left: $r('app.float.back_icon_margin') })
      }
      .height($r('app.float.top_bar_container_height'))
      .width(StyleConstants.FULL_WIDTH)
      .padding({ left: $r('app.float.notes_container_padding') })
      Stack({ alignContent: Alignment.Bottom }) {
        Scroll(this.scroller) {
          Column() {
            Text(this.notesInfo.title)
              .width(StyleConstants.TEXT_INPUT_WIDTH)
              .height($r('app.float.text_input_height'))
              .fontSize($r('app.float.font_size_larger'))
              .backgroundColor($r('app.color.white_color'))
            Text(this.notesInfo.content)
              .width(StyleConstants.CONTENT_WIDTH)
              .fontSize($r('app.float.font_size_normal'))
              .padding({ bottom: $r('app.float.text_area_padding_bottom') })
            ForEach(this.imageArr, (item: string) => {
              Image($rawfile(item))
                .height($r('app.float.note_picture_height'))
                .width(StyleConstants.CONTENT_WIDTH)
                .objectFit(ImageFit.Fill)
                .margin({ top: $r('app.float.image_Space') })
            }, (item: string) => JSON.stringify(item))
          }
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
        .align(Alignment.Top)
        .height(StyleConstants.FULL_HEIGHT)
        .margin({ bottom: $r('app.float.top_bar_container_height') })

        Scroll(this.scroller) {
          List({ space: 0, initialIndex: 0 }) {
            ForEach(this.contentList, (item, index) => {
              ListItem() {
                if (this.chatMode == ChatMode.One) this.getListOne(item)
                else if (this.chatMode == ChatMode.All) this.getListAll(item)
              }
            }, item => item)
          }.height('100%')
        }.height('100%')
        .margin({top:'25%'})




        Stack() {
          Column(){
            Row() {
              this.bottoms()
            }.height(60).width('100%').backgroundColor(Color.White)
          }
        }
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(StyleConstants.FULL_HEIGHT)
      .padding({ bottom: $r('app.float.top_bar_container_height') })
      .backgroundColor($r('app.color.white_color'))
    }
    .height(StyleConstants.FULL_HEIGHT)
    .backgroundColor($r('app.color.white_color'))
  }

  onPageShow() {
    this.notesInfo.time = formatTime();
  }

  onChangeCollect() {
    this.isCollectChange = !this.isCollectChange;
  }

  onBackPress() {
    if (this.isDataChanged || this.notesFolder !== this.notesInfo.folder || this.isCollectChange) {
      this.saveDialogController.open();
    } else {
      router.replaceUrl({
        url: 'pages/MainPage'
      });
    }
    return true;
  }
}
```

登录页面

```
import CommonConstants from '../common/constants/CommonConstants';
import router from '@ohos.router';
import prompt from '@ohos.prompt'

@Entry
@Component
struct Login {
  @State users: string = ''
  @State password: string = ''
  build() {
    Column() {
      Row() {
        Image($r('app.media.returnback'))
          .height('50%')
          .margin({ top: '5', left: '5' })
          .onClick(() => {
            router.back();
          })
        Text($r('app.string.mine_title'))
          .fontColor(CommonConstants.LOGIN_COLOR)
          .fontSize(CommonConstants.LOGIN_SIZE)
          .fontWeight(FontWeight.Bold)
          .margin({ top: '5' })
          .onClick(() => {
            router.back();
          })
      }
      .width('100%')
      .height('8%')
      .shadow({
        radius: 4,
        color: `rgba(0,0,0,0.2)`,
        offsetY: 10
      })

      Row() {
        Column() {
          TextInput({ placeholder: CommonConstants.USERNAME })
            .width(300)
            .height(50)
            .type(InputType.Normal)
            .margin({ top: '30' })
            .onChange((value: string) => {
              this.users = value;
            })
          TextInput({ placeholder: CommonConstants.PASSWORD })
            .width(300)
            .height(50)
            .fontSize(20)
            .type(InputType.Password)
            .margin({ top: '30'})
            .onChange((value: string) => {
              this.password = value;
            })
          Button(CommonConstants.LOGIN)
            .width(300)
            .height(50)
            .fontSize(CommonConstants.LOGIN_SIZE)
            .backgroundColor(CommonConstants.LOGIN_COLOR)
            .margin({ top: '30' })
            .onClick(() => {
              if (this.users == '' || this.password == '') {
                prompt.showToast({
                  message: '用户名和密码不能为空！',
                  duration: 3000
                });
              } else {
                if (this.users != 'admin' || this.password != 'password') {
                  prompt.showToast({
                    message: '用户名密码输入错误！',
                    duration: 3000
                  });
                } else {
                  router.replaceUrl({
                    url: 'pages/MainPage',
                    params:{
                      src: 'Logined',
                    }
                  });
                }
              }
            })
          Text(CommonConstants.REGISTERACCOUNT)
            .margin({ top: '20', left: '-85' })
            .onClick(this.clickRegister.bind(this))
          Text(CommonConstants.FORGET)
            .margin({ top: '-19', left: '100' })
            .onClick(this.clickForget.bind(this))
        }
        .width('100%')
      }
      .height('30%')
    }
  }
  clickRegister() {
    router.pushUrl({
      url: "pages/Register",
    })
  }
  clickForget() {
    router.pushUrl({
      url: "pages/Forget",
    })
  }
}
```

注册页面

```
import CommonConstants from '../common/constants/CommonConstants';
import router from '@ohos.router';

@Entry
@Component
struct Register {
  build() {
    Column() {
      Row() {
        Image($r('app.media.returnback'))
          .height('50%')
          .margin({ top: '5', left: '5' })
          .onClick(() => {
            router.back();
          })
        Text(CommonConstants.LOGIN)
          .fontColor(CommonConstants.LOGIN_COLOR)
          .fontSize(CommonConstants.LOGIN_SIZE)
          .fontWeight(FontWeight.Bold)
          .margin({ top: '5' })
          .onClick(() => {
            router.back();
          })
      }
      .width('100%')
      .height('8%')

      Row() {
        Column() {
          TextInput({ placeholder: CommonConstants.USERNAME })
            .width(300)
            .height(50)
            .type(InputType.Normal)
            .margin({ top: '30'})
          TextInput({ placeholder: CommonConstants.PASSWORD })
            .width(300)
            .height(50)
            .fontSize(20)
            .type(InputType.Password)
            .margin({ top: '30'})
          TextInput({ placeholder: CommonConstants.CONFIRMPASSWORD })
            .width(300)
            .height(50)
            .fontSize(20)
            .type(InputType.Password)
            .margin({ top: '30'})
          TextInput({ placeholder: CommonConstants.CODE })
            .width(300)
            .height(50)
            .type(InputType.Normal)
            .margin({ top: '30'})
          Button('注册')
            .width(300)
            .height(50)
            .fontSize(CommonConstants.LOGIN_SIZE)
            .backgroundColor(CommonConstants.LOGIN_COLOR)
            .margin({ top: '30'})
        }
        .width('100%')
      }
      .height('30%')
    }
  }
}
```

忘记密码页面

```
import CommonConstants from '../common/constants/CommonConstants';
import router from '@ohos.router';

@Entry
@Component
struct Forget {
  build() {
    Column() {
      Row() {
        Image($r('app.media.returnback'))
          .height('50%')
          .margin({ top: '5', left: '5' })
          .onClick(() => {
            router.back();
          })
        Text(CommonConstants.LOGIN)
          .fontColor(CommonConstants.LOGIN_COLOR)
          .fontSize(CommonConstants.LOGIN_SIZE)
          .fontWeight(FontWeight.Bold)
          .margin({ top: '5' })
          .onClick(() => {
            router.back();
          })
      }
      .width('100%')
      .height('8%')

      Row() {
        Column() {
          TextInput({ placeholder: CommonConstants.USERNAME })
            .width(300)
            .height(50)
            .type(InputType.Normal)
            .margin({ top: '30'})
          TextInput({ placeholder: '输入新密码' })
            .width(300)
            .height(50)
            .fontSize(20)
            .type(InputType.Password)
            .margin({ top: '30'})
          TextInput({ placeholder: '确认新密码' })
            .width(300)
            .height(50)
            .fontSize(20)
            .type(InputType.Password)
            .margin({ top: '30'})
          TextInput({ placeholder: '输入手机号' })
            .width(300)
            .height(50)
            .type(InputType.Normal)
            .margin({ top: '30'})
          TextInput({ placeholder: '输入验证码' })
            .width(300)
            .height(50)
            .type(InputType.Normal)
            .margin({ top: '30'})
          Text('|   获取验证码')
            .margin({ top: '-50',left:'180'})
          Button('重置密码')
            .width(300)
            .height(50)
            .fontSize(CommonConstants.LOGIN_SIZE)
            .backgroundColor(CommonConstants.LOGIN_COLOR)
            .margin({ top: '30'})
            .key('button')
            .onClick(()=>{
              focusControl.requestFocus('button')
            })
        }
        .width('100%')
      }
      .height('30%')
    }
  }
}
```

设置页面

```
import ChatItemComponent from '../view/ChatItemComponent';
import TitleBarComponent from '../view/TitleBarComponent';
import SetViewModel from '../viewmodel/SetViewModel';
import CommonConstants from '../common/constants/CommonConstants';
import StyleConstants from '../common/constants/StyleConstants';
import Logger from '../common/utils/Logger';
import PreferencesUtil from '../common/database/Preferencesutil';
import ChatData from '../viewmodel/ChatData';

const TAG = '[SetFontSizePage]';

/**
 * The SetFontSizePage is the page that sets the font size.
 * The page consists of title, chat list, and slider.
 * Drag the slider to change the font size of the chat list.
 */
@Entry
@Component
struct SetFontSizePage {
  private contentArr = SetViewModel.initChatData();
  @State changeFontSize: number = 0;
  @State fontSizeText: Resource = $r("app.string.set_size_normal");

  onPageShow() {
    PreferencesUtil.getChangeFontSize().then((value) => {
      this.changeFontSize = value;
      this.fontSizeText = SetViewModel.getTextByFontSize(value);
      Logger.info(TAG, 'Get the value of changeFontSize: ' + this.changeFontSize);
    });
  }

  build() {
    Column() {
      TitleBarComponent({ title: $r('app.string.mine_title') })

      if (this.changeFontSize > 0) {
        List() {
          ForEach(this.contentArr, (item: ChatData) => {
            ListItem() {
              ChatItemComponent({ item: item, changeFontSize: this.changeFontSize })
            }
          }, (item: ChatData) => JSON.stringify(item))
        }
        .layoutWeight(CommonConstants.FULL_PARENT)
      }

      SliderLayout({ fontSizeText: $fontSizeText, changeFontSize: $changeFontSize })
    }
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    .height(StyleConstants.FULL_HEIGHT)
    .width(StyleConstants.FULL_WIDTH)
  }
}

@Component
struct SliderLayout {
  @Link fontSizeText: Resource;
  @Link changeFontSize: number;

  build() {
    Column() {
      Text($r('app.string.set_font_size'))
        .fontSize($r('app.float.set_text'))
        .fontColor($r('app.color.title_text_color'))
        .margin({ left: StyleConstants.SLIDER_LAYOUT_LEFT_PERCENT, top: StyleConstants.SLIDER_LAYOUT_TOP_PERCENT })
        .fontWeight(FontWeight.Medium)

      Column() {
        Text(this.fontSizeText)
          .fontSize($r('app.float.set_text'))
          .fontColor($r('app.color.title_text_color'))

        Row() {
          Text($r('app.string.set_char_a'))
            .fontColor($r('app.color.title_text_color'))
            .fontSize($r('app.float.set_small_a'))
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.End)
            .width(StyleConstants.A_WIDTH_PERCENT)
            .padding({ right: $r('app.float.a_right_padding') })

          Slider({
            value: this.changeFontSize === CommonConstants.SET_SIZE_HUGE
              ? CommonConstants.SET_SLIDER_MAX : this.changeFontSize,
            min: CommonConstants.SET_SLIDER_MIN,
            max: CommonConstants.SET_SLIDER_MAX,
            step: CommonConstants.SET_SLIDER_STEP,
            style: SliderStyle.InSet
          })
            .showSteps(true)
            .width(StyleConstants.SLIDER_WIDTH_PERCENT)
            .onChange(async (value: number) => {
              if (this.changeFontSize === 0) {
                this.changeFontSize = await PreferencesUtil.getChangeFontSize();
                this.fontSizeText = SetViewModel.getTextByFontSize(value);
                return;
              }
              this.changeFontSize = (value === CommonConstants.SET_SLIDER_MAX ?
              CommonConstants.SET_SIZE_HUGE : value);
              this.fontSizeText = SetViewModel.getTextByFontSize(this.changeFontSize);
              PreferencesUtil.saveChangeFontSize(this.changeFontSize);
            })

          Text($r('app.string.set_char_a'))
            .fontColor($r('app.color.title_text_color'))
            .fontSize($r('app.float.set_big_a'))
            .fontWeight(FontWeight.Bold)
            .width(StyleConstants.A_WIDTH_PERCENT)
            .padding({ left: $r('app.float.a_left_padding') })
        }
      }
      .backgroundColor(Color.White)
      .borderRadius($r('app.float.block_background_radius'))
      .width(StyleConstants.TEXT_INPUT_WIDTH)
      .padding({ top: $r('app.float.slider_top_padding'), bottom: $r('app.float.slider_bottom_padding') })
      .margin({
        left: StyleConstants.SLIDER_HORIZONTAL_MARGIN_PERCENT,
        right: StyleConstants.SLIDER_HORIZONTAL_MARGIN_PERCENT,
        top: StyleConstants.SLIDER_TOP_MARGIN_PERCENT,
        bottom: StyleConstants.SLIDER_BOTTOM_MARGIN_PERCENT
      })
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.End)
  }
}
```

关于界面

```
import CommonConstants from '../common/constants/CommonConstants';
import router from '@ohos.router';

@Entry
@Component
struct About {
  @State message: string = '一 总则\n第1条 我们致力于为用户提供一个开放，友善的角色扮演(rp)互动社区。根据社区建立以来所积累的经验，制定本基础版规。\n第2条 本版的所有使用者与管理者的所有行为均需遵守本版规，本版规对于所有发布在本应用上的内容生效\n第3条各分版块版规在不违背总规则的前提下，以各自版块的版规为准，如无分版块版规则按照总版规执行。\n二行为规范\n第1条 禁止发表、讨论黄、赌、毒等违反相关法律法规的内容。禁止涉及军事、政治等不宜在论坛讨论的内容。禁止发布商业广告。\n第2条 禁止发表质疑版务管理的内容，如有改进意见请通过反馈通道与我们交流。禁止发布挑衅、含沙射影攻击版务的内容。\n第3条 禁止恶意攻击、辱骂、讽刺、嘲弄他人。\n第4条 禁止发表带有私人信息及隐私性质的内容，包括自己和他人的私人联系方式、群组等。禁止发泄个人间矛盾:如挂人对线等。\n第5条 禁止发表引战、恶意转进、单纯负面情绪宣泄等消极内容。\n第6条 禁止恶意灌水、刷屏、刷楼、在帖内进行大量与帖子主题无关的讨论。\n第7条 除去长期贴的正常更新及各版块特殊规定的帖子类型，其余超过7天未回复的贴子视为坟贴，坟贴禁止回复，跟坟行为同样视作挖坟。\n第8条 在不违反行为规范第1至7条的前提下，本应用容纳所有类型的rp(角色扮演)相关内容，以及和版面主题相关的非rp(版外)内容。无论发表的内容是否为版外，均需与所处版面主题相关，如在格里芬匿名版发表的帖子，需要和少女前线相关。\n第9条 版面使用tag机制区分特定类型的帖子，如果你想发布的帖子类型不属于现有的任何tag，则无需添加tag，若该种类的帖子较为热门，版务组会在讨论后决定是否新增该类型的tag。以非角色身份发帖时，帖子必须添加[版外]tag，同时该帖的所有回复会强制作为版外发表。\n三 删贴标准\n包含以下内容的帖子和回复，版务可以直接删除，如有异议请通过反馈功能提出。\n第1条 与所处版面主题无关的;\n第2条 发表版外帖、回复时不添加版外tag的:\n第3条 发表行为规范第1至7条所禁止内容的:\n第4条 涉及宗教敏感内容的:\n第5条 涉及地域歧视、破坏两岸及港澳和谐的:\n第6条涉及宣扬反国家、反政府言论的:\n第7条涉及煽动历史、民族仇恨的:\n第8条其他影响版面用户浏览体验或影响论坛正常讨论秩序的:\n四 封禁标准\n第1条 违反行为规范第1条，以及发表涉及删帖标准第4至第7条内容的用户，处7天禁言，情节严重的将封号\n第2条 违反行为规范第3至7条，以及发表与所处版面主题无关内容的用户，初次违反会被警告7天，再次违反会被禁言7天，情节严重的将封号。\n第3条 发帖时未能添加正确tag的，版务会在提醒过后调整其帖子tag。故意错误添加tag的，屡教不改者会受惩罚。\n第4条 经版务组讨论认定的其他严重违反版面正常管理秩序的行为，同样会受到禁言或封号处理，具体措施视严重程度决定。'
  scroller: Scroller = new Scroller();
  build() {
    Column() {
      Row() {
        Image($r('app.media.returnback'))
          .height('50%')
          .margin({ top: '5', left: '5' })
          .onClick(() => {
            router.back();
          })
        Text(CommonConstants.LOGIN)
          .fontColor(CommonConstants.LOGIN_COLOR)
          .fontSize(CommonConstants.LOGIN_SIZE)
          .fontWeight(FontWeight.Bold)
          .margin({ top: '5' })
          .onClick(() => {
            router.back();
          })
      }
      .width('100%')
      .height('8%')
      .backgroundColor('white')
      Row() {
        Scroll(this.scroller) {
          Text(this.message)
            .fontSize(18)
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('gray')
  }
}
```

小组件页面

```
@Entry
@Component
struct GISwidgetCard {
  /*
   * The max lines.
   */
  readonly MAX_LINES: number = 1;

  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';

  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';

  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'EntryAbility';

  /*
   * The with percentage setting.
   */
  readonly FULL_WIDTH_PERCENT: string = '100%';

  /*
   * The height percentage setting.
   */
  readonly FULL_HEIGHT_PERCENT: string = '100%';

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text("GIS留言板")
            .width("100%")
            .height("47vp")
            .position({ x: "0px", y: "0px" })
            .fontColor(Color.Black)
            .textAlign(TextAlign.Center)
            .fontSize("19fp")
            .fontStyle(FontStyle.Normal)
            .fontWeight(FontWeight.Bold)
          Image($r('app.media.icon'))
            .width("100%")
            .height("100%")
        }
        .width("150vp")
        .height("150vp")
      }
      .width(this.FULL_WIDTH_PERCENT)
    }
    .height(this.FULL_HEIGHT_PERCENT)
    .onClick(() => {
      postCardAction(this, {
        action: this.ACTION_TYPE,
        abilityName: this.ABILITY_NAME,
        params: {
          message: this.MESSAGE
        }
      });
    })
  }
}
```