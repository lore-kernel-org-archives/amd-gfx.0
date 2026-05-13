Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BD6CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 16:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9035810E34B;
	Wed, 13 May 2026 16:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pFeOahUu";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931DD10E34B
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 16:30:48 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488d2079582so73038585e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778689847; x=1779294647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhO5t7nRFPwv4olVlC9fcJwZKMhaya7wfKed0qKonKg=;
 b=pFeOahUuoeavmc/4Lhqn5lxRvOhkBc1DDszO6PyLp+PElY7oWczgO38GQ0xqAOHifN
 5WUSvMB3qcjaSHS7fe5YN0y9+JmcjBKbaEc8UP0KJ6ws2XXigZDzv8SMvCAPj7ED7uLo
 d8EzCQtrFt+hW4R9266Ttfoi62hAyuwoduK0tk8u6E8yNTOM0gOnP1hLZO9e2O0QEpf6
 zZPRh3MBHfD8CCMeL6e+lPJeOMhwPNTV9jEi8bY9joc6Sn093m7rHEaT8a9GtOo1zY19
 a+zxbYKDpRs15NcRuuwVKzX0B0e1K+wNUhsoH7iQK/ClyA/eps+lXf352WozqXB3Bvuc
 dS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689847; x=1779294647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HhO5t7nRFPwv4olVlC9fcJwZKMhaya7wfKed0qKonKg=;
 b=K8YMTRkIKU7fPJUSxDbbEKJTpxZdYE5bGgGYD0pYJJixAsBhwLxiKbzMXTFl1XD9Hz
 T5lha6cuOnUk40D5U8qRQg564hQPhZ6X5BA1qvFDamAyXTTqn8M7FJc8RI6OhxP+Hjdp
 OZuJidK1csY+yhfRlp5GenOSQtZn+1sgkIQQFarn1ybbyWUhz3FCAhhm1ryaNuzn/fhc
 jqmJDwVxsKwoxt0lEyyFbLxzY4OPUuZvbCdEei0SbFN0Nwa5TBwDoRJwyRT8G5beHU0U
 +V4NcMf7Bqj2cv633xjy4fqh0G3s0zbGzOK6DJbVfiDEdKKXnRsgnuOCU/yfB9d/PTAN
 lDKw==
X-Gm-Message-State: AOJu0Yzxgt3uATUcn9n/LF0NcrcbCvKJkTvNLFdepx+D+zUGpvDjiasy
 CNsXCm0eAvHVLmsFemFx1j+2bKbtO7UUWLu2KHXrSOo17XDcmxOmDsY6dD9QMg==
X-Gm-Gg: Acq92OH0mW0T/odpUVkkrbKOifT+X8TpjVyxtFKhF83PDlaxdSxQkzLV8vFHNELY+7r
 z+YW9vmHJdqQxv5ONI+zZWqobWoDWhNjTqm4/SGzc9M+PxsJVqU1P2yeWJZiL9Jyx6dvsiTOGGJ
 IMqwoPDudP94aEETMWoZB3miwlzGZQW14d8sarfBBdgDLkNuSjvmEFF9yiIsR5hz21Y55THdOZV
 MQL32oC50MtYnmpOXu3YHJdW4tahuVDWJWBR/V7TCR/HWQAnFF/dRq42GMSNNEmDsCiifrU1u/m
 Ddox8TTq75+OsBk4BXTxK+cb14uEhUXwq0zvWz82unLMukQBfTo6sIqP7Sx91Dxo7/TYwhLH+OS
 O6WizsEE6G/i0lRU/GN8euYm9kQQgCut1myo4UfVBDrJ8lsfKCEpp4FkD3CCheDquXOk5j0HpG1
 fyqoa4E4DRmg8GZZys7S2KlSoEqaBTDKPdDwoiArtnotn2nrP1oOQ9gDN4tS3OJnon8XrN
X-Received: by 2002:a05:600c:608b:b0:48e:5990:96b1 with SMTP id
 5b1f17b1804b1-48fce9edc64mr49374545e9.23.1778689846706; 
 Wed, 13 May 2026 09:30:46 -0700 (PDT)
Received: from Timur-Hyperion (540017BE.dsl.pool.telekom.hu. [84.0.23.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64b5271sm1846385e9.14.2026.05.13.09.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:30:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/6] drm/amdgpu: Use gmc->noretry instead of amdgpu_noretry
 directly
Date: Wed, 13 May 2026 18:30:38 +0200
Message-ID: <20260513163043.8725-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513163043.8725-1-timur.kristof@gmail.com>
References: <20260513163043.8725-1-timur.kristof@gmail.com>
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

Whether retry faults are actually enabled, is determined by
the amdgpu_gmc_noretry_set() function. The rest of the code
base should use gmc->noretry instead of the module parameter.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c   | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index f9949fedfbb9..f845ba698b40 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -321,7 +321,7 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 7609b9cecae8..ba78b5a1a7cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -326,7 +326,7 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index abe30c8bd2ba..631f99e3741a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -318,7 +318,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index b3ef6e71811f..8a87410ce016 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -323,7 +323,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 3d82cfa0f1b5..ab56dd15b3f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -340,7 +340,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index a1b0b7b39a42..6522a89379b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -333,7 +333,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 34e8dbd47c0f..23cf95783264 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -339,7 +339,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index cfce7e1297d4..98568c72c2be 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -451,7 +451,7 @@ static void mmhub_v3_3_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
index bef75c4c48d3..c9fb48992a2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
@@ -334,7 +334,7 @@ static void mmhub_v4_1_0_setup_vmid_config(struct amdgpu_device *adev)
 		/* Send no-retry XNACK on fault to suppress VM fault storm. */
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-				    !amdgpu_noretry);
+				    !adev->gmc.noretry);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
 				    i * hub->ctx_distance, tmp);
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 29f7ed466858..49b7f16a941f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -518,7 +518,7 @@ static void mmhub_v4_2_0_mid_setup_vmid_config(struct amdgpu_device *adev,
 			/* Send no-retry XNACK on fault to suppress VM fault storm. */
 			tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
 					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
-					    !amdgpu_noretry);
+					    !adev->gmc.noretry);
 			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_CNTL,
 					    i * hub->ctx_distance, tmp);
 			WREG32_SOC15_OFFSET(MMHUB, GET_INST(MMHUB, j), regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
-- 
2.54.0

