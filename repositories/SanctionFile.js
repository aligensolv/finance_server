import { NOT_FOUND } from "../constants/status_codes.js"
import CustomError from "../interfaces/custom_error_class.js"
import promiseAsyncWrapper from "../middlewares/promise_async_wrapper.js"
import PrismaClientService from "../utils/prisma_client.js"
import TimeRepository from "./Time.js"

class SanctionFileRepository {
    static prisma = PrismaClientService.instance

    static getSanctionFiles = async ({ sanction_id }) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const files = await this.prisma.sanctionFile.findMany({
                where: {
                    sanction_id: +sanction_id
                }
            })
            resolve(files)
        })
    )

    static addSanctionFiles = async ({ files, sanction_id }) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const newFiles = await this.prisma.sanctionFile.createMany({
                data: files.map((file) => {
                    return {
                        ...file,
                        sanction_id: +sanction_id,
                        uploaded_at: TimeRepository.getCurrentDateTime(),
                        uploaded_by_id: 1
                    }
                })
            })
            resolve(newFiles)
        })
    )

    static addSanctionFilesUsingControlNumber = async ({ files, control_number }) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const invoice = await this.prisma.invoice.findFirst({
                where: {
                    control_number
                }
            })
            
            if (!invoice) {
                const no_invoice_found  = new CustomError(
                    "Invoice not found",
                    NOT_FOUND
                )

                return reject(no_invoice_found)
            }
            console.log(invoice);

            const newFiles = await this.prisma.sanctionFile.createMany({
                data: files.map((file) => {
                    return {
                        ...file,
                        sanction_id: +invoice.sanction_id,
                        uploaded_at: TimeRepository.getCurrentDateTime(),
                        uploaded_by_id: 1
                    }
                })
            })
            resolve(newFiles)
        })
    )

    static deleteSanctionFile = async ({ id }) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const file = await this.prisma.sanctionFile.delete({
                where: {
                    id: +id
                }
            })
            resolve(file)
        })
    )

    static deleteAllSanctionFiles = async ({ sanction_id }) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const files = await this.prisma.sanctionFile.deleteMany({
                where: {
                    sanction_id: +sanction_id
                }
            })
            resolve(files)
        })
    )
}

export default SanctionFileRepository