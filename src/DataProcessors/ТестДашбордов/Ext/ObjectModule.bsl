﻿
Процедура Тест_ДашбордыСериализовать() Экспорт
	
	ВсегоЗаработано = Дашборды.Создать(Перечисления.ВидыДашбордов.ВсегоЗаработано);
	ВсегоЗаработано.Параметры.Дата = ТекущаяДата();
	Результат = Дашборды.Сериализовать(ВсегоЗаработано);
	
КонецПроцедуры
