
import {
  Container,
  Paper,
  Typography,
  Box,
  Grid,
  Avatar,
  IconButton,
  Badge,
  Tooltip,
} from '@mui/material';
import {
  PhotoCamera as PhotoCameraIcon,
  Email as EmailIcon,
  Phone as PhoneIcon,
  LocationOn as LocationIcon,
  Work as WorkIcon,
  School as SchoolIcon,
} from '@mui/icons-material';
import { styled } from '@mui/material/styles';
 
const StyledPaper = styled(Paper)(({ theme }) => ({
  padding: theme.spacing(4),
  marginTop: theme.spacing(3),
  marginBottom: theme.spacing(3),
  borderRadius: theme.spacing(2),
  boxShadow: '0 4px 20px rgba(0,0,0,0.1)',
}));

const ProfileAvatar = styled(Avatar)(({ theme }) => ({
  width: 120,
  height: 120,
  margin: '0 auto',
  border: `4px solid ${theme.palette.primary.main}`,
  boxShadow: '0 4px 10px rgba(0,0,0,0.2)',
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


const AccountSettings = () => {
 

  return (
    <Container maxWidth="lg">
      <Box sx={{ py: 4 }}>
        <Typography variant="h4" gutterBottom fontWeight="bold" color="primary">
          Account Settings
        </Typography>
        <Typography variant="body1" color="text.secondary" gutterBottom>
          Manage your profile, preferences, and privacy settings
        </Typography>

        {/* Profile Header Card */}
        <StyledPaper>
          <Grid container spacing={3} alignItems="center">
            <Grid item xs={12} md={3} sx={{ textAlign: 'center' }}>
              <Badge
                overlap="circular"
                anchorOrigin={{ vertical: 'bottom', horizontal: 'right' }}
                badgeContent={
                  <Tooltip title="Change photo">
                    <IconButton
                      component="label"
                      sx={{
                        bgcolor: 'primary.main',
                        color: 'white',
                        '&:hover': { bgcolor: 'primary.dark' },
                        width: 35,
                        height: 35,
                      }}
                    >
                      <PhotoCameraIcon sx={{ fontSize: 18 }} />
                      <VisuallyHiddenInput type="file" accept="image/*" />
                    </IconButton>
                  </Tooltip>
                }
              >
                <ProfileAvatar src="/path-to-profile-image.jpg" alt="Profile" />
              </Badge>
              <Typography variant="h6" sx={{ mt: 2 }}>
                name
              </Typography>
            </Grid>
            <Grid item xs={12} md={9}>
              <Grid container spacing={2}>
                <Grid item xs={12} sm={4}>
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    <EmailIcon color="action" />
                    <Typography variant="body2">email</Typography>
                  </Box>
                </Grid>
                <Grid item xs={12} sm={4}>
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    <PhoneIcon color="action" />
                    <Typography variant="body2">contact</Typography>
                  </Box>
                </Grid>
                <Grid item xs={12} sm={4}>
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    <LocationIcon color="action" />
                    <Typography variant="body2">location</Typography>
                  </Box>
                </Grid>
                <Grid item xs={12} sm={4}>
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    <WorkIcon color="action" />
                    <Typography variant="body2">occupation</Typography>
                  </Box>
                </Grid>
                <Grid item xs={12} sm={4}>
                  <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                    <SchoolIcon color="action" />
                    <Typography variant="body2">education</Typography>
                  </Box>
                </Grid>
              </Grid>
            </Grid>
          </Grid>
        </StyledPaper>
      </Box>
    </Container>
  );
};

export default AccountSettings;
