#Welcome message

# TELLRAW TEMPLATE:
tellraw @a {"text":"_____________________________________________","color":"white"}

tellraw @a [{"text":"Loaded Pixel Survival Pack v","color":"white"},{"text":"0.1 ","color":"yellow"},{"text":"by ","color":"white"},{"text":"PixelDotOriginal","color":"yellow"}]

tellraw @a [{"text":"Call ","color":"white"},{"text":"/function xtra_lifes:reset ","color":"green"},{"text":"if is the first time!","color":"white"}]

tellraw @a {"text":"Recepie:","color":"green"}
tellraw @a {"text":"      Drop 1 golden apple","color":"yellow"}
tellraw @a {"text":"      and 32 emerald","color":"yellow"}
tellraw @a {"text":"      on a workbanch","color":"yellow"}
tellraw @a {"text":"      to get +1 life.","color":"yellow"}

# Create Scoraboards: 
scoreboard objectives add lifes dummy "Lifes"
scoreboard objectives add hp health "HP"
scoreboard objectives add as_helper dummy "as_helper"


# Display Scoraboards:
scoreboard objectives setdisplay sidebar lifes
#scoreboard objectives setdisplay belowName hp

#scoreboard objectives setdisplay sidebar as_helper
