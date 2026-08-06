
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
} from "@mui/material";
import { styled } from "@mui/material/styles";
import { LocalizationProvider } from "@mui/x-date-pickers";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";
import NumberField from "../components/NumberField";
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { useState } from "react";
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
    const [image, setImage] = useState("");
    const [status, setStatus] = useState("");
    const [detail, setDetail] = useState("");
    const [physical, setPhysical] = useState("");
    const [height, setHeight] = useState("");

    const [profile, setProfile] = useState([]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const newProfile = {
                Gender: gender,
                Name: username,
                Email: email,
                Age: age,
                DOB: date,
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
            }
            const res = await axios.post(`${API_URL}/profile`, newProfile);
            newProfile.RegisterID = res.data.RegisterID;

            setProfile([newProfile]);

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
            setImage("");
            setStatus("");
            setDetail("");
            setPhysical("");
            setHeight("");

            navigate("/match");
        } catch (err) {
            console.log(err);
            alert("Error");
        }
    };

    return (
        <>
            <CssBaseline />

            <Container maxWidth="lg" sx={{ py: 4 }} onChange={handleSubmit}>
                
                <Typography
                    variant="h3"
                    align="center"
                    fontWeight="bold"
                    color="error"
                >
                    Matrimonial Profile
                </Typography>

                {/* PERSONAL DETAILS */}

                <SectionTitle title="Personal Information" />
                <Grid container spacing={2}>

                    <Grid item xs={12} md={6} sx={{ width: '50%', marginLeft:30 }}>
                        <Grid >
                            <Item>
                                <TextField select fullWidth label="Gender" >
                                    <MenuItem value="Male">Male</MenuItem>
                                    <MenuItem value="Female">Female</MenuItem>
                                </TextField>
                            </Item>
                        </Grid>

                    </Grid>
                    <Grid item xs={12} md={6} sx={{ width: '48%' }}>
                        <Item>
                            <TextField fullWidth label="Full Name"  />
                        </Item>
                    </Grid>
                    <Grid item xs={12} md={6} sx={{ width: '48%' }}>
                        <Item>
                            <TextField fullWidth label="Email" />
                        </Item>
                    </Grid>

                    <Grid item xs={12} md={6} sx={{ width: '35%' }}>
                        <Item>
                            <LocalizationProvider dateAdapter={AdapterDayjs}>
                                <DatePicker
                                    label="Date of Birth"
                                    sx={{ width: "100%" }}
                                    
                                />
                            </LocalizationProvider>
                        </Item>
                    </Grid>

                    <Grid item xs={12} md={6} sx={{ width: '25%' }}>
                        <Item>
                            <NumberField
                                label="Age"
                                min={18}
                                max={80}
                                sx={{ width: "100%" }}
                               
                            />
                        </Item>
                    </Grid>

                    <Grid item xs={12} md={6} sx={{ width: '35%' }}>
                        <Item>
                            <TextField fullWidth label="Height (cm)"/>
                        </Item>
                    </Grid>

                    <Grid item xs={12} md={6} sx={{ width: '35%' }}>
                        <Item>
                            <TextField select fullWidth label="Marital Status" >
                                <MenuItem value="Single">Single</MenuItem>
                                <MenuItem value="Divorced">Divorced</MenuItem>
                                <MenuItem value="Widowed">Widowed</MenuItem>
                            </TextField>
                        </Item>
                    </Grid>

                    <Grid item xs={12} md={6} sx={{ width: '25%' }}>
                        <Item>
                            <TextField select fullWidth label="Religion" >
                                <MenuItem value="Hindu">Hindu</MenuItem>
                                <MenuItem value="Muslim">Muslim</MenuItem>
                                <MenuItem value="Christian">Christian</MenuItem>
                                <MenuItem value="Sikh">Sikh</MenuItem>
                                <MenuItem value="Jain">Jain</MenuItem>
                                <MenuItem value="Other">Other</MenuItem>
                            </TextField>
                        </Item>
                    </Grid>

                    <Grid item xs={12} md={6} sx={{ width: '35%' }}>
                        <Item>
                            <TextField select fullWidth label="Mother Tongue" >
                                <MenuItem value="Hindi">Hindi</MenuItem>
                                <MenuItem value="Marathi">Marathi</MenuItem>
                                <MenuItem value="Gujarati">Gujarati</MenuItem>
                                <MenuItem value="Tamil">Tamil</MenuItem>
                                <MenuItem value="Telugu">Telugu</MenuItem>
                            </TextField>
                        </Item>
                    </Grid>
                </Grid>
            

                <SectionTitle title="Contact Information" />

                <Grid container spacing={2}>
                    <Grid item xs={12} md={6} sx={{ width: '35%' }}>
                        <Item>
                            <TextField fullWidth label="Mobile Number" />
                        </Item>
                    </Grid>

                    <Grid item xs={12} sx={{ width: '55%' }}>
                        <Item>
                            <TextField
                                fullWidth
                                multiline
                                rows={3}
                                label="Address"
                                
                            />
                        </Item>
                    </Grid>
                </Grid>

                {/* EDUCATION */}

                <SectionTitle title="Education & Career" />

                <Grid container spacing={2}>
                    <Grid item xs={12} md={6} sx={{ width: '45%' }}>
                        <Item>
                            <TextField fullWidth label="Highest Education"  />
                        </Item>
                    </Grid>

                    <Grid item xs={12} md={6} sx={{ width: '45%' }}>
                        <Item>
                            <TextField fullWidth label="Occupation"  />
                        </Item>
                    </Grid>

                    <Grid item xs={12} md={6} sx={{ width: '45%' }}>
                        <Item>
                            <TextField fullWidth label="Company Name" />
                        </Item>
                    </Grid>

                    <Grid item xs={12} md={6} sx={{ width: '25%' }}>
                        <Item>
                            <NumberField
                                fullWidth
                                label="Annual Income"
                                min={100000}
                                max={10000000}
                                sx={{ width: "100%" }}
                                
                            />
                        </Item>
                    </Grid>
                </Grid>

                {/* LIFESTYLE */}

                <SectionTitle title="Lifestyle" />

                <Grid container spacing={2}>
                    <Grid item xs={12} md={6} sx={{ width: '45%' }}>
                        <Item>
                            <TextField select fullWidth label="Physically Challenged" >
                                <MenuItem value="No">No</MenuItem>
                                <MenuItem value="Yes">Yes</MenuItem>
                            </TextField>
                        </Item>
                    </Grid>
                </Grid>

                {/* ABOUT */}

                <SectionTitle title="About Me" />

                <Grid container spacing={2}>
                    <Grid item xs={12} sx={{ paddingBottom: 5, width: '40%' }}>
                        <Item>
                            <TextField
                                fullWidth
                                multiline
                                rows={5}
                                label="Write about yourself"
                                placeholder="Describe yourself, hobbies, values, and expectations..."
                                
                            />
                        </Item>
                    </Grid>
                    <Grid item xs={12} sx={{ paddingBottom: 5 }}>
                        <Item>
                            <Button
                                
                                component="label"
                                variant="contained"
                                tabIndex={-1}
                                startIcon={<CloudUploadIcon />}
                            >
                                Upload Images
                                <VisuallyHiddenInput
                                    type="file"
                                    onChange={(event) => console.log(event.target.files)}
                                    multiple
                                />
                            </Button>
                        </Item>
                    </Grid>
                </Grid>
                <Box textAlign="center" mt={5}>
                    <Button
                        variant="contained"
                        size="large"
                        color="error"
                        type="submit"
                    >
                        Submit Profile
                    </Button>
                </Box>
            </Container>
        </>
    );
}
