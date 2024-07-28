-- CreateTable
CREATE TABLE `Payment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `client_name` VARCHAR(191) NOT NULL,
    `plate_number` VARCHAR(191) NOT NULL,
    `charged_at` VARCHAR(191) NOT NULL,
    `paid_at` VARCHAR(191) NOT NULL,
    `paid_amount` DOUBLE NOT NULL,
    `control_number` VARCHAR(191) NOT NULL,
    `debt_collect_id` INTEGER NULL,

    UNIQUE INDEX `Payment_debt_collect_id_key`(`debt_collect_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_debt_collect_id_fkey` FOREIGN KEY (`debt_collect_id`) REFERENCES `DebtCollect`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
