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

    Chip,
    Divider,
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
    const [image, setImage] = useState(null); 
    const [imagePreview, setImagePreview] = useState(""); 
    const [status, setStatus] = useState("");
    const [detail, setDetail] = useState("");
    const [physical, setPhysical] = useState("");
    const [height, setHeight] = useState("");

    const [profile, setProfile] = useState(null);
    const [loading, setLoading] = useState(false);
    
    const [errors, setErrors] = useState({});

    
    useEffect(() => {
        fetchProfile();
    }, []);

    const fetchProfile = async () => {
        const userEmail = localStorage.getItem("email");
        if (!userEmail) return;

        try {
            const res = await axios.get(`${API_URL}/profile/profile`);
            console.log("API Response:", res.data);
            
    
            const userProfile = Array.isArray(res.data) 
                ? res.data.find(p => p.Email === userEmail)
                : res.data;
            
            if (userProfile) {
                setProfile(userProfile);
    
                populateForm(userProfile);
            }
        } catch (err) {
            console.log("Error fetching profile:", err);
        }
    };

    const populateForm = (profileData) => {
        setGender(profileData.Gender || "");
        setUsername(profileData.Name || "");
        setEmail(profileData.Email || "");
        setAge(profileData.Age || "");
        setDate(profileData.DOB ? profileData.DOB.split('T')[0] : "");
        setContact(profileData.Contact || "");
        setAddress(profileData.Address || "");
        setLanguage(profileData.Language || "");
        setReligion(profileData.Religion || "");
        setEducation(profileData.Education || "");
        setOccupation(profileData.Occupation || "");
        setCompany(profileData.CompanyName || "");
        setIncome(profileData.MonthlyIncome || "");
        setStatus(profileData.Status || "");
        setDetail(profileData.Detail || "");
        setPhysical(profileData.Physically || "");
        setHeight(profileData.Height || "");
        if (profileData.Image) {
            setImagePreview(`${API_URL}/${profileData.Image}`);
        }
    };

    const validateForm = () => {
        const newErrors = {};

        if (!gender) newErrors.gender = "Gender is required";
        if (!username.trim()) newErrors.username = "Name is required";
        if (!email.trim()) {
            newErrors.email = "Email is required";
        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            newErrors.email = "Invalid email format";
        }
        if (!date) newErrors.date = "Date of birth is required";
        if (contact && !/^\d{10}$/.test(contact)) {
            newErrors.contact = "Invalid mobile number";
        }

        setErrors(newErrors);
        return Object.keys(newErrors).length === 0;
    };

    const handleImageChange = (event) => {
        const file = event.target.files[0];
        if (file) {
            if (!file.type.startsWith('image/')) {
                return;
            }
            // Validate file size (max 5MB)
            if (file.size > 5 * 1024 * 1024) {
                return;
            }
            setImage(file);
            setImagePreview(URL.createObjectURL(file));
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        if (!validateForm()) {
            return;
        }

        setLoading(true);
        try {
            const formData = new FormData();
            formData.append('Gender', gender);
            formData.append('Name', username);
            formData.append('Email', email);
            formData.append('Age', age);
            formData.append('DOB', date);
            formData.append('Contact', contact);
            formData.append('Address', address);
            formData.append('Language', language);
            formData.append('Religion', religion);
            formData.append('Education', education);
            formData.append('Occupation', occupation);
            formData.append('CompanyName', company);
            formData.append('MonthlyIncome', income);
            formData.append('Status', status);
            formData.append('Detail', detail);
            formData.append('Physically', physical);
            formData.append('Height', height);
            if (image) {
                formData.append('Image', image);
            }

            const res = await axios.post(`${API_URL}/profile/profile`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });

            setProfile(res.data);
        
            localStorage.setItem("name", username);
            localStorage.setItem("email", email);

        } catch (err) {
            console.log("Error details:", err.response?.data || err.message);
        } finally {
            setLoading(false);
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
        setProfile(null);
        setErrors({});
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
                    {profile ? "Edit Profile" : "Create Profile"}
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
                                            error={!!errors.gender}
                                            helperText={errors.gender}
                                        >
                                            <MenuItem value="Male">Male</MenuItem>
                                            <MenuItem value="Female">Female</MenuItem>
                                        </TextField>
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            label="Full Name"
                                            value={username}
                                            onChange={(e) => setUsername(e.target.value)}
                                            required
                                            error={!!errors.username}
                                            helperText={errors.username}
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
                                            error={!!errors.email}
                                            helperText={errors.email}
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            type="date"
                                            label="Date of Birth"
                                            value={date}
                                            onChange={(e) => setDate(e.target.value)}
                                            InputLabelProps={{
                                                shrink: true,
                                            }}
                                            required
                                            error={!!errors.date}
                                            helperText={errors.date}
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
                                            <MenuItem value="English">English</MenuItem>
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
                                            error={!!errors.contact}
                                            helperText={errors.contact}
                                            InputProps={{
                                                startAdornment: <InputAdornment position="start">+91</InputAdornment>,
                                            }}
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
                                            placeholder="e.g., Bachelor's, Master's, PhD"
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <TextField
                                            fullWidth
                                            label="Occupation"
                                            value={occupation}
                                            onChange={(e) => setOccupation(e.target.value)}
                                            placeholder="e.g., Software Engineer, Doctor"
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
                                            rows={4}
                                            label="Write about yourself"
                                            placeholder="Describe yourself, hobbies, values, and expectations..."
                                            value={detail}
                                            onChange={(e) => setDetail(e.target.value)}
                                        />
                                    </Grid>
                                </Grid>

                                <SectionTitle title="Lifestyle & Upload" />
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
                                    <Grid size={{ xs: 12, sm: 6 }}>
                                        <Button
                                            component="label"
                                            variant="contained"
                                            startIcon={<CloudUploadIcon />}
                                            fullWidth
                                            sx={{ height: 50 }}
                                        >
                                            Upload Photo
                                            <VisuallyHiddenInput
                                                type="file"
                                                accept="image/*"
                                                onChange={handleImageChange}
                                            />
                                        </Button>
                                        {imagePreview && (
                                            <Box sx={{ mt: 1, textAlign: 'center' }}>
                                                <img 
                                                    src={imagePreview} 
                                                    alt="Preview" 
                                                    style={{ 
                                                        maxWidth: '100%', 
                                                        maxHeight: 150, 
                                                        borderRadius: 8,
                                                        border: '2px solid #c2185b'
                                                    }} 
                                                />
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
                                        startIcon={loading && <CircularProgress size={20} />}
                                    >
                                        {loading ? "Saving..." : profile ? "Update Profile" : "Submit Profile"}
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

                    {/* Preview Section */}
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
                                
                                {profile ? (
                                    <>
                                        <Box sx={{ textAlign: 'center', mb: 2 }}>
                                            {profile.Image && (
                                                <img
                                                    src={`${API_URL}/${profile.Image}`}
                                                    alt={profile.Name}
                                                    style={{
                                                        width: 150,
                                                        height: 150,
                                                        borderRadius: '50%',
                                                        objectFit: 'cover',
                                                        border: '3px solid #c2185b'
                                                    }}
                                                />
                                            )}
                                            <Typography variant="h6" fontWeight="bold" mt={2}>
                                                {profile.Name || 'Not provided'}
                                            </Typography>
                                            <Box sx={{ display: 'flex', gap: 1, justifyContent: 'center', mt: 1, flexWrap: 'wrap' }}>
                                                <Chip label={profile.Gender || 'N/A'} size="small" color="primary" />
                                                <Chip label={`${profile.Age || 'N/A'} years`} size="small" color="secondary" />
                                                {profile.Status && <Chip label={profile.Status} size="small" color="info" />}
                                            </Box>
                                        </Box>

                                        <Divider sx={{ my: 2 }} />

                                        <InfoRow icon={<EmailIcon />} label="Email" value={profile.Email} />
                                        <InfoRow icon={<PhoneIcon />} label="Contact" value={profile.Contact} />
                                        <InfoRow icon={<LocationOnIcon />} label="Address" value={profile.Address} />

                                        <Divider sx={{ my: 2 }} />

                                        <Grid container spacing={2}>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Date of Birth</Typography>
                                                <Typography variant="body2">{profile.DOB ? new Date(profile.DOB).toLocaleDateString() : 'N/A'}</Typography>
                                            </Grid>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Height</Typography>
                                                <Typography variant="body2">{profile.Height ? `${profile.Height} ft` : 'N/A'}</Typography>
                                            </Grid>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Religion</Typography>
                                                <Typography variant="body2">{profile.Religion || 'N/A'}</Typography>
                                            </Grid>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Mother Tongue</Typography>
                                                <Typography variant="body2">{profile.Language || 'N/A'}</Typography>
                                            </Grid>
                                        </Grid>

                                        <Divider sx={{ my: 2 }} />

                                        <InfoRow icon={<SchoolIcon />} label="Education" value={profile.Education} />
                                        <InfoRow icon={<WorkIcon />} label="Occupation" value={profile.Occupation} />

                                        <Grid container spacing={2} sx={{ mt: 1 }}>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Company</Typography>
                                                <Typography variant="body2">{profile.CompanyName || 'N/A'}</Typography>
                                            </Grid>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Monthly Income</Typography>
                                                <Typography variant="body2">{profile.MonthlyIncome ? `₹${profile.MonthlyIncome}` : 'N/A'}</Typography>
                                            </Grid>
                                        </Grid>

                                        <Divider sx={{ my: 2 }} />

                                        <Typography variant="caption" color="text.secondary">About Me</Typography>
                                        <Typography variant="body2" sx={{ mb: 1 }}>
                                            {profile.Detail || 'No description provided'}
                                        </Typography>

                                        {profile.Physically && (
                                            <Box sx={{ mt: 1 }}>
                                                <Chip
                                                    label={profile.Physically === 'Yes' ? 'Physically Challenged' : 'Not Physically Challenged'}
                                                    size="small"
                                                    color={profile.Physically === 'Yes' ? 'warning' : 'success'}
                                                />
                                            </Box>
                                        )}
                                    </>
                                ) : (
                                    <Box sx={{ textAlign: 'center', py: 8, color: 'text.secondary' }}>
                                        <PersonIcon sx={{ fontSize: 80, mb: 2, opacity: 0.3 }} />
                                        <Typography variant="h6" gutterBottom>
                                            No Profile Data
                                        </Typography>
                                        <Typography variant="body2">
                                            Fill out the form and click "Submit Profile" to see the preview
                                        </Typography>
                                    </Box>
                                )}
                            </CardContent>
                        </DisplayCard>
                    </Grid>
                </Grid>
                
            </Container>
        </>
    );
}
