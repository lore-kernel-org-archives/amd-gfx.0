Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8716C982D2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 07:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F285710F226;
	Fri, 18 Sep 2026 07:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iAR2/6yS";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2882D10F08A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 19:15:25 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f8694aeso82554766b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789672523; x=1790277323; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UVO42avi1AUnneieHW+g4jz1dvgdxwcJ0ctKNKrRziI=;
 b=iAR2/6yS2LRdsTLru3rvafZOFu5L8Nn/Rw0XQarPxcvuYNhLm8G7c/31K2O+DOw2Uu
 zExKri7Z/6IbD6lEjejm/uCcO/crSs1SkUWPtgJIMxK5P/qDNOJ6ifqg3DzFGeJxaH8v
 QmvYqo6nUdaXB2kA5XZjBnOjbviE2A/QbY5J6/GytyLPX4iASH91vWTPH9Boigv2KP/w
 S5xRZTjZkDcprW+Ih6eX+l6rJd+niQMPcQFRyhSoaF+Bwvxai75mKK6/nFD+VvgBIBFw
 8iVXnsWnKxbyCXIVfl0er9tKMMNQoUWneo7wuLxweXjnVs92oSsG35B3t9n3olxDgYoI
 xCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789672523; x=1790277323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UVO42avi1AUnneieHW+g4jz1dvgdxwcJ0ctKNKrRziI=;
 b=pbRg6lcin+wFa4r4Y5ZhxZ1g+kqxpkHhQoX5MvKck9SG/VyvFvCoXt6sVl9OWSzD4+
 mg/sBWiGCsJzehpdY/P1DBLGsnH08sMNb4uhnINWSijW4Q0W0YA++gp4qM8YYtzmu1Lg
 g870BYe/DdNnt8TaRPathIgtCeGjGgEruboUGbAuW4oIGLLmjqIN3uSdOLizHLQRtcOm
 Dnpid9gQXukmuQzSm5zJBxa9sfvgEBsUBktKMYBbHlnfKYDp3r6v/yHgrMrrWxYOSTr0
 uxuOQPCsOCHfyS6sIM5uzviXf0nh3aNy/w/w/KbmWENJ4sNfYJi5mNO6a6yTpfDr5n/L
 4MvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPBfE4/vWfU3Y3BCfScF+cFOT6gq7XOm5V3cJ04ojMmUg3LkXbJTOJFtwp89gREfi5PQMLh7OA@lists.freedesktop.org
X-Gm-Message-State: AFuF++nQEipixaxx5bROpeq8Xf4Kj3J3um+CLf8BohKbpH8Xnsfrnl4f
 LsQOyduTUpvWhFX69j2OI7iLYygNXDeg6pfstC8HchVaC/q9OlvxaJXF
X-Gm-Gg: AYBFou2vhctBU/OG5/n2VW87Hr5ncyY+rtnldUQRR6LNtAx2GnBZQxgXA3DNXIb1klR
 fXqzH71exEnYHB07eZrKq1d/Cv1v0lRy9GZ9mTZamNTumt3XwUgo0gxWsVwFXt5tbu0UVZ3Hpsd
 E19cwkap7oDLEcdTUUK+NRTtDCCxNhj7oPaQj4nAQ2+7AxaOVKRr6teglnp8D9gIYMDvCYvf8ju
 OQftAtGRy6dTSOwks2xNt7I3LVj68/+mkbntn2iA2Nuth13S/9c4I67OZ+9DZNZL5fyGjFvBS96
 AhAYbhuw6V31uLRejCZLbVAGolN/cmRo220GMaARqovvkRxDvNgCuMGl8+DzDAzd6Q4SlnPrTB9
 Isftm34Z8d7CaItvhKPs8GlW5CwZ+Sf5ZdWloPW6ria6ua4VVM4zdYPwMCFumAGPklQNOKYeC+y
 AM+XOaGNEDuTXejKempR+QCOrcP8l3YJhHRYYEQLCQeB0UvDR9ljeTPqnuDT517r2+Y5Q=
X-Received: by 2002:a17:907:9703:b0:c24:6382:2648 with SMTP id
 a640c23a62f3a-c2a16403e1fmr9238266b.5.1789672523059; 
 Thu, 17 Sep 2026 12:15:23 -0700 (PDT)
Received: from cartold ([77.213.69.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de454b4csm333264166b.17.2026.09.17.12.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:15:22 -0700 (PDT)
From: Theo Andersen Carton <andersen.theo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kai.heng.feng@canonical.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Theo Andersen Carton <andersen.theo@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: skip the noirq suspend reset for a
 switcheroo-parked GPU
Date: Thu, 17 Sep 2026 21:15:12 +0200
Message-ID: <20260917191512.38838-1-andersen.theo@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:44:40 +0000
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

amdgpu_pmops_suspend_noirq() resets the ASIC unconditionally. When the GPU
has been parked by vga_switcheroo it has neither power nor a PCIe link, so
the reset cannot reach it: pci_set_power_state() reports the device as
inaccessible and amdgpu_asic_reset() returns -EINVAL. A failure there
aborts the entire noirq suspend phase, and with it the system suspend, so
the machine cannot sleep at all while the GPU is switched off.

amdgpu_device_prepare(), amdgpu_device_suspend() and amdgpu_device_resume()
all bail out early on DRM_SWITCH_POWER_OFF. This callback was added later,
for an unrelated reason, and did not inherit the check. nouveau guards
every one of its PM callbacks the same way.

Bail out the same way here. On a single-GPU system switch_power_state is
never DRM_SWITCH_POWER_OFF, so this is a no-op there.

Found on a MacBookPro11,5, where the Radeon is powered down through
apple-gmux so that the internal panel can be driven by the iGPU instead.
Every suspend failed in amdgpu_pmops_suspend_noirq() while the card was
off; with this check a full S3 cycle completes.

Fixes: 9e051720f9d3 ("drm/amdgpu: Ensure HDA function is suspended before ASIC reset")
Cc: stable@vger.kernel.org
Signed-off-by: Theo Andersen Carton <andersen.theo@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5c33c19fd9bc..d9d794a7db96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2664,6 +2664,14 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	/*
+	 * A GPU parked by vga_switcheroo has no power and no PCIe link, so the
+	 * ASIC reset below would fail and abort the whole noirq suspend phase.
+	 * Bail out like amdgpu_device_prepare/suspend/resume() already do.
+	 */
+	if (drm_dev->switch_power_state == DRM_SWITCH_POWER_OFF)
+		return 0;
+
 	if (amdgpu_acpi_should_gpu_reset(adev)) {
 		amdgpu_device_lock_reset_domain(adev->reset_domain);
 		r = amdgpu_asic_reset(adev);

base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.55.0

