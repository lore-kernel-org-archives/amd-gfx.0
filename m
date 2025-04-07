Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1BDC36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 05:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9CA10E1B1;
	Mon,  7 Apr 2025 05:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y4K1RZUg";
	dkim-atps=neutral
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DAF10E1B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 05:52:48 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-6f0c30a1ca3so11813066d6.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 06 Apr 2025 22:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744005167; x=1744609967; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dni3VEqNmbwSeGcjbO3TjTwIzcApKYTMYdnSGUg/Ej8=;
 b=Y4K1RZUg8XqgcDT0zY7dgjqKzL4ByxqnTtYlKEo8SEzrrXNIPe3DSUTTyQkhOPF0RS
 S20ProDebN2xdNcwQmOwwKNVTnNew+19mLzHDO4uYZWoypRP8bTOvaUQ0bh+qQ42vJqJ
 E4n7OochgqjqMhtzAnC3slUW+ElRwXSzXiRIb1A6iQwVGzQFEvHeJOexNuqjrMIfKHYl
 PfPg6pZOD69JoRbOKDnKfT6Uzs3HNMXSeXW/EeM07UanybDleKSYQNMDKX2GpNWcrBQb
 sFBXZLOINn2+E3920Dj1UTl4vtDXwa1TJSAOl0Qv4ySrLXTip+mW5STuKUwCOSbrOHcI
 ccLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744005167; x=1744609967;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dni3VEqNmbwSeGcjbO3TjTwIzcApKYTMYdnSGUg/Ej8=;
 b=jAID/3mtrT/K9RoMRN4npBXLVIIyQCELZIcVJlo+mMmhjsvLu8Jlw+EGs9/lL1uP+Z
 M35PbC1WqK1UX1IUNh0k2HaErdVRz7Dr5M9ZOVgWA2Q+AHPRabmlqLNUl/aVjGtGYxtq
 r8Q2ERIo1khz1Hi5uaLzFpf41hjlTq4jjAXDrFgPZBhIZ39P0I5NQqV8taXVmwsU7aW9
 7YV2czjbfQPWkqXwfRgUNX3fdeVzPH2bnPLs0Lc+vkHFGFCIcE/ELaHMIs03J5ArGu9M
 qK3ZORu4FOBcPfWNwAYg7AOpZa4pS97mFeN9mokbJxwQYxaCDIMJtAG2MMr7z1WXhMGD
 f/jg==
X-Gm-Message-State: AOJu0YxSS8yvZjIlF5zmLxATCYsSBOE/PYlxn4c5hIxmnFsp+q05Q6Jz
 azo7XjHJLwT1ng1Chf58HQ2FZ3Z/qE/JOAfn/rEDM+UGrUrcHv+CtE34Mg==
X-Gm-Gg: ASbGnctUZkgfzWjUEk+gp6z727xo/VVY6Orb88ikDSD8RJovGxJA7WfHyp2N7WFVJlI
 XwLpzdMBjUmHd0DKTOLOSbfl6WKCHkDVnbvA9uSAr7PvEECnYm/02so/VrFGJYGUbH2WVhV5gmh
 FERlNwlywWGWoe9mwdHBAgAyCGBIMcNl2z5MBf0H+oiJv5bR7gtBV3YiQ4/B5K5uO/DxuqDxK6w
 WhdOAYr9QwAj9LjGCvaV4UroVM2+XVZlHr5Ac2GUNvnXlLS2ecJCgsaJwUrSSBtYtRiWSZPfF0G
 VJ0L7qzssbdgDeEIIT3GsAQ8V6gVoaqimsPXyhJRa6wWIDkX65HMekpDcoc1bK5MkL4J
X-Google-Smtp-Source: AGHT+IFBWCYaK2msanwBedGqHbyIYleachzsQQVsAdRR71MoJidMDcFznlP45AyiLhQBL34HXzv7/Q==
X-Received: by 2002:a05:6214:1c4c:b0:6e8:f949:38c6 with SMTP id
 6a1803df08f44-6f01e790021mr190654596d6.33.1744005167224; 
 Sun, 06 Apr 2025 22:52:47 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f047cfasm54078976d6.62.2025.04.06.22.52.46
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 22:52:46 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: still cleanup sid.h
Date: Mon,  7 Apr 2025 01:52:30 -0400
Message-ID: <20250407055230.35519-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The defines, shifts and masks are already available in dce_6_0_d.h,
dce_6_0_sh_mask.h.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c  | 26 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/sid.h | 16 ----------------
 2 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 3b8c65a966b9..c21f97d89cbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1278,24 +1278,24 @@ static bool si_read_disabled_bios(struct amdgpu_device *adev)
 	u32 rom_cntl;
 	bool r;
 
