Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19893606A323
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jIERI0Z4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F65E10E573;
	Sat, 14 Nov 2026 19:10:56 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F5510E228
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:08:03 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-3282db206d3so5973895eec.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672482; x=1795277282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=547AYHesvWuVRdGCIewRd+N2Li/XBFq8XpI3l0Qzhfk=;
 b=jIERI0Z4qaHzsEXUuR7hjKe/DGCdld3TXCXV9RQ3n2DlFlp20SUO0hpANMjhOMpXuY
 elHTG0YEGOU49SuKhEW062cnIuMuA45RCgS4WkjcTpJjubL3SLuWbRDms89VAvNas/Lj
 enw9BN6/PsGOXjEjSgkiukG3SKAmQhKlOQan3bBf+E6Zai/BhzQkpwSthgjSl/0CLDSm
 xvMql02fOF4/H2RDVrEwtieQ7ItyR4c3OI/wwz/MvgQ/3RimMqI7T/fiQS7SvD32m+yn
 S9aUGGD0LCV+MLlYwwNRGSCPfnHnKXWMgjiM73UXWskx75AQmh8QWu9XxYb/RDEyRcrq
 kOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672482; x=1795277282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=547AYHesvWuVRdGCIewRd+N2Li/XBFq8XpI3l0Qzhfk=;
 b=RPOYiQwJo5lBtcUxcMsSFNOdQUxDenjlVzltXNhutBPCnF8JyRoVDZvq8aILJjEy32
 +zr98TT2efzFSf4X+iknfjP7029SHidXvQm47z2igYa5SyJDnWFV3+UIFOCUBEtbeD5Q
 1XRqZkP4w821fDPr41b+T4wAKt/aE816uKTV76kj1b54rtw7aOOR57HVlAWalrVyNLk/
 +hdrNdEDtn9kyytR1vJWa6Q7GCaQ+w+BHNANAWEZqpXQQ1l8ZoyDANhuf0m1/R/wKajn
 zmA9Q0eX9/g63o43LpbKB1CXlAmNxhQkHX9IN5La8dFF7csU9tyRPJgGDF9+bjXKsEhu
 aBRg==
X-Forwarded-Encrypted: i=1;
 AL+hErHGQ543/44NSS4vN9WY0LE9YvyVT7qVOmEsxnhtDvcEAMFAIxzDZe6v5SmMXMIrZ8jcAmgT2yA8@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Aogl6vsSmgmnASbCjnFtCGdIxa0JblGSHVCAzacIbCEP64W8a
 uTQRywJrnnbEWxHUAYVv0ccDE3T95ChnqHfi11HE9uXJ+bH9kfqnvnY=
X-Gm-Gg: AYBFou3xDqjoe3N4YW+lv+xjdzec+VA9YHI1znDwtKr50hV/Dy6Tk/s3QvrGwlcFE/z
 AGuoduhdrsWegdTeetFCt9cHRATFLvuJCadw9mv7qpV/06HYV4TCJZC44UH4VXHE05t1K15myVe
 9YQ+iOO/IWp/ymUhOKKJnGw8ftVjYz0nN0MSQxmCymw8RKgmyE0uReHyCRz4soB0vPkRbls4PuS
 FqYjat99hL9I0PouGQuaZkFAhFTS3w/ksAtMLO2DMZ+IIu1BK5jc/YPukLak2v9M46BFGyKX+5h
 uKNTnJSHrg7eSOE4nqyOd4yo5FnR/CydFwM7ZzlcUm2C8TVbjMMWlvcoMYqlA0sztT6Z3WBafll
 JdqoMkmrZeP5sjigrWw1BnNvgpS4/Q7eaHTRuSn3UakwpOoP7lMRNrEMaVaFVBr7qRsEZw/3AsR
 pxwUZaBIDpI9KSIq2QrPpXsTYS43jdlNQVeIwgQ3YY02uIOd3pN5eEfCnxTKtsrWaZM1CZa4Y4x
 gCsXdzA4Ljr+aDYzBLJfqtAHDPBe5P1VBX1BpGElhJ95Wz56siW3008BDeLaz6cy0IMGg6v9gcT
 pRREbnnhtB9HPMmjbW2Fw9W6JFxbg6jMtuLITehw52hpjF2wcLSPH20iG7rHVVoSqg==
