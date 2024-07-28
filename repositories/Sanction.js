import promiseAsyncWrapper from "../middlewares/promise_async_wrapper.js"
import PrismaClientService from "../utils/prisma_client.js"
import InvoiceRepository from "./Invoice.js"
import TimeRepository from "./Time.js"

class SanctionRepository {
    static prisma = PrismaClientService.instance

    static getSanctions = async () => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const sanctions = await this.prisma.sanction.findMany({
                where: {
                    deleted_at: null
                },
                include: {
                    invoice: {
                        include: {
                            rules: true
                        }
                    },
                    sanction_files: true,
                }
            })
            resolve(sanctions)
        })
    )

    static getDeletedSanctions = async () => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const sanctions = await this.prisma.sanction.findMany({
                where: {
                    deleted_at: {
                        not: null
                    }
                },
                include: {
                    invoice: {
                        include: {
                            rules: true
                        }
                    },
                    sanction_files: true
                }
            })
            resolve(sanctions)
        })
    )

    static getSanctionById = async (id) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const sanction = await this.prisma.sanction.findUnique({
                where: {
                    id: +id
                }
            })
            resolve(sanction)
        })
    )

    static createSanction = async ({ kid_number, control_number, total_charge, rules, employee_pnid, violated_at }) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            const sanction = await this.prisma.sanction.create({
                data: {
                    employee_pnid, 
                    created_at: TimeRepository.getCurrentDateTime(),
                    date: TimeRepository.getCurrentDate(),
                    due_date: TimeRepository.increaseTimeByWeeks({
                        current_time: violated_at,
                        weeks: 3
                    }),
                }
            })

            const invoice = await InvoiceRepository.createInvoice({
                kid_number,
                control_number,
                total_charge,
                rules,
                sanction_id: sanction.id
            })

            const new_sanction = await this.prisma.sanction.findFirst({
                where: {
                    id: sanction.id
                },
                include: {
                    invoice: {
                        include: {
                            rules: true
                        }
                    },

                    sanction_files: true
                }
            })

            resolve(new_sanction)
            
        })
    )

    static deleteSanction = async ({ id }) => new Promise(
        promiseAsyncWrapper(async (resolve, reject) => {
            await this.prisma.invoice.update({
                where: {
                    sanction_id: +id
                },
                data: {
                    deleted_at: TimeRepository.getCurrentDateTime()
                }
            })

            const deleted_sanction = await this.prisma.sanction.update({
                where: {
                    id: +id
                },
                data: {
                    deleted_at: TimeRepository.getCurrentDateTime()
                }
            })
            resolve(deleted_sanction)
        })
    )
}

export default SanctionRepository