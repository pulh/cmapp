import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFACA1EB), // Màu nền xanh tím nhạt cho App Bar
      body: Container(
        color: const Color(0xFFACA1EB), // Màu nền xanh tím nhạt cho màn hình
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'A new world to explore',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Màu chữ trắng
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Image.asset('lib/assets/Image26.png',
                height: 300, width: 300), // Đường dẫn hình ảnh của bạn
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Xử lý sự kiện khi nhấn nút "Get Started"
                _navigateToLogin(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Màu nút xanh
              ),
              child: Text('Get Started'),
            ),
            SizedBox(height: 35),
            TextButton(
                onPressed: () {
                  // Xử lý sự kiện khi nhấn nút "Sign Up"
                  _navigateToSignup(context);
                },
                child: Text('Register if  do not have an account?',
                    style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    // Điều hướng đến trang đăng nhập
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}

void _navigateToSignup(BuildContext context) {
  // Điều hướng đến trang đăng ký
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignUpScreen()),
  );
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class LoginPage extends StatefulWidget {
  final String? successMessage;
  const LoginPage({Key? key, this.successMessage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String enteredPassword = '';
  bool _isPasswordIncorrect = false;
  bool rememberMe = false;
  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFACA1EB),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tiêu đề text "Login"
              _buildLoginTitle(),
              // Hình ảnh giữa màn hình
              _buildLogo(),
              // Ô nhập Email
              _buildEmailInput(),
              // Ô nhập Mật khẩu
              _buildPasswordInput(),
              // Thông báo lỗi mật khẩu
              if (_isPasswordIncorrect) _buildErrorText(),
              _buildRememberMeCheckbox(),

              // Nút Đăng nhập
              _buildLoginButton(),
              // Đường dẫn Quên mật khẩu
              _buildForgotPasswordLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTitle() {
    return const Text(
      'LOGIN',
      style: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Image.asset(
        'lib/assets/Image44.png', // Thay 'your_logo.png' bằng tên file hình ảnh của bạn
        width: 150.0,
        height: 150.0,
      ),
    );
  }

  Widget _buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          hintText: 'Email',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          prefixIcon: const Icon(Icons.email),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          // You can add more advanced email validation if needed
          if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          prefixIcon: const Icon(Icons.remove_red_eye_rounded),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: (value) {
            setState(() {
              rememberMe = value!;
            });
          },
        ),
        const Text('Remember me'),
      ],
    );
  }

  Widget _buildErrorText() {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        '*Incorrect email or password, please re-enter',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: const Color(0xff879A15),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: const SizedBox(
          width: double.infinity,
          child: Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return TextButton(
      onPressed: _navigateToForgotPassword,
      child: Text(
        'Forgot your password?',
        style: TextStyle(
          color: Color(0xff1728c8),
        ),
      ),
    );
  }

  void _handleLogin() {
    // Xử lý đăng nhập
    String enteredEmail = _emailController.text;
    String enteredPassword = _passwordController.text;
    if (enteredEmail == 'lhpu@gmail.com' && enteredPassword == '2002') {
      // Đăng nhập thành công
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      setState(() {
        _isPasswordIncorrect = false;
      });
      // Thực hiện các hành động cần thiết sau khi đăng nhập thành công
    } else {
      // Hiển thị thông báo lỗi mật khẩu
      setState(() {
        _isPasswordIncorrect = true;
      });
    }
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FORGOT PASSWORD'),
        backgroundColor: Colors.purple[200], // Màu nền tím nhạt
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 17),
            _buildLogo(),
            SizedBox(height: 40),
            Text(
                'Enter your email address. You will receive a new password to login via email'),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _handleSend(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Màu nút xanh
              ),
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    // Bạn có thể thay thế hình ảnh dưới đây bằng hình ảnh của bạn
    return Image.asset('lib/assets/Image44.png', height: 150, width: 150);
  }
}

void _handleSend(BuildContext context) {
  // Lấy giá trị email từ người dùng
  String email =
      '_emailController.text'; // Đây là nơi bạn sẽ lấy giá trị từ TextField hoặc nơi người dùng nhập email

  // Kiểm tra xem email có trống không
  if (email.isEmpty) {
    // Hiển thị thông báo nếu email trống
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please enter your email !', textAlign: TextAlign.center),
      ),
    );
  } else {
    // Gửi thông báo nếu email đã được nhập và đúng định dạng
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sent. Check your email!'),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isMale = false;
  bool isFemale = false;
  bool isOther = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFACA1EB), // Màu nền xanh tím nhạt cho App Bar
      body: Container(
        color: const Color(0xFFACA1EB),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SIGN UP',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            buildInputField('Name', _nameController),
            const SizedBox(height: 10),
            buildInputField('Email', _emailController),
            const SizedBox(height: 10),
            buildInputField('Age', _ageController),
            const SizedBox(height: 10),
            buildInputField('Phone', _phoneController),
            const SizedBox(height: 10),
            buildInputField('Password', _passwordController),
            const SizedBox(height: 5),
            CheckboxListTile(
              title: Text('Male'),
              value: isMale,
              onChanged: (value) {
                setState(() {
                  isMale = value ?? false;
                  isFemale = false;
                  isOther = false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Female'),
              value: isFemale,
              onChanged: (value) {
                setState(() {
                  isMale = false;
                  isFemale = value ?? false;
                  isOther = false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Other'),
              value: isOther,
              onChanged: (value) {
                setState(() {
                  isMale = false;
                  isFemale = false;
                  isOther = value ?? false;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Handle sign-up logic here
                _handleSignUp(); // After successful sign-up, navigate to login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Text('Sign Up'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    ); // Navigate to login page
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffbfdc9d)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with signup logic
      if (_nameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _ageController.text.isEmpty ||
          _phoneController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          (!isMale && !isFemale && !isOther)) {
        // At least one field is empty, show a message
        _showErrorSnackBar('Please fill in field');
      } else {
        // Navigate to the login page and show a success message
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              successMessage: 'Registration successful, Please log in',
            ),
          ),
        );
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
