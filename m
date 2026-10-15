Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2207CCA491
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 08:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B134E1126A3;
	Fri, 16 Oct 2026 08:55:45 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0309910E8E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 18:19:05 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso854082066b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792088343; x=1792693143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9AM0Gv89/jti2Z4oloYI+pxfIXugphtFed7imqnHYeQ=;
 b=eOf3q+2u06RVWJh+1FJRoeOPOjVqtE/jKNBRgEE9uWhw9tp+lrofBqvuZN26qMBeIT
 Ya9KUc3mGptvL0DfkxALVgo/L5ykWOgXRPWpNyOb/DaMKNyD663h5SoMNEr+UKI/gQfR
 f35qPbe62xCdwEA+KPpqob6wwoSXrBrmnPYIbKEqgoCpjr2qQscopo2ocGv4Si8IAVtF
 199r8PGtcBlNs1WzdIBkV9cRjbg2MbmuIFVLCyNfJhStcvK6/TQC6zRfJWOXuaT3Yku0
 PYG6+/k9wg8lKZJKSPhlzzIbAR2eDkWA1k+sxmDCGvfps4+r6Cs9C+wzAv1Bp969+29j
 upww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792088343; x=1792693143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9AM0Gv89/jti2Z4oloYI+pxfIXugphtFed7imqnHYeQ=;
 b=mGMMk8a93bx5eYmbsGc/fPv6VdisSJuCVkglNKubFNr77+ZPelBCXrSZ4kuoetRMSz
 ESBdDKgjXcky1mW2t2aeRZHMuVg+PJaG2l/xro47NeXd9tAidSsYRWszKosY2rQ8P8ud
 1QaBacMTnDmG1VIQ0GMmF34RsEt+Xr+IcHg9HrDPp7gEwyFGxr3eOwk3+AlsPZG0ONVo
 dzAxfIMENE6RwT+40Ha43UQu8S4l7Qf0L05kVfJh+YpN6OH5qL1NK1ZDmuQPsAxLohvZ
 RhOW5WYgnXhTTOSaSggvV0VNtKLMkX/09DBXQlKvqlwK2Zm4PESQWNG3+Wa2UsdCo4Ww
 flOw==
X-Gm-Message-State: AFq9FYLI7leQ9c3Z4nLrJPFGCCtM2RWBiGLl/tsTZ+Ic2IHtsHOXj+qR
 WZNv753Oh7zlC2Ut9Pqoz1LGlr0VttWsBsjmXmzjxfyJUqFSr7JZBdRktq2SlHWS4Hs=
X-Gm-Gg: AYBFou2j1gU52163369N2FnVTcsQMeTCbrVM6zeHjGNyHyOgdv3fr95adSWvUgmEHnr
 T0xvuTBc3/FviCHL8JsYJMVSAcwEU8m5pwIYvaxq0/oQ7nMPdjW0cNDngMWdpYEJCsvwZfs9aXx
 D6Fr0zGivYz8dubGd0mAk1SLSiANWufx0TEJkpGnSktj1AH0I/83gL5qPUtN0hWNCvXQRQnt+XR
 OMwXI2diQasMDO25ckjpja9XSN/KUxqq0cZdIcpSkRx9YaxTzyBj7NIhVbsdPUOkmn6vr/mbR2w
 cm7y/KQ+JZ1QMMNt0YEv9hKULHgvjSgBacxMAjB9Ty6MhPAS6mYBeRBi1AvcwbjDxRXOEZBBQhR
 cCFHDyR0SBHwklxwcQxUZFEw5LLXDpU6RVdrUEp5rSqaG+Ej2yh5XAkB5aSQgHlOfPSuI6AU9DS
 Z4vif0MJozcwfKgga4gUfLkzZuGesYdUGsShRN7kNbgtT6V+qzjwVFZTdtkMgxizvM/dUq2Whyp
 i3I5RYRv9Edc9xTTb5CFi2t7gK06K4=
X-Received: by 2002:a17:907:2d12:b0:c2d:b9b4:f4d1 with SMTP id
 a640c23a62f3a-c31a9a29d5bmr1742275266b.6.1792088343237; 
 Thu, 15 Oct 2026 11:19:03 -0700 (PDT)
Received: from mbp-2015 (46.205.244.1.static.t-mobile.pl. [46.205.244.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed9b33006sm161790066b.32.2026.10.15.11.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:19:01 -0700 (PDT)
From: Maciej Kucharek <qchcio@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Cc: christian.koenig@amd.com, Maciej Kucharek <qchcio@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Date: Thu, 15 Oct 2026 20:18:35 +0200
Message-ID: <20261015181837.41690-2-qchcio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181837.41690-1-qchcio@gmail.com>
References: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
 <20261015181837.41690-1-qchcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 08:55:44 +0000
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
0.  The VI quirk for the MacBookPro14,3 resets at load for the same
reason:

  commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")

Other Apple SI boards get the same reset if FB_BASE reads 0 at load.

Tested on a MacBookPro11,5 with 7.2.5 and this patch: the panel comes
up at boot, and 4 of 4 deep S3 cycles resume.  Without the patch, S3
resume fails every time.  The GPU reset path is not tested.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5978
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 0adfd4b10..e5e590425 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1512,6 +1512,16 @@ static void si_invalidate_hdp(struct amdgpu_device *adev,
 
 static bool si_need_reset_on_init(struct amdgpu_device *adev)
 {
+	/*
+	 * MacBookPros with switchable graphics put VRAM at 0 when the iGPU
+	 * is enabled.  Any later post (S3 resume, GPU reset) moves it back to
+	 * the vbios default, so reset and post on load to start with the
+	 * vbios layout.
+	 */
+	if (adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+	    !(RREG32(mmMC_VM_FB_LOCATION) & MC_VM_FB_LOCATION__FB_BASE_MASK))
+		return true;
+
 	return false;
 }
 
-- 
2.55.0

