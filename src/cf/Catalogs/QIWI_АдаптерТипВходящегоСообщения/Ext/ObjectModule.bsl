﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;	
	
	Если Не ДополнительныеСвойства.Свойство("ПроверкаВыполнена") Тогда
		ТекстСообщения = Справочники.QIWI_АдаптерТипВходящегоСообщения.ИдентификаторТипаВходящегоУникален(ЭтотОбъект, Отказ);
		Если Отказ Тогда			
			QIWI_АдаптерШлюзБСПКлиентСервер.СообщитьПользователю(ТекстСообщения, , , , Отказ);
			Возврат;
		КонецЕсли;	
	КонецЕсли;
	
КонецПроцедуры

#КонецЕсли