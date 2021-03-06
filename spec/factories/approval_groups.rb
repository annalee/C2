FactoryGirl.define do
  factory :approval_group do
    name "RobsApprovalGroup"

    factory :approval_group_with_approvers_and_requester do
      after :create do |approval_group|
        approver1 = User.find_by(email_address: 'approver1@some-dot-gov.gov') || FactoryGirl.create(:user, email_address: 'approver1@some-dot-gov.gov')
        approver2 = User.find_by(email_address: 'approver2@some-dot-gov.gov') || FactoryGirl.create(:user, email_address: 'approver2@some-dot-gov.gov')
        requester1 = User.find_by(email_address: 'requester1@some-dot-gov.gov') || FactoryGirl.create(:user, email_address: 'requester1@some-dot-gov.gov', first_name: "Liono", last_name: "Requester")
        UserRole.create!(user_id: approver1.id, approval_group_id: approval_group.id, role: 'approver')
        UserRole.create!(user_id: approver2.id, approval_group_id: approval_group.id, role: 'approver')
        UserRole.create!(user_id: requester1.id, approval_group_id: approval_group.id, role: 'requester')
      end
   end

    factory :approval_group_with_approver_and_requester_approvals do
      after :create do |approval_group|
        approver1 = User.find_by(email_address: 'approver1@some-dot-gov.gov') || FactoryGirl.create(:user, email_address: 'approver1@some-dot-gov.gov')
        approver2 = User.find_by(email_address: 'approver2@some-dot-gov.gov') || FactoryGirl.create(:user, email_address: 'approver2@some-dot-gov.gov')
        requester1 = User.find_by(email_address: 'requester1@some-dot-gov.gov') || FactoryGirl.create(:user, email_address: 'requester1@some-dot-gov.gov')
        UserRole.create!(user_id: approver1.id, approval_group_id: approval_group.id, role: 'approver')
        UserRole.create!(user_id: approver2.id, approval_group_id: approval_group.id, role: 'approver')
        UserRole.create!(user_id: requester1.id, approval_group_id: approval_group.id, role: 'requester')

        Approval.create!(user_id: approver1.id, cart_id: approval_group.cart_id, role: 'approver', status: 'pending')
        Approval.create!(user_id: approver2.id, cart_id: approval_group.cart_id, role: 'approver', status: 'pending')
        Approval.create!(user_id: requester1.id, cart_id: approval_group.cart_id, role: 'requester', status: 'pending')
      end
   end

  end
end
