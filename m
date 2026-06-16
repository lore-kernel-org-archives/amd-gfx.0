Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A84CD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 07:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0BB210EE44;
	Wed, 17 Jun 2026 07:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="TquJnotm";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C7A10ECF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 18:43:17 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-9159951f05aso538990785a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781635396; x=1782240196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dd83DKF3frqmG4DXmGPzNS34lS70vyOR5YrJhziAaCg=;
 b=TquJnotmrTH2YNFI75AnpJzkBg+P8iwc46FjiIKaFgT5Id+NiAwyhPvtM5t/UDgfat
 NhGDk9KdsxsDwlmq/vzDT88j3T6n0E9rbNG0wxUnC4nAK8pRt8rDmDTm4u5NjFXYFhsV
 6lTcHjT4FC43bBf2UI/V1gOdVGZXW77Vfv12MiuGjSxGy3co5V5fLjUloEmdF3HN4BBU
 zPlmM/YDww8sdsS8712HZ/MmjczNnW1wxKzHSfUHiOHIt53EtkB66nndIH7ogfwubjyM
 yHe/MbM3GmzPE61KMATy2204tsnlVbbgO4aiKe/b2Dj8OaFEsBvmwRSYrjfb9vTI6z/8
 ItwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635396; x=1782240196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dd83DKF3frqmG4DXmGPzNS34lS70vyOR5YrJhziAaCg=;
 b=DQwT0ImkpnyJqC5IqJZfy1rxiA1iESjCmWafgNsNIPSpOx39S6Jrs98eyOLdaCk5SD
 OT4vrEWRAgisg3JFTQ3RqcK2kfeBL9QJE7j2OclECe1U/NSeedAbid5hzCOIYoDqM0rw
 DgqCal7Se6nsRqjEf8VZeQV6JBuSZGyqlv0K19+UozhHEeBXVAJxhvIK/JgMR44vwsUo
 cOVm0znqk6jdIQb+M068ThLid0EOeBWHxCH91z8oNeM0vJRc/yQ/ca2rYgbjyMh+4sHc
 ZPclOnYQoxAAG3qX4VbtNW1e63rsXTyasomsVLC0aezXSbUL4Wcm98unUC+buddn4Mlv
 CQkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ80qiPIc/TG4blwsMZaAwL+AkR3VGYE5wB7MtPgsCOAxszMQqY1hv6s/DZ10MBDcp++CKF4fvKp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwroVcV3rgdFv0vpVf75umq9NdUIV5SLjwgnEWpN1d6SpHTG67L
 mAVJQQAHpMlqtZJHu34j0SXttAFEG6d2hR5aFDbhWn/g4qkaYfvwnkmpTSs+GfIWslw=
X-Gm-Gg: Acq92OFRVGF9eSWQyU456FoXU8Fh5fJwKLhTxltasPqMlKpCkjkaETItEepUDwl68nf
 czVkwIPCj8Yx+SLGsp5srtRVIZ4GXDj1UBA5V1U7GzjzhANyPRHol45nEM8DbHSzlMpo4KkYumO
 ijBUXXUZpmu1SEBgAHT1NBK+DAerI2cNuxsfIbeF65URcBPwrhVdmPZgDz8UOlz0IYp66R9lBHV
 CDTwzXn1+9WbcUAoMFuIZNfA74SIB10Hm2A4aqE3rFOhApysx8575fEr5Fvcbed9c2PnxEhPCSo
 sQ6gmE4a6t2BIK2PR3maldSQPq0Z+vwaA82mmS+aNXdTmmGUBYl0RbFjP2/5k720k+jcJ7FNvbe
 HbXu6EuznKwzcCZRmB8A1pC7OxK6CorbSD7DpjeLji0/vvx6HyN4VaLynblMzAr1DuTnfixkt6g
 M=
X-Received: by 2002:a05:620a:4727:b0:915:86c6:8432 with SMTP id
 af79cd13be357-91db9a804aemr31412185a.14.1781635395939; 
 Tue, 16 Jun 2026 11:43:15 -0700 (PDT)
