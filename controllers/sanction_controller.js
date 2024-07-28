import SocketEvents from "../configs/socket_events.js"
import { OK } from "../constants/status_codes.js"
import asyncWrapper from "../middlewares/async_wrapper.js"
import SanctionRepository from "../repositories/Sanction.js"
import SanctionFileRepository from "../repositories/SanctionFile.js"
import ValidatorRepository from "../repositories/Validator.js"
import { io } from "../server.js"

export const getSanctions = asyncWrapper(
    async (req,res) => {
        const sanctions = await SanctionRepository.getSanctions()
        res.status(OK).json(sanctions)
    }
)


export const createSanction = asyncWrapper(
    async (req,res) => {
        const {
            kid_number,
            control_number,
            total_charge,
            employee_pnid,
            violated_at,
            rules
        } = req.body

        await ValidatorRepository.validateNotNull({
            kid_number,
            control_number,
            total_charge,
            violated_at,
            employee_pnid
        })

        const new_sanction = await SanctionRepository.createSanction({
            kid_number,
            control_number,
            total_charge,
            employee_pnid,
            violated_at,
            rules: [
                {
                    name: '1 - Avgiftsparkering - Billett / elektronisk registrering utløpt - pforskr.§31(2)',
                    charge: 660
                },
                {
                    name: '2 - Avgiftsparkering - Gyldig billett ikke synlig i frontruten / ingen gyldig elektronisk registrering funnet - pforskr.§31(2)',
                    charge: 660
                }
            ]
        })

        io.emit(
            SocketEvents.sanction_added,
            new_sanction
        )

        res.status(OK).json(new_sanction)
    }
)

export const addSanctionFiles = asyncWrapper(
    async (req,res) => {
        const { id: sanction_id } = req.params

        const files = req.files.map((file) => {
            return {
                file_name: file.filename,
                file_path: `storage/files/attachments/${file.filename}`,
                file_size: Number((file.size / 1024).toFixed(2)),
                file_extension: file.originalname.split('.').pop(),
                file_type: 'image',
            }
        })

        console.log(files);

        const new_files = await SanctionFileRepository.addSanctionFiles({
            sanction_id: sanction_id,
            files
        })
        res.status(OK).json(new_files)
    }
)

export const addSanctionFilesUsingControlNumber = asyncWrapper(
    async (req,res) => {
        const { control_number } = req.body

        const files = req.files.map((file) => {
            return {
                file_name: file.filename,
                file_path: `storage/files/attachments/${file.filename}`,
                file_size: Number((file.size / 1024).toFixed(2)),
                file_extension: file.originalname.split('.').pop(),
                file_type: 'image',
            }
        })

        console.log(files);

        const new_files = await SanctionFileRepository.addSanctionFilesUsingControlNumber({
            control_number: control_number,
            files
        })
        res.status(OK).json(new_files)
    }
)


export const deleteSanctionFile = asyncWrapper(
    async (req,res) => {
        const { id } = req.params
        const deleted_file = await SanctionFileRepository.deleteSanctionFile({
            id
        })
        res.status(OK).json(deleted_file)
    }
)

export const getSanctionFiles = asyncWrapper(
    async (req,res) => {
        const { id } = req.params
        const files = await SanctionFileRepository.getSanctionFiles({
            id
        })
        res.status(OK).json(files)
    }
)

export const deleteAllSanctionFiles = asyncWrapper(
    async (req,res) => {
        const { id } = req.params
        const deleted_files = await SanctionFileRepository.deleteAllSanctionFiles({
            id
        })
        res.status(OK).json(deleted_files)
    }
)

export const deleteSanction = asyncWrapper(
    async (req,res) => {
        const { id } = req.params
        const deleted_sanction = await SanctionRepository.deleteSanction({
            id
        })

        res.status(OK).json(deleted_sanction)
    }
)

export const getDeletedSanctions = asyncWrapper(
    async (req,res) => {
        const sanctions = await SanctionRepository.getDeletedSanctions()
        res.status(OK).json(sanctions)
    }
)