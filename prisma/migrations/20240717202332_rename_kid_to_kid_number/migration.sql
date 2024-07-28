/*
  Warnings:

  - You are about to drop the column `kid` on the `invoice` table. All the data in the column will be lost.
  - Added the required column `kid_number` to the `Invoice` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `invoice` DROP COLUMN `kid`,
    ADD COLUMN `kid_number` VARCHAR(191) NOT NULL;
