class PayoutData {
  final String sellerEmail;
  final String delivererEmail;
  final double sellerAmount;
  final double delivererAmount;
  final String orderId;

  PayoutData({
    required this.sellerEmail,
    required this.delivererEmail,
    required this.sellerAmount,
    required this.delivererAmount,
    required this.orderId,
  });

  Map<String, dynamic> toJson() {
    return {
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
        },
        {
          "recipient_type": "EMAIL",
          "receiver": delivererEmail,
          "amount": {
            "value": delivererAmount.toStringAsFixed(2),
            "currency": "USD"
          },
          "note": "Delivery Payment for Order $orderId",
          "sender_item_id": "DeliveryPayment-$orderId"
        }
      ]
    };
  }
}
