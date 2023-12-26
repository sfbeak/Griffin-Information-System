import prompt from '@system.prompt';
import CommonConstants from '../common/constants/CommonConstants';
import StyleConstants from '../common/constants/StyleConstants';
import { NoteIdBean, NotesInfoBean, notesItemArr } from '../viewmodel/NotesInfoViewModel';
import ConfirmDialog from './ConfirmDialog';

@Component
export default struct BottomBar {
  @Link notesInfo: NotesInfoBean;
  @Link operationType: string;
  @Link noteIdArray: NoteIdBean[];
  @Link imageArr: string[];
  @Link isDataChanged: boolean;
  @Link isFavorite: boolean;
  @State isCollectChange: boolean = false;
  @State collectImgSrc: string = this.isFavorite ? 'ic_bottom_star_selected.svg' : 'ic_bottom_star_normal.svg';
  @State imageUrls: string[] = ['cook_picture.png', 'dinner_food.png', 'drink_coffee.png'];
  @State noteItem: NotesInfoBean = notesItemArr[0];
  @State imageSrc: string = '';

  clickCollect?: () => void;
  clickDelete?: () => void;
  clickAddPicture?: () => void;
  deleteDialogController: CustomDialogController = new CustomDialogController({
    builder: ConfirmDialog({
      notesInfo: $notesInfo,
      operationType: $operationType,
      noteIdArray: $noteIdArray,
      type: CommonConstants.DELETE_DIALOG
    }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: $r('app.float.dialog_offset_x'), dy: $r('app.float.dialog_margin_bottom') }
  });

  build() {
    Row() {
      Column() {
        Image($r('app.media.ic_bottom_share'))
          .width($r('app.float.ic_bottom_picture_size'))
          .aspectRatio(1)
        Text($r('app.string.share_note'))
          .fontSize($r('app.float.font_size_smallest'))
          .margin({ top: $r('app.float.bottom_txt_margin') })
      }
      .onClick(() => {
        prompt.showToast({
          message: '该功能暂未实现'
        });
      })
      Column() {
        Image($rawfile(this.collectImgSrc))
          .width($r('app.float.ic_bottom_picture_size'))
          .aspectRatio(1)
        Text($r('app.string.collect_note'))
          .fontSize($r('app.float.font_size_smallest'))
          .margin({ top: $r('app.float.bottom_txt_margin') })
      }
      .onClick(() => {
        this.clickCollect = () => {
          this.notesInfo.isFavorite = !this.notesInfo.isFavorite;
          this.isFavorite = !this.isFavorite;
          this.collectImgSrc = this.notesInfo.isFavorite ?
            'ic_bottom_star_selected.svg' : 'ic_bottom_star_normal.svg';
        }
        this.clickCollect();
      })
      Column() {
        Image($r('app.media.ic_bottom_delete'))
          .width($r('app.float.ic_bottom_picture_size'))
          .aspectRatio(1)
        Text($r('app.string.delete_note'))
          .fontSize($r('app.float.font_size_smallest'))
          .margin({ top: $r('app.float.bottom_txt_margin') })
      }
      .onClick(() => {
        this.clickDelete = () => {
          if (this.operationType === CommonConstants.MODIFY_NOTE) {
            this.deleteDialogController.open();
          } else {
            prompt.showToast({
              message: 'The addition operation cannot be deleted'
            });
          }
        }
        this.clickDelete();
      })

    }
    .height($r('app.float.top_bar_container_height'))
    .width(StyleConstants.FULL_WIDTH)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .backgroundColor($r('app.color.white_color'))
  }

}