-	bus_cntl = RREG32(R600_BUS_CNTL);
+	bus_cntl = RREG32(mmBUS_CNTL);
 	if (adev->mode_info.num_crtc) {
-		d1vga_control = RREG32(AVIVO_D1VGA_CONTROL);
-		d2vga_control = RREG32(AVIVO_D2VGA_CONTROL);
+		d1vga_control = RREG32(mmD1VGA_CONTROL);
+		d2vga_control = RREG32(mmD2VGA_CONTROL);
 		vga_render_control = RREG32(mmVGA_RENDER_CONTROL);
 	}
 	rom_cntl = RREG32(R600_ROM_CNTL);
 
 	/* enable the rom */
-	WREG32(R600_BUS_CNTL, (bus_cntl & ~R600_BIOS_ROM_DIS));
+	WREG32(mmBUS_CNTL, (bus_cntl & ~BUS_CNTL__BIOS_ROM_DIS_MASK));
 	if (adev->mode_info.num_crtc) {
 		/* Disable VGA mode */
-		WREG32(AVIVO_D1VGA_CONTROL,
-		       (d1vga_control & ~(AVIVO_DVGA_CONTROL_MODE_ENABLE |
-					  AVIVO_DVGA_CONTROL_TIMING_SELECT)));
-		WREG32(AVIVO_D2VGA_CONTROL,
-		       (d2vga_control & ~(AVIVO_DVGA_CONTROL_MODE_ENABLE |
-					  AVIVO_DVGA_CONTROL_TIMING_SELECT)));
+		WREG32(mmD1VGA_CONTROL,
+		       (d1vga_control & ~(D1VGA_CONTROL__D1VGA_MODE_ENABLE_MASK |
+					  D1VGA_CONTROL__D1VGA_TIMING_SELECT_MASK)));
+		WREG32(mmD2VGA_CONTROL,
+		       (d2vga_control & ~(D1VGA_CONTROL__D1VGA_MODE_ENABLE_MASK |
+					  D1VGA_CONTROL__D1VGA_TIMING_SELECT_MASK)));
 		WREG32(mmVGA_RENDER_CONTROL,
 		       (vga_render_control & ~VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK));
 	}
@@ -1304,10 +1304,10 @@ static bool si_read_disabled_bios(struct amdgpu_device *adev)
 	r = amdgpu_read_bios(adev);
 
 	/* restore regs */
-	WREG32(R600_BUS_CNTL, bus_cntl);
+	WREG32(mmBUS_CNTL, bus_cntl);
 	if (adev->mode_info.num_crtc) {
-		WREG32(AVIVO_D1VGA_CONTROL, d1vga_control);
-		WREG32(AVIVO_D2VGA_CONTROL, d2vga_control);
+		WREG32(mmD1VGA_CONTROL, d1vga_control);
+		WREG32(mmD2VGA_CONTROL, d2vga_control);
 		WREG32(mmVGA_RENDER_CONTROL, vga_render_control);
 	}
 	WREG32(R600_ROM_CNTL, rom_cntl);
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 19889276d677..99f6dfae9b81 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -81,11 +81,6 @@
 #define		MC_CG_ENABLE				(1 << 18)
 #define		MC_LS_ENABLE				(1 << 19)
 
-#define MC_SHARED_CHMAP						0x801
-#define		NOOFCHAN_SHIFT					12
-#define		NOOFCHAN_MASK					0x0000f000
-#define MC_SHARED_CHREMAP					0x802
-
 #define	MC_VM_FB_LOCATION				0x809
 #define	MC_VM_AGP_TOP					0x80A
 #define	MC_VM_AGP_BOT					0x80B
@@ -664,17 +659,6 @@
 #define CURSOR_WIDTH 64
 #define CURSOR_HEIGHT 64
 
-#define AVIVO_D1VGA_CONTROL					0x00cc
-#       define AVIVO_DVGA_CONTROL_MODE_ENABLE            (1 << 0)
-#       define AVIVO_DVGA_CONTROL_TIMING_SELECT          (1 << 8)
-#       define AVIVO_DVGA_CONTROL_SYNC_POLARITY_SELECT   (1 << 9)
-#       define AVIVO_DVGA_CONTROL_OVERSCAN_TIMING_SELECT (1 << 10)
-#       define AVIVO_DVGA_CONTROL_OVERSCAN_COLOR_EN      (1 << 16)
-#       define AVIVO_DVGA_CONTROL_ROTATE                 (1 << 24)
-#define AVIVO_D2VGA_CONTROL					0x00ce
-
-#define R600_BUS_CNTL                                           0x1508
-#       define R600_BIOS_ROM_DIS                                (1 << 1)
 
 #define R600_ROM_CNTL                              0x580
 #       define R600_SCK_OVERWRITE                  (1 << 1)
-- 
2.49.0

