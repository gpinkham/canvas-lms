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

class AccountAuthorizationConfig::MvOauth < AccountAuthorizationConfig::Oauth2
  include AccountAuthorizationConfig::PluginSettings
  self.plugin = :mv_oauth
  plugin_settings :domain, :client_id, client_secret: :client_secret_dec

  def self.sti_name
    'mv_oauth'.freeze
  end

  def self.display_name
    'MediVector'.freeze
  end

  def self.recognized_params
    [ :login_attribute, :jit_provisioning ].freeze
  end

  # Rename db field
  def domain=(val)
    self.auth_host = val
  end

  def domain
    auth_host
  end

  def unique_id(token)
    token.options[:mode] = :query
    token.get('users/me').parsed[login_attribute].to_s
  end

  def self.login_attributes
    ['email'.freeze, 'login'.freeze].freeze
  end
  validates :login_attribute, inclusion: login_attributes

  def login_attribute
    super || 'email'.freeze
  end

  protected

  def client_options
    {
        site: "http://#{domain}",
        authorize_url: "http://#{domain}/oauth/authorize",
        token_url: "http://#{domain}/oauth/token"
    }
  end

  def inferred_domain
    domain.presence || 'localhost'.freeze
  end
end
