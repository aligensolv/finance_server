/*
  Warnings:

  - Added the required column `file_path` to the `SanctionFile` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `sanctionfile` ADD COLUMN `file_path` VARCHAR(191) NOT NULL;
