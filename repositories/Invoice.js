import promiseAsyncWrapper from "../middlewares/promise_async_wrapper.js";
import PrismaClientService from "../utils/prisma_client.js";
import InvoiceHelperRepository from "./InvoiceHelper.js";
import TimeRepository from "./Time.js";

class InvoiceRepository {
    static prisma = PrismaClientService.instance

    static getInvoices = async () => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const invoices = await this.prisma.invoice.findMany({
                include: {
                    rules: true
                }
            })
            resolve(invoices)
        })
    )

    static getInvoiceById = async (id) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const invoice = await this.prisma.invoice.findUnique({
                where: {
                    id: +id
                }
            })
            resolve(invoice)
        })
    )

    static createInvoice = async ({ kid_number, control_number, total_charge, rules, sanction_id }) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const invoice_file = await InvoiceHelperRepository.generateInvoiceFile({})

            const invoice = await this.prisma.invoice.create({
                data: {
                    kid_number,
                    control_number,
                    sanction_id: +sanction_id,
                    total_charge: +total_charge,
                    invoice_file,
                    rules: {
                        create: rules
                    },
                    created_at: TimeRepository.getCurrentDateTime(),
                    status: 'pending'
                }
            })
            resolve(invoice)
        })
    )

    static changeInvoiceStatus = async ({ id, status }) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const invoice = await this.prisma.invoice.update({
                where: {
                    id: +id
                },
                data: {
                    status
                }
            })
            resolve(invoice)
        })
    )
}

export default InvoiceRepository