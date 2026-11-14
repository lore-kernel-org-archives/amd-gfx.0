Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82884606A32D
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Nov 2026 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pClGs9xO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA6610E5CA;
	Sat, 14 Nov 2026 19:10:56 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C58F10E261
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 16:05:41 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1b3ada81853so1897207c88.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Nov 2026 08:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672340; x=1795277140; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=547AYHesvWuVRdGCIewRd+N2Li/XBFq8XpI3l0Qzhfk=;
 b=pClGs9xOj8jKmB12W43tZbGlY8ZK4Yw6uyTeVSqEK15TIh4IPKKPYSEPQ+/nxStxzb
 mNCFgBTo1Ro7DAguUApgRkL0hPKrkqDraieCb1GwbUxxCJ/ssEAvPS/++Bo8lJ+Wupjm
 +n+Uh35EXRuZPlcKmderE4UPNdWNT3Vp8hXAXlBkb9Mi56zUx4uibL2Z6yDrMJkD7TW7
 z/2Yu/DKbsK3qT/epFVz2xogmYjVAt32C+IgJZmQAcQFNJyaxujNGfE0ZAgUUnar1n2L
 UVoFJpbOdU1a7aCLud5yGahhi91hAW2PuNp/v/NqKTEgB6grespsslTPoW46+uXFIIcZ
 qtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672340; x=1795277140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=547AYHesvWuVRdGCIewRd+N2Li/XBFq8XpI3l0Qzhfk=;
 b=yXn0b/WGB0BsJUYE2FGltKT/R/JDY103lS8/oQSAJZScaN19FcNffyphwo5gHZzzxy
 lDYKAwHob+tP26gXG+3DRVlhhnkg9hutRWGTmNZmZrcAGKGfU0G4/MR2aWWxciz3rppm
 DdgYyWx15VyDp2pQuXHbbj1XTa81EWbqVhEMhjBh+yLIU5/dAMmsEa0ZsVaxB2EKMAmu
 9zy/ULL5apxHpGQ6DTy9slDcHsfhwD52cp4473nsUoXRQUoY5yidoXeei1SfUvsfd3Sr
 +EN1+ljPjK8tFk+40YJjxcZKnjgcQ6HBYaO0DpijoTHakyxu1NbH1qeP4psTaFKsfcU0
 YLww==
X-Forwarded-Encrypted: i=1;
 AL+hErGQiNUWjdOAte++GB1qMcglkko6Ane9xlPWibVyXqzqLq1NfZZTdi4deoxL2Ip4dLrp6w/Q2KK6@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/NmSWHgRKx20H6aUB5epLUgvNYfr6LevSG3Um4uDg1g0TY5Lo3
 H3G7ueDMcjjvcVZsa9FJWvqBaNgQUO2SwcJf0qckZnEGQxzDth560j0=
X-Gm-Gg: AYBFou3B4+o5ApOFld5pTdtn0/Y9/+P1abXKzuFaeNwhwUuZ8F9rikbf+7kbMp5a+Nt
 ftjHQlPXlXapb7E1TmRItHAZNcBb1lBtSo3tfO2Z80W/pPU/dJAUvydWod0M8oods21MIuuHnb5
 ppMKX4jZk0mtLvcoI26YPP8B1xpEMDkLW73WD7gfOxnj1niOSUPKKM9wgT1EpGaqEPt/lnbSBl1
 zVyF/836q/RclH3U7kAfp3Ww3lRSeVUtD7mESwjhfXpaq7BebFwvsDhRpWC1dy3PXqG79seIWNR
 oGG1Qbxs4HEft5E3gwKVZitfycDjPXn3pG3goYR5uXcTEPI5wq6AV/+YXfNC8pVuNucj3EfvGcm
 gDQ0dd1jGfmGSGNMSxXsoq8nKYkyVJgdt1CVFG1agwrB+dQnqP0S72+WgQJnUQtfFY/zZtJwf/M
 U52kmo8bvRO3ixc8iEZBmvcK0N4BGMiHNuJzO96o9CaSyuw7QB1NMJdLifAVVehysro8EkmrlqC
 xNcCMj/4xvkdXHci7r2kwYX8FBv92N1fXCKaHFpAT9lo3Y1nfbUH039ZOf87eOSXnWpMmznilVb
 cLik+JE2BdZ1hTxXtg32PaTlHlE9FzXgP2IFQjVaxvfB8qJF2kjDXF2U+pJcJh4Vgw==
X-Received: by 2002:a05:7022:3b86:b0:1ae:59d6:91cd with SMTP id
 a92af1059eb24-1b5239e163dmr123330c88.38.1794672340199; 
 Sat, 14 Nov 2026 08:05:40 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.114.179])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b505b5bf76sm13378548c88.10.2026.11.14.08.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:05:39 -0800 (PST)
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
Date: Sat, 14 Nov 2026 11:03:47 -0500
Message-ID: <20261114160457.3034-1-atharvatiwarilinuxdev@gmail.com>
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

