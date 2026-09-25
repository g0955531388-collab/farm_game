import 'dart:html';

int day = 1;
int grapeWater = 80;
int avocadoWater = 90;
int grapeLeavesDays = 0;

void updateUI() {
  querySelector('#day-counter')?.text = '$day';
  querySelector('#grape-water')?.text = '$grapeWater%';
  querySelector('#avocado-water')?.text = '$avocadoWater%';
  querySelector('#grape-leaves')?.text = '$grapeLeavesDays';

  var msg = querySelector('#message-log');
  if (grapeLeavesDays >= 15) {
    msg?.text = '⚠️ [تنبيه]: أوراق العنب جاهزة للقطاف الآن!';
  } else if (grapeWater < 30) {
    msg?.text = '🚨 [تحذير]: العنب بحاجة للري!';
  } else if (avocadoWater < 30) {
    msg?.text = '🚨 [تحذير]: الأفوكادو بحاجة للري!';
  } else {
    msg?.text = '';
  }
}

void main() {
  updateUI();

  querySelector('#btn-water-grape')?.onClick.listen((_) {
    grapeWater = (grapeWater + 30).clamp(0, 100);
    updateUI();
  });

  querySelector('#btn-water-avocado')?.onClick.listen((_) {
    avocadoWater = (avocadoWater + 30).clamp(0, 100);
    updateUI();
  });

  querySelector('#btn-next-day')?.onClick.listen((_) {
    day++;
    grapeWater = (grapeWater - 10).clamp(0, 100);
    avocadoWater = (avocadoWater - 15).clamp(0, 100);
    grapeLeavesDays++;
    updateUI();
  });

  querySelector('#btn-harvest')?.onClick.listen((_) {
    var msg = querySelector('#message-log');
    if (grapeLeavesDays >= 15) {
      msg?.text = '🎉 تم قطاف أوراق العنب بنجاح!';
      grapeLeavesDays = 0;
    } else {
      msg?.text = '❌ الأوراق لم تكتمل بعد (تحتاج 15 يوماً).';
    }
    updateUI();
  });
}
