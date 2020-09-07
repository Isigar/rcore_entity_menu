Config = {}
Config.Debug = false
Config.Menu = {
    -------------------------------------------------------
    --                      AUTOMATY
    --------------------------------------------------------
    {
        model = -1034034125,
        help = 'Zmackni   ~INPUT_CONTEXT~pro pouziti automatu',
        menuDistance = 2.0,
        items = {-- [xScripts]/x_automat/config.lua you can find all IDs for products
            {
                name = 'buy_a_chip',
                emoji = '🍛',
                label = 'Koupit si brambůrky',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "snack", 1)
                end
            },

            {
                name = 'buy_a_snickers',
                emoji = '🍫',
                label = 'Koupit si snickers',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "snack", 2)
                end
            },

            {
                name = 'buy_a_m_m',
                emoji = '🍬',
                label = 'Koupit si m & m',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "snack", 3)
                end
            },

            {
                name = 'buy_a_skittles',
                emoji = '🍭',
                label = 'Koupit si skittles',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "snack", 4)
                end
            },
        }
    },

    {
        model = 1114264700,
        help = 'Zmackni   ~INPUT_CONTEXT~pro pouziti automatu',
        menuDistance = 2.0,
        items = {-- [xScripts]/x_automat/config.lua you can find all IDs for products
            {
                name = 'buy_a_sprite',
                emoji = '🧃',
                label = 'Koupit si sprite',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "soda", 1)
                end
            },

            {
                name = 'buy_a_coca_cola',
                emoji = '🥤',
                label = 'Koupit si Coca Colu',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "soda", 2)
                end
            },

            {
                name = 'buy_a_fanta',
                emoji = '🍾',
                label = 'Koupit si Fantu',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "soda", 3)
                end
            },

            {
                name = 'buy_a_water',
                emoji = '🍼',
                label = 'Koupit si vodu',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "soda", 4)
                end
            },
        }
    },

    {
        model = 992069095,
        help = 'Zmackni   ~INPUT_CONTEXT~pro pouziti automatu',
        menuDistance = 2.0,
        items = {-- [xScripts]/x_automat/config.lua you can find all IDs for products
            {
                name = 'buy_a_sprite',
                emoji = '🧃',
                label = 'Koupit si sprite',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "soda", 1)
                end
            },

            {
                name = 'buy_a_coca_cola',
                emoji = '🥤',
                label = 'Koupit si Coca Colu',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "soda", 2)
                end
            },

            {
                name = 'buy_a_fanta',
                emoji = '🍾',
                label = 'Koupit si Fantu',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "soda", 3)
                end
            },

            {
                name = 'buy_a_water',
                emoji = '🍼',
                label = 'Koupit si vodu',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "soda", 4)
                end
            },
        }
    },

    {
        model = -1691644768,
        help = 'Zmackni   ~INPUT_CONTEXT~pro pouziti automatu',
        menuDistance = 2.0,
        items = {
            {
                name = 'buy_a_water_machine',
                emoji = '🧊',
                label = 'Koupit si vodu',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "water", 1)
                end
            },
        }
    },

    {
        model = -742198632,
        help = 'Zmackni   ~INPUT_CONTEXT~pro pouziti automatu',
        menuDistance = 2.0,
        items = {
            {
                name = 'buy_a_water_machine',
                emoji = '🧊',
                label = 'Koupit si vodu',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "water", 1)
                end
            },
        }
    },

    {
        model = -742198632,
        help = 'Zmackni   ~INPUT_CONTEXT~pro pouziti automatu',
        menuDistance = 2.0,
        items = {
            {
                name = 'buy_a_water_machine',
                emoji = '☕',
                label = 'Koupit si vodu',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "water", 1)
                end
            },
        }
    },

    {
        model = 690372739,
        help = 'Zmackni   ~INPUT_CONTEXT~pro pouziti automatu',
        menuDistance = 2.0,
        items = {
            {
                name = 'buy_a_coffe_machine',
                emoji = '☕',
                label = 'Koupit kávu',
                cb = function(object)
                    TriggerEvent("x_automat:useAutomat", object, "coffe", 1)
                end
            },
        }
    },
    ------------------------------------------------------------------
}
