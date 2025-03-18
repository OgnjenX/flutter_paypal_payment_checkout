import 'delivery_payout.dart';

class PayoutData {
  final String sellerEmail;
  final double sellerAmount;
  final String orderId;
  final DeliveryPayout? delivery;

  PayoutData({
    required this.sellerEmail,
    required this.sellerAmount,
    required this.orderId,
    this.delivery,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> payoutData = {
      "sender_batch_header": {
        "sender_batch_id":
            "Payout-$orderId-${DateTime.now().millisecondsSinceEpoch}",
        "email_subject": "Payment from OnlyFarms",
      },
      "items": [
        {
          "recipient_type": "EMAIL",
          "receiver": sellerEmail,
          "amount": {
            "value": sellerAmount.toStringAsFixed(2),
            "currency": "USD"
          },
          "note": "Payment for Order $orderId",
          "sender_item_id": "SellerPayment-$orderId"
        }
      ]
    };

    // Add delivery payout if present
    if (delivery != null) {
      payoutData["items"].add({
        "recipient_type": "EMAIL",
        "receiver": delivery!.email,
        "amount": {
          "value": delivery!.amount.toStringAsFixed(2),
          "currency": "USD"
        },
        "note": "Delivery Payment for Order $orderId",
        "sender_item_id": "DeliveryPayment-$orderId"
      });
    }

    return payoutData;
  }
}