Received: from arch-ideapad ([2804:388:d03b:e57f:9ee:2b4c:ee76:e0e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619ed7f16sm1504660285a.1.2026.06.16.11.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:43:15 -0700 (PDT)
From: Ryan Oliveira <ryan.oliveiraf@usp.br>
X-Google-Original-From: Ryan Oliveira
To: alexander.deucher@amd.com
Cc: airlied@gmail.com, ryan.oliveiraf@usp.br, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 kaikycintra@usp.br, simona@ffwll.ch
Subject: [PATCH RESEND] drm/amdgpu: Unify vm_fault_interrupt_state logic for
 gmc v10 and v12_0
Date: Tue, 16 Jun 2026 15:42:09 -0300
Message-ID: <20260616184209.18014-1-ryan.oliveiraf@usp.br>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Jun 2026 07:14:49 +0000
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

From: Ryan Oliveira <ryan.oliveiraf@usp.br>

This patch consolidates vm_fault_interrupt_state handling logic found
in gmc_v10_0.c and gmc_v12_0.c into a shared helper function inside
amdgpu_gmc.c

Since the v10 and v12_0 implementations are identical copies, moving
this to amdgpu_gmc simplifies maintenance and reduces code duplication.

Signed-off-by: Ryan Oliveira <ryan.oliveiraf@usp.br>
Co-developed-by: Kaiky Cintra <kaikycintra@usp.br>
Signed-off-by: Kaiky Cintra <kaikycintra@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 37 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 39 +------------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 38 +-----------------------
 4 files changed, 42 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..eebf5c17efb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -590,6 +590,43 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_gmc_vm_fault_interrupt_state(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *src, unsigned int type,
+				   enum amdgpu_interrupt_state state)
+{
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		/* MM HUB */
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), false);
+		/* GFX HUB */
+		/* This works because this interrupt is only
+		 * enabled at init/resume and disabled in
+		 * fini/suspend, so the overall state doesn't
+		 * change over the course of suspend/resume.
+		 */
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		/* MM HUB */
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), true);
+		/* GFX HUB */
+		/* This works because this interrupt is only
+		 * enabled at init/resume and disabled in
+		 * fini/suspend, so the overall state doesn't
+		 * change over the course of suspend/resume.
+		 */
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), true);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+
 int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 676e3aaa1f27..386e5f292c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -437,6 +437,9 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 				  u32 cam_index,
 				  u32 node_id,
 				  bool write_fault);
+int amdgpu_gmc_vm_fault_interrupt_state(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *src, unsigned int type,
+				   enum amdgpu_interrupt_state state);
 int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8523833a74fb..4aaa3c65e186 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -59,43 +59,6 @@ static int gmc_v10_0_ecc_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int
-gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
-				   struct amdgpu_irq_src *src, unsigned int type,
-				   enum amdgpu_interrupt_state state)
-{
-	switch (state) {
-	case AMDGPU_IRQ_STATE_DISABLE:
-		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), false);
-		/* GFX HUB */
-		/* This works because this interrupt is only
-		 * enabled at init/resume and disabled in
-		 * fini/suspend, so the overall state doesn't
-		 * change over the course of suspend/resume.
-		 */
-		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);
-		break;
-	case AMDGPU_IRQ_STATE_ENABLE:
-		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), true);
-		/* GFX HUB */
-		/* This works because this interrupt is only
-		 * enabled at init/resume and disabled in
-		 * fini/suspend, so the overall state doesn't
-		 * change over the course of suspend/resume.
-		 */
-		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), true);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
@@ -168,7 +131,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 }
 
 static const struct amdgpu_irq_src_funcs gmc_v10_0_irq_funcs = {
-	.set = gmc_v10_0_vm_fault_interrupt_state,
+	.set = amdgpu_gmc_vm_fault_interrupt_state,
 	.process = gmc_v10_0_process_interrupt,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 586703ec0dfa..d3eabe3b6dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -53,42 +53,6 @@ static int gmc_v12_0_ecc_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gmc_v12_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
-					      struct amdgpu_irq_src *src, unsigned type,
-					      enum amdgpu_interrupt_state state)
-{
-	switch (state) {
-	case AMDGPU_IRQ_STATE_DISABLE:
-		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), false);
-		/* GFX HUB */
-		/* This works because this interrupt is only
-		 * enabled at init/resume and disabled in
-		 * fini/suspend, so the overall state doesn't
-		 * change over the course of suspend/resume.
-		 */
-		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);
-		break;
-	case AMDGPU_IRQ_STATE_ENABLE:
-		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), true);
-		/* GFX HUB */
-		/* This works because this interrupt is only
-		 * enabled at init/resume and disabled in
-		 * fini/suspend, so the overall state doesn't
-		 * change over the course of suspend/resume.
-		 */
-		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), true);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
@@ -160,7 +124,7 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 }
 
 static const struct amdgpu_irq_src_funcs gmc_v12_0_irq_funcs = {
-	.set = gmc_v12_0_vm_fault_interrupt_state,
+	.set = amdgpu_gmc_vm_fault_interrupt_state,
 	.process = gmc_v12_0_process_interrupt,
 };
 
-- 
2.54.0

