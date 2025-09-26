import 'package:flutter/material.dart';

class StepperDemo extends StatefulWidget {
  const StepperDemo({super.key});

  @override
  State<StepperDemo> createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int currentStep = 0;
  List<bool> completedSteps = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: currentStep,
      controlsBuilder: (context, details) {
        return Row(
          children: [
            if (details.stepIndex < 2)
              ElevatedButton(
                onPressed: details.onStepContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Next'),
              ),
            const SizedBox(width: 8),
            if (details.stepIndex > 0)
              TextButton(
                onPressed: details.onStepCancel,
                child: const Text('Back'),
              ),
          ],
        );
      },
      onStepTapped: (step) {
        setState(() {
          currentStep = step;
        });
      },
      onStepContinue: () {
        if (currentStep < 2) {
          setState(() {
            completedSteps[currentStep] = true;
            currentStep++;
          });
        }
      },
      onStepCancel: () {
        if (currentStep > 0) {
          setState(() {
            currentStep--;
          });
        }
      },
      steps: [
        Step(
          title: const Text('Account Setup'),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create your account with basic information.'),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          isActive: currentStep == 0,
          state: completedSteps[0] 
              ? StepState.complete 
              : currentStep == 0 
                  ? StepState.editing 
                  : StepState.indexed,
        ),
        Step(
          title: const Text('Profile Details'),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add your profile information.'),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          isActive: currentStep == 1,
          state: completedSteps[1] 
              ? StepState.complete 
              : currentStep == 1 
                  ? StepState.editing 
                  : StepState.indexed,
        ),
        Step(
          title: const Text('Verification'),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Verify your account via email.'),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Check your email for verification link'),
                ],
              ),
            ],
          ),
          isActive: currentStep == 2,
          state: completedSteps[2] 
              ? StepState.complete 
              : currentStep == 2 
                  ? StepState.editing 
                  : StepState.indexed,
        ),
      ],
    );
  }
}