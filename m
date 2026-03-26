Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D1910ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F163910EDCB;
	Fri, 27 Mar 2026 12:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fAPm4hFl";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1343010EB28
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:40 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c741db5d610so783352a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568859; x=1775173659; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
 b=fAPm4hFlTWd+Vmk0N2NAldaV8DjFXR56E12R+GM3VN3pJMh7A3e2Y78m5o4oL0PCyY
 nneXpxdOuPFpavBIwYBdsg/1ct11PdE2qA3nE3col6WD/ov9/6dMg186tHcht56qgEb6
 fur2pt60VZ0O2Nif0TGCSeVY09jQbr5kGkHAYEtoT/vw3JLd9w8rIIZFwLnKCg7AsUnl
 ejReP5IN+s8YuoesfxN+J2YxLwg/JXk5zDkI9HRQWKuCRwMXR4gsVBP5BHVw15xVTXFn
 Ub0FiP2sbh7gySRYsTa+8HoASRIXalZVEvUOx5hU+QoVFCHE43QYwchz1+tx+h9x0MTp
 mE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568859; x=1775173659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
 b=nxrQrAulykU64h0VjmyqphICtVruqEL2c/mQhPY4XRhegvApv85HGeEkzrNZjt3QOc
 7eSnScDK41egxUxPg/Gd96koc7kk8VslxfEsUD+VMbbiNSAEcduy6xcqh2girGegupnu
 pFvfXscEvLEjmJmO/5KfYd0m/si4CIfjKko8wZY3sbTJg52HNtg4Jh4QO4+HAT7MAmIE
 Met+Vcn1JRoUrPpqTI8GoGsIGUaprKLXkm/qeJL/wmHkEb6VJ+4jtgKyYmOupMx9ymro
 xRW2NrrXXjl64hpZKWHbH3UkY+M6AJFIaMn7X5eDYaECBcQQr9ku2hs5xzz2GfVW4116
 w1zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjxEYQNES8YQ3mubjDJGhPwoiFb6saNPWvb1aMdmhnIiIk3v5GQCem56XMgZ4n6hHxZrVvTITq@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5/usEoyTx4bXoB+ESMqC8o/2PIiOJokyKJkJ+4mFCeFK5V5BW
 EfYVdQZ+A9FgRuhJVqr2dEM7s3lZo/but1TfQffHBXBYypAqjib8XPLx
X-Gm-Gg: ATEYQzySAzNjINBH5+miBpfnN6FHy9y0mHIZc5pP9gzLr/epAJvYIkduShVns8/xMHt
 XaomiadzOxn9X27o0Y6nqeX6B2lCUIFXU7g34o188aZJ9UfJa0ATI/+nvDhQNNEQn5I/HoGtQyU
 FYgxwTisc7vH/gNYnC+xHi4saT6TgWPXNmolQ5bkHlzeTA/RNActyMO0wflkNyGCa/8obCg4ij+
 w8R49lOaZMDp3prZCBElZv/Y/pr5g786wUJQG2OggHr+85mz7TEQmQxDlgn4WGjgXezO9eve54W
 dc4NGBHY1BN/x3GLyEjHRR+Cu1L3cC2HlAS2g4UV8phCkLiCB69XZ5Cl8URrO8nfRpQWeVK0SFG
 imLyPM+mBZaNQfJAFonLZzi1ggYwPuyakfzsWdNjLb7ui999hI5LYC7W7rPtUlvEOdd4pRYu+sW
 q4/Kj2DBdupaeAo8e6s7HsOtL8DhnEdQZ1rZoXrn0dt4AaKqYQrvo3pFE=
X-Received: by 2002:a05:6a21:3287:b0:398:9ae9:7112 with SMTP id
 adf61e73a8af0-39c8781ff90mr479262637.1.1774568859447; 
 Thu, 26 Mar 2026 16:47:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 2/9] drm/amd/amdgpu: disable ASPM in some situations
Date: Thu, 26 Mar 2026 16:47:09 -0700
Message-ID: <20260326234716.16723-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:00 +0000
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

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit c770ef19673fb1defcbde2ee2b91c3c89bfcf164 ]

disable ASPM with some ASICs on some specific platforms.
required from PCIe controller owner.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index dbee43c58741..eb3c6bfe2e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -84,6 +84,7 @@
 
 #if IS_ENABLED(CONFIG_X86)
 #include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #endif
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
@@ -1758,6 +1759,35 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
 	return true;
 }
 
+static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 0) ||
+		  amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 1)))
+		return false;
+
+	if (c->x86 == 6 &&
+		adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5) {
+		switch (c->x86_model) {
+		case VFM_MODEL(INTEL_ALDERLAKE):
+		case VFM_MODEL(INTEL_ALDERLAKE_L):
+		case VFM_MODEL(INTEL_RAPTORLAKE):
+		case VFM_MODEL(INTEL_RAPTORLAKE_P):
+		case VFM_MODEL(INTEL_RAPTORLAKE_S):
+			return true;
+		default:
+			return false;
+		}
+	} else {
+		return false;
+	}
+#else
+	return false;
+#endif
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1782,6 +1812,8 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (adev->flags & AMD_IS_APU)
 		return false;
+	if (amdgpu_device_aspm_support_quirk(adev))
+		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-- 
2.53.0

