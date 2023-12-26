import CommonConstants from '../constants/CommonConstants';

export default function formatTime() {
  let time = new Date();
  let hourTip = '';
  if(time.getHours() >= CommonConstants.START_HOUR_OF_MORNING &&
  time.getHours() < CommonConstants.END_HOUR_OF_MORNING) {
    hourTip = 'AM';
  } else {
    hourTip = 'PM';
  }
  return `${time.toTimeString().split(' ')[0]} ${hourTip}`;
}