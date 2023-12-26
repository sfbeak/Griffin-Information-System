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