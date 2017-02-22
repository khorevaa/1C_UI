﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		
		Если ОбщегоНазначения.ЭтоПодчиненныйУзелРИБ() Тогда 
			
			НаборДляРегистрацииОтветаВГлавныйУзел = РегистрыСведений.ДанныеОбработанныеВЦентральномУзлеРИБ.СоздатьНаборЗаписей();
			
			Для Каждого СтрТабл Из ЭтотОбъект Цикл
				
				ДополнительныеПараметры    = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
				ПолноеИмяОбъектаМетаданных = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СтрТабл.ОбъектМетаданных, "ПолноеИмя");
				
				Если СтрНайти(ПолноеИмяОбъектаМетаданных, "РегистрНакопления") > 0
					Или СтрНайти(ПолноеИмяОбъектаМетаданных, "РегистрБухгалтерии") > 0
					Или СтрНайти(ПолноеИмяОбъектаМетаданных, "РегистрРасчета") > 0 Тогда
					
					ДополнительныеПараметры.ЭтоДвижения       = Истина;
					ДополнительныеПараметры.ПолноеИмяРегистра = ПолноеИмяОбъектаМетаданных;
					ДанныеДляОтметки                          = СтрТабл.Данные;
					
				ИначеЕсли СтрНайти(ПолноеИмяОбъектаМетаданных, "РегистрСведений") > 0 Тогда
					
					МетаданныеРегистра = Метаданные.НайтиПоПолномуИмени(ПолноеИмяОбъектаМетаданных);
					
					Если МетаданныеРегистра.РежимЗаписи = Метаданные.СвойстваОбъектов.РежимЗаписиРегистра.Независимый Тогда
						
						МенеджерРегистра = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ПолноеИмяОбъектаМетаданных);
						ДанныеДляОтметки = МенеджерРегистра.СоздатьНаборЗаписей();
						ЗначенияОтбора   = СтрТабл.ЗначенияОтборовНезависимогоРегистра.Получить();
						
						Для Каждого КлючЗначение Из ЗначенияОтбора Цикл
							ДанныеДляОтметки.Отбор[КлючЗначение.Ключ].Установить(КлючЗначение.Значение);
						КонецЦикла;
						
					Иначе
						
						ДополнительныеПараметры.ЭтоДвижения       = Истина;
						ДополнительныеПараметры.ПолноеИмяРегистра = ПолноеИмяОбъектаМетаданных;
						ДанныеДляОтметки                          = СтрТабл.Данные;
						
					КонецЕсли;
					
				Иначе
					ДанныеДляОтметки = СтрТабл.Данные;
				КонецЕсли;
				
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(ДанныеДляОтметки, ДополнительныеПараметры, СтрТабл.Очередь);
				
				НаборДляРегистрацииОтветаВГлавныйУзел.Отбор.УзелПланаОбмена.Установить(СтрТабл.УзелПланаОбмена);
				НаборДляРегистрацииОтветаВГлавныйУзел.Отбор.ОбъектМетаданных.Установить(СтрТабл.ОбъектМетаданных);
				НаборДляРегистрацииОтветаВГлавныйУзел.Отбор.Данные.Установить(СтрТабл.Данные);
				НаборДляРегистрацииОтветаВГлавныйУзел.Отбор.Очередь.Установить(СтрТабл.Очередь);
				НаборДляРегистрацииОтветаВГлавныйУзел.Отбор.КлючУникальности.Установить(СтрТабл.КлючУникальности);
				
				ПланыОбмена.ЗарегистрироватьИзменения(ОбменДанными.Отправитель, НаборДляРегистрацииОтветаВГлавныйУзел);
				
			КонецЦикла;
			
		КонецЕсли;
		
		Очистить();
		
	Иначе
		Если Количество() > 0
			И (Не ЗначениеЗаполнено(ПараметрыСеанса.ПараметрыОбработчикаОбновления.ОчередьОтложеннойОбработки)
				Или ОбщегоНазначения.ЭтоПодчиненныйУзелРИБ()
				Или (ПараметрыСеанса.ПараметрыОбработчикаОбновления.ЗапускатьТолькоВГлавномУзле
				      И Не СтандартныеПодсистемыПовтИсп.ИспользуетсяРИБ())
				Или (Не ПараметрыСеанса.ПараметрыОбработчикаОбновления.ЗапускатьТолькоВГлавномУзле
				      И Не СтандартныеПодсистемыПовтИсп.ИспользуетсяРИБ("СФильтром"))) Тогда
			
			Отказ = Истина;
			ТекстИсключения = НСтр("ru = 'Запись в РегистрСведений.ДанныеОбработанныеВЦентральномУзлеРИБ возможна только при отметке выполнения отложенного обработчика обновления информационной базы, который выполняется только в центральном узле.'");
			ВызватьИсключение ТекстИсключения;
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли