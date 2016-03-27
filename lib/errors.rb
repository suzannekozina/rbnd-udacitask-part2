module UdaciListErrors
  class InvalidItemTypeError < StandardError 
  end
  class IndexExceedsListSizeError < StandardError
  end
  class InvalidPriorityValueError < StandardError
  end
end
