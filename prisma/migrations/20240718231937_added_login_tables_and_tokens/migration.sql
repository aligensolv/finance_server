/*
  Warnings:

  - You are about to drop the column `host` on the `login` table. All the data in the column will be lost.
  - Added the required column `hostname` to the `Login` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `login` DROP COLUMN `host`,
    ADD COLUMN `hostname` VARCHAR(191) NOT NULL;
