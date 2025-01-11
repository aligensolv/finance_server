import Stripe from "stripe"
import promiseAsyncWrapper from "../middlewares/promise_async_wrapper.js"

const stripe = new Stripe('sk_test_51N3EcJHHXVdH5ff2lychuFFYXORs7jbQCqiVjqL3hZgvgb6jlxdyeZQbq6Vc91ByhLB8PGa5Fqc2k20WlUuiu8ju00eMfbtq1V')

class PaymentRepository {
    static async createPaymentIntent() {
        return new Promise(promiseAsyncWrapper(async (resolve, reject) => {
            const paymentIntent = await stripe.paymentIntents.create({
                amount: 10 * 100,
                currency: "nok",
                automatic_payment_methods: { enabled: true },
            });
            return resolve(paymentIntent)
        }))
    }

    static async createCardHolderDetails({ full_name, card_number, payment_id }) {
        return new Promise(promiseAsyncWrapper(async (resolve, reject) => {
            const cardHolderDetails = await this.prisma.cardHolderDetails.create({
                data: {
                    full_name,
                    card_number,
                    payment_id
                }
            });
            return resolve(cardHolderDetails)
        }))
    }

    static async createPayment({ violation_id, transaction_id, kid_number, card_holder_details, required_amount, payment_method, status, init_date, paid_at, refund, plate_number, control_number, sanction_id }) {
        return new Promise(promiseAsyncWrapper(async (resolve, reject) => {
            const payment = await this.prisma.payment.create({
                data: {
                    violation_id,
                    transaction_id,
                    kid_number,
                    card_holder_details: {
                        connect: { id: card_holder_details.id }
                    },
                    required_amount,
                    payment_method,
                    status,
                    init_date,
                    paid_at,
                    refund: refund ? {
                        create: {
                            id: refund.id
                        }
                    } : null,
                    plate_number,
                    control_number,
                    sanction_id
                }
            });
            return resolve(payment)
        }))
    }

    static async getPaymentById(id) {
        return new Promise(promiseAsyncWrapper(async (resolve, reject) => {
            const payment = await this.prisma.payment.findUnique({
                where: { id: +id },
                include: {
                    card_holder_details: true,
                    refund: true,
                    sanction: true
                }
            });
            return resolve(payment)
        }))
    }

    static async updatePaymentStatus(id, status) {
        return new Promise(promiseAsyncWrapper(async (resolve, reject) => {
            const payment = await this.prisma.payment.update({
                where: { id: +id },
                data: {
                    status
                }
            });
            return resolve(payment)
        }))
    }
}

export default PaymentRepository
