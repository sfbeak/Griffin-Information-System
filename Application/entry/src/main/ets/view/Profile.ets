import CommonConstants from '../common/constants/CommonConstants';
import prompt from '@ohos.prompt'
import router from '@ohos.router';
@Component
export default struct Profile {

  build() {
    Scroll() {
      Column({ space: CommonConstants.COMMON_SPACE }) {
        Swiper() {
          Image($r('app.media.bk1'))
            .width("100%")
            .height("100%")
            .objectFit(ImageFit.Fill)

          Image($r('app.media.bk2'))
            .width("100%")
            .height("100%")
            .objectFit(ImageFit.Fill)
          Image($r('app.media.bk3'))
            .width("100%")
            .height("100%")
            .objectFit(ImageFit.Fill)
          Image($r('app.media.bk4'))
            .width("100%")
            .height("100%")
            .objectFit(ImageFit.Fill)
        }
        .width('100%')
        .height('40%')
        .autoPlay(true)

        Row() {
          Image($r('app.media.user_dark'))
            .width($r('app.float.setting_account_size'))
            .height($r('app.float.setting_account_size'))
          Column() {
            Text($r('app.string.setting_account_name'))
              .fontSize($r('app.float.setting_account_fontSize'))
          }
          .alignItems(HorizontalAlign.Start)
          .margin({left: $r('app.float.setting_account_margin') })
        }
        .margin({ top: '-11%' ,bottom:"-8%"})
        .alignItems(VerticalAlign.Center)
        .width(CommonConstants.FULL_PARENT)
        .height($r('app.float.setting_account_height'))
        .padding({ left: $r('app.float.setting_account_padding') })
        .borderRadius($r('app.float.setting_account_borderRadius'))
        .onClick(this.clickLogin.bind(this))

        List() {
            ListItem() {
              Row() {
                Row({ space: CommonConstants.COMMON_SPACE }) {
                  Image($r('app.media.news'))
                    .width($r('app.float.setting_size'))
                    .height($r('app.float.setting_size'))
                  Text($r('app.string.setting_invitation_code'))
                    .fontSize($r('app.float.normal_text_size'))
                }

                Image($r('app.media.right_grey'))
                  .width($r('app.float.setting_jump_width'))
                  .height($r('app.float.setting_jump_height'))
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .width(CommonConstants.FULL_PARENT)
              .padding({
                left: $r('app.float.setting_settingCell_left'),
                right: $r('app.float.setting_settingCell_right')
              })
            }
            .height($r('app.float.setting_list_height'))
            .onClick(() => {
              prompt.showToast({
                message: '请先登录',
                duration: 1500
              });
            })

          ListItem() {
            Row() {
              Row({ space: CommonConstants.COMMON_SPACE }) {
                Image($r('app.media.data'))
                  .width($r('app.float.setting_size'))
                  .height($r('app.float.setting_size'))
                Text($r('app.string.setting_check_update'))
                  .fontSize($r('app.float.normal_text_size'))
              }

              Image($r('app.media.right_grey'))
                .width($r('app.float.setting_jump_width'))
                .height($r('app.float.setting_jump_height'))
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width(CommonConstants.FULL_PARENT)
            .padding({
              left: $r('app.float.setting_settingCell_left'),
              right: $r('app.float.setting_settingCell_right')
            })
          }
          .height($r('app.float.setting_list_height'))
          .onClick(() => {
            prompt.showToast({
              message: '已经是最新版本',
              duration: 1500
            });
          })

          ListItem() {
            Row() {
              Row({ space: CommonConstants.COMMON_SPACE }) {
                Image($r('app.media.menu'))
                  .width($r('app.float.setting_size'))
                  .height($r('app.float.setting_size'))
                Text($r('app.string.setting_list_menu'))
                  .fontSize($r('app.float.normal_text_size'))
              }

              Image($r('app.media.right_grey'))
                .width($r('app.float.setting_jump_width'))
                .height($r('app.float.setting_jump_height'))
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width(CommonConstants.FULL_PARENT)
            .padding({
              left: $r('app.float.setting_settingCell_left'),
              right: $r('app.float.setting_settingCell_right')
            })
          }
          .height($r('app.float.setting_list_height'))
          .onClick(this.clickSettings.bind(this))

          ListItem() {
            Row() {
              Row({ space: CommonConstants.COMMON_SPACE }) {
                Image($r('app.media.about'))
                  .width($r('app.float.setting_size'))
                  .height($r('app.float.setting_size'))
                Text($r('app.string.setting_list_about'))
                  .fontSize($r('app.float.normal_text_size'))
              }

              Image($r('app.media.right_grey'))
                .width($r('app.float.setting_jump_width'))
                .height($r('app.float.setting_jump_height'))
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width(CommonConstants.FULL_PARENT)
            .padding({
              left: $r('app.float.setting_settingCell_left'),
              right: $r('app.float.setting_settingCell_right')
            })
          }
          .height($r('app.float.setting_list_height'))
          .onClick(this.clickAbout.bind(this))

          ListItem() {
            Row() {
              Row({ space: CommonConstants.COMMON_SPACE }) {
                Image($r('app.media.recycle'))
                  .width($r('app.float.setting_size'))
                  .height($r('app.float.setting_size'))
                Text($r('app.string.setting_list_storage'))
                  .fontSize($r('app.float.normal_text_size'))
              }

              Image($r('app.media.right_grey'))
                .width($r('app.float.setting_jump_width'))
                .height($r('app.float.setting_jump_height'))
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width(CommonConstants.FULL_PARENT)
            .padding({
              left: $r('app.float.setting_settingCell_left'),
              right: $r('app.float.setting_settingCell_right')
            })

          }
          .height($r('app.float.setting_list_height'))
          .onClick(() => {
            prompt.showToast({
              message: '缓存已清除',
              duration: 1500
            });
          })
        }
        .divider({
          strokeWidth: $r('app.float.setting_list_strokeWidth'),
          color: Color.Grey,
          startMargin: $r('app.float.setting_list_startMargin'),
          endMargin: $r('app.float.setting_list_endMargin')
        })
        .borderRadius($r('app.float.setting_list_borderRadius'))
        .padding({ top: $r('app.float.setting_list_padding'), bottom: $r('app.float.setting_list_padding') })

        Blank()

        Button($r('app.string.setting_button'), { type: ButtonType.Capsule })
          .width(CommonConstants.BUTTON_WIDTH)
          .height($r('app.float.login_button_height'))
          .fontSize($r('app.float.normal_text_size'))
          .fontColor($r('app.color.setting_button_fontColor'))
          .fontWeight(FontWeight.Medium)
          .backgroundColor($r('app.color.setting_button_backgroundColor'))
          .margin({ bottom: $r('app.float.setting_button_bottom')})
          .onClick(() => {
            prompt.showToast({
              message: '尚未登录',
              duration: 1500
            });
          })
      }
      .height(CommonConstants.FULL_PARENT)
    }
    .backgroundColor($r('app.color.page_background'))
  }
  clickLogin() {
    router.pushUrl({
      url: "pages/Login",
    })
  }
  clickAbout() {
    router.pushUrl({
      url: "pages/About",
    })
  }
  clickInvite() {
    router.pushUrl({
      url: "pages/Invite",
    })
  }
  clickSettings() {
    router.pushUrl({
      url: "pages/Settings",
    })
  }
}



