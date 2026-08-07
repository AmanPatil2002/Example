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
} from "@mui/material";
import { styled } from "@mui/material/styles";
import { LocalizationProvider } from "@mui/x-date-pickers";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";
import NumberField from "../../components/NumberField";
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import PersonIcon from '@mui/icons-material/Person';
import EmailIcon from '@mui/icons-material/Email';
import PhoneIcon from '@mui/icons-material/Phone';
import LocationOnIcon from '@mui/icons-material/LocationOn';
import SchoolIcon from '@mui/icons-material/School';
import WorkIcon from '@mui/icons-material/Work';
import { useState } from "react";
import dayjs from 'dayjs';
import axios from "axios";
const API_URL = import.meta.env.VITE_API_URL;
import { useNavigate } from "react-router-dom";

const Item = styled(Paper)(({ theme }) => ({
    padding: theme.spacing(2),
}));

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
    const [date, setDate] = useState(null);
    const [contact, setContact] = useState("");
    const [address, setAddress] = useState("");
    const [language, setLanguage] = useState("");
    const [religion, setReligion] = useState("");
    const [education, setEducation] = useState("");
    const [occupation, setOccupation] = useState("");
    const [company, setCompany] = useState("");
    const [income, setIncome] = useState("");
    const [image, setImage] = useState("");
    const [status, setStatus] = useState("");
    const [detail, setDetail] = useState("");
    const [physical, setPhysical] = useState("");
    const [height, setHeight] = useState("");

    const [profile, setProfile] = useState(null);

    const handleDateChange = (newDate) => {
        setDate(newDate);
        if (newDate && newDate.isValid()) {
            const calculatedAge = dayjs().diff(newDate, 'year');
            setAge(calculatedAge.toString());
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const dateString = date ? date.format('YYYY-MM-DD') : '';
            
            const newProfile = {
                Gender: gender,
                Name: username,
                Email: email,
                Age: age,
                DOB: dateString,
                Contact: contact,
                Address: address,
                Language: language,
                Religion: religion,
                Education: education,
                Occupation: occupation,
                CompanyName: company,
                MonthlyIncome: income,
                Image: image,
                Status: status,
                Detail: detail,
                Physically: physical,
                Height: height,
            };
            
            const res = await axios.post(`${API_URL}/profile`, newProfile);
            newProfile.RegisterID = res.data.RegisterID;
            newProfile.DOB = dateString;

            setProfile(newProfile);
            
            alert("Profile created successfully!");
            
        } catch (err) {
            console.log(err);
            alert("Error submitting profile");
        }
    };

    const handleReset = () => {
        setGender("");
        setUsername("");
        setEmail("");
        setAge("");
        setDate(null);
        setContact("");
        setAddress("");
        setLanguage("");
        setReligion("");
        setEducation("");
        setOccupation("");
        setCompany("");
        setIncome("");
        setImage("");
        setStatus("");
        setDetail("");
        setPhysical("");
        setHeight("");
        setProfile(null);
    };

    const formatDate = (dateString) => {
        if (!dateString) return 'Not provided';
        return dayjs(dateString).format('DD MMMM YYYY');
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
                    Matrimonial Profile
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
                                        <LocalizationProvider dateAdapter={AdapterDayjs}>
                                            <DatePicker
                                                label="Date of Birth"
                                                value={date}
                                                onChange={handleDateChange}
                                                format="DD/MM/YYYY"
                                                slotProps={{
                                                    textField: {
                                                        fullWidth: true,
                                                        required: true,
                                                    },
                                                }}
                                            />
                                        </LocalizationProvider>
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
                                            label="Height (cm)"
                                            value={height}
                                            onChange={(e) => setHeight(e.target.value)}
                                            type="number"
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
                                            rows={3}
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
                                            label="Annual Income"
                                            type="number"
                                            value={income}
                                            onChange={(e) => setIncome(e.target.value)}
                                            InputProps={{
                                                inputProps: { min: 100000, max: 10000000 }
                                            }}
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

                                <SectionTitle title="About Me" />
                                <Grid container spacing={2}>
                                    <Grid size={{ xs: 12 }}>
                                        <TextField
                                            fullWidth
                                            multiline
                                            rows={5}
                                            label="Write about yourself"
                                            placeholder="Describe yourself, hobbies, values, and expectations..."
                                            value={detail}
                                            onChange={(e) => setDetail(e.target.value)}
                                        />
                                    </Grid>
                                    <Grid size={{ xs: 12 }}>
                                        <Button
                                            component="label"
                                            variant="contained"
                                            tabIndex={-1}
                                            startIcon={<CloudUploadIcon />}
                                        >
                                            Upload Images
                                            <VisuallyHiddenInput
                                                type="file"
                                                onChange={(event) => {
                                                    const file = event.target.files[0];
                                                    if (file) {
                                                        setImage(URL.createObjectURL(file));
                                                    }
                                                }}
                                                multiple
                                            />
                                        </Button>
                                    </Grid>
                                </Grid>

                                <Box textAlign="center" mt={4} sx={{ display: 'flex', gap: 2, justifyContent: 'center' }}>
                                    <Button
                                        variant="contained"
                                        size="large"
                                        color="error"
                                        type="submit"
                                    >
                                        Submit Profile
                                    </Button>
                                    <Button
                                        variant="outlined"
                                        size="large"
                                        color="secondary"
                                        onClick={handleReset}
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
                                
                                {profile ? (
                                    <>
                                        <Box sx={{ textAlign: 'center', mb: 2 }}>
                                            {image && (
                                                <CardMedia
                                                    component="img"
                                                    image={image}
                                                    alt={profile.Name}
                                                    sx={{ 
                                                        width: 150, 
                                                        height: 150, 
                                                        borderRadius: '50%',
                                                        margin: '0 auto',
                                                        objectFit: 'cover',
                                                        border: '3px solid #c2185b'
                                                    }}
                                                />
                                            )}
                                            <Typography variant="h6" fontWeight="bold" mt={2}>
                                                {profile.Name}
                                            </Typography>
                                            <Box sx={{ display: 'flex', gap: 1, justifyContent: 'center', mt: 1 }}>
                                                <Chip label={profile.Gender} size="small" color="primary" />
                                                <Chip label={`${profile.Age} years`} size="small" color="secondary" />
                                                {profile.Status && <Chip label={profile.Status} size="small" color="info" />}
                                            </Box>
                                        </Box>

                                        <Divider sx={{ my: 2 }} />

                                        <InfoRow 
                                            icon={<EmailIcon />} 
                                            label="Email" 
                                            value={profile.Email} 
                                        />
                                        <InfoRow 
                                            icon={<PhoneIcon />} 
                                            label="Contact" 
                                            value={profile.Contact} 
                                        />
                                        <InfoRow 
                                            icon={<LocationOnIcon />} 
                                            label="Address" 
                                            value={profile.Address} 
                                        />
                                        
                                        <Divider sx={{ my: 2 }} />

                                        <Grid container spacing={2}>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Date of Birth</Typography>
                                                <Typography variant="body2">{formatDate(profile.DOB)}</Typography>
                                            </Grid>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Height</Typography>
                                                <Typography variant="body2">{profile.Height ? `${profile.Height} cm` : 'Not provided'}</Typography>
                                            </Grid>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Religion</Typography>
                                                <Typography variant="body2">{profile.Religion || 'Not provided'}</Typography>
                                            </Grid>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Mother Tongue</Typography>
                                                <Typography variant="body2">{profile.Language || 'Not provided'}</Typography>
                                            </Grid>
                                        </Grid>

                                        <Divider sx={{ my: 2 }} />

                                        <InfoRow 
                                            icon={<SchoolIcon />} 
                                            label="Education" 
                                            value={profile.Education} 
                                        />
                                        <InfoRow 
                                            icon={<WorkIcon />} 
                                            label="Occupation" 
                                            value={profile.Occupation} 
                                        />
                                        
                                        <Grid container spacing={2} sx={{ mt: 1 }}>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Company</Typography>
                                                <Typography variant="body2">{profile.CompanyName || 'Not provided'}</Typography>
                                            </Grid>
                                            <Grid size={{ xs: 6 }}>
                                                <Typography variant="caption" color="text.secondary">Annual Income</Typography>
                                                <Typography variant="body2">{profile.MonthlyIncome ? `₹${profile.MonthlyIncome}` : 'Not provided'}</Typography>
                                            </Grid>
                                        </Grid>

                                        <Divider sx={{ my: 2 }} />

                                        <Typography variant="caption" color="text.secondary">About Me</Typography>
                                        <Typography variant="body2" sx={{ mb: 1 }}>
                                            {profile.Detail || 'No description provided'}
                                        </Typography>

                                        {profile.Physically && (
                                            <Box sx={{ mt: 1 }}>
                                                <Typography variant="caption" color="text.secondary">Physical Status</Typography>
                                                <Chip 
                                                    label={profile.Physically} 
                                                    size="small" 
                                                    color={profile.Physically === 'Yes' ? 'warning' : 'success'} 
                                                />
                                            </Box>
                                        )}
                                    </>
                                ) : (
                                    <Box 
                                        sx={{ 
                                            textAlign: 'center', 
                                            py: 8,
                                            color: 'text.secondary'
                                        }}
                                    >
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
