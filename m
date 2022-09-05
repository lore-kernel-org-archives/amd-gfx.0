Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0817C38145
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 07:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1460E10E586;
	Tue,  6 Sep 2022 07:27:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4D310E214
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 08:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662366954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FKWvK74RqhWO5Ba3E7ZgA5XXRtVg9Ah/YW25Q16K5a0=;
 b=W03J9ypy1ohup2A993P5R7LtK4QE6RpB7mVKXX7OqKqXCzuQp/RbGvI1TRXmPyadLfmNA6
 wMGsJ8vwYVb0yiTAEj063xLmRljOKZlqed7+CKoyQsRENxecOKZ+g3Upo7JZTiRVWyN/Do
 hjffQC+rUeUiwWjGBdQdhMByfEEfnkg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-Vjv08M23OLuhIhFwRvwdWw-1; Mon, 05 Sep 2022 04:35:50 -0400
X-MC-Unique: Vjv08M23OLuhIhFwRvwdWw-1
Received: by mail-ed1-f71.google.com with SMTP id
 l19-20020a056402255300b0043df64f9a0fso5448693edb.16
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Sep 2022 01:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date;
 bh=FKWvK74RqhWO5Ba3E7ZgA5XXRtVg9Ah/YW25Q16K5a0=;
 b=Uf9z3T54H4k3b/U92xdMxGYK/xd+d4bgdl4PgKImbQCXXjgoVXm6VLwPz0iDZN4nwL
 lQ1qQKwJWXx0FTz13sSnXulJ1yrcNqwQyYoBU1BQFqs9Zgr1UBweznpnSIbXLxGui5tF
 XK/c3mgnA2G6MSaojBa1ne98g5tjjqp0gM+rmk3+/Eg7Gpd0dJVXfYZCCr2eZx6FPgWW
 dUaIOXUBnGFhnjNz0dRN9FyIXShUFc5s6Pb5iGyErrt6N6cTnFycAbwFdBkUk3Kk2W1/
 LSctajGjHWIZGywhnwc6tRX4TTW3sTojqrbdGTnE6bRj/E6p5EzLVeDOTXb2g5Tlg5xC
 vcpQ==
X-Gm-Message-State: ACgBeo3aED+ZOA7QLFZkvPszXdrIxyNxGxelr6Bri58pMtxRMA0kziGi
 4bWwneLfxAQEBo7rDi+npyDKV5Skb/Cii+F8DHXaoqzbsMY1H/SFAYyXWSQXGNNtHv6sJZIVIYI
 FHw7s6yMtHClfA72aBv16PTcpPg==
X-Received: by 2002:a05:6402:f92:b0:44e:84e0:1d2a with SMTP id
 eh18-20020a0564020f9200b0044e84e01d2amr3153079edb.395.1662366949051; 
 Mon, 05 Sep 2022 01:35:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4VBNuR9PQ8/ymdedcVLZvd83Z5BrbBJNdtbcbD4W3JQHoyQWf8ni6TYgJ7xy7xpT4yxIFbjA==
X-Received: by 2002:a05:6402:f92:b0:44e:84e0:1d2a with SMTP id
 eh18-20020a0564020f9200b0044e84e01d2amr3153055edb.395.1662366948816; 
 Mon, 05 Sep 2022 01:35:48 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
 by smtp.gmail.com with ESMTPSA id
 ee35-20020a056402292300b0044dde9244fdsm3162245edb.8.2022.09.05.01.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Sep 2022 01:35:48 -0700 (PDT)
Message-ID: <261afe3d-7790-e945-adf6-a2c96c9b1eff@redhat.com>
Date: Mon, 5 Sep 2022 10:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] Immutable backlight-detect-refactor branch between acpi,
 drm-* and pdx86
To: Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude <lyude@redhat.com>, Daniel Dadap <ddadap@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xinhui <Xinhui.Pan@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Mark Gross <markgross@kernel.org>,
 Andy Shevchenko <andy@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 06 Sep 2022 07:27:23 +0000
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
Cc: linux-acpi@vger.kernel.org, nouveau@lists.freedesktop.org,
 intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@redhat.com>, Len Brown <lenb@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi All,

Now that all patches have been reviewed/acked here is an immutable backlight-detect-refactor
branch with 6.0-rc1 + the v5 patch-set, for merging into the relevant (acpi, drm-* and pdx86)
subsystems.

Please pull this branch into the relevant subsystems.

I will merge this into the review-hans branch of the pdx86 git tree today and
from there it will move to for-next once the builders have successfully build-tested
the merge.

Regards,

Hans


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/backlight-detect-refactor-1

for you to fetch changes up to 4f96b1bc156e7076f6efedc2a76a8c7e897c7977:

  drm/todo: Add entry about dealing with brightness control on devices with > 1 panel (2022-09-03 12:17:27 +0200)

----------------------------------------------------------------
Immutable backlight-detect-refactor branch between acpi, drm-* and pdx86

