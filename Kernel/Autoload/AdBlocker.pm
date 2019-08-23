# --
# Copyright (C) 2019–present Efflux GmbH, https://efflux.de/
# Part of the AdBlocker package.
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

use strict;
use warnings;

no warnings 'redefine';

# Disable console command Maint::CloudServices::ConnectionCheck.
{
  use Kernel::System::Console::Command::Maint::CloudServices::ConnectionCheck;
  package Kernel::System::Console::Command::Maint::CloudServices::ConnectionCheck;

  sub Configure {
    my ($Self, %Param) = @_;

    $Self->Description('Disabled by AdBlocker.');

    return;
  }

  sub Run {
    return 0;
  }
}

# Disable console command Maint::OTRSBusiness::AvailabilityCheck.
{
  use Kernel::System::Console::Command::Maint::OTRSBusiness::AvailabilityCheck;
  package Kernel::System::Console::Command::Maint::OTRSBusiness::AvailabilityCheck;

  sub Configure {
    my ($Self, %Param) = @_;

    $Self->Description('Disabled by AdBlocker.');

    return;
  }

  sub Run {
    return 0;
  }
}

# Disable console command Maint::OTRSBusiness::EntitlementCheck.
{
  use Kernel::System::Console::Command::Maint::OTRSBusiness::EntitlementCheck;
  package Kernel::System::Console::Command::Maint::OTRSBusiness::EntitlementCheck;

  sub Configure {
    my ($Self, %Param) = @_;

    $Self->Description('Disabled by AdBlocker.');

    return;
  }

  sub Run {
    return 0;
  }
}

# Pretend that business solution is installed.
{
  use Kernel::System::OTRSBusiness;
  package Kernel::System::OTRSBusiness;

  sub OTRSBusinessIsInstalled {
    my ($Self, %Param) = @_;

    return 1;
  }
}

# Pretend that cloud services are enabled. Can't be done over css, because there is no unique selector for AdminPackageManager. 
{
  use Kernel::Modules::AdminPackageManager;
  package Kernel::Modules::AdminPackageManager;

  sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {%Param};
    bless( $Self, $Type );

    $Self->{CloudServicesDisabled} = 0;  # Hide warning.

    return $Self;
  }
}

# Don't check for 'verified' packages in AdminPackageManager. Can't be done over css, because there is no unique selector for AdminPackageManager and the notification.
{
  use Kernel::System::Package;
  package Kernel::System::Package;

  sub PackageVerifyAll {  # List view.
    return (); 
  }

  sub PackageVerify {  # Detailed package view.
    return 'verified';
  }
}

1;
