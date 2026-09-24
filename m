Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A92C9830D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 07:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F4310F92D;
	Fri, 25 Sep 2026 07:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eop+dxWj";
	dkim-atps=neutral
Received: from mail-vs2-f28.google.com (mail-vs2-f28.google.com
 [74.125.227.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B43410F559
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 13:30:06 +0000 (UTC)
Received: by mail-vs2-f28.google.com with SMTP id
 71dfb90a1353d-5c9031e714dso792087e0c.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790256605; x=1790861405; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GafHdzyK4yGVm8vNQl3Rr48yBibIJneXjnAJvLweW2w=;
 b=eop+dxWjYWvd1/lA+izKVKqyLMnFp++Y2aXzYo4Q7UHBAP4sfRVleKTKlT+c4By/NI
 i2HEC2/sCzH5CVVEE97lY52mSVFSDHtUFk1Fmnt8AYTRXmH/n2B+g8bRmDKAFOt1tW5R
 CC5IhfkbB9gRPK7g3KYdKk9QPbNtDh4OElBjjBb40TmddoRrbX7JdUrbVCvldV1rQK6V
 usxd+1kGEIxbkyK9HBTS4SdUXV7LMjYQD8N/wpD3nV0+PikISMT8fCLh89hqeeYfdDi9
 VNbWv0iNJ9ePEbDafIHq2Ot2QwAp92G7zdmSexfI2w5eWXiox4M0aMQGgDJ0vRFBY883
 2d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256605; x=1790861405;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GafHdzyK4yGVm8vNQl3Rr48yBibIJneXjnAJvLweW2w=;
 b=qQo3s6XQeo7eUrq9n9RBLv1hAxG68Vvakrsgzr8X+cX7+OhmvwY9EWGI669l5GzwAk
 J01lelaSph+ZqbTltGJpKXHscnTRP7wLONwQdt2rI0zciKynEDOHTCkSpnQyYhhLEk9+
 iRmyz92oFH1xK9OYXGvrQwblvrCILB/1Re6psdQvlABJ747E+RVRxFK/D8Tdki/zDyJw
 rrMdhoy2jTeGDabrbjbAi9XQ7SmlbI3KTAKe8YC36S9sdELbukwHT9iK6ZFfjumxX15w
 0wizu5jwJOILCv9Bnk5SuG/MNR/4xpoicb8ktsVXQ3wkI1orIlfJzk0PsrwDAWF15c54
 PuIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwb7EzrYJVejCjdCvwqXmdTIv6ZviiHFTNGoEPFV+sRdFdQzZlVOBBUQEb+T4El4IZRk8XwGO3@lists.freedesktop.org
X-Gm-Message-State: AFuF++lpE2D8g0VGHgokvoUHwR8+lU+6ekJ7iaijHq3hfkrkvkAtLMRh
 6uL+r5+OmSAf3N0V6/Za85we/z/9/IIIt/HYmmV+FPxi4z4dC0ErtXJM
X-Gm-Gg: AYBFou20vVgZ/OyxjmUmtciJ/Dhv2DYCUl2lIsdXWYg2NyViCPcHxKQpdceYya5AV22
 KA9LR7cfIrKZwu8IYTfTenwuIC7TJBOFgh++4tUxW5D0SOb6bxLQcahLam9v/Lq5ow4kZFDbaCy
 w9L5LYLQbDAazb7wWAi39HwphMU1uJNVw3EKOjVgrziI/yBLX7q8I6T/FirglWkCVpt7Umkf0z5
 7oPdt3gjQisYlkra29RNV/z/qpPqM4c8TfdKl/3s+lcUa8IR3SQxvSTnno2wJBfs5JI4vXPuwoO
 Aq+21J4PyAt999IVzLOjzKSiq2mm+i+dPp58mUkzKRrrRtoO8dYLxTmPeVPPKcuVJJ0KD9HND09
 /wCkRe7g9BGKPRferB4WEov/32f8I54HEAd+wZ2M7mpJQkyDh8JfB4LodBRkf4uz8F5hHiThgVk
 Vyv6mQRI096/hYIwLQzCEVSxvr0z8oMEyoY9KXIWGtnKDMCV+fZ1k2ZWP/LASvvYp7sWxhV52xx
 A5b6RGPwI2b7IYbVE8r
X-Received: by 2002:a05:6122:3d0e:b0:5c9:c60a:e9b6 with SMTP id
 71dfb90a1353d-5cb0c149318mr1312750e0c.22.1790256605213; 
 Thu, 24 Sep 2026 06:30:05 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9f0582b6bsm7050251e0c.18.2026.09.24.06.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 06:30:04 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?=
 <fbeltranmillalen@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/gmc_v8_0: restore the FB location after a re-POST
Date: Thu, 24 Sep 2026 10:29:52 -0300
Message-ID: <20260924132952.25054-1-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:39:28 +0000
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

On a MacBookPro14,3 (Radeon Pro 560, POLARIS11) amdgpu has never recovered
from an ASIC reset: five attempts recorded, zero successes.  Since suspend
to RAM goes through a reset, S3 fails the same way, and as the internal
panel hangs off the AMD GPU the machine comes back blind.

The failure looks like VRAM going write-only-dead: writes are silently
dropped while reads still work, the driver reports success at every step,
and then it hands the SMU a pointer to a table that was never written:

  amdgpu_device_asic_init()  -> 0          (reports success)
  gmc_v8_0_hw_init()         -> 0          (reports success)
  memcpy_toio()                             (write silently discarded)
  send_msg(0x251, ...)                      (SMU parses garbage)
  smu7_check_fw_load_finish() -> -EINVAL -> black screen

It is not VRAM dying.  It is the framebuffer moving.

On this machine the Apple firmware places VRAM at MC address 0 on a cold
boot, and gmc_v8_0_vram_gtt_location() reads MC_VM_FB_LOCATION once, at
init, to derive vram_start.  A re-POST -- which is what an ASIC reset and
an S3 resume both trigger -- lets the VBIOS put the framebuffer back at
its own default instead, 0xf400_0000 here:

  cold boot:   MC_VM_FB_LOCATION = 0x007f0000
  after reset: MC_VM_FB_LOCATION = 0xf47ff400

gmc_v8_0_mc_program() programs the system aperture from the stale
vram_start, but only writes MC_VM_FB_LOCATION and HDP_NONSURFACE_BASE
under SR-IOV; on bare metal it trusts whatever the VBIOS left behind.
While the MC is still in pass-through everything appears to work, so the
mismatch goes unnoticed.  Then gmc_v8_0_gart_enable() sets ENABLE_L1_TLB,
SYSTEM_ACCESS_MODE=3 and ENABLE_ADVANCED_DRIVER_MODEL, the MC starts
checking the system aperture, and every access lands outside it -- which
is why reads return data written before the reset, from a different
physical place than the writes are going to.

Write the framebuffer location back when it does not match the one the
driver is working with, which is what the SR-IOV path already does.  The
comparison keeps this a no-op on machines where the VBIOS restores the
same location, so nothing changes for them.

This runs after the VGA aperture has been locked out and with the display
suspended, so the MC does not need to be stopped; only CPU access through
the BAR could land while the FB and HDP bases disagree, so BIF_FB_EN is
cleared around the update and re-enabled below.

With this the GPU survives resets and S3: the machine has since completed
twelve suspend/resume cycles in a single boot without a failure, and the
restore is visible on each resume:

  amdgpu 0000:01:00.0: amdgpu: FB location 0xf47ff400 does not match
  vram_start, restoring 0x007f0000

To be precise about what those cycles prove: the kernel they were run on
also carries unrelated local patches for this machine's Thunderbolt
controller, which fails separately.  This patch is the one that brings the
display back -- without it the GPU never recovered from a reset at all.

Tested on 6.18.49 on a MacBookPro14,3.  I have no other smu7 hardware, so
this is only known to matter on machines whose firmware boots the GPU at a
different framebuffer location than the VBIOS default; elsewhere the new
branch does nothing.

Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
---
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -472,14 +472,42 @@
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 
+	tmp = ((adev->gmc.vram_end >> 24) & 0xFFFF) << 16;
+	tmp |= ((adev->gmc.vram_start >> 24) & 0xFFFF);
+
 	if (amdgpu_sriov_vf(adev)) {
-		tmp = ((adev->gmc.vram_end >> 24) & 0xFFFF) << 16;
-		tmp |= ((adev->gmc.vram_start >> 24) & 0xFFFF);
 		WREG32(mmMC_VM_FB_LOCATION, tmp);
 		/* XXX double check these! */
 		WREG32(mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
 		WREG32(mmHDP_NONSURFACE_INFO, (2 << 7) | (1 << 30));
 		WREG32(mmHDP_NONSURFACE_SIZE, 0x3FFFFFFF);
+	} else {
+		u32 fb_loc = RREG32(mmMC_VM_FB_LOCATION);
+
+		/*
+		 * On bare metal vram_start is the FB base found at init (see
+		 * gmc_v8_0_vram_gtt_location()).  Normally the VBIOS put it
+		 * there and a later re-POST puts it back in the same place.
+		 * On MacBookPros with switchable graphics VRAM is at 0 at boot
+		 * instead, and a re-POST (S3 resume, ASIC reset) moves it to
+		 * the VBIOS default, away from the addresses the driver
+		 * already uses.  Move it back.
+		 *
+		 * This only happens after a re-POST: the display is suspended
+		 * and the VGA aperture has been locked out above, so there is
+		 * no need to stop the MC.  Only CPU access through the BAR
+		 * could land while the FB and HDP bases disagree, so block it
+		 * here; BIF_FB_EN is enabled again below.
+		 */
+		if (REG_GET_FIELD(fb_loc, MC_VM_FB_LOCATION, FB_BASE) !=
+		    REG_GET_FIELD(tmp, MC_VM_FB_LOCATION, FB_BASE)) {
+			dev_info(adev->dev,
+				 "FB location 0x%08x does not match vram_start, restoring 0x%08x\n",
+				 fb_loc, tmp);
+			WREG32(mmBIF_FB_EN, 0);
+			WREG32(mmMC_VM_FB_LOCATION, tmp);
+			WREG32(mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
+		}
 	}
 
 	WREG32(mmMC_VM_AGP_BASE, 0);
