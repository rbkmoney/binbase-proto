namespace java com.rbkmoney.damsel.binbase
namespace erlang binbase

enum CardType {
    charge_card
    credit
    debit
    credit_or_debit
}

struct Last {}

typedef i64 Version

/**
* Версия данных БИН
* version - указание версии
* last - последняя версия
*/
union Reference {
    1: Version version
    2: Last last
}

exception BinNotFound {}

/**
* Ответ с данными БИН и версией
*/
struct ResponseData {
    1: required BinData bin_data
    2: required Version version
}

/**
* Данные о БИН
* payment_system - платежная система
* bank_name - наименование банка
* iso_country_code - страна эмитента в формате ISO3166-1 Alpha 3
* card_type - тип карты
*/
struct BinData {
    1: required string payment_system
    2: optional string bank_name
    3: optional string iso_country_code
    4: optional CardType card_type
}

service Binbase {

    /**
    * Получить данные по БИН
    * card_pan - номер карты
    * reference - версия данных БИН
    * возращает данные БИН и версию
    * кидает BinNotFound, если данных о БИН нет
    */
    ResponseData Lookup (1: string card_pan, 2: Reference reference) throws (1: BinNotFound not_found)

}
