/*
  Warnings:

  - Added the required column `created_at` to the `Sanction` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `sanction` ADD COLUMN `created_at` VARCHAR(191) NOT NULL;
