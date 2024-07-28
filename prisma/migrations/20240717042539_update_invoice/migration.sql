/*
  Warnings:

  - Added the required column `rule` to the `InvoiceRule` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `invoicerule` ADD COLUMN `rule` VARCHAR(191) NOT NULL;
