Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11437CC6B2F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A46A1121A0;
	Thu, 15 Oct 2026 08:21:45 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CF7910EABC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 19:20:53 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa29e06bso2158334a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792005652; x=1792610452; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OydTZHfQdRb3QLHEK759Swg+bjXzVK1VsozJK/ser9Y=;
 b=Jj0AAPlW2g5GwSb5fBWGJYGS+nDS+l0Lg8yO1er7zqrL/n5rz132igbmlB/NFBm13S
 Sk2cUtBDC2bK39UZ4dyMOLrfmzQbY/PS9kE2Q3hQaYXYN3qYojCspUtAPOCa9ZTT28po
 3xkFtEorcFNBI+G1bO+5uwRSeIjMvsAK3Oa6NFVSgpCsAsBXt5JKBy/Fv7IxrCGDHLOd
 VfinpVMKhWbAwO5ROvB3QeoRgRevler2ypuOm+V2VyDX9mF9iC6bh3jBR1yrXto0aGLt
 7eSuJbev9dgEprDQ1cZ4A6ZS7hbCKs6QWvyMRbCiahhwurmhPoDJfZAAr7oo5dRfejo8
 WaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792005652; x=1792610452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OydTZHfQdRb3QLHEK759Swg+bjXzVK1VsozJK/ser9Y=;
 b=jbTDEi/dRY63zJVPU+7vVcLrI9fXrzGUBQQPCBd0Or7U4Obh1kQrIavc0Mu6bDVmpt
 uM9USUhfLn5HWz9EHvAQV+gXcKx9N928l7HKQQ3CCbtgcU+4JhtE6UpF+O154jpElFat
 eioUvt/4XKqkgA7S4Uel0ZqbGJFiSmOp1kCVemznbHQRRkntPWXhXyW5ZYuCh5gAggb4
 xIGBYg+fJDhRL1o+qFtb8T9+vE/757JBZlZGb0fnfxCJF7L43f8Noz83EcgZno7bdAuK
 tn0P6UEXV58OEHBcasfwpOWAO3hsYvGBWNZ+iwQGTDEu6zLO4mZbUlKF9aYpLun4fchf
 lwPQ==
X-Gm-Message-State: AFq9FYI0NcJwmeq5+x9Ih2yF8X8unJZPHGIpkFho5VCBPg4djUCyQSh/
 WPm4TdGpXnfO65xCIAvnGb7fRv8r1ccbVvJhFXG/QOwU5T2iKuFdCi+DJeSvbLPB0XY=
X-Gm-Gg: AYBFou0Jvi4NN89q4s6wIdh6gClG9YxOXX+HTZa7rl5M341dK/lchJgPkzfn5viT2ze
 xG093dMQg70vNMn7vbegw3FBineM25GFIhM1p9sgEiQmrz/KKcEAS+prEPU7yfW+8n+b/s6MBdH
 2r2MDGVMegPwYX6sNcsp1P5MhMnAJkknHexdO5W7wcP7142zEhEi5eJRb6RKj3A4zIpbo8R5p11
 wARqtO6IpM25S1aBy/eMwqaOE5O/7TjiBQ7mGDYq84kWIyGyLBna9AxGpRVBkeNIgzOLjnSq4Kv
 II1oRv1H1peQNr+pKCBuuSTxHhw2yCboJTt4jUg42ihQlh5v3foLM9v/zjYDuzaPb2BmWLS5+Xy
 6uM2rKmcMrcQQGG/PA+q/LapF8VW6FhSqp9b91O6IKoa22lxaZ0hfXWwikSazhFNgoOISrCNylg
 HL83IY6qQVKaLSFeEmiWgs7s0C5nCxbHiLuPTpZchlNLRtgojJxORmpveNv3NE+hq2Jh/sT4Xi8
 i6DXnmOObmn0QbTONtg
X-Received: by 2002:a05:6402:27c8:b0:6ac:94cf:9f1d with SMTP id
 4fb4d7f45d1cf-6b1e49eb8bcmr5469388a12.21.1792005651553; 
 Wed, 14 Oct 2026 12:20:51 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b203762b6fsm1456132a12.5.2026.10.14.12.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:20:49 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maciej Kucharek <qchcio@gmail.com>
Subject: [PATCH] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Date: Wed, 14 Oct 2026 21:20:30 +0200
Message-ID: <20261014192030.10611-1-qchcio@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:21:44 +0000
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

On MacBookPros with switchable graphics, the firmware puts VRAM at MC
address 0 when the iGPU is enabled.  The EFI stub enables the iGPU on
these machines through apple_set_os().  On a MacBookPro11,5 (Radeon R9
M370X, 1002:6821, subsystem 106b:0149), the driver adopts this layout
at init:

  MC_VM_FB_LOCATION=0x007f0000, HDP_NONSURFACE_BASE=0
  VRAM at 0x0-0x7fffffff, GART table at 0x1400000

The driver posts the ASIC again on S3 resume and after a GPU reset.
The VBIOS asic_init table then moves VRAM back to the VBIOS default:

  MC_VM_FB_LOCATION=0xf47ff400, HDP_NONSURFACE_BASE=0xf4000000

gmc_v6_0 does not reprogram these registers.  The GART table is then
no longer in VRAM, and the gfx ring test times out:

  amdgpu: ring gfx test failed (-110)
  amdgpu: resume of IP block <gfx_v6_0> failed -110

Reset and post the ASIC at driver load on Apple boards with VRAM at 0.
The driver then uses the VBIOS layout (VRAM at 0xf400000000) from the
start, and later posts keep it.  After the reset, FB_BASE is not 0, so
a module reload does not reset the ASIC again.

The test is the same one that commit c7f44ec5c4ec ("drm/amdgpu: make
Mac FB workaround generic") uses: an Apple subsystem vendor and VRAM at
0.  The VI quirks for the MacBookPro14,3 and MacBookPro15,1 reset at
load for the same reason:

  commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")
  commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1")

Other Apple SI boards only change if their firmware also leaves VRAM at
0.  They then get the same reset at load.

Tested on a MacBookPro11,5 with 7.2.5 and this patch: the panel comes
up at boot, and 4 of 4 deep S3 cycles resume.  Without the patch, S3
resume fails every time.  The GPU reset path is not tested.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5978
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 0adfd4b10..892e80f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1512,6 +1512,15 @@ static void si_invalidate_hdp(struct amdgpu_device *adev,
 
 static bool si_need_reset_on_init(struct amdgpu_device *adev)
 {
+	/*
+	 * MacBookPros with switchable graphics put VRAM at 0.  Any later post
+	 * (S3 resume, GPU reset) moves it back to the vbios default, so reset
+	 * and post on load to start with the vbios layout.
+	 */
+	if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+	    !(RREG32(mmMC_VM_FB_LOCATION) & MC_VM_FB_LOCATION__FB_BASE_MASK))
+		return true;
+
 	return false;
 }
 
-- 
2.55.0

