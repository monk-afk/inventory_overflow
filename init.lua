--==[[ Inventory Overflow - 0.0.1 ]]==--
    --==[[  MIT © 2024  monk  ]]==--

local bags_enabled = minetest.get_modpath("unified_inventory")
    and minetest.settings:get_bool("unified_inventory_bags") ~= false
    or minetest.get_modpath("sfinv_bags") and true

local void_chest_item = minetest.get_modpath("void_chest") and "void_chest:void_chest"
local void_chest_inv  = void_chest_item and "void_chest:void_chest"

local enderchest_item = minetest.get_modpath("xdecor") and "xdecor:enderchest"
local enderchest_inv  = enderchest_item and "enderchest"

local function get_bags(player)
  return minetest.get_inventory({
    type = "detached",
    name = player:get_player_name().."_bags"
  })
end

local old_handle_node_drops = minetest.handle_node_drops
function minetest.handle_node_drops(pos, drops, digger)

  if not digger or not digger:is_player() then
    return old_handle_node_drops(pos, drops, digger)
  end

  local inv = digger:get_inventory()

  if inv then
    for _, item in ipairs(drops) do

      if inv:room_for_item("main", item) then
        inv:add_item("main", item)

      elseif enderchest_item
          and inv:contains_item("main", enderchest_item)
          and inv:room_for_item(enderchest_inv, item) then
        inv:add_item(enderchest_inv, item)

      elseif void_chest_item
          and inv:contains_item("main", void_chest_item)
          and inv:room_for_item(void_chest_inv, item) then
        inv:add_item(void_chest_inv, item)

      elseif bags_enabled and (function()
          local bag_inv = get_bags(digger)
          for i = 1, 4 do
            if bag_inv:get_stack("bag" .. i, 1):get_definition().groups.bagslots then
              local bagcontents = "bag"..i.."contents"

              if inv:room_for_item(bagcontents, item) then
                inv:add_item(bagcontents, item)
                return true

              elseif enderchest_item
                  and inv:contains_item(bagcontents, enderchest_item)
                  and inv:room_for_item(enderchest_inv, item) then
                inv:add_item(enderchest_inv, item)
                return true

              elseif void_chest_item
                  and inv:contains_item(bagcontents, void_chest_item)
                  and inv:room_for_item(void_chest_inv, item) then
                inv:add_item(void_chest_inv, item)
                return true
              end
            end
          end
        end)() then

      else
        minetest.add_item(pos, item)
      end
    end
  end
end




------------------------------------------------------------------------------------
-- MIT License                                                                    --
--                                                                                --
-- Copyright © 2024 monk                                                          --
--                                                                                --
-- Permission is hereby granted, free of charge, to any person obtaining a copy   --
-- of this software and associated documentation files (the "Software"), to deal  --
-- in the Software without restriction, including without limitation the rights   --
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      --
-- copies of the Software, and to permit persons to whom the Software is          --
-- furnished to do so, subject to the following conditions:                       --
--                                                                                --
-- The above copyright notice and this permission notice shall be included in all --
-- copies or substantial portions of the Software.                                --
--                                                                                --
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     --
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       --
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    --
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         --
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  --
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  --
-- SOFTWARE.                                                                      --
------------------------------------------------------------------------------------