-- AlterTable
ALTER TABLE `manager` ADD COLUMN `last_login_time` VARCHAR(191) NULL;

-- CreateTable
CREATE TABLE `Login` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `manager_id` INTEGER NOT NULL,
    `login_time` VARCHAR(191) NOT NULL,
    `ip_address` VARCHAR(191) NOT NULL,
    `host` VARCHAR(191) NOT NULL,
    `token` VARCHAR(191) NOT NULL,
    `created_at` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Login` ADD CONSTRAINT `Login_manager_id_fkey` FOREIGN KEY (`manager_id`) REFERENCES `Manager`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
