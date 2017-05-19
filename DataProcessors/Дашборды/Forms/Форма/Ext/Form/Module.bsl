﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Запущено задание по переходу на новый релиз информационной базы. Форму не показываем
	БазаОбновляется = ВыполняетсяОбновлениеИнформационнойБазы();
	
	Если Не БазаОбновляется Тогда
		ПодготовитьФормуНаСервере();
		УправлениеЭлементамиФормы(ЭтотОбъект);
	КонецЕсли;
	
		
	Инициализировать();
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Инициализировать();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если Не БазаОбновляется Тогда
		ЗапуститьФоновоеОбновлениеОтчетов();
	Иначе
		// Исправить не работает в  режиме первоначального заполнения
		ПодключитьОбработчикОжидания("Подключаемый_ЖдатьЗавершенияОбновленияИБ", 5, Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ОбновитьДанные(Команда)
	
	ЗапуститьФоновоеОбновлениеОтчетов();
	
	ОбновитьТекущиеСредства();
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьОтчетКурсовВалют(Элемент)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("БуквенныйКодВалюты", Элемент.Заголовок);
	ПараметрыФормы.Вставить("НачалоПериода", ПериодДанных.ДатаНачала);
	ПараметрыФормы.Вставить("ОкончаниеПериода", ПериодДанных.ДатаОкончания);
	ПараметрыФормы.Вставить("СформироватьПриОткрытии", Истина);
	
	ОткрытьФорму("Отчет.КурсыВалюты.Форма", ПараметрыФормы,,Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьОтчетКурсовТоваров(Элемент)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("НаименованиеТовара", Элемент.Заголовок);
	ПараметрыФормы.Вставить("НачалоПериода", ПериодДанных.ДатаНачала);
	ПараметрыФормы.Вставить("ОкончаниеПериода", ПериодДанных.ДатаОкончания);
	ПараметрыФормы.Вставить("СформироватьПриОткрытии", Истина);
	
	ОткрытьФорму("Отчет.КурсыТовара.Форма", ПараметрыФормы,, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьОтчетСтоимостьКапитала(Элемент)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("БуквенныйКодВалюты", Элемент.Заголовок);
	ПараметрыФормы.Вставить("Интервал", Интервал);
	ПараметрыФормы.Вставить("НачалоПериода", ПериодДанных.ДатаНачала);
	ПараметрыФормы.Вставить("ОкончаниеПериода", ПериодДанных.ДатаОкончания);
	ПараметрыФормы.Вставить("СформироватьПриОткрытии", Истина);
	
	ОткрытьФорму("Отчет.СтоимостьКапитала.Форма", ПараметрыФормы,, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьКурсыВалют(Элемент)
	
	РаботаСВалютамиВызовСервера.ЗагрузитьАктуальныйКурс();
	
	ЗапуститьФоновоеОбновлениеОтчетов();
	
КонецПроцедуры

&НаКлиенте
Процедура ПериодНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОбратныйВызов = Новый ОписаниеОповещения("ЗавершитьВыборПериода",ЭтотОбъект);
	
	ДиалогПериода = Новый ДиалогРедактированияСтандартногоПериода;
	ДиалогПериода.Показать(ОбратныйВызов);
	
	Интервал = ПредопределенноеЗначение("Перечисление.ИнтервалПериода.Произвольный");
	
КонецПроцедуры

&НаКлиенте
Процедура ИнтервалНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыВыбораИнтервала = Новый Структура("Отбор,СтрокаПоиска, СпособПоискаСтроки",,,СпособПоискаСтрокиПриВводеПоСтроке.ЛюбаяЧасть);
	
	ДанныеВыбора = ПолучитьДанныеВыбора(Тип("ПеречислениеСсылка.ИнтервалПериода"), ПараметрыВыбораИнтервала);
	
	ОбратныйВызов = Новый ОписаниеОповещения("ЗавершитьВыборИнтервала",ЭтотОбъект);
	ПоказатьВыборИзСписка(ОбратныйВызов, ДанныеВыбора, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ВводСредствНажатие(Элемент)
	
	РендерСпискаДокументов("ВводСредсвЭкспанд");
	
	//ИмяОткрФормы = "Документ.%ИмяДокумента.ФормаОбъекта";
	//ИмяОткрФормы = СтрЗаменить(ИмяОткрФормы, "%ИмяДокумента", Элемент.Имя);
	//ОткрытьФорму(ИмяОткрФормы);
	//
КонецПроцедуры

&НаКлиенте
Процедура ВыводСредствНажатие(Элемент)
	
	РендерСпискаДокументов("ВыводСредствЭкспанд");
	
КонецПроцедуры

&НаКлиенте
Процедура ПереводМеждуЭПСНажатие(Элемент)
	
	РендерСпискаДокументов("ПереводСредствЭкспанд");
	
КонецПроцедуры

&НаКлиенте
Процедура ЭкспортБД(Команда)
	
	ОткрытьФорму("Обработка.ОбменСБД.Форма");	
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкаПанелей(Команда)
	
	ПоказатьФормуНастройкиПанелей();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузкаЗагрузкаКотировок(Команда)
	
	ОткрытьФорму("Обработка.ОбменКотировками.Форма");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьКурсы(Команда)
	
	АктуализацияКурсовФормыКлиент.ЗапуститьФоновоеОбновлениеКурсов(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ФоновоеФормированиеОтчетов

&НаКлиенте
Процедура ЗапуститьФоновоеОбновлениеОтчетов() Экспорт
	
	АктуализацияКурсовФормыКлиент.СкрытьЭлементыАктуализации(ЭтотОбъект);
	
	Если Не ФоновоеЗаданиеАктуализацииАктивно(ИдентификаторЗадания) Тогда
		Элементы.ГруппаОжиданиеОбновленияОтчетов.Видимость = Истина;
		
		Результат = ВыполнитьВФоне();
		
		ПараметрыОжидания     = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
		ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
		ОповещениеОЗавершении = Новый ОписаниеОповещения("ЗавершитьОбновлениеОтчетов", ЭтотОбъект);
		ДлительныеОперацииКлиент.ОжидатьЗавершение(Результат, ОповещениеОЗавершении, ПараметрыОжидания);

		
	//	ИдентификаторЗадания = Результат.ИдентификаторЗадания;
	//	
	//	Если АктуализацияФоновыеЗаданияВызовСервера.ПроверитьЗаданиеВыполнено(ИдентификаторЗадания) Тогда
	//		ЗавершитьОбновлениеОтчетов();
	//	Иначе
	//		
	//		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжиданияАктуализации);
	//		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьАктуальностьЗадания", 1, Истина);
	//	КонецЕсли;
	//	
	КонецЕсли;
	
КонецПРоцедуры

&НаСервереБезКонтекста
Функция ФоновоеЗаданиеАктуализацииАктивно(ИдентификаторЗадания)
	
	ФоновоеЗаданиеАктуализации = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(ИдентификаторЗадания);
	Если ФоновоеЗаданиеАктуализации <> Неопределено И ФоновоеЗаданиеАктуализации.Состояние = СостояниеФоновогоЗадания.Активно Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура ОбновитьОтчеты(СформированныеДашборды)
	
	Для Каждого Дашборд Из СформированныеДашборды Цикл
		Дашборды.РазместитьВИнтерфейсе(ЭтотОбъект, Дашборд);
	КонецЦикла;
	
	ВсеДашборды = Дашборды.ПолучитьВсе();
	
	Для каждого ВидДашборда Из ВсеДашборды Цикл
		
		Элементы[ВидДашборда.Значение].Видимость = Ложь;
		
	КонецЦикла;
	
	Для каждого ВидДашборда Из АктивныеДашборды Цикл
		
		Элементы[ВидДашборда.Значение].Видимость = Истина;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьОбновлениеОтчетов(Результат, ПараметрыЗадания) Экспорт
	
	Элементы.ГруппаОжиданиеОбновленияОтчетов.Видимость = Ложь;
	
	АдресРезультата = Результат.АдресРезультата;
	СформированныеДашборды = ПолучитьИзВременногоХранилища(АдресРезультата);
	АдресРезультата = Неопределено;
	ОбновитьОтчеты(СформированныеДашборды);
	
	АктуализацияКурсовФормыКлиент.ПроверитьАктуальностьКурсов(ЭтотОбъект, КурсыОбновляютсяАвтоматически);
	
КонецПроцедуры

&НаСервере
Функция ВыполнитьВФоне()
	
	НаименованиеЗадания = НСтр("ru = 'Обновление дашбордов'");
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("АктивныеДашборды", АктивныеДашборды.ВыгрузитьЗначения());
	
	ПараметрыОтчетов = Новый Структура;
	ПараметрыОтчетов.Вставить("НачалоПериода", ПериодДанных.ДатаНачала);
	ПараметрыОтчетов.Вставить("ОкончаниеПериода", ПериодДанных.ДатаОкончания);
	ПараметрыОтчетов.Вставить("Интервал", Интервал);
	ПараметрыОтчетов.Вставить("Дата", ДатаСейчас);
	ПараметрыЗадания.Вставить("ПараметрыОтчетов",ПараметрыОтчетов);
	
	ПараметрыВыполненияВФоне = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполненияВФоне.ОжидатьЗавершение = 0;
	Результат = ДлительныеОперации.ВыполнитьВФоне("Обработки.Дашборды.ОбновитьОтчеты", ПараметрыЗадания, ПараметрыВыполненияВФоне);
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура Подключаемый_ПроверитьАктуальностьЗаданияКурсов() Экспорт
	
	АктуализацияКурсовФормыКлиент.ПроверитьАктуальностьЗаданияОбновленияКурсов(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область АсинхронныеПроцедуры

&НаКлиенте
Процедура ЗавершитьВыборПериода(Период, ДополнительныеПараметры) Экспорт
	
	Если Период = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПериодДанных = Период;
	
	ЗапуститьФоновоеОбновлениеОтчетов();
	
КОнецПроцедуры

&НаКлиенте
Процедура ЗавершитьВыборИнтервала(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныйЭлемент = Неопределено тогда
		Возврат;
	КонецЕсли;
	
	Интервал = ВыбранныйЭлемент.Значение.Значение;
	ПериодДанных.ДатаНачала = ПолучитьДатуНачала(Интервал, ПериодДанных.ДатаОкончания);
	
	ЗапуститьФоновоеОбновлениеОтчетов();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура Инициализировать()
	
	// Порядок инициализации переменных:
	// 1. Интервал
	// 2. Остальные переменные - в любом порядке.
	
	Интервал = Перечисления.ИнтервалПериода.Квартал;
	ДатаСейчас = ТекущаяДатаСеанса();
	ПериодДанных.ДатаОкончания = ДатаСейчас;
	ПериодДанных.ДатаНачала = ПолучитьДатуНачала(Интервал, ПериодДанных.ДатаОкончания);
	
	КурсыОбновляютсяАвтоматически = УправлениеНастройкамиПользователей.ПолучитьПризнакОбновленияКурсов();
	ОсновнаяВалюта = ЗапросыВспомогательныеДанные.ПолучитьОсновнуюВалюту();
	ОсновнойИсточникСредств = УправлениеНастройкамиПользователей.ПолучитьОсновнойИсточникСредств();
	ОсновнаяПлатежнаяСистема = УправлениеНастройкамиПользователей.ПолучитьОсновнуюПлатежнуюСистему();
	ПользовательскиеДашборды = УправлениеНастройкамиПользователей.ПолучитьАктивныеДашборды();
	
	Если ПользовательскиеДашборды = Неопределено Тогда
		ПользовательскиеДашборды = Дашборды.ПолучитьСтандартные();
	КонецЕсли;
	
	АктивныеДашборды = ПользовательскиеДашборды;
	
КонецПроцедуры

&НаСервере
Процедура ПодготовитьФормуНаСервере();
	
	//РаботыСФормамиУИ.УстановитьУсловноеОформлениеПоляДата(ЭтотОбъект, "СписокДокументовДоход.Дата", "СписокДокументовДата");
	//РаботыСФормамиУИ.УстановитьУсловноеОформлениеПоляДата(ЭтотОбъект, "СписокДокументовРасход.Дата", "СписокДокументовРасходДата");
	//РаботыСФормамиУИ.УстановитьУсловноеОформлениеПоляДата(ЭтотОбъект, "СписокДокументовПеревод.Дата", "СписокДокументовПереводДата");
	
	ТекущиеСредстваФормы.ЗаполнитьИнфоСредств(ЭтотОбъект);
	ТекущиеСредстваФормы.ЗаполнитьСпискиДокументов(ЭтотОбъект);
	
	УстановитьУсловноеОформление()
	
КонецПроцедуры

Процедура УстановитьУсловноеОформление()
	
	ЭлементУО = УсловноеОформление.Элементы.Добавить();
	ПолеУО = ЭлементУО.Поля.Элементы.Добавить();
	ПолеУО.Поле = Новый ПолеКомпоновкиДанных (Элементы.СписокДокументовДоход.Имя);
	ОтборУО = ЭлементУО.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборУО.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("СписокДокументовДоход.ПометкаУдаления");
	ОтборУО.ПравоеЗначение = Истина;
	ОтборУО.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	
	ЭлементУО.Оформление.УстановитьЗначениеПараметра("ЦветТекста", WebЦвета.ТемноСерый);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеЭлементамиФормы(Форма);
	
	Элементы = Форма.Элементы;
	
	СтрелкаВниз = БиблиотекаКартинок.СтрелкаВниз;
	Элементы.ВводСредсвЭкспанд.Картинка = СтрелкаВниз;
	Элементы.ВыводСредствЭкспанд.Картинка = СтрелкаВниз;
	Элементы.ПереводСредствЭкспанд.Картинка = СтрелкаВниз;
	
КонецПроцедуры

&НаСервере
Функция РеквизитОбъект(КонвертируемыйОбъект)
	
	ОтчетОбъект = Неопределено;
	
	Если ТипЗнч(КонвертируемыйОбъект) = Тип("Строка") Тогда
		ОтчетОбъект = РеквизитФормыВЗначение(КонвертируемыйОбъект);
	Иначе
		ЗначениеВРеквизитФормы
			(КонвертируемыйОбъект,КонвертируемыйОбъект.Метаданные().Имя);
	КонецЕсли;
	
	Возврат ОтчетОбъект;
	
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьДатуНачала(Интервал, КонечнаяДата);
	
	ДатыОтчетов = Новый Структура;
	
	Если Интервал = Перечисления.ИнтервалПериода.Месяц Тогда
		КоличествоМесяцев = -1;
	ИначеЕсли Интервал = Перечисления.ИнтервалПериода.Квартал Тогда
		КоличествоМесяцев = -3;
	ИначеЕсли Интервал = Перечисления.ИнтервалПериода.Полугодие Тогда
		КоличествоМесяцев = -6;
	ИначеЕсли Интервал = Перечисления.ИнтервалПериода.Год тогда
		КоличествоМесяцев = -12;
	Иначе
		КоличествоМесяцев = 0;
	КонецЕсли;
	
	НачалоПериода = НачалоДня(ДобавитьМесяц(КонечнаяДата, КоличествоМесяцев));
	
	Возврат НачалоПериода;
	
КонецФункции

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ОбновитьДашборды" Тогда
		// Возникает в случае записи документов ввода, вывода средств.
		ЗапуститьФоновоеОбновлениеОтчетов();
	ИначеЕсли ИмяСобытия = "НастройкаПанелейДашбордов" Тогда
		// Обработка выбора из формы Настроек панелей. Нужно сначала записать выбранные дашборды, затем только обновить.
		АктивныеДашборды = Параметр;
		
		ЗапуститьФоновоеОбновлениеОтчетов();
		
	ИначеЕсли ИмяСобытия = "ИзменениеСредств" Тогда
		// Возникает для обновления текущих итогов в случае записи документов ввода, вывода средств.
		ЗаполнитьИнфоСредств();
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Декорация2Нажатие(Элемент)
	
	РендерСпискаДокументов(Элемент.Имя);
	
КонецПроцедуры

&НаСервере
Процедура РендерСпискаДокументов(ИмяЭкспанда)
	
	Экспанд = Элементы[ИмяЭкспанда];
	
	Если Экспанд.Картинка = БиблиотекаКартинок.СтрелкаВниз Тогда
		Разворачивается = Истина;
	Иначе
		Разворачивается = Ложь;
	КонецЕсли;
	
	Элементы.СписокДокументовДоход.Видимость = Ложь;
	Элементы.СписокДокументовРасход.Видимость = Ложь;
	Элементы.СписокДокументовПеревод.Видимость = Ложь;
	
	Элементы.ГруппаИтоги.Видимость = Ложь;
	
	ТаблицаСписка = Неопределено;
	Если Экспанд = Элементы.ВводСредсвЭкспанд Тогда
		ТаблицаСписка = "Документ.ВводСредств";
		Элементы.СписокДокументовДоход.Видимость = Разворачивается;
	ИначеЕсли Экспанд = Элементы.ВыводСредствЭкспанд Тогда
		ТаблицаСписка = "Документ.ВыводСредств";
		Элементы.СписокДокументовРасход.Видимость = Разворачивается;
	ИначеЕсли Экспанд = Элементы.ПереводСредствЭкспанд Тогда
		ТаблицаСписка = "Документ.ПереводМеждуЭПС";
		Элементы.СписокДокументовПеревод.Видимость = Разворачивается;
	КонецЕсли;
	
	Элементы.ГруппаИтоги.Видимость = Разворачивается;
	
	СтрелкаВниз = БиблиотекаКартинок.СтрелкаВниз;
	Элементы.ВводСредсвЭкспанд.Картинка = СтрелкаВниз;
	Элементы.ВыводСредствЭкспанд.Картинка = СтрелкаВниз;
	Элементы.ПереводСредствЭкспанд.Картинка = СтрелкаВниз;
	
	Если Разворачивается Тогда
		Экспанд.Картинка = БиблиотекаКартинок.СтрелкаВверх;
	Иначе
		Экспанд.Картинка = БиблиотекаКартинок.СтрелкаВниз;
	КонецЕсли;
	
	//Элементы.ГруппаСписокДокументов.Видимость = Разворачивается;
//	СписокДокументовДоход.ОсновнаяТаблица = ТаблицаСписка;
	Элементы.ИнформационнаяПанель.Видимость = Не Разворачивается;
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьФормуНастройкиПанелей()
	
	НеактивныеДашборды = НеактивныеДашборды(АктивныеДашборды);
	
	ПараметрыФормы = Новый Структура("ВыбранныеПанели, ДоступныеПанели", АктивныеДашборды, НеактивныеДашборды);
	ОткрытьФорму("ОбщаяФорма.НастройкиПанелей", ПараметрыФормы, ЭтотОбъект);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция НеактивныеДашборды(АктивныеДашборды)
	
	Возврат Дашборды.ПолучитьНеактивные(АктивныеДашборды);
	
КонецФункции

&НаКлиенте
Процедура Подключаемый_ЖдатьЗавершенияОбновленияИБ()
	
	Если ВыполняетсяОбновлениеИнформационнойБазы() Тогда
		ПодключитьОбработчикОжидания("Подключаемый_ЖдатьЗавершенияОбновленияИБ", 5, Истина);
	Иначе
		БазаОбновляется = Ложь;
		ПодготовитьФормуНаСервере();
		УправлениеЭлементамиФормы(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВыполняетсяОбновлениеИнформационнойБазы()
	
	Возврат ОбновлениеИнформационнойБазы.ВыполняетсяОбновлениеИнформационнойБазы();
	
КонецФункции

#Область ОперацииСоСредствами

&НаСервере
Процедура ОбновитьТекущиеСредства()
	
	ТекущиеСредстваФормы.ЗаполнитьИнфоСредств(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьИнфоСредств()
	
	ТекущиеСредстваФормы.ЗаполнитьИнфоСредств(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьДокументСписка(Команда)
	
	ТекущиеСредстваФормыКлиент.УдалитьДокументСписка(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьДокументСписка(Команда)

	ТекущиеСредстваФормыКлиент.ДобавитьДокументСписка(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПеревестиВЧерновик(Команда)
	
	ТекущиеСредстваФормыКлиент.ПеревестиВЧерновикДокументСписка(ЭтотОбъект);

КонецПроцедуры

// СПИСОК ДОКУМЕНТОВ ДОХОДОВ
&НаКлиенте
Процедура СписокДокументовДоходПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ТекСтрока = Элементы.СписокДокументовДоход.ТекущиеДанные;
	ОбновляемыеРеквизиты = Новый Структура("Валюта, Сумма, ПлатежнаяСистема, ИсточникСредств", 
		ТекСтрока.Валюта, ТекСтрока.Сумма, ТекСтрока.ПлатежнаяСистема, ТекСтрока.ИсточникСредств);

	ТекущиеСредстваФормыКлиент.ОбновитьДанныеТекущейСтроки(Элементы.СписокДокументовДоход, ОбновляемыеРеквизиты, ОтменаРедактирования);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокДокументовДоходПередУдалением(Элемент, Отказ)
	
	Отказ = Истина;
	
	ОбработатьУдалениеДокументаНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьУдалениеДокументаНаСервере()
	
	ТекущиеСредстваФормы.ОбработатьУдалениеДокументаНаСервере(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура СписокДокументовДоходПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		ТекСтрока = Элементы.СписокДокументовДоход.ТекущиеДанные;
		ТекущиеСредстваФормыКлиент.ЗаполнитьРеквизитыПоУмолчанию(Элементы.СписокДокументовДоход,
			ОсновнойИсточникСредств, ОсновнаяПлатежнаяСистема);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокДокументовДоходВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "СписокДокументовДоходСостояниеДокумента" Тогда
		ТекущиеСредстваФормыКлиент.ОткрытьТекущийДокумент(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

// СПИСОК ДОКУМЕНТОВ РАСХОД
&НаКлиенте
Процедура СписокДокументовРасходВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "СписокДокументовРасходСостояниеДокумента" Тогда
		ТекущиеСредстваФормыКлиент.ОткрытьТекущийДокумент(ЭтотОбъект);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СписокДокументовРасходПередУдалением(Элемент, Отказ)
	
	Отказ = Истина;
	
	ОбработатьУдалениеДокументаНаСервере();

КонецПроцедуры

&НаКлиенте
Процедура СписокДокументовРасходПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		ТекСтрока = Элементы.СписокДокументовРасход.ТекущиеДанные;
		ТекущиеСредстваФормыКлиент.ЗаполнитьРеквизитыПоУмолчанию(Элементы.СписокДокументовРасход,, ОсновнаяПлатежнаяСистема);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СписокДокументовРасходПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ТекСтрока = Элементы.СписокДокументовРасход.ТекущиеДанные;
	ОбновляемыеРеквизиты = Новый Структура("Валюта, Сумма, ПлатежнаяСистема, ОбъектИнвестиций, ИнвестированыВПроект", 
		ТекСтрока.Валюта, ТекСтрока.Сумма, ТекСтрока.ПлатежнаяСистема, ТекСтрока.ОбъектИнвестиций, ТекСтрока.ИнвестированыВПроект);

	ТекущиеСредстваФормыКлиент.ОбновитьДанныеТекущейСтроки(Элементы.СписокДокументовРасход, ОбновляемыеРеквизиты, ОтменаРедактирования);

КонецПроцедуры

#КонецОбласти

// СПИСОК ДОКУМЕНТОВ ПЕРЕВОД 

&НаКлиенте
Процедура СписокДокументовПереводВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "СписокДокументовПереводСостояниеДокумента" Тогда
		ТекущиеСредстваФормыКлиент.ОткрытьТекущийДокумент(ЭтотОбъект);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СписокДокументовПереводПередУдалением(Элемент, Отказ)
	
	Отказ = Истина;
	
	ОбработатьУдалениеДокументаНаСервере();

КонецПроцедуры

&НаКлиенте
Процедура СписокДокументовПереводПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		ТекСтрока = Элементы.СписокДокументовПеревод.ТекущиеДанные;
		ТекСтрока.Дата = ТекущаяДата();
		ТекСтрока.ПлатежнаяСистемаИсточник = ОсновнаяПлатежнаяСистема;
		ТекСтрока.ПлатежнаяСистемаПриемник = ОсновнаяПлатежнаяСистема;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СписокДокументовПереводПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ТекСтрока = Элементы.СписокДокументовПеревод.ТекущиеДанные;
	Индекс = СписокДокументовПеревод.Индекс(СписокДокументовПеревод.НайтиПоИдентификатору(ТекСтрока.ПолучитьИдентификатор()));
	
	Если ТекСтрока.ВалютаИсточник = ТекСтрока.ВалютаПриемник Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru = 'Валюты не могут совпадать!'"),
			ТекСтрока.Ссылка,
			"ВалютаПриемник",
			"СписокДокументовПеревод["+ (Индекс) +"].ВалютаПриемник",
			ОтменаРедактирования);
	КонецЕсли;
	
	ОбновляемыеРеквизиты = Новый Структура("ВалютаИсточник, ВалютаПриемник, СуммаИсточник, СуммаПриемник, ПлатежнаяСистемаИсточник, ПлатежнаяСистемаПриемник, ПометкаУдаления", 
		ТекСтрока.ВалютаИсточник, ТекСтрока.ВалютаПриемник, ТекСтрока.СуммаИсточник, ТекСтрока.СуммаПриемник, ТекСтрока.ПлатежнаяСистемаИсточник, ТекСтрока.ПлатежнаяСистемаПриемник, ОтменаРедактирования);
		
	ТекущиеСредстваФормыКлиент.ОбновитьДанныеТекущейСтроки(Элементы.СписокДокументовПеревод, ОбновляемыеРеквизиты);
	
КонецПроцедуры

#КонецОбласти