Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581EECD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE8510EB23;
	Tue, 19 May 2026 08:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ChnmD21A";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E3610EB17
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:22:11 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso19947765e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779178930; x=1779783730; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkkxDlPQxkgfiWwzk3GrlqZFueDePNk5jc6JeVbxfPg=;
 b=ChnmD21AghzjCTNVS3STPgm5fUVKhPJL+TwkcviG+NM/Hcub5d17SQt2FenO+nXdXZ
 Qj32Hbx5tVSKfqOUr9jWaqLiiAjMCdu2k9Uauu0X+kMj9IVbSqvmephfavPFJC62jG4y
 HjbY/avS5ZlHcAdvzStC1Regzp1Lj5fqUnkFaZZTe/ZR3jz8Rr0YrNnQ1u/GDCt8PYDC
 oZAPsIwKS/8UqBTXdLuocxxw5Nj9DG4AGeQRqZdrOhVD9/Zjfj3EsW0la/VDwWwgv+EA
 +xTcEBlUSZl7xKKgkxDoCJY1ubUJQMC/H2u6LiJtKiCm0d29vxrrNz8H+Bpu/GsQTD3l
 8KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178930; x=1779783730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kkkxDlPQxkgfiWwzk3GrlqZFueDePNk5jc6JeVbxfPg=;
 b=aS9+jWLJjdbWnkQJrB/EPJUc38qMYDq2Hmyf3l+VkbYb1V6RvtR6qdshfgZoYav/i/
 0JawyvwI2OwgYI9OfA2Eac8hTcTQtF5FRhZ2Cuscs85YD7nx8oK+51/79Y33mHEqEzFZ
 sY5PzZryB3ceH7tZdszB64Uz2QYY6nAPGraB3ZijVgovFgG/ddsDZvzwefp0Aa0Q3GFM
 144vcOu5S4ZXH0HF98aG9Xi3Kemp5MfHxNr5uHJ1Ed7UsnsLoC6Pv7WJEQA8d6WlSd0S
 4tAMEmSc01RyDBErwZkFwK9kkduoETOFoIwCE/naQakvBAK3fQwONJAE+hDwRQ251GbC
 KkAg==
X-Gm-Message-State: AOJu0Yz3K+EYbH9ldWHX0MGwk6yjc1hvsQhuD6AlHY2YdPjCduw5jmDL
 NkH27p7zIWfaf5tlEBF4qRikFEIIP37EKpVlRep7ytPFszRMcfmjYp2cpk/1Pw==
X-Gm-Gg: Acq92OEJEQIrL8y4piWFGc/VtbDyUaz60Tcq6tcL73sj8hwGi/qQrKXMKhXh0ohgnkV
 tmEYnYHROjCj8y7/DF7FuPJT0VDDulMSQfuQ7xxXZHe47mPu6j8naNWxax+V177ONImQa5C2A1E
 qR/R3cmBBKePFPwxBts1nXvSqFdbzfvsMCXjIehmbhDdRQPcTAfDZE9N3FJiF0kBXxXY2kBGZ9f
 mue1aT3tbb2ysdAxQ5BlXVcCH/xXeo8L8hD11SW43c4ST+yMbQ9GqZV3S63MIXMjKhK3kq3Lqay
 CAUjRik+vw6RwkMtLdsyLlZy5n1ED/HfgnrjVjdhf6G4j2zAG5i77JR8xuZe0fNNpZvRTuJw1Pk
 dkTnqKRXYLarzY1d3ZQ/JjQiE6yw+T1Ow2oeRCKEx8SZTFs3v3L2+RQUbEie6rbx97ZuTjvLzVW
 0psTEt7l2+p3ym6C2a2xu2kER+HlPqKUPSitJj+t6km6mBsNV6+DRGXt9NzMH4J0USwyuTy4MNe
 2E=
X-Received: by 2002:a05:600c:3e07:b0:48f:d1c0:721e with SMTP id
 5b1f17b1804b1-48fe60d7823mr297033565e9.12.1779178929901; 
 Tue, 19 May 2026 01:22:09 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm101575685e9.13.2026.05.19.01.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:22:09 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/5] drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD 4.x
 and older
Date: Tue, 19 May 2026 10:22:02 +0200
Message-ID: <20260519082204.60811-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519082204.60811-1-timur.kristof@gmail.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
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

These UVD versions don't fully support GPUVM and are only
validated to work when their VCPU BO is placed in VRAM.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 3a3bc0d370fa..1e59ca924abe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -188,6 +188,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 	const struct common_firmware_header *hdr;
 	unsigned int family_id;
 	int i, j, r;
+	u32 vcpu_bo_domain;
 
 	INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
 
@@ -319,12 +320,20 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
 		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
+	/* UVD 5.0 and newer HW can use 64 bit addressing. */
+	adev->uvd.address_64_bit =
+		!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0);
+
+	vcpu_bo_domain = AMDGPU_GEM_DOMAIN_VRAM;
+	if (adev->uvd.address_64_bit)
+		vcpu_bo_domain |= AMDGPU_GEM_DOMAIN_GTT;
+
 	for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
 		if (adev->uvd.harvest_config & (1 << j))
 			continue;
+
 		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_VRAM |
-					    AMDGPU_GEM_DOMAIN_GTT,
+					    vcpu_bo_domain,
 					    &adev->uvd.inst[j].vcpu_bo,
 					    &adev->uvd.inst[j].gpu_addr,
 					    &adev->uvd.inst[j].cpu_addr);
@@ -339,10 +348,6 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		adev->uvd.filp[i] = NULL;
 	}
 
-	/* from uvd v5.0 HW addressing capacity increased to 64 bits */
-	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
-		adev->uvd.address_64_bit = true;
-
 	r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo);
 	if (r)
 		return r;
-- 
2.54.0

