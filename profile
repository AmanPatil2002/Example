import {
    Box,
    Button,
    Container,
    CssBaseline,
    Grid,
    MenuItem,
    Paper,
    TextField,
    Typography,
    Card,
    CardContent,
    CardMedia,
    Chip,
    Divider,
    Alert,
    Snackbar,
    CircularProgress,
} from "@mui/material";
import { styled } from "@mui/material/styles";
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import PersonIcon from '@mui/icons-material/Person';
import EmailIcon from '@mui/icons-material/Email';
import PhoneIcon from '@mui/icons-material/Phone';
import LocationOnIcon from '@mui/icons-material/LocationOn';
import SchoolIcon from '@mui/icons-material/School';
import WorkIcon from '@mui/icons-material/Work';
import { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import InputAdornment from '@mui/material/InputAdornment';

const API_URL = import.meta.env.VITE_API_URL;

const VisuallyHiddenInput = styled('input')({
    clip: 'rect(0 0 0 0)',
    clipPath: 'inset(50%)',
    height: 1,
    overflow: 'hidden',
    position: 'absolute',
    bottom: 0,
    left: 0,
    whiteSpace: 'nowrap',
    width: 1,
});

const DisplayCard = styled(Card)(({ theme }) => ({
    height: '100%',
    display: 'flex',
    flexDirection: 'column',
    position: 'sticky',
    top: 20,
}));

const SectionTitle = ({ title }) => (
    <Typography
        variant="h5"
        sx={{
            mt: 4,
            mb: 2,
            color: "#c2185b",
            fontWeight: "bold",
        }}
    >
        {title}
    </Typography>
);

const InfoRow = ({ icon, label, value }) => (
    <Box sx={{ display: 'flex', alignItems: 'center', mb: 1.5 }}>
        <Box sx={{ mr: 2, color: '#c2185b' }}>{icon}</Box>
        <Box>
            <Typography variant="caption" color="text.secondary">
                {label}
            </Typography>
            <Typography variant="body1" fontWeight="medium">
                {value || 'Not provided'}
            </Typography>
        </Box>
    </Box>
);

export default function Profile() {
    const navigate = useNavigate();
    const token = localStorage.getItem('token'); // Get token from localStorage

    const [gender, setGender] = useState("");
    const [username, setUsername] = useState("");
    const [email, setEmail] = useState("");
    const [age, setAge] = useState("");
    const [date, setDate] = useState("");
    const [contact, setContact] = useState("");
    const [address, setAddress] = useState("");
    const [language, setLanguage] = useState("");
    const [religion, setReligion] = useState("");
    const [education, setEducation] = useState("");
    const [occupation, setOccupation] = useState("");
    const [company, setCompany] = useState("");
    const [income, setIncome] = useState("");
    const [image, setImage] = useState(null); // Store File object, not URL
    const [imagePreview, setImagePreview] = useState(""); // For preview only
    const [status, setStatus] = useState("");
    const [detail, setDetail] = useState("");
    const [physical, setPhysical] = useState("");
    const [height, setHeight] = useState("");
    const [profiles, setProfiles] = useState([]);
    const [loading, setLoading] = useState(false);
    const [snackbar, setSnackbar] = useState({
        open: false,
        message: '',
        severity: 'success'
    });

    useEffect(() => {
        // Check if user is authenticated
        if (!token) {
            navigate('/login');
            return;
        }
        fetchProfiles();
    }, []);

    const fetchProfiles = async () => {
        try {
            setLoading(true);
            const res = await axios.get(`${API_URL}/api/profiles`, {
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            });
            console.log("API Response:", res.data);
            setProfiles(res.data);
        } catch (error) {
            console.error("Error fetching profiles:", error);
            if (error.response?.status === 401) {
                // Token expired or invalid
                localStorage.removeItem('token');
                navigate('/login');
            }
            showSnackbar('Failed to fetch profiles', 'error');
        } finally {
            setLoading(false);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        
        // Validate required fields
        if (!gender || !username || !email || !date) {
            showSnackbar('Please fill in all required fields', 'warning');
            return;
        }

        try {
            setLoading(true);
            
            const formData = new FormData();
            formData.append('gender', gender);
            formData.append('name', username);
            formData.append('email', email);
            formData.append('age', age);
            formData.append('dob', date);
            formData.append('contact', contact);
            formData.append('address', address);
            formData.append('language', language);
            formData.append('religion', religion);
            formData.append('education', education);
            formData.append('occupation', occupation);
            formData.append('company', company);
            formData.append('income', income);
            formData.append('status', status);
            formData.append('detail', detail);
            formData.append('physical', physical);
            formData.append('height', height);
            
            // Append image file if selected
            if (image) {
                formData.append('image', image);
            }

            const res = await axios.post(`${API_URL}/api/profiles`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                    'Authorization': `Bearer ${token}`
                },
            });

            // Add new profile to list
            setProfiles(prev => [...prev, res.data.profile || res.data]);
            
            // Reset form
            handleReset();
            
            showSnackbar('Profile created successfully!', 'success');
            
            // Refresh profiles list
            fetchProfiles();
            
        } catch (error) {
            console.error("Error creating profile:", error);
            const errorMessage = error.response?.data?.message || error.response?.data?.error || 'Failed to create profile';
            showSnackbar(errorMessage, 'error');
            
            if (error.response?.status === 401) {
                localStorage.removeItem('token');
                navigate('/login');
            }
        } finally {
            setLoading(false);
        }
    };

    const handleImageChange = (event) => {
        const file = event.target.files[0];
        if (file) {
            // Validate file type
            const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
            if (!allowedTypes.includes(file.type)) {
                showSnackbar('Please upload a valid image file (JPEG, PNG, GIF, WEBP)', 'error');
                return;
            }
            
            // Validate file size (5MB)
            if (file.size > 5 * 1024 * 1024) {
                showSnackbar('Image size should be less than 5MB', 'error');
                return;
            }
            
            setImage(file); // Store the actual file for upload
            setImagePreview(URL.createObjectURL(file)); // Create preview URL
        }
    };

    const handleReset = () => {
        setGender("");
        setUsername("");
        setEmail("");
        setAge("");
        setDate("");
        setContact("");
        setAddress("");
        setLanguage("");
        setReligion("");
        setEducation("");
        setOccupation("");
        setCompany("");
        setIncome("");
        setImage(null);
        setImagePreview("");
        setStatus("");
        setDetail("");
        setPhysical("");
        setHeight("");
    };

    const showSnackbar = (message, severity = 'success') => {
        setSnackbar({
            open: true,
            message,
            severity
        });
    };

    const handleCloseSnackbar = () => {
        setSnackbar(prev => ({ ...prev, open: false }));
    };

    return (
        <>
            <CssBaseline />
            <Container maxWidth="xl" sx={{ py: 4 }}>
                <Typography
                    variant="h3"
                    align="center"
                    fontWeight="bold"
                    color="error"
                    gutterBottom
                >
                    Create Profile
                </Typography>

                <Grid container spacing={3}>
                    <Grid size={{ xs: 12, md: 7 }}>
                        <Paper elevation={3} sx={{ p: 3 }}>
                            <form onSubmit={handleSubmit}>
                                <SectionTitle title="Personal Information" />
                                <Grid container spacing={2}>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            select
                                            fullWidth
                                            label="Gender"
                                            value={gender}
                                            onChange={(e) => setGender(e.target.value)}
                                            required
                                        >
                                            <MenuItem value="Male">Male</MenuItem>
                                            <MenuItem value="Female">Female</MenuItem>
                                            <MenuItem value="Other">Other</MenuItem>
                                        </TextField>
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            label="Full Name"
                                            value={username}
                                            onChange={(e) => setUsername(e.target.value)}
                                            required
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            label="Email"
                                            type="email"
                                            value={email}
                                            onChange={(e) => setEmail(e.target.value)}
                                            required
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            type="date"
                                            name="birthDate"
                                            value={date}
                                            onChange={(e) => setDate(e.target.value)}
                                            InputLabelProps={{
                                                shrink: true,
                                            }}
                                            helperText="Enter Date of Birth"
                                            variant="outlined"
                                            required
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 3 }}>
                                        <TextField
                                            fullWidth
                                            label="Age"
                                            type="number"
                                            value={age}
                                            onChange={(e) => setAge(e.target.value)}
                                            InputProps={{
                                                inputProps: { min: 18, max: 80 }
                                            }}
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 3 }}>
                                        <TextField
                                            fullWidth
                                            label="Height (ft)"
                                            value={height}
                                            onChange={(e) => setHeight(e.target.value)}
                                            type="number"
                                            InputProps={{
                                                startAdornment: <InputAdornment position="start">Ft</InputAdornment>,
                                            }}
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            select
                                            fullWidth
                                            label="Marital Status"
                                            value={status}
                                            onChange={(e) => setStatus(e.target.value)}
                                        >
                                            <MenuItem value="Single">Single</MenuItem>
                                            <MenuItem value="Married">Married</MenuItem>
                                            <MenuItem value="Divorced">Divorced</MenuItem>
                                            <MenuItem value="Widowed">Widowed</MenuItem>
                                        </TextField>
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            select
                                            fullWidth
                                            label="Religion"
                                            value={religion}
                                            onChange={(e) => setReligion(e.target.value)}
                                        >
                                            <MenuItem value="Hindu">Hindu</MenuItem>
                                            <MenuItem value="Muslim">Muslim</MenuItem>
                                            <MenuItem value="Christian">Christian</MenuItem>
                                            <MenuItem value="Sikh">Sikh</MenuItem>
                                            <MenuItem value="Jain">Jain</MenuItem>
                                            <MenuItem value="Buddhist">Buddhist</MenuItem>
                                            <MenuItem value="Other">Other</MenuItem>
                                        </TextField>
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            select
                                            fullWidth
                                            label="Mother Tongue"
                                            value={language}
                                            onChange={(e) => setLanguage(e.target.value)}
                                        >
                                            <MenuItem value="Hindi">Hindi</MenuItem>
                                            <MenuItem value="Marathi">Marathi</MenuItem>
                                            <MenuItem value="Gujarati">Gujarati</MenuItem>
                                            <MenuItem value="Tamil">Tamil</MenuItem>
                                            <MenuItem value="Telugu">Telugu</MenuItem>
                                            <MenuItem value="Bengali">Bengali</MenuItem>
                                            <MenuItem value="Kannada">Kannada</MenuItem>
                                            <MenuItem value="Malayalam">Malayalam</MenuItem>
                                            <MenuItem value="Other">Other</MenuItem>
                                        </TextField>
                                    </Grid>
                                </Grid>

                                <SectionTitle title="Contact Information" />
                                <Grid container spacing={2}>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            label="Mobile Number"
                                            value={contact}
                                            onChange={(e) => setContact(e.target.value)}
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12 }}>
                                        <TextField
                                            fullWidth
                                            multiline
                                            rows={2}
                                            label="Address"
                                            value={address}
                                            onChange={(e) => setAddress(e.target.value)}
                                        />
                                    </Grid>
                                </Grid>

                                <SectionTitle title="Education & Career" />
                                <Grid container spacing={2}>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            label="Highest Education"
                                            value={education}
                                            onChange={(e) => setEducation(e.target.value)}
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            label="Occupation"
                                            value={occupation}
                                            onChange={(e) => setOccupation(e.target.value)}
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            label="Company Name"
                                            value={company}
                                            onChange={(e) => setCompany(e.target.value)}
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            label="Monthly Income"
                                            type="number"
                                            value={income}
                                            onChange={(e) => setIncome(e.target.value)}
                                            InputProps={{
                                                startAdornment: <InputAdornment position="start">₹</InputAdornment>,
                                                inputProps: { min: 0 }
                                            }}
                                        />
                                    </Grid>
                                </Grid>

                                <SectionTitle title="About Me" />
                                <Grid container spacing={2}>
                                    <Grid size={{ xs: 12 }}>
                                        <TextField
                                            fullWidth
                                            multiline
                                            rows={3}
                                            label="Write about yourself"
                                            placeholder="Describe yourself, hobbies, values, and expectations..."
                                            value={detail}
                                            onChange={(e) => setDetail(e.target.value)}
                                        />
                                    </Grid>
                                </Grid>

                                <SectionTitle title="Lifestyle" />
                                <Grid container spacing={2}>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            select
                                            fullWidth
                                            label="Physically Challenged"
                                            value={physical}
                                            onChange={(e) => setPhysical(e.target.value)}
                                        >
                                            <MenuItem value="No">No</MenuItem>
                                            <MenuItem value="Yes">Yes</MenuItem>
                                        </TextField>
                                    </Grid>
                                </Grid>

                                <SectionTitle title="Profile Image" />
                                <Grid container spacing={2} alignItems="center">
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <Button
                                            component="label"
                                            variant="contained"
                                            startIcon={<CloudUploadIcon />}
                                            fullWidth
                                            sx={{ height: 50 }}
                                        >
                                            Upload Image
                                            <VisuallyHiddenInput
                                                type="file"
                                                accept="image/*"
                                                onChange={handleImageChange}
                                            />
                                        </Button>
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        {imagePreview ? (
                                            <CardMedia
                                                component="img"
                                                image={imagePreview}
                                                alt="Profile preview"
                                                sx={{
                                                    width: '100%',
                                                    height: 200,
                                                    objectFit: 'cover',
                                                    borderRadius: 2,
                                                    border: '3px solid #c2185b'
                                                }}
                                            />
                                        ) : (
                                            <Box
                                                sx={{
                                                    width: '100%',
                                                    height: 200,
                                                    display: 'flex',
                                                    alignItems: 'center',
                                                    justifyContent: 'center',
                                                    border: '2px dashed #ccc',
                                                    borderRadius: 2,
                                                    bgcolor: '#f5f5f5'
                                                }}
                                            >
                                                <Typography color="text.secondary">
                                                    Image Preview
                                                </Typography>
                                            </Box>
                                        )}
                                    </Grid>
                                </Grid>

                                <Box textAlign="center" mt={4} sx={{ display: 'flex', gap: 2, justifyContent: 'center' }}>
                                    <Button
                                        variant="contained"
                                        size="large"
                                        color="error"
                                        type="submit"
                                        disabled={loading}
                                        startIcon={loading && <CircularProgress size={20} color="inherit" />}
                                    >
                                        {loading ? 'Submitting...' : 'Submit Profile'}
                                    </Button>
                                    <Button
                                        variant="outlined"
                                        size="large"
                                        color="secondary"
                                        onClick={handleReset}
                                        disabled={loading}
                                    >
                                        Reset Form
                                    </Button>
                                </Box>
                            </form>
                        </Paper>
                    </Grid>

                    <Grid size={{ xs: 12, md: 5 }}>
                        <DisplayCard elevation={3}>
                            <CardContent>
                                <Typography
                                    variant="h5"
                                    gutterBottom
                                    color="error"
                                    fontWeight="bold"
                                    textAlign="center"
                                >
                                    Profile Preview
                                </Typography>
                                
                                {/* Show preview of current form data */}
                                <Box sx={{ textAlign: 'center', mb: 2 }}>
                                    {imagePreview ? (
                                        <CardMedia
                                            component="img"
                                            image={imagePreview}
                                            alt={username || 'Profile'}
                                            sx={{
                                                width: 150,
                                                height: 150,
                                                borderRadius: '50%',
                                                margin: '0 auto',
                                                objectFit: 'cover',
                                                border: '3px solid #c2185b'
                                            }}
                                        />
                                    ) : (
                                        <Box
                                            sx={{
                                                width: 150,
                                                height: 150,
                                                borderRadius: '50%',
                                                margin: '0 auto',
                                                display: 'flex',
                                                alignItems: 'center',
                                                justifyContent: 'center',
                                                border: '3px solid #c2185b',
                                                bgcolor: '#f5f5f5'
                                            }}
                                        >
                                            <PersonIcon sx={{ fontSize: 60, color: '#ccc' }} />
                                        </Box>
                                    )}
                                    <Typography variant="h6" fontWeight="bold" mt={2}>
                                        {username || 'Your Name'}
                                    </Typography>
                                    <Box sx={{ display: 'flex', gap: 1, justifyContent: 'center', mt: 1, flexWrap: 'wrap' }}>
                                        {gender && <Chip label={gender} size="small" color="primary" />}
                                        {age && <Chip label={`${age} years`} size="small" color="secondary" />}
                                        {status && <Chip label={status} size="small" color="info" />}
                                    </Box>
                                </Box>

                                <Divider sx={{ my: 2 }} />

                                <InfoRow icon={<EmailIcon />} label="Email" value={email} />
                                <InfoRow icon={<PhoneIcon />} label="Contact" value={contact} />
                                <InfoRow icon={<LocationOnIcon />} label="Address" value={address} />

                                <Divider sx={{ my: 2 }} />

                                <Grid container spacing={2}>
                                    <Grid size={{ xs: 6 }}>
                                        <Typography variant="caption" color="text.secondary">Date of Birth</Typography>
                                        <Typography variant="body2">{date || 'Not provided'}</Typography>
                                    </Grid>
                                    <Grid size={{ xs: 6 }}>
                                        <Typography variant="caption" color="text.secondary">Height</Typography>
                                        <Typography variant="body2">{height ? `${height} ft` : 'Not provided'}</Typography>
                                    </Grid>
                                    <Grid size={{ xs: 6 }}>
                                        <Typography variant="caption" color="text.secondary">Religion</Typography>
                                        <Typography variant="body2">{religion || 'Not provided'}</Typography>
                                    </Grid>
                                    <Grid size={{ xs: 6 }}>
                                        <Typography variant="caption" color="text.secondary">Mother Tongue</Typography>
                                        <Typography variant="body2">{language || 'Not provided'}</Typography>
                                    </Grid>
                                </Grid>

                                <Divider sx={{ my: 2 }} />

                                <InfoRow icon={<SchoolIcon />} label="Education" value={education} />
                                <InfoRow icon={<WorkIcon />} label="Occupation" value={occupation} />

                                <Grid container spacing={2} sx={{ mt: 1 }}>
                                    <Grid size={{ xs: 6 }}>
                                        <Typography variant="caption" color="text.secondary">Company</Typography>
                                        <Typography variant="body2">{company || 'Not provided'}</Typography>
                                    </Grid>
                                    <Grid size={{ xs: 6 }}>
                                        <Typography variant="caption" color="text.secondary">Monthly Income</Typography>
                                        <Typography variant="body2">{income ? `₹${income}` : 'Not provided'}</Typography>
                                    </Grid>
                                </Grid>

                                <Divider sx={{ my: 2 }} />

                                <Typography variant="caption" color="text.secondary">About Me</Typography>
                                <Typography variant="body2" sx={{ mb: 1 }}>
                                    {detail || 'No description provided'}
                                </Typography>

                                {physical && (
                                    <Box sx={{ mt: 1 }}>
                                        <Typography variant="caption" color="text.secondary">Physical Status</Typography>
                                        <Chip
                                            label={physical}
                                            size="small"
                                            color={physical === 'Yes' ? 'warning' : 'success'}
                                        />
                                    </Box>
                                )}
                            </CardContent>
                        </DisplayCard>
                    </Grid>
                </Grid>

                <Snackbar
                    open={snackbar.open}
                    autoHideDuration={6000}
                    onClose={handleCloseSnackbar}
                    anchorOrigin={{ vertical: 'bottom', horizontal: 'right' }}
                >
                    <Alert onClose={handleCloseSnackbar} severity={snackbar.severity} sx={{ width: '100%' }}>
                        {snackbar.message}
                    </Alert>
                </Snackbar>
            </Container>
        </>
    );
}
