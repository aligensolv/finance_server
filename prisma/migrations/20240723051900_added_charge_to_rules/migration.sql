/*
  Warnings:

  - You are about to drop the column `rule` on the `invoicerule` table. All the data in the column will be lost.
  - You are about to drop the `extraaddedfiles` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `charge` to the `InvoiceRule` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `InvoiceRule` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `invoicerule` DROP COLUMN `rule`,
    ADD COLUMN `charge` DOUBLE NOT NULL,
    ADD COLUMN `name` VARCHAR(191) NOT NULL;

-- DropTable
DROP TABLE `extraaddedfiles`;
