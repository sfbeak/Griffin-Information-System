import CommonConstants from '../common/constants/CommonConstants';
import router from '@ohos.router';
@Entry
@Component
struct Invite {
  build() {
    Column(){
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
      .backgroundColor('white')
      .shadow({
        radius: 4,
        color: `rgba(0,0,0,0.2)`,
        offsetY: 10
      })

      Row(){
        Text("10746ZPQCDGPTZQ")
          .fontSize(CommonConstants.LOGIN_SIZE)
          .margin({ left: '20',top:'-20' })
        Text("未使用")
          .margin({top:35,left:-185})
        Button('复制')
          .width(50)
          .height(30)
          .margin({left:85})
      }
      .width('97%')
      .height('10%')
      .margin({ top: '5%' })
      .backgroundColor('white')
      .borderRadius(10)
      .shadow({
        radius: 2,
        color: `rgba(0,0,0,0.2)`,
        offsetY: 5
      })

      Row() {
        Text("10745KMMFRAAZUC")
          .fontSize(CommonConstants.LOGIN_SIZE)
          .margin({ left: '20',top:'-20' })
        Text("未使用")
          .margin({top:35,left:-195})
        Button('复制')
          .width(50)
          .height(30)
          .margin({left:75})
      }
      .width('97%')
      .height('10%')
      .margin({ top: '5%' })
      .backgroundColor('white')
      .borderRadius(10)
      .shadow({
        radius: 2,
        color: `rgba(0,0,0,0.2)`,
        offsetY: 5
      })
    }
    .backgroundColor('gray')
    .width('100%')
    .height('100%')
  }
}