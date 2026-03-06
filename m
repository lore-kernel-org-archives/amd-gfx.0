Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6C5F01838
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 14:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17CB10ED48;
	Fri,  6 Mar 2026 14:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k8bsKCJl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A195A10E1EC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772801061; x=1804337061;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=Tq1d43LGzegHgS7nbs7ynJ8NqJPbG38gDZGWn7nBmhU=;
 b=k8bsKCJlcHdl38VS0SQaNeWvdFRSVfeCNuSYUPfyF/wMb7ng5JB3pguW
 /XkgmFgWLPtWQ6PjdG4VFrec2ZoY3TVKo5z0cVJXY/vV00AWniEFdcodN
 EiR51z1Llz1J22EKevkwph14FM9QCdieMtvBXZ7rfyHfOvmjyoO7gM7ro
 i+z+0aGV+FQ+OIPTC691b9dN//0WWZKjpha8sYxbwJGBkpp9wJWM9pCvT
 ReVd4Zq+6Ro6hJiM7vPAaVLvjJuUNtKmcsU2oYNb1L6S5UM0+p6hiYT4S
 NqPhH5JtQ1Uk+xfmv1Z/d22AS8osey84VTfTLvTPeiSp86+uP/tFzdWR7 w==;
X-CSE-ConnectionGUID: MqPn0K7XRuegvOwL8zefhg==
X-CSE-MsgGUID: SBWX+V7SQ92yA/JLfX8XSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77777582"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="77777582"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 04:44:20 -0800
X-CSE-ConnectionGUID: OtofVhFTTyOSIeT4q7K2KA==
X-CSE-MsgGUID: MGdmFMJNQ6aArM44PPNKoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="223123793"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.235])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 04:44:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Mar 2026 14:44:12 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Linux ACPI <linux-acpi@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
 platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v1 9/9] ACPI: AC: Define ACPI_AC_CLASS in one place
In-Reply-To: <2787819.X9hSmTKtgW@rafael.j.wysocki>
Message-ID: <ba409fad-7b2e-6fb1-eeee-8d9cacf4cb74@linux.intel.com>
References: <4505861.ejJDZkT8p0@rafael.j.wysocki>
 <2787819.X9hSmTKtgW@rafael.j.wysocki>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-151852091-1772801052=:1000"
X-Mailman-Approved-At: Fri, 06 Mar 2026 14:00:04 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-151852091-1772801052=:1000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Mar 2026, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> The ACPI_AC_CLASS symbol is defined in several places in the same way
> which is rather unfortunate.
>=20
> Instead, define it in one common header file (acpi_bus.h) that is
> already included by all of its users.

It's a bit misleading to say it like that as acpi_bus.h is included only=20
through another include (at least acpi/acpi.h) for most of the=20
cases.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/ac.c                         |    1 -
>  drivers/acpi/sbs.c                        |    1 -
>  drivers/gpu/drm/amd/include/amd_acpi.h    |    2 --
>  drivers/gpu/drm/radeon/radeon_acpi.c      |    2 --
>  drivers/platform/x86/hp/hp-wmi.c          |    2 --
>  drivers/platform/x86/lenovo/wmi-capdata.c |    1 -
>  include/acpi/acpi_bus.h                   |    2 ++
>  7 files changed, 2 insertions(+), 9 deletions(-)
>=20
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -21,7 +21,6 @@
>  #include <linux/acpi.h>
>  #include <acpi/battery.h>
> =20
> -#define ACPI_AC_CLASS=09=09=09"ac_adapter"
>  #define ACPI_AC_FILE_STATE=09=09"state"
>  #define ACPI_AC_NOTIFY_STATUS=09=090x80
>  #define ACPI_AC_STATUS_OFFLINE=09=090x00
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -26,7 +26,6 @@
> =20
>  #include "sbshc.h"
> =20
> -#define ACPI_AC_CLASS=09=09=09"ac_adapter"
>  #define ACPI_SBS_DEVICE_NAME=09=09"Smart Battery System"
>  #define ACPI_BATTERY_DIR_NAME=09=09"BAT%i"
>  #define ACPI_AC_DIR_NAME=09=09"AC0"
> --- a/drivers/gpu/drm/amd/include/amd_acpi.h
> +++ b/drivers/gpu/drm/amd/include/amd_acpi.h
> @@ -26,8 +26,6 @@
> =20
>  #include <linux/types.h>
> =20
> -#define ACPI_AC_CLASS           "ac_adapter"
> -
>  struct atif_verify_interface {
>  =09u16 size;=09=09/* structure size in bytes (includes size field) */
>  =09u16 version;=09=09/* version */
> --- a/drivers/gpu/drm/radeon/radeon_acpi.c
> +++ b/drivers/gpu/drm/radeon/radeon_acpi.c
> @@ -44,8 +44,6 @@ bool radeon_atpx_dgpu_req_power_for_disp
>  static inline bool radeon_atpx_dgpu_req_power_for_displays(void) { retur=
n false; }
>  #endif
> =20
> -#define ACPI_AC_CLASS           "ac_adapter"
> -
>  struct atif_verify_interface {
>  =09u16 size;=09=09/* structure size in bytes (includes size field) */
>  =09u16 version;=09=09/* version */
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -58,8 +58,6 @@ enum hp_ec_offsets {
>  #define HP_POWER_LIMIT_DEFAULT=09 0x00
>  #define HP_POWER_LIMIT_NO_CHANGE 0xFF
> =20
> -#define ACPI_AC_CLASS "ac_adapter"
> -
>  #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when=
 zero insize is required
> =20
>  enum hp_thermal_profile_omen_v0 {
> --- a/drivers/platform/x86/lenovo/wmi-capdata.c
> +++ b/drivers/platform/x86/lenovo/wmi-capdata.c
> @@ -53,7 +53,6 @@
>  #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE01=
8154"
>  #define LENOVO_FAN_TEST_DATA_GUID "B642801B-3D21-45DE-90AE-6E86F164FB21"
> =20
> -#define ACPI_AC_CLASS "ac_adapter"
>  #define ACPI_AC_NOTIFY_STATUS 0x80
> =20
>  #define LWMI_FEATURE_ID_FAN_TEST 0x05
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -613,6 +613,8 @@ struct acpi_bus_event {
>  =09u32 data;
>  };
> =20
> +#define ACPI_AC_CLASS=09"ac_adapter"
> +
>  extern struct kobject *acpi_kobj;
>  extern int acpi_bus_generate_netlink_event(const char*, const char*, u8,=
 int);
>  void acpi_bus_private_data_handler(acpi_handle, void *);

--8323328-151852091-1772801052=:1000--
