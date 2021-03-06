﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОсновнаяВалюта = ЗапросыВспомогательныеДанные.ПолучитьОсновнуюВалюту();
	
	Если Объект.Ссылка.Пустая() Тогда
		Объект.ПлатежнаяСистема =  УправлениеНастройкамиПользователей.ПолучитьОсновнуюПлатежнуюСистему();
		Объект.Валюта = УправлениеНастройкамиПользователей.ПолучитьОсновнуюВалюту(); 
	КонецЕсли;
	
	ПодготовитьФормуНаСервере();
	
	// Начало СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	ДополнительныеПараметры.Вставить("СкрытьУдаленные", Истина);
	ДополнительныеПараметры.Вставить("Объект", ОбъектИнвестицийОбъект);
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	Если Не Объект.ОбъектИнвестиций.Пустая() Тогда
		ПрочитатьОбъектИнвестиции();
	КонецЕсли;
	
// СтандартныеПодсистемы.Свойства
	ТекОбъектОбъектИнвестиций = РеквизитФормыВЗначение("ОбъектИнвестицийОбъект");
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекОбъектОбъектИнвестиций);
// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
// Конец СтандартныеПодсистемы.Свойства

	Если Объект.ИнвестированыВПроект Тогда
		Если Не ЗначениеЗаполнено(ОбъектИнвестицийОбъект.ВидИнвестиции) Тогда
			ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения(, "Заполнение", НСтр("ru = 'Инвестиция'"));
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "ОбъектИнвестицийОбъект.ВидИнвестиции", , Отказ);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	//ДашбордыФормыКлиент.ОповеститьДашборды();
	ТекущиеСредстваФормыКлиент.ОповеститьИзменениеСредств();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	ТекОбъектОбъектИнвестиций = РеквизитФормыВЗначение("ОбъектИнвестицийОбъект");
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекОбъектОбъектИнвестиций);
	ЗначениеВРеквизитФормы(ТекОбъектОбъектИнвестиций, "ОбъектИнвестицийОбъект");
	// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВалютаПриИзменении(Элемент)
	
	УстановитьВидимостьСуммыВалюты();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбъектИнвестицийОбъектВидИнвестицииПриИзменении(Элемент)
	
	Если Не ОбъектИнвестицийОбъект.Ссылка.Пустая() Тогда
		ЗаблокироватьОбъектИнвестиций(ОбъектИнвестицийОбъект.Ссылка, 
			ОбъектИнвестицийОбъект.ВерсияДанных, 
			УникальныйИдентификатор);
	КонецЕсли;
	
	ОбновитьЭлементыДополнительныхРеквизитов();
	
КонецПроцедуры

&НаКлиенте
Процедура ИнвестированыПриИзменении(Элемент)
	УправлениеФормой(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСвойство(Команда)
	
	НаборСвойств = ПрочитатьНаборСвойств(ОбъектИнвестицийОбъект.ВидИнвестиции);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("НаборСвойств", НаборСвойств);
	ПараметрыФормы.Вставить("ЭтоДополнительноеСведение", Ложь);
	ПараметрыФормы.Вставить("ТекущийНаборСвойств", НаборСвойств);
	
	ОткрытьФорму("ПланВидовХарактеристик.ДополнительныеРеквизитыИСведения.ФормаОбъекта",
		ПараметрыФормы, Элементы.ДобавитьСвойство);
	
	//НовоеСвойствоФормы();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ПрочитатьНаборСвойств(Знач ВидИнвестиции)
	
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВидИнвестиции, "НаборСвойств");
	
КонецФункции


// СтандартныеПодсистемы.Свойства 
&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект, ОбъектИнвестицийОбъект, Истина);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

&НаСервере
Процедура ПодготовитьФормуНаСервере()
	
	УстановитьВидимостьСуммыВалюты();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьСуммыВалюты()
	
	Если ОсновнаяВалюта = Объект.Валюта Тогда
		Элементы.Сумма.Видимость = Ложь;
		
	Иначе
		Элементы.Сумма.Видимость = Истина;
		Элементы.Сумма.Заголовок = СтрШаблон(НСтр("ru = 'Сумма после конвертации: (%1)'"),
			ОбщегоНазначения.ЗначениеРеквизитаОбъекта(объект.Валюта, "Наименование"));
	КонецЕсли;
	
	Элементы.Сумма.Заголовок = СтрШаблон(Нстр("ru = 'Сумма: (%1)'"),Строка(ОсновнаяВалюта));

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Элементы = Форма.Элементы;
	Объект = Форма.Объект;
	
	Элементы.ГруппаИнвестиции.Доступность = Объект.ИнвестированыВПроект;
	
