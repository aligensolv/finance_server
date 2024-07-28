/*
  Warnings:

  - You are about to drop the column `charge` on the `sanctions` table. All the data in the column will be lost.
  - You are about to drop the column `control_number` on the `sanctions` table. All the data in the column will be lost.
  - You are about to drop the column `kid_number` on the `sanctions` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `sanctions` DROP COLUMN `charge`,
    DROP COLUMN `control_number`,
    DROP COLUMN `kid_number`;
