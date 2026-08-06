import Paper from '@mui/material/Paper';
import {
    Box,
    Typography,
    Table,
    TableBody,
    TableCell,
    TableContainer,
    TableHead,
    TableRow,
    Grid,
} from "@mui/material";
import { useState, useEffect } from "react";
import axios from "axios";
const API_URL = import.meta.env.VITE_API_URL;
import Card from '@mui/material/Card';
import Chip from '@mui/material/Chip';
import CardMedia from '@mui/material/CardMedia';
//import Button from '@mui/material/Button';
import CardActionArea from '@mui/material/CardActionArea';
import CardActions from '@mui/material/CardActions';

export default function ProfileTable() {

    const [profile, setProfile] = useState([])

    useEffect(() => {
        showProfile();
    }, []);

    const showProfile = async () => {
        try {
            const res = await axios.get(`${API_URL}/profile/profile`);
            console.log("API Response:", res.data);
            setProfile(res.data);
        } catch (err) {
            console.log("Error details:", err.response?.data || err.message);
        }
    };

    return (
        <Box >
            <Typography
                variant="h4"
                align="center"
                fontWeight="bold"
                gutterBottom
                className="mb-6 text-gray-800"
            >
                Profile Table
            </Typography>

            <Paper
                sx={{ width: '100%' }}
                elevation={2}
                className="overflow-hidden rounded-lg "
            >
                <TableContainer className="max-h-[600px] w-[100%]">
                    <Table stickyHeader>
                        <TableHead>
                            <TableRow>
                                <TableCell
                                    className="font-bold text-lg bg-gray-100 w-[15%]"
                                    align="center"
                                >
                                    Status
                                </TableCell>

                                <TableCell
                                    className="font-bold text-lg bg-gray-100 w-[15%]"
                                    align="center"
                                >
                                    User Information
                                </TableCell>
                                <TableCell
                                    className="font-bold text-lg bg-gray-100 w-[20%]"
                                    align="center"
                                >
                                    Education / Employment
                                </TableCell>
                                <TableCell
                                    className="font-bold text-lg bg-gray-100 w-[15%]"
                                    align="center"
                                >
                                    Hobbies / Details
                                </TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {profile.map((cell) => (
                                <TableRow

                                    className="hover:bg-gray-50 transition-colors"
                                >

                                    <TableCell align="center" className="py-4 font-medium">
                                        <Card
                                            sx={{
                                                width: "100%",
                                                maxWidth: 220,
                                                height: 300,
                                                mx: "auto",
                                            }}
                                        >
                                            <CardActionArea>
                                                <CardMedia
                                                    component="img"
                                                    sx={{
                                                        height: 250,
                                                        objectFit: "cover",
                                                    }}
                                                    image={cell.Image}
                                                    alt={cell.Name}
                                                />
                                            </CardActionArea>

                                            <CardActions
                                                sx={{
                                                    justifyContent: "center",
                                                    padding: 1,
                                                }}
                                            >
                                                <Chip
                                                    label={cell.Status}
                                                    variant="outlined"
                                                />
                                            </CardActions>
                                        </Card>
                                    </TableCell>

                                    <TableCell
                                        align="left"
                                        className="py-4 text-gray-600"
                                    >
                                        <Grid container rowSpacing={1} columnSpacing={{ xs: 1, sm: 2, md: 3 }}>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Name : </b>{cell.Name}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Gender : </b>{cell.Gender}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Age : </b>{cell.Age}
                                                </Typography>
                                            </Grid>
                                           
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Date : </b>{cell.DOB}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Religion : </b>{cell.Religion}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Mother Tongue : </b>{cell.Language}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Physically Challanged : </b>{cell.Physically}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Height : </b>{cell.Height} ft
                                                </Typography>
                                            </Grid>
                                            
                                        </Grid>
                                    </TableCell>
                                    <TableCell
                                        align="left"
                                        className="py-4 font-medium"
                                    >
                                        <Grid container rowSpacing={1} columnSpacing={{ xs: 1, sm: 2, md: 3 }}>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Education : </b>{cell.Education}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Occupation : </b>{cell.Occupation}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Company Name : </b>{cell.CompanyName}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Monthly Income : </b>{cell.MonthlyIncome}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Email : </b>{cell.Email}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Contact : </b>{cell.Contact}
                                                </Typography>
                                            </Grid>
                                            <Grid size={12}>
                                                <Typography variant="body1">
                                                    <b>Address : </b>{cell.Address}
                                                </Typography>
                                            </Grid>
                                        </Grid>
                                    </TableCell>

                                    <TableCell
                                        align="left"
                                        className=" font-medium"
                                    >
                                        <Typography variant="body1">
                                            <b>{cell.Detail}</b>
                                        </Typography>
                                    </TableCell>
                                </TableRow>
                            ))}
                        </TableBody>
                    </Table>
                </TableContainer>
            </Paper>
        </Box>
    );
}
