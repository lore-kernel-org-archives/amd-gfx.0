Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D969C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 12:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A6E10E976;
	Mon, 13 Jul 2026 12:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+5Xb3Tr";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B5510E976
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:58:59 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso2603175f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783947538; x=1784552338; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ifWmatkuHnE/huKJkAvhI2hVTCiqs3WNZQd5bSfB9lc=;
 b=i+5Xb3TrIBGnSiFCYTrcffVwJTNtJ0MB5xXyOt+5HKLR9D5+UR8TJAoNFnsjit5mdo
 1ED8HNWYXBFTCip3MXu3GpDHzsTpbGUWvbi4aXNLUcpcrlOBQ5EVU05BBoCs2CuXuAxt
 nE+Ft4V2Uvy6TZC+N1mepzmDA22C0pMMJcX7+QNZDXLJUpAe0kIlvELNy+gIrumi2j4M
 DQL1leuBK0R6rgaWHq78aJvawJ8P/SoctXXNcZbcX1vaADVGZaXXJLQQlSP3/Gmk5KNt
 gApeD1TJefzrKrMWQsRPbIEcf+MGOrh/5qEARhR/Ur7eqSi/QfW7QnGYrXQurnM6olnl
 1Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947538; x=1784552338;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ifWmatkuHnE/huKJkAvhI2hVTCiqs3WNZQd5bSfB9lc=;
 b=XC2htB7KC9s5hNCsVe846jF4WbroenOEFmlSna3anApmPWD31mZkifAzO87CY7mLvP
 QUApf7mQWTkmIwEWkQ7q8ZZfNdbxT2G6ShuGeCMyRxKfjnPlfM1FJnkTBwJA7Lej4Nxv
 DAfOQ54zHfa+oAs3voJ0ora6hGdPvXaTY1vjgP1zp/1X3BBxlXVK7v9vv1mP8HigaMOm
 bWZPceG4PI6PuzyodvErDZ4kq7OfACV32Qwi0w5BXWq+5mfDtinMayRRhCFzz+acnDpw
 j7p0VNrE4jG+SyiZdois25nDLQJJaUJNFAA+3gb5NgpTY398GqwwqCS786BPg6KuOoM6
 PuOg==
X-Gm-Message-State: AOJu0YxxpbPTF4IZeAhcaB7LHpQDIlCf2W/N0oVMt8KZ/Ra/dP4Z1Mst
 UsdE+ZbtG5brXn+wE963jLxI/f40OnuBS5erTiDCvHTtd0T+xUwnZe8KC7IjVg==
X-Gm-Gg: AfdE7cl0wuz5CazpYog0CSbLtTqlZISeqEQ947VxTAoQeHxpqWcyjPr1+K3YIEGNaIi
 qe3pUVgKe9ulZwhXhC5gDmZchMKSnhcu31icBnRSxFCWhkOHWwplKLNizSTl2fNg1zNSYBaFWxp
 hr86XW/0tPyafPZkkGHyIeOLYxY3YvflamlKs0eW6rLqchmTQAtVB/tkCh7UxPB0HQuGNWxJju9
 1IFEvo6zn6P1BLFdyXbY4XVJdNmajzHwwmZByey5sDaZRj+h/RUkHceBi91q/R/tmziNBSaxgeE
 PaFIySb+9DkdWyM48aKc/r8glKf0d90k7WQ0iZf31M8RWoq1ez34ZCavvBPoFjYYPnFD0U1fxEQ
 VuEDj1QQCcBT4laKdHFYhwYU5LFlL6vdiNdud2bWxXHBtODl5tjfeFx1N2Z0nX0O/gbu81gXJYy
 sVDJHLyW5W3I6WZGrGnQp0H3MdTu0hjeamYhaopyBC5Vd3WGron0K2Cg==
X-Received: by 2002:a05:6000:4b03:b0:478:4de8:9b91 with SMTP id
 ffacd0b85a97d-47f2dd0517bmr10913533f8f.41.1783947538187; 
 Mon, 13 Jul 2026 05:58:58 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm80456918f8f.10.2026.07.13.05.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:58:57 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 9/9] drm/amdgpu/gfx7: Enable IP block soft reset as a GPU
 recovery method
Date: Mon, 13 Jul 2026 14:58:38 +0200
Message-ID: <20260713125838.30607-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713125838.30607-1-timur.kristof@gmail.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Enable IP block soft reset as a GPU recovery method for GFX7
graphics and compute rings.

This improves current user experience on all GFX7 chips:

* On Kaveri and Kabini there is currently no working
  GPU recovery method so those chips currently require
  the user to manually reset the computer when there
  was a hang.

* On Hawaii and Bonaire, the current GPU recovery method
  always clears the contents of VRAM, which means that
  a buggy (hanging) app can crash the whole graphical
  session, which is less than ideal.

Using GFX IP block soft reset means that we can now
have a working recovery on GFX7 APUs and we can also
move on from GFX hangs on dGPUs without crashing the
whole system.

Tested with the "hard_reset_cp_wait" test case from the
Hang Test Suite created by Natalie Vock and Konstantin Seurer.
This Vulkan testcase waits for an event that never occurs,
effectively a WAIT_REG_MEM packet that intentionally hangs.
IP block soft reset can resolve that hang and allow
the rest of the system to move on and keep functioning
without needing a full ASIC reset.

Tested on the following chips:

Bonaire (Radeon HD 7790)
Hawaii (Radeon R9 390X)
Kaveri (A10-7850K)

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 825e3d7d5f0f..1a7a6962303e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4434,6 +4434,11 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
 
+	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_ip_block_soft_reset) {
+		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+	}
+
 	return r;
 }
 
-- 
2.55.0

