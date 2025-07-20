import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../services/payment_service.dart';

/// Contribute to community security screen with payment options
class ContributeScreen extends StatefulWidget {
  const ContributeScreen({super.key});

  @override
  State<ContributeScreen> createState() => _ContributeScreenState();
}

class _ContributeScreenState extends State<ContributeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _paymentService = PaymentService();
  
  PaymentMethod _selectedPaymentMethod = PaymentMethod.mobileMoney;
  bool _isProcessing = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.contributeTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.1),
                      AppColors.success.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.security,
                      size: 48,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Support Community Safety',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your contribution helps fund community security initiatives, patrol services, and emergency response programs.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Amount Section
              Text(
                AppStrings.amount,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  hintText: AppStrings.enterAmount,
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.requiredField;
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return AppStrings.invalidAmount;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Quick Amount Buttons
              Row(
                children: [
                  Expanded(child: _buildQuickAmountButton('10')),
                  const SizedBox(width: 8),
                  Expanded(child: _buildQuickAmountButton('25')),
                  const SizedBox(width: 8),
                  Expanded(child: _buildQuickAmountButton('50')),
                  const SizedBox(width: 8),
                  Expanded(child: _buildQuickAmountButton('100')),
                ],
              ),
              const SizedBox(height: 24),
              
              // Payment Method Section
              Text(
                AppStrings.paymentMethod,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              
              // Payment Method Options
              ..._paymentService.getAvailablePaymentMethods().map((method) {
                return _buildPaymentMethodOption(method);
              }),
              
              const SizedBox(height: 32),
              
              // Process Payment Button
              ElevatedButton(
                onPressed: _isProcessing ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonSecondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.textLight,
                          ),
                        ),
                      )
                    : Text(
                        AppStrings.processPayment,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              
              // Disclaimer
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.info.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.info,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This is a demo payment flow. No actual charges will be made. Future versions will integrate with Flutterwave and MPesa.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAmountButton(String amount) {
    return OutlinedButton(
      onPressed: () {
        _amountController.text = amount;
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8),
      ),
      child: Text('\$$amount'),
    );
  }

  Widget _buildPaymentMethodOption(PaymentMethod method) {
    final isSelected = _selectedPaymentMethod == method;
    final displayName = _paymentService.getPaymentMethodDisplayName(method);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPaymentMethod = method;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.divider,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
            color: isSelected 
                ? AppColors.primary.withOpacity(0.05)
                : AppColors.cardBackground,
          ),
          child: Row(
            children: [
              Icon(
                _getPaymentMethodIcon(method),
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  displayName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getPaymentMethodIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.mobileMoney:
        return Icons.phone_android;
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.bankTransfer:
        return Icons.account_balance;
    }
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    final amount = double.parse(_amountController.text);
    
    try {
      final result = await _paymentService.processPayment(
        amount: amount,
        method: _selectedPaymentMethod,
      );

      setState(() {
        _isProcessing = false;
      });

      if (result.success) {
        _showSuccessDialog(result);
      } else {
        _showErrorDialog(result.message);
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      _showErrorDialog('Payment processing failed: $e');
    }
  }

  void _showSuccessDialog(PaymentResult result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.paymentSuccess,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              result.message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (result.transactionId != null) ...[
              const SizedBox(height: 12),
              Text(
                'Transaction ID: ${result.transactionId}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetForm();
            },
            child: const Text(AppStrings.ok),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Payment Failed',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.ok),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    _amountController.clear();
    setState(() {
      _selectedPaymentMethod = PaymentMethod.mobileMoney;
    });
  }
}