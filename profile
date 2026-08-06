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
    Avatar,
    Divider,
    Chip,
    Card,
    CardContent,
} from "@mui/material";
import { useState, useEffect } from "react";
import axios from "axios";
import PersonIcon from '@mui/icons-material/Person';
import EmailIcon from '@mui/icons-material/Email';
import PhoneIcon from '@mui/icons-material/Phone';
import WorkIcon from '@mui/icons-material/Work';
import SchoolIcon from '@mui/icons-material/School';
import HomeIcon from '@mui/icons-material/Home';
import CakeIcon from '@mui/icons-material/Cake';

const API_URL = import.meta.env.VITE_API_URL;

export default function AccountView() {
    const [profile, setProfile] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        showProfile();
    }, []);

    const showProfile = async () => {
        try {
            setLoading(true);
            const res = await axios.get(`${API_URL}/profile/profile`);
            console.log("API Response:", res.data);
            setProfile(res.data);
        } catch (err) {
            console.log("Error details:", err.response?.data || err.message);
        } finally {
            setLoading(false);
        }
    };

    if (loading) {
        return (
            <Box display="flex" justifyContent="center" alignItems="center" minHeight="400px">
                <Typography variant="h6">Loading...</Typography>
            </Box>
        );
    }

    return (
        <Box sx={{ p: 3 }}>
            <Typography
                variant="h4"
                align="center"
                fontWeight="bold"
                gutterBottom
                sx={{ mb: 4, color: '#1a237e' }}
            >
                Account Overview
            </Typography>

            <Grid container spacing={3}>
                {profile.map((user) => (
                    <Grid item xs={12} sm={6} md={4} key={user.id || user.Email}>
                        <Card 
                            elevation={3}
                            sx={{
                                height: '100%',
                                transition: 'transform 0.2s, box-shadow 0.2s',
                                '&:hover': {
                                    transform: 'translateY(-4px)',
                                    boxShadow: 6,
                                }
                            }}
                        >
                            <CardContent>
                                {/* Profile Header */}
                                <Box 
                                    display="flex" 
                                    flexDirection="column" 
                                    alignItems="center"
                                    sx={{ mb: 2 }}
                                >
                                    <Avatar
                                        src={user.Image}
                                        alt={user.Name}
                                        sx={{ 
                                            width: 100, 
                                            height: 100, 
                                            mb: 2,
                                            border: '3px solid #1976d2'
                                        }}
                                    >
                                        {!user.Image && <PersonIcon sx={{ fontSize: 60 }} />}
                                    </Avatar>
                                    
                                    <Typography variant="h6" fontWeight="bold">
                                        {user.Name}
                                    </Typography>
                                    
                                    <Chip
                                        label={user.Status || "Active"}
                                        size="small"
                                        color={user.Status === "Active" ? "success" : "default"}
                                        sx={{ mt: 1 }}
                                    />
                                </Box>

                                <Divider sx={{ my: 2 }} />

                                {/* Basic Information */}
                                <Box sx={{ mb: 1 }}>
                                    <Box display="flex" alignItems="center" sx={{ mb: 1 }}>
                                        <CakeIcon sx={{ mr: 1, color: '#1976d2', fontSize: 20 }} />
                                        <Typography variant="body2">
                                            <b>Age/Gender:</b> {user.Age} yrs, {user.Gender}
                                        </Typography>
                                    </Box>
                                    
                                    <Box display="flex" alignItems="center" sx={{ mb: 1 }}>
                                        <EmailIcon sx={{ mr: 1, color: '#1976d2', fontSize: 20 }} />
                                        <Typography variant="body2" noWrap>
                                            <b>Email:</b> {user.Email}
                                        </Typography>
                                    </Box>
                                    
                                    <Box display="flex" alignItems="center" sx={{ mb: 1 }}>
                                        <PhoneIcon sx={{ mr: 1, color: '#1976d2', fontSize: 20 }} />
                                        <Typography variant="body2">
                                            <b>Contact:</b> {user.Contact}
                                        </Typography>
                                    </Box>
                                    
                                    <Box display="flex" alignItems="center" sx={{ mb: 1 }}>
                                        <WorkIcon sx={{ mr: 1, color: '#1976d2', fontSize: 20 }} />
                                        <Typography variant="body2">
                                            <b>Occupation:</b> {user.Occupation}
                                        </Typography>
                                    </Box>
                                    
                                    <Box display="flex" alignItems="center" sx={{ mb: 1 }}>
                                        <SchoolIcon sx={{ mr: 1, color: '#1976d2', fontSize: 20 }} />
                                        <Typography variant="body2">
                                            <b>Education:</b> {user.Education}
                                        </Typography>
                                    </Box>
                                    
                                    <Box display="flex" alignItems="flex-start" sx={{ mb: 1 }}>
                                        <HomeIcon sx={{ mr: 1, color: '#1976d2', fontSize: 20, mt: 0.3 }} />
                                        <Typography variant="body2">
                                            <b>Location:</b> {user.Address}
                                        </Typography>
                                    </Box>
                                </Box>

                                <Divider sx={{ my: 2 }} />

                                {/* Additional Info */}
                                <Box>
                                    <Typography variant="body2" color="textSecondary">
                                        <b>Religion:</b> {user.Religion}
                                    </Typography>
                                    <Typography variant="body2" color="textSecondary">
                                        <b>Language:</b> {user.Language}
                                    </Typography>
                                    <Typography variant="body2" color="textSecondary">
                                        <b>Height:</b> {user.Height} ft
                                    </Typography>
                                    {user.Detail && (
                                        <Typography 
                                            variant="body2" 
                                            color="textSecondary"
                                            sx={{ 
                                                mt: 1,
                                                fontStyle: 'italic',
                                                bgcolor: '#f5f5f5',
                                                p: 1,
                                                borderRadius: 1
                                            }}
                                        >
                                            "{user.Detail}"
                                        </Typography>
                                    )}
                                </Box>
                            </CardContent>
                        </Card>
                    </Grid>
                ))}
            </Grid>
        </Box>
    );
}
