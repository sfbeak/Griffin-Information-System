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