﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ОткрытьФорму("ПланОбмена.QIWI_АдаптерВнешниеСистемы.ФормаСписка", ,
					ПараметрыВыполненияКоманды.Источник,
					ПараметрыВыполненияКоманды.Уникальность,
					ПараметрыВыполненияКоманды.Окно,
					ПараметрыВыполненияКоманды.НавигационнаяСсылка);
					
КонецПроцедуры
