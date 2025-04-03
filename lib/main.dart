import 'package:demo_1/database_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for Date Formatting
import 'package:carousel_slider/carousel_slider.dart'; // For Health Tips Carousel
import 'notification_service.dart'; // Import the notification service
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init(); // Initialize notification service
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Child Health Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins', // Custom font
      ),
      home: const LoginPage(),
    );
  }
}


//  Login Page


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/child.webp',
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("LOGIN"),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupPage()),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//  Signup Page
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _signup() async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Signup failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/child.webp',
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("SIGN UP"),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  Home Page
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Child Health Reminder App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("User Name"),
              accountEmail: const Text("user@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
              decoration: const BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Message
              const Text(
                "Welcome, Parent!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Stay on top of your child's health with reminders and tips.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Quick Actions Grid
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildQuickActionButton(
                    icon: Icons.add_alert,
                    label: "Add Reminder",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FirstRoute()),
                      );
                    },
                  ),
                  _buildQuickActionButton(
                    icon: Icons.list,
                    label: "View Reminders",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FirstRoute()),
                      );
                    },
                  ),
                  _buildQuickActionButton(
                    icon: Icons.person,
                    label: "Profile",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage()),
                      );
                    },
                  ),
                  _buildQuickActionButton(
                    icon: Icons.medical_services,
                    label: "Health Tips",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HealthTips()),
                      );// Navigate to Health Tips Page
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Health Tips Carousel
              const Text(
                "Health Tips",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CarouselSlider(
                items: [
                  _buildHealthTipCard("Tip 1: Ensure your child gets enough sleep."),
                  _buildHealthTipCard("Tip 2: Encourage a balanced diet."),
                  _buildHealthTipCard("Tip 3: Regular check-ups are essential."),
                ],
                options: CarouselOptions(
                  height: 150,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Quick Action Button Widget
  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Health Tip Card Widget
  Widget _buildHealthTipCard(String tip) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          tip,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// 📌 Reminder Page



class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Map<String, dynamic>> reminders = [];
  final NotificationService _notificationService = NotificationService();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _notificationService.init();
    await _loadReminders();
  }

  Future<void> _loadReminders() async {
    final List<Map<String, dynamic>> loadedReminders = await _dbHelper.queryAll();
    setState(() => reminders.addAll(loadedReminders));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _addReminder() async {
    if (_titleController.text.isNotEmpty &&
        selectedDate != null &&
        selectedTime != null) {

      final DateTime scheduledTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      // Fixed ID generation
      final int uniqueId = DateTime.now().millisecondsSinceEpoch % 2147483647;

      try {
        await _notificationService.scheduleNotification(
          id: uniqueId,
          title: _titleController.text,
          body: _descriptionController.text,
          scheduledTime: scheduledTime,
        );

        // Save to database
        final newReminder = {
          "id": uniqueId,
          "title": _titleController.text,
          "description": _descriptionController.text,
          "date": DateFormat('yyyy-MM-dd').format(selectedDate!),
          "time": selectedTime!.format(context),
          "scheduled_time": scheduledTime.millisecondsSinceEpoch,
        };

        await _dbHelper.insert(newReminder);

        setState(() {
          reminders.add(newReminder);
          _titleController.clear();
          _descriptionController.clear();
          selectedDate = null;
          selectedTime = null;
        });

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Reminder Added Successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add reminder: ${e.toString()}")),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Reminder")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => _buildAddReminderDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const Icon(Icons.notifications, color: Colors.blue),
                      title: Text(reminders[index]["title"]),
                      subtitle: Text(
                        "${reminders[index]["description"]}\n"
                            "Date: ${reminders[index]["date"]} "
                            "Time: ${reminders[index]["time"]}",
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          try {
                            await _notificationService.cancelNotification(
                                reminders[index]["id"]);
                            await _dbHelper.delete(reminders[index]["id"]);
                            setState(() {
                              reminders.removeAt(index);
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Failed to delete: ${e.toString()}")),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Your original dialog implementation - completely unchanged
  Widget _buildAddReminderDialog() {
    return AlertDialog(
      title: const Text("Add Reminder"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Reminder Title"),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: "Description"),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text("Select Date"),
              ),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: const Text("Select Time"),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _addReminder,
          child: const Text("Save"),
        ),
      ],
    );
  }
}

class HealthTips extends StatelessWidget {
  const HealthTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vaccination Schedule"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVaccinationSection(
              title: "Birth",
              vaccines: [
                "✅ BCG – Prevents tuberculosis (TB)",
                "✅ Hepatitis B (1st dose) – Prevents Hepatitis B",
                "✅ OPV (0 dose) – Prevents polio",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "6 Weeks (1.5 Months)",
              vaccines: [
                "✅ Pentavalent-1 (DPT, Hep-B, Hib) – Prevents diphtheria, pertussis, tetanus, hepatitis B, and Haemophilus influenzae type b",
                "✅ OPV-1 – Prevents polio",
                "✅ IPV-1 – Extra polio protection",
                "✅ Rotavirus-1 – Prevents rotavirus diarrhea",
                "✅ PCV-1 – Prevents pneumonia & meningitis",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "10 Weeks (2.5 Months)",
              vaccines: [
                "✅ Pentavalent-2",
                "✅ OPV-2",
                "✅ IPV-2",
                "✅ Rotavirus-2",
                "✅ PCV-2",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "14 Weeks (3.5 Months)",
              vaccines: [
                "✅ Pentavalent-3",
                "✅ OPV-3",
                "✅ IPV-3",
                "✅ Rotavirus-3",
                "✅ PCV Booster",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "6 Months",
              vaccines: [
                "✅ Hepatitis B (3rd dose, if not given in Pentavalent vaccine)",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "9-12 Months",
              vaccines: [
                "✅ Measles-Rubella (MR-1) / MMR-1 – Prevents measles & rubella",
                "✅ JE-1 (Japanese Encephalitis) – In endemic areas",
                "✅ Typhoid Conjugate Vaccine (TCV)",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "12-18 Months (1-1.5 Years)",
              vaccines: [
                "✅ DPT 1st Booster",
                "✅ OPV Booster",
                "✅ MMR-2",
                "✅ Hepatitis A",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "18 Months - 2 Years",
              vaccines: [
                "✅ Typhoid Booster (if not given earlier)",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "2 Years",
              vaccines: [
                "✅ Hepatitis A (2nd dose if required)",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "4-6 Years",
              vaccines: [
                "✅ DPT 2nd Booster",
                "✅ OPV Booster",
                "✅ Varicella (Chickenpox) – Optional",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "10-12 Years",
              vaccines: [
                "✅ Tdap / Td (Tetanus & Diphtheria booster)",
                "✅ HPV (Human Papillomavirus) – For girls (Prevents cervical cancer)",
              ],
            ),
            const SizedBox(height: 20),
            _buildVaccinationSection(
              title: "Optional Vaccines (Recommended by IAP but not in NIS)",
              vaccines: [
                "📌 Flu Vaccine (Annually from 6 months - 5 years) – Prevents influenza",
                "📌 Meningococcal Vaccine – Prevents meningitis",
                "📌 Varicella (Chickenpox) – 2 doses",
                "📌 HPV Vaccine (For girls 9-14 years)",
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a vaccination section
  Widget _buildVaccinationSection({required String title, required List<String> vaccines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 10),
        ...vaccines.map((vaccine) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("• "),
              Expanded(
                child: Text(
                  vaccine,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}


// 📌 Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("assets/images/profile.jpg"),
            ),
            const SizedBox(height: 20),
            const Text("User Name", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            const Text("user@example.com", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// 📌 About Us Page
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Us")),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "This app is designed to help parents keep track of their child's health reminders. It ensures timely vaccinations, check-ups, and other important health-related tasks.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

// 📌 Contact Page
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Us")),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "For any inquiries, please contact us at:\nEmail: support@healthreminder.com\nPhone: +91 6200854150",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}