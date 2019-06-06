# Searching for craftable:
tag @e[type=item,nbt={Item:{id:"minecraft:golden_apple",Count:1b}}] add extra_life_recipe_1
tag @e[type=item,nbt={Item:{id:"minecraft:emerald",Count:32b}}] add extra_life_recipe_2

# Crafting Recipe:

# 0  (0-->1) no AS around
# 2  (2-->3) is AS around

# if() -> summon armor_stand:"extra_live_craft_area"
execute as @e[tag=extra_life_recipe_1] at @s if entity @e[tag=extra_life_recipe_2,distance=..1] if block ~ ~-1 ~ minecraft:crafting_table if score AsIsAlive as_helper matches 0 run summon minecraft:armor_stand ~ ~ ~ {CustomName:"\"extra_live_craft_area\"",CustomNameVisible:0b,Invisible:1b}
execute as @e[tag=extra_life_recipe_1] at @s if entity @e[tag=extra_life_recipe_2,distance=..1] if block ~ ~-1 ~ minecraft:crafting_table if score AsIsAlive as_helper matches 0 run scoreboard players add AsIsAlive as_helper 1
execute if score AsIsAlive as_helper matches 1 run scoreboard players add AsTickLived as_helper 1

# Particle
execute as @e[name="extra_live_craft_area"] at @s run particle minecraft:firework ~ ~0.2 ~ 0.01 0.01 0.01 0.1 32
execute as @e[name="extra_live_craft_area"] at @s run particle minecraft:enchant ~ ~1 ~ 0.01 0.01 0.01 1 100
execute as @e[name="extra_live_craft_area"] at @s run particle minecraft:enchanted_hit ~ ~0.2 ~ 0.01 0.01 0.01 1 10
# Play Sound
execute as @e[name="extra_live_craft_area"] at @s run playsound minecraft:entity.firework_rocket.large_blast_far block @a ~ ~ ~ 1 1

# Increase health points
execute as @e[name="extra_live_craft_area"] run scoreboard players add count lifes 1
# Reset timer:
execute as @e[name="extra_live_craft_area"] run scoreboard players set TurnOffTimer as_helper 0

# Delete recipe items
execute as @e[name="extra_live_craft_area"] run kill @e[tag=extra_life_recipe_1,distance=..2]
execute as @e[name="extra_live_craft_area"] run kill @e[tag=extra_life_recipe_2,distance=..2]


# TODO: THIS BOTTOM COMMAND RUNS IN THE SAME TICK AS THE UPPER ONES !!!
# Delete helper armor_stand

#STOP CONDITION
execute if score AsTickLived as_helper matches 2.. run scoreboard players set AsTickLived as_helper 0
execute if score AsTickLived as_helper matches 0 run scoreboard players set AsIsAlive as_helper 0

execute if score AsIsAlive as_helper matches 0 run scoreboard players set AsTickLived as_helper 0
execute as @e[name="extra_live_craft_area"] at @s if score AsIsAlive as_helper matches 1 run kill @e[tag=extra_life_recipe_1,distance=..2]
execute as @e[name="extra_live_craft_area"] at @s if score AsIsAlive as_helper matches 1 run kill @e[tag=extra_life_recipe_2,distance=..2]
execute as @e[name="extra_live_craft_area"] at @s if score AsIsAlive as_helper matches 1 run execute as @s run tellraw @a {"text":"HP added 1","color":"yellow"}
execute as @e[name="extra_live_craft_area"] at @s if score AsIsAlive as_helper matches 1 run scoreboard players set RunTimer as_helper 1
execute as @e[name="extra_live_craft_area"] at @s if score AsIsAlive as_helper matches 1 run scoreboard players add AsIsAlive as_helper 0
execute as @e[name="extra_live_craft_area"] at @s if score AsIsAlive as_helper matches 1 run kill @e[name="extra_live_craft_area",distance=..2]

# Remove points if somebody died:
execute if entity @a[scores={xDeaths=1..}] if score count lifes matches 1.. run scoreboard players remove count lifes 1
execute if entity @a[scores={xDeaths=1..}] run scoreboard players set RunTimer as_helper 1
execute if entity @a[scores={xDeaths=1..}] run scoreboard players set TurnOffTimer as_helper 0
execute if entity @a[scores={xDeaths=1..}] run scoreboard players set @a[scores={xDeaths=1..}] hp 20
execute if entity @a[scores={xDeaths=1..}] run scoreboard players set @a[scores={xDeaths=1..}] xDeaths 0


# Make KeepInventory modification ONLY if TurnOffTimer = 1001
# TurnOffTimer will be reseted only when life count is modofied

# Ha lifes=0 akkor novelje 1001-ig a TurnOffTimer-t
execute if score TurnOffTimer as_helper matches ..1000 run scoreboard players add TurnOffTimer as_helper 1

# Show / Hide TurnOffTimer
execute if score TurnOffTimer as_helper matches 0 run scoreboard players add delay lifes 1000
execute if score TurnOffTimer as_helper matches ..1000 run scoreboard players operation TurnOffTimerInv as_helper = _100 as_helper
execute if score TurnOffTimer as_helper matches ..1000 run scoreboard players operation TurnOffTimerInv as_helper -= TurnOffTimer as_helper
execute if score TurnOffTimer as_helper matches ..1000 run scoreboard players operation delay lifes = TurnOffTimerInv as_helper
execute if score TurnOffTimer as_helper matches 1001 run scoreboard players reset delay lifes
execute if score TurnOffTimer as_helper matches 1001 if score RunTimer as_helper matches 1 if score count lifes matches 1.. run say KEEP INVENTORY : ON
execute if score TurnOffTimer as_helper matches 1001 if score RunTimer as_helper matches 1 if score count lifes matches 0 run say KEEP INVENTORY : OFF
execute if score TurnOffTimer as_helper matches 1001 run scoreboard players set RunTimer as_helper 0




# if lives >= 1 then make TurnOffTimer := 0
#execute if score count lifes matches 0 if score TurnOffTimer as_helper matches 1001 run scoreboard players set TurnOffTimer as_helper 0


#
# Change Gamerule: keepInventory 
#

# only after waiting 1000 ticks
execute if score count lifes matches 1.. if score TurnOffTimer as_helper matches 1001 run scoreboard players set KeepInventory as_helper 1
execute if score RunTimer as_helper matches 1 if score TurnOffTimer as_helper matches 1001 if score count lifes matches 1.. run scoreboard players set TurnOffTimer as_helper 0

# stop timer when limit is reached
execute if score TurnOffTimer as_helper matches 1001 run scoreboard players set RunTimer as_helper 0

# Ha a Timer ki van akadva 1001-nel akkor keepInventory := false
execute if score count lifes matches 0 if score TurnOffTimer as_helper matches 1001 run scoreboard players set KeepInventory as_helper 0

#
# Set Gamerule:
#

# keepInventory Controller:
execute if score KeepInventory as_helper matches 0 run gamerule keepInventory false
execute if score KeepInventory as_helper matches 1 run gamerule keepInventory true

# DEGUB:
#say Running
