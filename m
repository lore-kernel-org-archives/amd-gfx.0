Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C382EF588C1
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D0BB10E5B6;
	Mon, 20 Apr 2026 13:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="RCgYpsx5";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDCB10E15F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 03:29:17 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2de831d2b20so5158850eec.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2026 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1776655756; x=1777260556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2YUykogMSTzdKl7l1H7YGxOELJxyyASGqYoQwq+uteU=;
 b=RCgYpsx5YH4sEXktyP/rBVXutHaF/0WaILkgpqzZv36U9r3ueZbslSrjtp179B7Y5h
 mqfsnTE5dLG5ZbWwi9GXC6iPKFalhDO/mNLcwlP4qJmqSutm55I69++gcywn2bbEVk1T
 0+yYQDTU9meTqM5x0cMpuFGa9I0P8g/SA3q0+xfXtaR+QMbMZFv7Cxgqd6ogYoZpU/lH
 k+6jesyqB2kiyFlT07BKfFMNb1cDTlZFUilLHRzNewjjpQEvbL3swvU9m5m/5s1QQDAO
 B9c/3F1UmkoKSwLglYo284lidKAq0IK6qRdY1sBFDh8+0YunZWoCHsW2h8PE6ZdE6X5F
 EXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776655756; x=1777260556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YUykogMSTzdKl7l1H7YGxOELJxyyASGqYoQwq+uteU=;
 b=UR22Nexxmp5xW3TGMgqxkOmSWXIxNVg5p5J7StYccEMybW4Y4NaOoUjYNhx/2xDal+
 U6LXlY754NCjJGsoCRhXDyz1TNajkuvED+BJdiwG0IJ55v9PvzpDciPvW6cR4FKUjT5y
 G8i6eQzjZoLC/TBsqWet76EVS6dEyGr2iapAa202xZIB94Q+QT14P888mmgs7lfi3Fpx
 S9FMW1HBAyYfHwtqoNts3W7SqPHcOh8B9Bt/0Sn747Cis9VOcZtCwGeRCTkdKptFyfhf
 rvlsyNQ+fCY2wiN6QHXyLKx1XdoVKUQpzxsbWo3Y9zh0tJfBIWl8tVZPVFfeVOjFCHtC
 9GOw==
X-Gm-Message-State: AOJu0YzAdvNWacAVYu8ZKTdGJQzm1VnOeWKccAciZn5CJNzgIbhKUtjg
 TekW6Z4B4p+rDaLEblEYdTjAUjYuT/Y7ZBnAagyWA+b0CEjj73jLGOzRcHrcFOUPNmP1+1CEdnO
 eaKiU5Ak=
X-Gm-Gg: AeBDietb+wrpGDMbATATm2f2Dd120+uRD+n0pdjERYYmDQjWTws7m2uWaIuVBhaFGzd
 nu+v1124vHmtK3IfasM8sjdp7/Rb7oFRaoF8CbI5FD1TzR6motEYRshbxZ5fhvkeLjLLsjU6Qso
 BUoc7DKLWG40cSu6V1H8zmKdX4e9nYTs0OT7//zFQ47lz90nzh5Nip7Aw/PB+toQjGtk+Y9AyBV
 AUzpYPdV2YJWacbBYe+SqN9QO3nR7PsHqh+5g9qRVSWJmrnbnV56XLbiNZFrKnYz9m4tBcdRvLL
 D9w1w+KYG3SRCEkTWf7JgN8Y0yvHXaPnTqBtcMAEdbp4wmEM73FYwgG1QZ/UCt690SWGatub6Zq
 GN7Ay6EXH7AX72qdC3TtM7Kavma4dHz+Fb8xc4to/FyiBcKLvolAmk6Q7TCZpxqn+GeuWYcqsUi
 rAGxny4wdnOWNc9MQ4FE2q5uHi/gU=
