class Debt < ActiveRecord::Base  #TODO create migration to prevent nulls on originating debt
  
  ## Hooks
  belongs_to :debtor, touch: true 
  has_many :mail_logs, dependent: :restrict_with_exception
  #has_many :payment_plans
  #Dependend Destroy means:
  # if Debtor is erase so are all the debts associeated with.
  
  ## REGEX
  VALID_NUM_REGEX = /\A[[:digit:]]+\.?[[:digit:]]*\z/
  VALID_PERMIT_REGEX = \
    /\A[[:alpha:]]{2}-?[[:alpha:]]{2}-?[0-9]{2}-?[0-9]{2}-?[0-9]{2}-?[0-9]{1}\z/i
  VALID_INFRACTION_REGEX = /\A[[:alpha:]]-?[0-9]{2}-?[0-9]{2}-?[0-9]{3}-?[[:alpha:]]{2}\z/i
  VALID_PERMIT_OR_INFRACTION_REGEX = \
    /\A([[:alpha:]]{2}-?[[:alpha:]]{2}-?[0-9]{2}-?[0-9]{2}-?[0-9]{2}-?[0-9]{1})|([[:alpha:]]-?[0-9]{2}-?[0-9]{2}-?[0-9]{3}-?[[:alpha:]]{2})\z/i
  VALID_DATE_REGEX = \
    /([0-9]{1,2}(\/?|-?)[0-9]{1,2}(\/?|-?)[0-9]{4}|[0-9]{4}(\/?|-?)[0-9]{1,2}(\/?|-?)[0-9]{1,2})/
  VALID_ROUTING_NUM_REGEX =/\A([0-9]{9}\z|\z)/
  
  ## Validations
  # validates :transaction_contact_person, length: {maximum: 144}
  validates :debtor_id, presence: true
  validates :original_debt_date, presence: true, format: { with: VALID_DATE_REGEX, 
            message: "Debe ser una fecha."}
  validates :amount_owed_pending_balance, format: { with: VALID_NUM_REGEX, 
            message: "Debe ser un número."}
  validates :bounced_check_number, format: { with: /\A[[:digit:]]*\z/i, 
            message: "Debe ser un número."}
  validates :permit_infraction_number, format: { with: VALID_PERMIT_OR_INFRACTION_REGEX, 
            message: "Debe ser un número de multa o permiso."}, 
            unless: Proc.new { |debt_ex| debt_ex.permit_infraction_number.blank? }
  validates :bank_routing_number, format: { with: VALID_ROUTING_NUM_REGEX,
            message: "Deber ser un numero de nueve (9) digitos o estar en blanco. " }
  
  ## Methods
  def find_debtor_name(debtor_id)
    debtor = Debtor.find_by_id(debtor_id)
    debtor.nil? ? 'NULL' : debtor.name
  end
   
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names + [:debtor_name]
      all.each do |debt_record|
        debtor_name = debt_record.find_debtor_name(debt_record.attributes["debtor_id"])
        csv << (debt_record.attributes.values_at(*column_names) << debtor_name)
      end
    end
  end

  private
  
    def self.to_plain_csv(options = {}) #For portability of code only.
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |debt_record|
          csv << debt_record.attributes.values_at(*column_names)
        end
      end
    end
  
end
