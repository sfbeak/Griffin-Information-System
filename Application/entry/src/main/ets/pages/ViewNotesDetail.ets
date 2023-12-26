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