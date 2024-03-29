﻿
#Область Логирование //******************************************
 
// Запись логов событий в регистр и журнал регистрациии
//
// Параметры:
//  ИмяСобытия  - Строка - Классфикация события. Короткий текст.
//  Уровень  	- УровеньЖурналаРегистрации - Уровень важности событий журнала регистрации 
//  Информация 	- Строка - Информация о событии
//	ДанныеДляЖР	- Число, Строка, Дата, Булево, Неопределено, Null, Тип - Ссылка на связанные данные
//	ЗаписыватьВПротокол - Булево - Признак для записи в отдельный регистр
//	СсылкаНаСообщение 	- СправочникСсылка.QIWI_АдаптерСообщенияИсходящие
//						- СправочникСсылка.QIWI_АдаптерСообщенияВходящие - ссылка на сообщение
//
Процедура ВыполнитьЛогирование(Знач ИмяСобытия, Знач Уровень, Знач Информация, Знач ДанныеДляЖР = Неопределено,
					Знач ЗаписыватьВПротокол = Ложь, Знач СсылкаНаСообщение = Неопределено) Экспорт
	
	ЗаписьЖурналаРегистрации(ИмяСобытия, Уровень, , ДанныеДляЖР, Информация);
			
	Если ЗаписыватьВПротокол И Не ТранзакцияАктивна() Тогда
		
		Попытка
			МенеджерЗаписи = РегистрыСведений.QIWI_АдаптерПротоколОбмена.СоздатьМенеджерЗаписи();
			МенеджерЗаписи.Сообщение = СсылкаНаСообщение;
			МенеджерЗаписи.Пользователь = QIWI_АдаптерШлюзБСПСервер.АвторизованныйПользователь();
			Если Уровень = УровеньЖурналаРегистрации.Ошибка Тогда
				УровеньСобытия = Перечисления.QIWI_АдаптерУровниСобытийПротокола.Ошибка;
			Иначе
				УровеньСобытия = Перечисления.QIWI_АдаптерУровниСобытийПротокола.Информация;
			КонецЕсли;
			МенеджерЗаписи.УровеньСобытия = УровеньСобытия;
			
			МенеджерЗаписи.ГодИМесяц = Формат(ТекущаяДатаСеанса(), "ДФ=yyyy_MM");			
			МенеджерЗаписи.ОписаниеСобытия = Информация;
			МенеджерЗаписи.ДатаСобытия = ТекущаяДатаСеанса();
			МенеджерЗаписи.УникальноеВремяСобытия = ТекущаяУниверсальнаяДатаВМиллисекундах();
			
			МенеджерЗаписи.Записать();
		Исключение
			ТекстОшибки = ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации("QIWI_АдаптерОшибкаЛогирования", УровеньЖурналаРегистрации.Ошибка,
											, ДанныеДляЖР, ТекстОшибки);
		КонецПопытки;		
		
	КонецЕсли;
	
КонецПроцедуры 

#КонецОбласти // Логирование

#Область Уведомления //******************************************

// Формирует параметры для отправки письма
//
// Параметры:
//  Адресаты - ТаблицаЗначений	- Получатели. Могут быть получены функцией ПолучитьАдресатовИнтеграционногоПроцесса()
// 
// Возвращаемое значение:
//  Структура - Параметры письма:
//  	* Кому - Массив из Строка  			 
//  	* Тема - Строка
//  	* ПолучателиСтрокой - Строка
//
Функция СформироватьПараметрыПисьма(Знач Адресаты) Экспорт
		
	ПараметрыПисьма = Новый Структура();
	
	Кому = Новый Массив;
	МассивАдресов = Новый Массив;
	Для Каждого ПочтовыйАдрес Из Адресаты Цикл
		Кому.Добавить(Новый Структура("Адрес, Представление", ПочтовыйАдрес.Адрес, ПочтовыйАдрес.Представление));
		МассивАдресов.Добавить(ПочтовыйАдрес.Адрес);
	КонецЦикла;
		
	ПараметрыПисьма.Вставить("Кому", Кому);
	ПараметрыПисьма.Вставить("Тема", "Ошибка синхронизации справочников контрагентов(договоров) ДО -> 1С");
	ПараметрыПисьма.Вставить("ПолучателиСтрокой", СтрСоединить(МассивАдресов));
	
	Возврат ПараметрыПисьма;
	
КонецФункции

#КонецОбласти // Уведомления

