FactoryGirl.define do
  factory :cart do
    name 'Test Cart needing approval'
    status 'pending'

    factory :cart_with_approval_group do
      after :create do |cart|
        approval_group = FactoryGirl.create(:approval_group_with_approver_and_requester_approvals)

        cart.approval_group = approval_group
        cart.save
      end
    end

    factory :cart_with_approvals do
      after :create do |cart|
        approver1 = FactoryGirl.create(:user, email_address: 'approver1@some-dot-gov.gov', first_name: 'Liono', last_name: 'Approver1')
        approver2 = FactoryGirl.create(:user, email_address: 'approver2@some-dot-gov.gov', first_name: 'Liono', last_name: 'Approver2')
        requester = FactoryGirl.create(:user, email_address: 'requester@some-dot-gov.gov', first_name: 'Liono', last_name: 'Requester')

        cart.approvals << FactoryGirl.create(:approval, role: 'approver', user_id: approver1.id)
        cart.approvals << FactoryGirl.create(:approval, role: 'approver', user_id: approver2.id)
        cart.approvals << FactoryGirl.create(:approval, role: 'requester', user_id: requester.id)
        cart.save
      end
    end

    factory :cart_with_approvals_and_items do
      after :create do |cart|
        approver1 = FactoryGirl.create(:user, email_address: 'approver3@some-dot-gov.gov', first_name: 'Liono', last_name: 'Approver1')
        approver2 = FactoryGirl.create(:user, email_address: 'approver4@some-dot-gov.gov', first_name: 'Liono', last_name: 'Approver2')
        requester = FactoryGirl.create(:user, email_address: 'requester2@some-dot-gov.gov', first_name: 'Liono', last_name: 'Requester')

        cart.approvals << FactoryGirl.create(:approval, role: 'approver', user_id: approver1.id)
        cart.approvals << FactoryGirl.create(:approval, role: 'approver', user_id: approver2.id)
        cart.approvals << FactoryGirl.create(:approval, role: 'requester', user_id: requester.id)
        cart.cart_items << FactoryGirl.create(:cart_item, cart_id: cart.id)
        cart.cart_items << FactoryGirl.create(:cart_item, cart_id: cart.id,vendor: "Spud Vendor")
        cart.cart_items[0].cart_item_traits << FactoryGirl.create(:cart_item_trait,name: 'socio',value: "wso")
        cart.cart_items[0].cart_item_traits << FactoryGirl.create(:cart_item_trait,name: 'features',value: "spud")
        cart.save
      end
    end

  end
end