X-Received: by 2002:a05:693c:8212:b0:36f:550f:bb0d with SMTP id
 5a478bee46e88-37963953f17mr6197803eec.5.1794672482123; 
 Sat, 14 Nov 2026 08:08:02 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:08:01 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andre Eikmeyer <dev@deq.rocks>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH v2 00/12] Fixes for apple-gmux and runtime support
Date: Sat, 14 Nov 2026 11:06:24 -0500
Message-ID: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 19:10:55 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes apple-gmux on T2 Macs (2018-2020):

  - Fix interrupt handling
  - Automatically turn on dGPU when a external monitor connects.
  - Fix base register read/write
  - Fix power handling
  - Improve documentation
  - New module parameter to toggle boot GPU.

It also adds vga_switcheroo runtime power management for T2 Macs, built
on gmux power control, so the dGPU is powered off automatically when
idle and users no longer need to toggle it manually.

Changes in v2:
- Check the discrete pdev config before GFX0 restore (01/13)
- Don't save bridges state when state is VGA_SWITCHEROO_OFF (01/13)
- Fixes discrete_pdev initialization (01/13)
- Used PWRD on 15,1 and 15,3 aswell
- Add quirk to 0x7360 PCI id aswell (02/13)
- Add 15,1 and 15,3 and its gpu's aswell
- Removed ignore_access code (02/13)
- Initialized val in read functions (03/13)
- Fixed permanent mutex block on failure (03/13)
- Only resumed when pm_runtime is available (skipping on iMacs) (04/13)
- Corrected ordering of interrupt_work (04/13)
- Notified drm about hotplug change (04/13)
- Checked if EFI_RT_SUPPORTED_SET_VARIABLE is available before writing
  gpu-active (05/13)
- Wrote gpu-active on shutdown aswell (05/13)
- Dropped boot-gpu parameter (06/13)
- Checked if vga_switcheroo has been initialized (09/13)
- Added additional pci_is_thunderbolt_attached check to
  amdgpu_device_supports_gmux (09/13)
- Removed duplicate check (10/13)
- Renamed gmux_off to runpm_active
- Checked if adev->dev exists in dm_dp_aux_transfer to fix null ptr
  deref (11/13)
- Removed GMUX specific code (12/13)
- Initialized edp_sink_present in testing code (13/13)

Link to v1:
https://lore.kernel.org/all/20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com/

Andre Eikmeyer (6):
  platform/apple-gmux: Write switch state to EFI on MMIO devices
  drm/amdgpu: Add Apple GMUX runtime PM support
  drm/amdgpu: Catch register access while GMUX keeps the GPU off
  drm/amd/display: Refuse DP AUX while GMUX keeps the GPU off
  drm/amdgpu: Skip AC/DC notification while the GPU is runtime suspended
  drm/amd/display: Skip panel power savings on eDP links without a panel

Atharva Tiwari (6):
  platform/apple-gmux: Fix power for MMIO systems
  PCI: Disable pcie port on specific amd devices
  platform/apple-gmux: Fix MMIO interface
  platform/apple-gmux: Fix Interrupts for MMIO systems
  platform/apple-gmux: Add check to detect FSS
  platform/apple-gmux: Add documentation about iMacs

 arch/x86/pci/fixup.c                          |  43 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  61 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  48 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    |  24 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 +-
 .../tests/amdgpu_dm_backlight_test.c          |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  19 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   1 +
 drivers/pci/pcie/portdrv.c                    |   2 +-
 drivers/platform/x86/Kconfig                  |   1 +
 drivers/platform/x86/apple-gmux.c             | 365 +++++++++++++++---
 include/linux/apple-gmux.h                    |   1 +
 include/linux/pci.h                           |   1 +
 16 files changed, 534 insertions(+), 72 deletions(-)

-- 
2.55.0

