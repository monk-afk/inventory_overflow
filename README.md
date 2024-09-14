Inventory Overflow
==================

Places digged items into the next available inventory

MIT © 2024 monk

___

## Summary

When you dig a node, and your main inventory is full, this mod will attempt to put that node into the next available inventory provided by:

- [sfinv_bags](https://codeberg.org/tenplus1/sfinv_bags) or [unified_inventory bags](https://github.com/minetest-mods/unified_inventory)
  - Support for up to all four bag inventories!
  - Only works if a bag is equipped!

- [Enderchest](https://codeberg.org/Wuzzy/xdecor-libre)
- [Void Chest](https://github.com/MeseCraft/void_chest)
  - Both chests can be used simultaneously!
  - Only works if a chest is in the main inventory, or a bag inventory!


Dig a node, try to put it in:
 - Main inventory
 - Enderchest if carried in main inventory
 - Void Chest if carried in main inventory
 - Equipped bags 1 through 4
 - Enderchest if carried in the equipped bag
 - Void Chest if carried in the equipped bag
 - The ground if everything is full


This mod should work as-is without configuration, provided there is at least one of the above mentionned mods already installed.

I guess that's it