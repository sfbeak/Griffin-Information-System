import NewsTypeViewModel from '../viewmodel/NewsTypeViewModel';
import NewsTypeModel from '../viewmodel/NewsTypeModel';
import MainTypeModel from '../viewmodel/MainTypeModel';
import MainTypeViewModel from '../viewmodel/MainTypeViewModel';
import {ChatMode} from '../typings/enum'
import prompt from '@ohos.prompt'
interface List {
  name:string
  code:string
  content:string
}
@Component
export default struct Messages {
  @State NewstabBarArray: NewsTypeModel[] = NewsTypeViewModel.getDefaultTypeList();
  @State currentIndex: number = 0;
  @State MaintabBarArray: MainTypeModel[] = MainTypeViewModel.getDefaultTypeList();
  @Builder NewsTabBuilder(index: number) {
    Column() {
      Text(this.NewstabBarArray[index].name)
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
  @Builder bottoms() {
    Row({space:20}) {
      Flex({justifyContent:FlexAlign.SpaceBetween}){
        Image($r('app.media.about')).width(40).height(40).borderRadius(50)
        TextInput({placeholder:'输入',text:this.text}).height(40).width('60%')
          .onChange((value:string)=>{1
            this.text=value.trim()
          })
        if(this.text==''){
          Image($r('app.media.favorite')).width(40).height(40).borderRadius(50)
          Image($r('app.media.ic_add')).width(40).height(40).borderRadius(50)
        }else{
          Button('发送').backgroundColor(Color.Green)
            .onClick(()=>{
              this.contentList.push({
                name:'wanqiu',
                code:'0001',
                content:this.text
              })
              this.text=''
            })
        }

      }

    }.height(60).width('100%')
  }
  //列表的每一列  群聊天
  @Builder getListAll(myCode:string,item:List){
    Flex({justifyContent:FlexAlign.Start,alignItems:ItemAlign.Center,direction:myCode==item.code?FlexDirection.RowReverse:FlexDirection.Row}){
      Image($r('app.media.user_dark')).width(50).height(50).borderRadius(50).margin({right:10,left:10})
      Column(){
        if(myCode!==item.code){
          Row(){
            Text(item.name)
          }
          .justifyContent(FlexAlign.Start)
          .padding({bottom:10})
        }

        Row(){
          Text(item.content).fontSize(18).fontWeight(FontWeight.Bold)
        }
        .constraintSize({minWidth:100,minHeight:60})
        .backgroundColor(myCode==item.code?Color.Green:Color.White)
        .justifyContent(myCode==item.code?FlexAlign.End:FlexAlign.Start)
        .padding({left:10,right:10})
        .borderRadius(20)
      }.alignItems(myCode==item.code?HorizontalAlign.End:HorizontalAlign.Start)

    }
    .width('100%').padding({right:10,left:10,top:20,bottom:20})
  }
  @Builder getListOne(myCode:string,item:List){
    Flex({justifyContent:FlexAlign.Start,alignItems:ItemAlign.Center,direction:myCode==item.code?FlexDirection.RowReverse:FlexDirection.Row}){
      Image($r('app.media.user_dark')).width(50).height(50).borderRadius(50).margin({right:10,left:10})
      Row(){
        Text(item.content).fontSize(18).fontWeight(FontWeight.Bold)
      }
      .constraintSize({minWidth:100,minHeight:60})
      .backgroundColor(myCode==item.code?Color.Green:Color.White)
      .justifyContent(myCode==item.code?FlexAlign.End:FlexAlign.Start)
      .padding({left:10,right:10})
      .borderRadius(20)
    }
    .width('100%').padding({right:10,left:10,bottom:5})
  }
  @State myCode:string='0001'
  @State code:string='0002'
  @State chatMode:ChatMode=ChatMode.One //one 个人聊天  all 群聊
  @State text:string=''
  scroller: Scroller = new Scroller()
  @State contentList:List[]=[
    {
      name:'admin',
      code:'0002',
      content:'你好,请问有什么可以帮您？'
    }
  ]
  build() {
    Stack() {
      Tabs() {
        TabContent() {

          Button('全部已读', { type: ButtonType.Capsule })
            .width("90%")
            .height("10%")
            .fontSize($r('app.float.normal_text_size'))
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .backgroundColor($r('app.color.setting_button_backgroundColor'))
            .margin({top:'-170%'})
            .onClick(() => {
              prompt.showToast({
                message: '成功',
                duration: 1500
              })
            })
        }
        .tabBar(this.NewsTabBuilder(0))

        TabContent() {
          Navigation(){
            Stack({alignContent : Alignment.Bottom}) {
              //聊天
              Scroll(this.scroller) {
                List({ space: 0, initialIndex: 0 }) {
                  ForEach(this.contentList, (item, index) => {
                    ListItem() {
                      if (this.chatMode == ChatMode.One) this.getListOne(this.myCode, item)
                      else if (this.chatMode == ChatMode.All) this.getListAll(this.myCode, item)
                    }
                  }, item => item)
                }.height('100%')
              }.height('100%')
              Stack() {
                Column(){
                  Row() {
                    this.bottoms()
                  }.height(60).width('100%').backgroundColor(Color.White)
                }
              }
            } .width('100%').height('100%')
          }
          .backgroundColor(Color.Grey)
        }
        .tabBar(this.NewsTabBuilder(1))
      }
      .barHeight('46vp')
      .height('100%')
      .barMode(BarMode.Scrollable)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .vertical(false)
    }
  }
}