X-Received: by 2002:a05:693c:2c10:b0:2c0:e404:8b08 with SMTP id
 5a478bee46e88-2e479418ac1mr6479116eec.29.1776655756266; 
 Sun, 19 Apr 2026 20:29:16 -0700 (PDT)
Received: from fedora ([187.21.59.138]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53a4a80c7sm15358484eec.10.2026.04.19.20.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 20:29:15 -0700 (PDT)
From: Giovanna Uchoa <giovannauchoa@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: consolidate SDMA trap IRQ handler
Date: Mon, 20 Apr 2026 00:28:56 -0300
Message-ID: <20260420032858.10286-1-giovannauchoa@usp.br>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 13:02:49 +0000
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

Move the amdgpu_sdma_process_trap_irq handler from version-specific
implementations (cik_sdma, sdma_v2_4, sdma_v3_0) to the common SDMA
module (amdgpu_sdma). This eliminates code duplication and centralizes
the trap interrupt handling logic, which is identical across all SDMA
versions.

Update the trap_irq_funcs in each version-specific module to reference
the common handler implementation.

Signed-off-by: Giovanna Uchoa <giovannauchoa@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 43 +-----------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 42 +----------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 42 +----------------------
 5 files changed, 47 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 321310ba2..4f15334ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -147,6 +147,47 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
+				     struct amdgpu_irq_src *source,
+				     struct amdgpu_iv_entry *entry)
+{
+	u8 instance_id, queue_id;
+
+	instance_id = (entry->ring_id & 0x3) >> 0;
+	queue_id = (entry->ring_id & 0xc) >> 2;
+	DRM_DEBUG("IH: SDMA trap\n");
+	switch (instance_id) {
+	case 0:
+		switch (queue_id) {
+		case 0:
+			amdgpu_fence_process(&adev->sdma.instance[0].ring);
+			break;
+		case 1:
+			/* XXX compute */
+			break;
+		case 2:
+			/* XXX compute */
+			break;
+		}
+		break;
+	case 1:
+		switch (queue_id) {
+		case 0:
+			amdgpu_fence_process(&adev->sdma.instance[1].ring);
+			break;
+		case 1:
+			/* XXX compute */
+			break;
+		case 2:
+			/* XXX compute */
+			break;
+		}
+		break;
+	}
+
+	return 0;
+}
+
 static int amdgpu_sdma_init_inst_ctx(struct amdgpu_sdma_instance *sdma_inst)
 {
 	uint16_t version_major;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2bf365609..ca4fd94ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -203,6 +203,9 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry);
+int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
+				     struct amdgpu_irq_src *source,
+				     struct amdgpu_iv_entry *entry);
 int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 			       bool duplicate);
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 120da838a..1bf1af633 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1141,47 +1141,6 @@ static int cik_sdma_set_trap_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int cik_sdma_process_trap_irq(struct amdgpu_device *adev,
-				     struct amdgpu_irq_src *source,
-				     struct amdgpu_iv_entry *entry)
-{
-	u8 instance_id, queue_id;
-
-	instance_id = (entry->ring_id & 0x3) >> 0;
-	queue_id = (entry->ring_id & 0xc) >> 2;
-	DRM_DEBUG("IH: SDMA trap\n");
-	switch (instance_id) {
-	case 0:
-		switch (queue_id) {
-		case 0:
-			amdgpu_fence_process(&adev->sdma.instance[0].ring);
-			break;
-		case 1:
-			/* XXX compute */
-			break;
-		case 2:
-			/* XXX compute */
-			break;
-		}
-		break;
-	case 1:
-		switch (queue_id) {
-		case 0:
-			amdgpu_fence_process(&adev->sdma.instance[1].ring);
-			break;
-		case 1:
-			/* XXX compute */
-			break;
-		case 2:
-			/* XXX compute */
-			break;
-		}
-		break;
-	}
-
-	return 0;
-}
-
 static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *source,
 					     struct amdgpu_iv_entry *entry)
