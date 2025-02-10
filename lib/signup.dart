import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  DateTime? selectedDate;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    await Permission.camera.request();
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        SnackBar(content: Text("Try Agian"));
      }
    } catch (e) {
      //print("Error picking image: $e");
      SnackBar(content: Text("Error,Try Again"));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick image. Please try again.")),
      );
    }
  }

  String selectedCountryCode = '+91';

  final _formKey = GlobalKey<FormState>();
  String? _nameError;
  String? _mailError;
  String? _phoneError;
  String? _ephoneError;
  String? _genderError;
  String? _maritalError;
  String? _heightError;
  String? _weightError;
  String? _locationError;
  String? _bgError;
  DateTime? _selectedDate;
  String? _dateError;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 249, 254, 1),
      appBar: AppBar(
        title: const Text("Complete Your Profile",
        style: TextStyle(color: Color.fromRGBO(72, 66, 109, 1),
        fontFamily: 'Outfit',
        fontWeight: FontWeight.w400),

        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'outfit',
                  color: Color.fromRGBO(72, 66, 109, 1),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              const Text(
                'Help us get to know you better—provide your basic\ndetails for a more personalized experience.',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'outfit',
                  color: Color.fromRGBO(102, 112, 133, 1),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),

              Center(
                child: Stack(
                  children: [
                    // Profile Image
                    ClipOval(
                      child: _image == null
                          ? Image.asset(
                              'assets/img.png',
                              height: 138,
                              width: 138,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _image!,
                              height: 138,
                              width: 138,
                              fit: BoxFit.cover,
                            ),
                    ),

                    // Camera Icon Positioned at Bottom-Right
                    Positioned(
                      bottom: 5, // Adjust position
                      right: 5,
                      child: GestureDetector(
                        onTap:
                            _showImagePicker, // Calls function to pick image// Adjust position
                        child: ClipOval(
                          child: Container(
                            color: Colors
                                .white, // Optional background for better visibility
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              "assets/camera.png",
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full Name'),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0XFFDADCDF)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(60),
                            TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                String text = newValue.text;
                                if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
                                  text = text[0].toUpperCase() + text.substring(1);
                                  return newValue.copyWith(
                                    text: text,
                                    selection: TextSelection.collapsed(offset: text.length),
                                  );
                                }
                                return newValue;
                              },
                            ),
                          ],
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                            border: InputBorder.none,
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            // Validate the input as it is typed
                            if (value == null || value.isEmpty) {
                              setState(
                                      () => _nameError = 'Please enter your name');
                            } else if (!RegExp(r'^[a-zA-Z\s]+$')
                                .hasMatch(value)) {
                              setState(() => _nameError =
                              'Name should not contain numbers or special characters');
                            } else {
                              setState(() => _nameError = null);
                            }
                            return null; // Return null when the input is valid
                          },
                          onChanged: (value) {
                            // Trigger validation immediately while typing
                            setState(() {
                              // If the value is invalid, show an error
                              _nameError = (value.isEmpty)
                                  ? 'Please enter your name'
                                  : (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value))
                                  ? 'Name should not contain numbers or special characters'
                                  : null;
                            });
                          },
                        ),
                      ),
                    ),
                    // Show error message below the TextField immediately
                    if (_nameError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _nameError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),

              SizedBox(height: 20),

                    //Enter E-mail

                    Text('Email Address'),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0XFFDADCDF)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40),
                          ],
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            border: InputBorder.none,
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(
                                  () => _mailError = 'Please enter an email.');
                            } else if (!value.contains('@')) {
                              setState(
                                  () => _mailError = 'Email must contain "@"');
                            } else if (!value.endsWith('.com')) {
                              setState(() =>
                                  _mailError = 'Email should end with .com');
                            } else {
                              setState(() => _mailError = null);
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _mailError = (value.isEmpty)
                                  ? 'Please enter an email.'
                                  : (!value.contains('@'))
                                  ? 'Email must contain @.'
                                  : (!value.contains('.com'))
                                  ? 'Please enter a valid email.'
                                  : null;
                            });
                          },
                        ),
                      ),
                    ),
                    if (_mailError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _mailError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    SizedBox(height: 20),

                    // Phone Number

                    Text('Phone Number'),
                    SizedBox(height: 5),
                    Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Color(0XFFDADCDF)),
                    ),
                    child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Row(
                    children: [
                    // Country Code Dropdown
                    Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: DropdownButton<String>(
                    value: selectedCountryCode, // Default country code (India)
                    items: [
                    '+1', '+44', '+91', '+61', '+81', '+33', '+49', '+86', '+55', '+34', '+39'
                    ].map((String code) {
                    return DropdownMenuItem<String>(
                    value: code,
                    child: Text(
                    code,
                    style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(72, 66, 109, 1),
                    ),
                    ),
                    );
                    }).toList(),
                    onChanged: (String? newCode) {
                        setState(() {
                          selectedCountryCode = newCode ?? '+91'; // Update selected code
                        });
                      },

                    underline: Container(),
                      isExpanded: false, // Prevents dropdown from expanding too wide
                      iconSize: 18.0, // Icon size adjustment
                      iconEnabledColor: Color.fromRGBO(72, 66, 109, 1),
                    ),
                    ),
                    // Editable TextFormField for the phone number
                    Expanded(
                    child: TextFormField(
                    inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    border: InputBorder.none,
                    hintText: 'Enter your mobile number',
                    hintStyle: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    ),
                    ),
                    validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    setState(() => _phoneError =
                                        'Please enter a phone number');
                                  } else if (!RegExp(r'^\d{10}$')
                                      .hasMatch(value)) {
                                    setState(() => _phoneError =
                                        'Enter a valid 10-digit phone number');
                                  } else {
                                    setState(() => _phoneError =
                                        null); // Clear error if valid
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _phoneError = (value.isEmpty)
                                        ? 'Please enter your phone number.'
                                        : (!RegExp(r'^\d{10}$').hasMatch(value))
                                        ? 'Enter a valid 10-digit phone number'
                                        : null;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (_phoneError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _phoneError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    SizedBox(height: 20),

                    Text('Gender'),
                    SizedBox(height: 5), // Spacing before gender field
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Color(0XFFDADCDF),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: DropdownButtonFormField<String>(
                          style: TextStyle(
                            fontFamily:
                                'Outfit', // Ensure font family is the same
                            fontSize: 14, // Ensure font size is the same
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            border: InputBorder.none,
                            hintText: 'Select gender',
                            hintStyle: TextStyle(
                              fontFamily:
                                  'Outfit', // Ensure font family is the same
                              fontSize: 14, // Ensure font size is the same
                              fontWeight: FontWeight
                                  .w300, // Match font weight to 'Enter your mobile number'
                              color: Colors.grey,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'Male',
                              child: Text(
                                'Male',
                                style: TextStyle(
                                    fontFamily: 'Outfit', fontSize: 14),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Female',
                              child: Text(
                                'Female',
                                style: TextStyle(
                                    fontFamily: 'Outfit', fontSize: 14),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              // selectedGender = value; // Update selected gender
                              _genderError =
                                  null; // Clear error message if user selects an option
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                _genderError =
                                    'Please select a gender'; // Show error if no option is selected
                              });
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    if (_genderError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _genderError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),

                    SizedBox(height: 20), // Spacing after gender field

                    // Date of Birth

                    Text('Date of Birth'),
                    SizedBox(height: 5), // Spacing before date of birth field
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Color(0XFFDADCDF),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate ?? DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null && picked != _selectedDate) {
                              setState(() {
                                _selectedDate = picked;
                                _dateError =
                                    null; // Clear error when a date is selected
                              });
                            }
                          },

                          readOnly:
                              true, // Makes the field non-editable by keyboard
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            border: InputBorder.none,
                            hintText: _selectedDate != null
                                ? '${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}'
                                : 'Select Date',
                            hintStyle: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (_selectedDate == null) {
                              // Setting error message manually
                              setState(() {
                                _dateError = 'Please select a date';
                              });
                              return null; 
                            }
                            return null; // Return null if valid
                          },
                        ),
                      ),
                    ),

                    if (_dateError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _dateError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    SizedBox(height: 20), // Spacing after date field
                 
              Text('Blood Group'),
              SizedBox(height: 5), // Spacing before the blood group field

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Color(0XFFDADCDF),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontFamily: 'Outfit', fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      border: InputBorder.none,
                      hintText: 'Select Blood Group',
                      hintStyle: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'A+',
                        child: Text(
                          'A+',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'A-',
                        child: Text(
                          'A-',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'B+',
                        child: Text(
                          'B+',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'B-',
                        child: Text(
                          'B-',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'O+',
                        child: Text(
                          'O+',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'O-',
                        child: Text(
                          'O-',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'AB+',
                        child: Text(
                          'AB+',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'AB-',
                        child: Text(
                          'AB-',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        // selectedGender = value; // Update selected gender
                        _bgError =
                        null; // Clear error message if user selects an option
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _bgError =
                          'Please select a blood group.'; // Show error if no option is selected
                        });
                      }
                      return null;
                    },
                  ),
                ),
              ),
                    if (_bgError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _bgError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
              SizedBox(height: 20),

              // Marital Status

              Text('Marital Status'),
              SizedBox(height: 5), // Spacing before marital status field
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Color(0XFFDADCDF),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontFamily: 'Outfit', fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      border: InputBorder.none,
                      hintText: 'Select Marital Status',
                      hintStyle: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'Single',
                        child: Text(
                          'Single',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Married',
                        child: Text(
                          'Married',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Widowed',
                        child: Text(
                          'Widowed',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Divorced',
                        child: Text(
                          'Divorced',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {

                        _maritalError =
                        null; // Clear error message if user selects an option
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _maritalError =
                          'Please select a marital status.'; // Show error if no option is selected
                        });
                      }
                      return null;
                    },
                  ),
                ),
              ),
                    if (_maritalError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _maritalError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
              SizedBox(height: 20), // Spacing after name field

              Text(
                'Height',
                // You can still add custom styling or uncomment the TextStyle section if you want
              ),

              SizedBox(height: 5), // Spacing before height field

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Color(0XFFDADCDF),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontFamily: 'Outfit', fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      border: InputBorder.none,
                      hintText: 'Select Height',
                      hintStyle: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: '150 cm',
                        child: Text(
                          '150 cm',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '155 cm',
                        child: Text(
                          '155 cm',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '160 cm',
                        child: Text(
                          '160 cm',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '165 cm',
                        child: Text(
                          '165 cm',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '170 cm',
                        child: Text(
                          '170 cm',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '175 cm',
                        child: Text(
                          '175 cm',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '180 cm',
                        child: Text(
                          '180 cm',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '185 cm',
                        child: Text(
                          '185 cm',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '190 cm',
                        child: Text(
                          '190 cm',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {

                        _heightError =
                        null; // Clear error message if user selects an option
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _heightError =
                          'Please select a height.'; // Show error if no option is selected
                        });
                      }
                      return null;
                    },
                  ),
                ),
              ),
                    if (_heightError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _heightError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
              SizedBox(height: 20), // Spacing after name field

              Text('Weight'),
              SizedBox(height: 5), // Spacing before weight field

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Color(0XFFDADCDF),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(
                        fontFamily: 'Outfit', fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      border: InputBorder.none,
                      hintText: 'Select Weight',
                      hintStyle: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: '40 kg',
                        child: Text(
                          '40 kg',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '45 kg',
                        child: Text(
                          '45 kg',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '50 kg',
                        child: Text(
                          '50 kg',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '55 kg',
                        child: Text(
                          '55 kg',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '60 kg',
                        child: Text(
                          '60 kg',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '65 kg',
                        child: Text(
                          '65 kg',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '70 kg',
                        child: Text(
                          '70 kg',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '75 kg',
                        child: Text(
                          '75 kg',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '80 kg',
                        child: Text(
                          '80 kg',
                          style: TextStyle(fontFamily: 'Outfit', fontSize: 14),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {

                        _weightError =
                        null; // Clear error message if user selects an option
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          _weightError =
                          'Please select a weight.'; // Show error if no option is selected
                        });
                      }
                      return null;
                    },
                  ),
                ),
              ),
                    if (_weightError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _weightError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
              SizedBox(height: 20), // Spacing after weight field

                    // Emergency Contact Number

              Text('Emergency Contact'),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0XFFDADCDF)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            // Country Code Dropdown
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: DropdownButton<String>(
                                value: selectedCountryCode, // Default country code (India)
                                items: [
                                  '+1', '+44', '+91', '+61', '+81', '+33', '+49', '+86', '+55', '+34', '+39'
                                ].map((String code) {
                                  return DropdownMenuItem<String>(
                                    value: code,
                                    child: Text(
                                      code,
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(72, 66, 109, 1),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newCode) {
                                  setState(() {
                                    selectedCountryCode = newCode ?? '+91'; // Update selected code
                                  });
                                },

                                underline: Container(),
                                isExpanded: false, // Prevents dropdown from expanding too wide
                                iconSize: 18.0, // Icon size adjustment
                                iconEnabledColor: Color.fromRGBO(72, 66, 109, 1),
                              ),
                            ),
                            // Editable TextFormField for the phone number
                            Expanded(
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                                  border: InputBorder.none,
                                  hintText: 'Enter your mobile number',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() =>
                                  _ephoneError = 'Please enter a phone number');
                            } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              setState(() => _ephoneError =
                                  'Enter a valid 10-digit phone number');
                            } else {
                              setState(() =>
                                  _ephoneError = null); // Clear error if valid
                            }
                            return null; // Prevent internal error message
                          },
                          onChanged: (value) {
                            setState(() {
                              _ephoneError = (value.isEmpty)
                                  ? 'Please enter your phone number.'
                                  : (!RegExp(r'^\d{10}$').hasMatch(value))
                                  ? 'Enter a valid 10-digit phone number'
                                  : null;// Clear error message on change
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (_ephoneError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _ephoneError!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              SizedBox(height: 20), // Spacing after phone field

              Text(
                'Location',
                // style: TextStyle(
                // fontSize: 16,
                // fontWeight: FontWeight.w500, // Medium weight for label
                // ),
              ),

              SizedBox(height: 5), // Spacing before email field

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Color(0XFFDADCDF),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          30), // Allows more characters for email
                    ],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      border: InputBorder.none,
                      hintText: 'Enter Location',
                      hintStyle: TextStyle(
                        fontFamily: 'Outfit', // Set font family
                        fontSize: 14, // Font size 14
                        fontWeight: FontWeight.w400, // Font weight 400
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        setState(() =>
                        _locationError = 'Please enter a valid location.');
                      } else if (RegExp(r'[^a-zA-Z0-9\s,-]').hasMatch(value)) {
                        setState(() =>
                        _locationError =  'Location should contain only letters and spaces');
                      }
                      return null; // If validation passes, return null
                    },
                    onChanged: (value) {
                      setState(() {
                        _locationError = (value.trim().isEmpty)
                            ? 'Please enter a valid location.'
                            : (RegExp(r'[^a-zA-Z0-9\s,-]').hasMatch(value))
                            ? 'Please enter a valid location.'
                            : null;// Clear error message on change
                      });
                    },
                  ),
                ),
              ),
                    if (_locationError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _locationError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),

              SizedBox(height: 20),
 ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: 363,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(
                              child: Text(
                                "Form Submitted",
                                style: TextStyle(color: Colors.white,

                                ),
                              ),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        // print('Form is valid');
                        setState(() {
                          // _mailError = null;
                        });

                      } else {
                        setState(() {
                          //_nameError = null;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please fix the errors in the form.",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromRGBO(72, 66, 109, 1), // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
