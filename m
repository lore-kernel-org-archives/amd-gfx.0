Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07477CD5BD2
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B2910E2A0;
	Mon, 25 May 2026 11:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aVw5Rphc";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9602B10E2A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:45:12 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so99553605e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779709511; x=1780314311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqY+uznyizqSjIsihQ7f34/Plj9lozDTO+AqBjdp6/8=;
 b=aVw5Rphcp2fzwhTkQCy1Zt5R17tks6sdSlHfJ5YSkgRxN4vU6JkPWsFY72N2EqIQJc
 NI/t6ibhpK53RB36yINYLmGRMNBNKA5SBMQP2zElDi77UDUoMjyGs7iGtk3DZUiJxtxo
 ej7S2D9eCS9KponN3YR3h7xtGgZjqw7qblpKKeuF4a1b5VWiNNPmWzIsVWw4BdaNMM+p
 LV19sHOpZHyUNqTu9dfj5KZiyV2AMMJrKJ8CUvC3cxkiH6TPvvHZhw6x2eKg2o0xVHSO
 ToBuCwEkA4Vj5qPDLesyRmkT28VLCuWr14pSIktygSUJASINenq6q5+Cx8JhcQiDJzVO
 km7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709511; x=1780314311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqY+uznyizqSjIsihQ7f34/Plj9lozDTO+AqBjdp6/8=;
 b=AQ31HLBVYTimMFNEPeoV/OzCiNdtuqpVLJPszQSo1Qfk2lA2u/2XK1guMr25eGTatP
 w3o4/pFwQVDm1x+4sCMMKjTLbjcgz475omhJaBbnpZL+f2FuJhzCb466MrsVlucxJedI
 NFGVijIEKiG8DboCLWS7+Ya3Pq2wKHNyk/EErQEelRlUk2k8OXyTSly4UhhFllbQmpY4
 MM4zTkbiu8IPTMIRE80DSxFvfel8pz3H8y/9pb8rTB0hGJOf21VZU7ehH7d4k5Xck4qE
 hLQBM9L/9YOwq02MpR2KiuZxoQv7ZoBqio0fa8yCz+MRbohO7gynPJIps+2rvjfiCZ5R
 Aang==
X-Gm-Message-State: AOJu0Yx42Knrn0cyJaAK4NCJ7x67zWFhRm2y1ID19H2C/zPxdQtDNww5
 2R8QqtRXS/zERyHZnFi9dNvrJ88RlJwsCkUIS2K3qfPh2FUMTQ6rVllJBErrUw==
X-Gm-Gg: Acq92OG+S8Dq7zSkH4ym4j31bw/wlkDUTJDzwe4YeVqWHHVarz92Ix0I4/XiX/nOCim
 Nmvu3hgSEtaCNi1/xgF+AT9PVB5/OsjoOzGtSDAm2jRagw14WzDNk9GSGaM1M5SV2S+tXPidjz2
 Z0Tu7mItGlYLOOl2xBdzaHIgHPhdt3tHuDDR4281Vh4QYhAssNQSCU91IWB1m/zQJN9/39F68ut
 EyE/o6i7AOzhreDQwh663tiPpEzG2Px4VBqK8kFKZp3MWSu4t1AJKDXdWbSEKe6jg+VpN5rbMDn
 JOCVbytP24+se3nA0n3zqyTbn6rHn0e3hYuAjH8NIB/kTy4vqcrrSiiGoK4n7nKRFtq6CGM6Hvq
 S95skCW2Fw5Tv+wR5SMyzP7WyikFB7VpCoqqHXK+mgmPBt7usOmMPy2nf/2wjuOYYxUEp6XGGBW
 dFLCvWXB5zMdGfUOpoSTyD3MfbOWX9yFULHmREDGFnwny6dnhHoRD6s6X+9ohX8RbW
X-Received: by 2002:a05:600c:674a:b0:490:5057:f5f7 with SMTP id
 5b1f17b1804b1-49050580a91mr159945865e9.11.1779709510768; 
 Mon, 25 May 2026 04:45:10 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm365533885e9.7.2026.05.25.04.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:45:10 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/7] drm/amdgpu: Use gmc->noretry instead of amdgpu_noretry
 directly
Date: Mon, 25 May 2026 13:45:01 +0200
Message-ID: <20260525114507.24566-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525114507.24566-1-timur.kristof@gmail.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
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

