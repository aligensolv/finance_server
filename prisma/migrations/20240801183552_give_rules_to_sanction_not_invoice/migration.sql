/*
  Warnings:

  - You are about to drop the `invoicerule` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `invoicerule` DROP FOREIGN KEY `InvoiceRule_invoice_id_fkey`;

-- DropTable
DROP TABLE `invoicerule`;

-- CreateTable
CREATE TABLE `SanctionRule` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sanction_id` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `charge` DOUBLE NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `SanctionRule` ADD CONSTRAINT `SanctionRule_sanction_id_fkey` FOREIGN KEY (`sanction_id`) REFERENCES `Sanction`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
