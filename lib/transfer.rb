class Transfer

  attr_accessor :sender, :receiver, :amount
  attr_reader :status


  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @transaction_record = []
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @amount > @sender.balance
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    elsif @status == "pending"
      @sender.balance -= @amount
      @receiver.balance += @amount
      @receiver.balance
      @status = "complete"
      @transaction_record << @amount
    else
      @status == "rejected"
    end
  end

  def reverse_transfer
    if !@transaction_record.empty?
      returned_amount = @transaction_record.last
      @sender.balance += returned_amount
      @receiver.balance -= returned_amount
      @status = "reversed"
      @transaction_record.pop
    end
  end


end



# Transfers start out in a "pending" status. They can be executed and go to a "complete" state.
# They can also go to a "rejected" status. A completed transfer can also be reversed and go into a
# "reversed" status.