КонецПроцедуры

#Область ОсновнойОбъектИнвестиций
&НаСервере
Процедура ЗаписатьОбъектИнвестиции(ТекущийОбъект, ОбъектИнвестиций)
	
	Если ОбъектИнвестицийОбъект.Ссылка.Пустая() Тогда
		ТекущийОбъект.ОбъектИнвестиций = Справочники.ОбъектыИнвестиций.ПолучитьСсылку();
		ОбъектИнвестиций.УстановитьСсылкуНового(ТекущийОбъект.ОбъектИнвестиций);
	КонецЕсли;
	
	ОбъектИнвестиций.Записать();
	ТекущийОбъект.Записать();
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьОбъектИнвестиции()
	
	ПрочитанныйОбъектИнвестиций =  Объект.ОбъектИнвестиций.ПолучитьОбъект();
	ЗначениеВРеквизитФормы(ПрочитанныйОбъектИнвестиций, "ОбъектИнвестицийОбъект");
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаблокироватьОбъектИнвестиций(Ссылка, ВерсияДанных, УникальныйИдентификатор)
	
	ЗаблокироватьДанныеДляРедактирования(Ссылка, ВерсияДанных, УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбъектИнвестицийОбъектВидИнвестицииОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ЗначениеЗаполнено(ОбъектИнвестицийОбъект.ВидИнвестиции) И Не ОбъектИнвестицийОбъект.Ссылка.Пустая() Тогда
		ОткрытьФорму("Справочник.ОбъектыИнвестиций.ФормаОбъекта", Новый Структура ("Ключ", Объект.ОбъектИнвестиций));
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура НовоеСвойствоФормы()
	
	ШаблонИмени = "НовоеСвойствоИнвестиции";
	
	ПорядковыйНомер = Строка(СчетчикРеквизитов);
	
	НовыйРеквизитФормыЗаголовок = Новый РеквизитФормы(ШаблонИмени + "Заголовок" + ПорядковыйНомер, ОбщегоНазначения.ОписаниеТипаСтрока(0));
	НовыйРеквизитФормыЗначение = Новый РеквизитФормы(ШаблонИмени + "Значение" + ПорядковыйНомер, ОбщегоНазначения.ОписаниеТипаСтрока(0));
	
	ДобавляемыеРеквизиты = Новый Массив;
	ДобавляемыеРеквизиты.Добавить(НовыйРеквизитФормыЗаголовок);
	ДобавляемыеРеквизиты.Добавить(НовыйРеквизитФормыЗначение);
	ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	НоваяГруппаФормы = Элементы.Добавить("Группа" + ШаблонИмени + ПорядковыйНомер, Тип("ГруппаФормы"), Элементы.ГруппаДополнительныеРеквизиты);
	НоваяГруппаФормы.Заголовок = "";
	НоваяГруппаФормы.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	НоваяГруппаФормы.РастягиватьПоГоризонтали = Ложь;
	НоваяГруппаФормы.ОтображатьЗаголовок = Ложь;
	
	// Заголовок доп. реквизита.
	НовыйЭлементФормы = Элементы.Добавить(НовыйРеквизитФормыЗаголовок.Имя, Тип("ПолеФормы"), ЭтаФорма.Элементы[НоваяГруппаФормы.Имя]);
	НовыйЭлементФормы.ПутьКДанным = НовыйРеквизитФормыЗаголовок.Имя;
	НовыйЭлементФормы.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлементФормы.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
	НовыйЭлементФормы.ПодсказкаВвода = НСтр("ru = 'Введите имя'");
	// Значение доп. реквизита.
	НовыйЭлементФормы = Элементы.Добавить(НовыйРеквизитФормыЗначение.Имя, Тип("ПолеФормы"), ЭтаФорма.Элементы[НоваяГруппаФормы.Имя]);
	НовыйЭлементФормы.ПутьКДанным = НовыйРеквизитФормыЗначение.Имя;
	НовыйЭлементФормы.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлементФормы.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
	НовыйЭлементФормы.ПодсказкаВвода = НСтр("ru = 'Введите значение'");
	
	СчетчикРеквизитов = СчетчикРеквизитов + 1;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если Не ОбъектИнвестицийОбъект.ВидИнвестиции.Пустая() Тогда
		ТекОбъектОбъектИнвестиций = РеквизитФормыВЗначение("ОбъектИнвестицийОбъект");
		ЗаписатьОбъектИнвестиции(ТекущийОбъект, ТекОбъектОбъектИнвестиций);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