@@ -1270,7 +1229,7 @@ static void cik_sdma_set_ring_funcs(struct amdgpu_device *adev)
 
 static const struct amdgpu_irq_src_funcs cik_sdma_trap_irq_funcs = {
 	.set = cik_sdma_set_trap_irq_state,
-	.process = cik_sdma_process_trap_irq,
+	.process = amdgpu_sdma_process_trap_irq,
 };
 
 static const struct amdgpu_irq_src_funcs cik_sdma_illegal_inst_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 93ec52c1f..545077897 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -1035,46 +1035,6 @@ static int sdma_v2_4_set_trap_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int sdma_v2_4_process_trap_irq(struct amdgpu_device *adev,
-				      struct amdgpu_irq_src *source,
-				      struct amdgpu_iv_entry *entry)
-{
-	u8 instance_id, queue_id;
-
-	instance_id = (entry->ring_id & 0x3) >> 0;
-	queue_id = (entry->ring_id & 0xc) >> 2;
-	DRM_DEBUG("IH: SDMA trap\n");
-	switch (instance_id) {
-	case 0:
-		switch (queue_id) {
-		case 0:
-			amdgpu_fence_process(&adev->sdma.instance[0].ring);
-			break;
-		case 1:
-			/* XXX compute */
-			break;
-		case 2:
-			/* XXX compute */
-			break;
-		}
-		break;
-	case 1:
-		switch (queue_id) {
-		case 0:
-			amdgpu_fence_process(&adev->sdma.instance[1].ring);
-			break;
-		case 1:
-			/* XXX compute */
-			break;
-		case 2:
-			/* XXX compute */
-			break;
-		}
-		break;
-	}
-	return 0;
-}
-
 static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
@@ -1159,7 +1119,7 @@ static void sdma_v2_4_set_ring_funcs(struct amdgpu_device *adev)
 
 static const struct amdgpu_irq_src_funcs sdma_v2_4_trap_irq_funcs = {
 	.set = sdma_v2_4_set_trap_irq_state,
-	.process = sdma_v2_4_process_trap_irq,
+	.process = amdgpu_sdma_process_trap_irq,
 };
 
 static const struct amdgpu_irq_src_funcs sdma_v2_4_illegal_inst_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 3fde9be74..b3eab4e11 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1373,46 +1373,6 @@ static int sdma_v3_0_set_trap_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int sdma_v3_0_process_trap_irq(struct amdgpu_device *adev,
-				      struct amdgpu_irq_src *source,
-				      struct amdgpu_iv_entry *entry)
-{
-	u8 instance_id, queue_id;
-
-	instance_id = (entry->ring_id & 0x3) >> 0;
-	queue_id = (entry->ring_id & 0xc) >> 2;
-	DRM_DEBUG("IH: SDMA trap\n");
-	switch (instance_id) {
-	case 0:
-		switch (queue_id) {
-		case 0:
-			amdgpu_fence_process(&adev->sdma.instance[0].ring);
-			break;
-		case 1:
-			/* XXX compute */
-			break;
-		case 2:
-			/* XXX compute */
-			break;
-		}
-		break;
-	case 1:
-		switch (queue_id) {
-		case 0:
-			amdgpu_fence_process(&adev->sdma.instance[1].ring);
-			break;
-		case 1:
-			/* XXX compute */
-			break;
-		case 2:
-			/* XXX compute */
-			break;
-		}
-		break;
-	}
-	return 0;
-}
-
 static int sdma_v3_0_process_illegal_inst_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
@@ -1601,7 +1561,7 @@ static void sdma_v3_0_set_ring_funcs(struct amdgpu_device *adev)
 
 static const struct amdgpu_irq_src_funcs sdma_v3_0_trap_irq_funcs = {
 	.set = sdma_v3_0_set_trap_irq_state,
-	.process = sdma_v3_0_process_trap_irq,
+	.process = amdgpu_sdma_process_trap_irq,
 };
 
 static const struct amdgpu_irq_src_funcs sdma_v3_0_illegal_inst_irq_funcs = {
-- 
2.53.0

