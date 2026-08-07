
import {
  Container,
  Paper,
  Typography,
  Box,
  // Grid,
  // Avatar,
  // IconButton,
  // Badge,
  // Tooltip,
} from '@mui/material';
// import {
//   PhotoCamera as PhotoCameraIcon,
//   Email as EmailIcon,
// } from '@mui/icons-material';
import { styled } from '@mui/material/styles';

const StyledPaper = styled(Paper)(({ theme }) => ({
  padding: theme.spacing(4),
  marginTop: theme.spacing(3),
  marginBottom: theme.spacing(3),
  borderRadius: theme.spacing(2),
  boxShadow: '0 4px 20px rgba(0,0,0,0.1)',
}));



const Account = () => {

  return (
    <Container maxWidth="lg">
      <Box sx={{ py: 4 }}>
        <Typography variant="h4" gutterBottom fontWeight="bold" color="primary">
          Account Settings
        </Typography>
        <Typography variant="body1" color="text.secondary" gutterBottom>
          Manage your profile, preferences, and privacy settings
        </Typography>
        <StyledPaper>


        </StyledPaper>
      </Box>
    </Container>
  );
};

export default Account;