Tag (immutable branch) with v6.0-rc1 + the (acpi/x86) backlight
detect refactor work. For merging into the acpi, drm-* and pdx86
subsystems.

----------------------------------------------------------------
Hans de Goede (31):
      ACPI: video: Add acpi_video_backlight_use_native() helper
      drm/i915: Don't register backlight when another backlight should be used (v2)
      drm/amdgpu: Don't register backlight when another backlight should be used (v3)
      drm/radeon: Don't register backlight when another backlight should be used (v3)
      drm/nouveau: Don't register backlight when another backlight should be used (v2)
      ACPI: video: Drop backlight_device_get_by_type() call from acpi_video_get_backlight_type()
      ACPI: video: Remove acpi_video_bus from list before tearing it down
      ACPI: video: Simplify acpi_video_unregister_backlight()
      ACPI: video: Make backlight class device registration a separate step (v2)
      ACPI: video: Remove code to unregister acpi_video backlight when a native backlight registers
      drm/i915: Call acpi_video_register_backlight() (v3)
      drm/nouveau: Register ACPI video backlight when nv_backlight registration fails (v2)
      drm/amdgpu: Register ACPI video backlight when skipping amdgpu backlight registration
      drm/radeon: Register ACPI video backlight when skipping radeon backlight registration
      platform/x86: nvidia-wmi-ec-backlight: Move fw interface definitions to a header (v2)
      ACPI: video: Refactor acpi_video_get_backlight_type() a bit
      ACPI: video: Add Nvidia WMI EC brightness control detection (v3)
      ACPI: video: Add Apple GMUX brightness control detection
      platform/x86: nvidia-wmi-ec-backlight: Use acpi_video_get_backlight_type()
      platform/x86: apple-gmux: Stop calling acpi/video.h functions
      platform/x86: toshiba_acpi: Stop using acpi_video_set_dmi_backlight_type()
      platform/x86: acer-wmi: Move backlight DMI quirks to acpi/video_detect.c
      platform/x86: asus-wmi: Drop DMI chassis-type check from backlight handling
      platform/x86: asus-wmi: Move acpi_backlight=vendor quirks to ACPI video_detect.c
      platform/x86: asus-wmi: Move acpi_backlight=native quirks to ACPI video_detect.c
      platform/x86: samsung-laptop: Move acpi_backlight=[vendor|native] quirks to ACPI video_detect.c
      ACPI: video: Remove acpi_video_set_dmi_backlight_type()
      ACPI: video: Drop "Samsung X360" acpi_backlight=native quirk
      ACPI: video: Drop NL5x?U, PF4NU1F and PF5?U?? acpi_backlight=native quirks
      ACPI: video: Fix indentation of video_detect_dmi_table[] entries
      drm/todo: Add entry about dealing with brightness control on devices with > 1 panel

 Documentation/gpu/todo.rst                         |  68 ++++
 MAINTAINERS                                        |   1 +
 drivers/acpi/Kconfig                               |   1 +
 drivers/acpi/acpi_video.c                          |  64 ++-
 drivers/acpi/video_detect.c                        | 428 ++++++++++++---------
 drivers/gpu/drm/Kconfig                            |  14 +
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |  14 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   9 +
 drivers/gpu/drm/gma500/Kconfig                     |   2 +
 drivers/gpu/drm/i915/Kconfig                       |   2 +
 drivers/gpu/drm/i915/display/intel_acpi.c          |  27 ++
 drivers/gpu/drm/i915/display/intel_acpi.h          |   3 +
 drivers/gpu/drm/i915/display/intel_backlight.c     |   7 +
 drivers/gpu/drm/i915/display/intel_display.c       |   2 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |  10 +
 drivers/gpu/drm/nouveau/nouveau_acpi.h             |   4 +
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |  13 +
 drivers/gpu/drm/radeon/atombios_encoders.c         |   7 +
 drivers/gpu/drm/radeon/radeon_encoders.c           |  11 +-
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |   7 +
 drivers/platform/x86/Kconfig                       |   1 +
 drivers/platform/x86/acer-wmi.c                    |  66 ----
 drivers/platform/x86/apple-gmux.c                  |   3 -
 drivers/platform/x86/asus-nb-wmi.c                 |  21 -
 drivers/platform/x86/asus-wmi.c                    |  13 -
 drivers/platform/x86/asus-wmi.h                    |   2 -
 drivers/platform/x86/eeepc-wmi.c                   |  25 +-
 drivers/platform/x86/nvidia-wmi-ec-backlight.c     |  82 +---
 drivers/platform/x86/samsung-laptop.c              |  87 -----
 drivers/platform/x86/toshiba_acpi.c                |  16 -
 include/acpi/video.h                               |   9 +-
 .../platform_data/x86/nvidia-wmi-ec-backlight.h    |  76 ++++
 32 files changed, 588 insertions(+), 507 deletions(-)
 create mode 100644 include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h

