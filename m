Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFB606A328
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aTgfUKZc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786E610ECC5;
	Mon, 26 Oct 2026 08:44:01 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8D510E258
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 04:01:26 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so3432496c88.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Oct 2026 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900885; x=1793505685; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lv7p0AUZ948zcVcPc4Q28K28YGEwBExkgg3ueLIutWo=;
 b=aTgfUKZckopDZX5UrTbYOauQSr0Adk81a836uRwpnmyBd82J5Qae7vfsFvolwxwbvm
 g7OgJxm7G3tsz0hIHifjOd9Y5auVF82D3xuU+gcbtvCuLYHkHCZXsTV6oaJCnkinU125
 TqvB/Q6AyJJZYjRYpok+egsa/8pfiNYiwWq/ZFcGLKw9Zke1MJJs8HdDnfua9KWjzPIj
 I9CRz3EqCPuFyc89QOHA84scoaXDtNpbjIyjGRoYD+rlvAPnVYAN7Z02MITDYct9TdKP
 PKLCTafDcpJXdvBYfnAvrg4PKIVmYYmzHA/Ano9+ZVzqw692yTdLZWi5G0wlez4dO5Io
 CQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900885; x=1793505685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lv7p0AUZ948zcVcPc4Q28K28YGEwBExkgg3ueLIutWo=;
 b=DdQDgJuLVHAM0wyry7SDTnGVd8r84g+x5FPhc8IagSpGdMiBsOg++Ov0EocBSdVk7D
 Xsm2BRPzX4cfOaTzcuahHGjmKTCNu06xix5YJONr1+MV/eYc1pQRVhCG9QAj2pla0X/l
 VcWGFXQQWLXif9kq0j78BltIVdrLAVwqBTJ+FdkxaotfIFf5501nbokXvI9F8amP44/n
 nBL9knuMAOIMb3YkvylqbGI16+K14Kw/+IOqZ7XK0c4nk3xwVBf6nWMBLWtDa8PXrzkb
 6/NCkp1MOJtCoMPw7udsEvtou7agasa92IewatTX4maCQ6B2/on84AbHXcVR+ZGGfgwK
 SoZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWENPGY/hOLS0Q7itxhFOyySy8H3A+pcq6YuIMtVtUnh665F0l8+3TGW6QAMaJJqjh9c20K03d@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIrK6OHacAczBH5XpWvJp5cDAe4gsHpyIb+l5Q/CmIy30ofIO+l
 uchyyalk44Jkz11QwvYOd9IbHK2CqgKHmTkEZSEsh9SZkkGp5OWRQUM=
X-Gm-Gg: AYBFou0+8QGpf9IO4cx4s0dmzsE2FAjEj2fp8aXgiC6GBFM4+MED4o4RIWuk65QVXmp
 BRKsl9oh/QHHH2ByV/DeU7FoEgJ0//WfKxj6RSVkjqTkxocshOHyRJQU7W7wxlB00BViymWwHOW
 Cc82K4r1h6jcQFO5dIykld8r1iHZgC+ul4fPqiYwACabKBk7x/tPgyYU5abgF07xFXENKVY0+aZ
 m0kEAFofvkeu3UMgG8oyQW4jo+nJP+oAhOrStz5J1v7JDRUdoG+vXK9G9DdhW5F+3Z5NYLCW/06
 eOgkF9cfLwz0Elxloo+d/DlFRbOzf0vBq1mttmNEIsj8lawNWt50Wz+hmo1t5/MmMQmiIoIIriT
 Qnj61pwAfC49q47xEBZ0j212Vhc/v86ETITysK2HhHnoEiLgGvrpCLXZ64WMcVKl1WNheiNdisF
 Gw1mZ9MRueaWIE+wcpXyF9Ne0R7FunFWM4RZvHRhMYYGidrVHrgSDn+5alLGvwzE2cfvnxj02kC
 3Z4zlpXco7VR0tn8vEf0XWIEUr/6DU99J1SRAwqFMdHti4INNN8ocXYBS/ZBgv6TyZUjprhbfLz
 oKn7VP/QH7zTG/s=
X-Received: by 2002:a05:7022:5f09:b0:15e:6541:3099 with SMTP id
 a92af1059eb24-19933e10e21mr5393203c88.7.1792900884823; 
 Sat, 24 Oct 2026 21:01:24 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:01:24 -0700 (PDT)
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
Subject: [PATCH 00/13] Fixes for apple-gmux and runtime support
Date: Sat, 24 Oct 2026 23:59:36 -0400
Message-ID: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

Andre Eikmeyer (6):
  platform/apple-gmux: Write switch state to EFI on MMIO devices
  drm/amdgpu: Add Apple GMUX runtime PM support
  drm/amdgpu: Catch register access while GMUX keeps the GPU off
  drm/amd/display: Refuse DP AUX while GMUX keeps the GPU off
  drm/amdgpu: Skip AC/DC notification while the GPU is runtime suspended
  drm/amd/display: Skip panel power savings on eDP links without a panel

Atharva Tiwari (7):
  platform/apple-gmux: Fix power for MMIO systems
  PCI: Disable pcie port and access on D3 on specific amd devices
  platform/apple-gmux: Fix MMIO interface
  platform/apple-gmux: Fix Interrupts for MMIO systems
  platform/apple-gmux: Add parameter to configure boot gpu
  platform/apple-gmux: Add check to detect FSS
  platform/apple-gmux: Add documentation about iMacs

 arch/x86/pci/fixup.c                          |  30 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  60 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  45 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    |  24 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  19 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   1 +
 drivers/pci/access.c                          |  18 +
 drivers/pci/pcie/portdrv.c                    |   2 +-
 drivers/platform/x86/Kconfig                  |   1 +
 drivers/platform/x86/apple-gmux.c             | 377 ++++++++++++++++--
 include/linux/apple-gmux.h                    |   1 +
 include/linux/pci.h                           |   7 +
 16 files changed, 554 insertions(+), 71 deletions(-)

-- 
2.55.0

