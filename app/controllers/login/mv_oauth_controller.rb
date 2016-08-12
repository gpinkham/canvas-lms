#
# Copyright (C) 2015 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

class Login::MvOauthController < Login::Oauth2Controller

  def create
    return unless validate_request

    @aac = AccountAuthorizationConfig.find(jwt['aac_id'])
    raise ActiveRecord::RecordNotFound unless @aac.is_a?(AccountAuthorizationConfig::Oauth2)

    unique_id = nil
    return unless timeout_protection do
      token = @aac.get_token(params[:code], oauth2_login_callback_url)
      unique_id = @aac.unique_id(token)
    end

    find_pseudonym(unique_id)
  end


end
