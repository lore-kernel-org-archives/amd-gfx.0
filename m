Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A23C10FCAC0
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9839410E1A4;
	Wed,  1 Apr 2026 18:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lVz8z4zj";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0670510EA1C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:33 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2c56aa62931so3207548eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003972; x=1775608772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
 b=lVz8z4zjjB+ZcYb+2Vn1OzHNGdN6rWjMUC1A2iZRmFSEcGH6UsLWpqJbXIY4eD7E56
 D5afH6XDH4rVrTd4e2Rd91BBVakYA6jTTVa15dBnCbiiACTZHlnXWCOZ1ePzd3jBNKGh
 rLlsto09d+Tpy2hceki4Su2mheaiqrqVVc0W4HJBVDrEMpdxUGx/tPWW+d32LsgfRABx
 PFwNHmebC/AADeD6RC6g6NAYV4Gzh4qBY3xd/fwOCczrPMi/IJXlH3LNzzhMGJPnYd9h
 z9TDv8TqJp9LGOQy/2Ej1kR0MOygV/sUWKQ3FZJBfVtpdZ9nma2SijYVFCiHCDBfq4pf
 zdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003972; x=1775608772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mqMdpDaaRiGg+2ZN9NqktjEbPVOkWurGFYKafkS7Z0Q=;
 b=s3zq4tQK4pqpiKA3ekMGMIBTfDr7EdzJJNjLj2UODHIxym+8R3YrQrVcbjtmNfDGKq
 AE/+F7zDesBVR6VPSwi1SYTwT6ZCmpmZYLCSynyQM6gRCgsebYbo9+sY9TokAP9Q3oEK
 tvLFoHuT4t/Y4UAHUbvPV6h3rsUG0qKuccmz9uXNCLsMYnSQRy2Vivw+xQBdl21uiZwT
 5UsoD+1TG/1QC3eK+hVMKypm7bARroInhUDHlnYNTnp/7zAmqYKpu3D08JzqRrIn2Wmp
 +UTVW46P9OizauUqPQE1C4ZxZn5faUjVtVxBYxtsbToBqmg7drqPnHOJlTwfP9tDqmjR
 94HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV6PvJI+ZFtocNsHBfGzXV/Fe1vXxJxHHQ0PK8/SM3uRPJSoXspq/745VrPM8JjVICjDeeW+Ay@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywkv+GbO/8KhVmVsYBzdzF5fMQAczCOrGg0qqrLkaSA5MuLdEXd
 BH6oxNtgyRX0rAB1Ss+LXtx/bkBJJ92sYzAY57Y8TYtP+uoau68BXPYf
X-Gm-Gg: ATEYQzw/gZ5WGjOD4vK8Z8792j7uTFldz8/r7rZn22664TejMNEx3yGyBxVZjnnVHy6
 zFop8zPteS9D8sB+cq7yS1HT4eaCpWk/544GqQPrujBBOOkoGWV99VXP9j//Vu5hkCUnnoW0zqX
 0f3P3fY86gpR6hc1jpZM+Wj6S444dW0TaVjjUHn3KTldU4+fKRaOzkmTef4gvqsp1EFYH6gZ6hb
 5pQs5eMnTt9Gfh6oeEe3CNuzz69rwLhjSmEyb54+dPVlWSbYoibQAeDOCZbSKMRkhN4KvHh7sfv
 Qc9hNHbDWRUcKp88hnjkpcqffjFnOHioCaQskzOktUXVZt7xq+JPpy0NC3mmJFZFEnL1xnW+R/2
 PgaYNYuZHq3eTAo5Ya3TM0lzeDNlkrk5R3I0MmZFnfZpLhEcYi7/lOo/MUSF/8EeDEfxehfvs9I
 XeVELSBJUJkR8ogLm+vtoz9pbCcBVxyRYVDAzwSJl5x1rIglz8nuXFzFc=
X-Received: by 2002:a05:7300:3205:b0:2be:837d:cc4d with SMTP id
 5a478bee46e88-2c9309851dfmr1044767eec.5.1775003972186; 
 Tue, 31 Mar 2026 17:39:32 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 02/10] drm/amd/amdgpu: disable ASPM in some
 situations
Date: Tue, 31 Mar 2026 17:39:00 -0700
Message-ID: <20260401003908.3438-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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

