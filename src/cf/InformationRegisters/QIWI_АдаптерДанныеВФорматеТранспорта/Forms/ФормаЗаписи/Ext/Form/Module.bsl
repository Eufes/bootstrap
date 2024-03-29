﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОтобразитьПредставлениеДанных();
	
КонецПроцедуры

&НаСервере
Процедура ОтобразитьПредставлениеДанных()
	
	Если Не Параметры.Ключ.Пустой() Тогда
		
		ТекЗапись = РеквизитФормыВЗначение("Запись");
		ДанныеЗаписи = ТекЗапись.ДанныеОбмена.Получить();
		Если ЗначениеЗаполнено(ДанныеЗаписи) Тогда
			Если ТипЗнч(ДанныеЗаписи) = Тип("Строка") Тогда 
				ПредставлениеДанных = ДанныеЗаписи;
			Иначе
				Элементы.ПредставлениеДанных.ПодсказкаВвода = "Данные не в строковом формате";				
			КонецЕсли;
		Иначе
			Элементы.ПредставлениеДанных.ПодсказкаВвода = "Нет данных для отображения";
		КонецЕсли;				
	КонецЕсли;	
	
КонецПроцедуры	

&НаКлиенте
Процедура ПредставлениеДанныхНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОтобразитьПредставлениеДанных();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ДанныеСжато = Новый ХранилищеЗначения(ПредставлениеДанных, Новый СжатиеДанных(9));
	ТекущийОбъект.ДанныеОбмена = ДанныеСжато;
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеДанныхПриИзменении(Элемент)
	Модифицированность = Истина;
КонецПроцедуры
