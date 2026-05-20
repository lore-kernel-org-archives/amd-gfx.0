Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED153CD4F3C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 07:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC0F10E477;
	Thu, 21 May 2026 07:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="PZZPPhAG";
	dkim-atps=neutral
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B479610F177
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 22:43:17 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-575eaa32c7cso1829171e0c.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1779316996; x=1779921796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dd83DKF3frqmG4DXmGPzNS34lS70vyOR5YrJhziAaCg=;
 b=PZZPPhAGCvVENZERFvGOnNncyhMUJTmfGgCwgR8AbrC1wnXEAwO1oFpvxz+tLnYJNX
 /mXYSGC3OeP4Isi7qXSjmFciURPC965URQulcNxpIJHWE/2MxGQ8Mr99pWUXceJNctfP
 vSmYBIrp/f7TmdzxNVRKArZbFD5QFJ0u4YVY6CSF5INu7fYAuivQCTPd2BXzCEm3HoR+
 e9SPrzN/VXpH8z/Wg/GR5WQqlFxEsDm885yNVuVFFrWOChGPKjSNcKucM/lZQdDuQDC8
 rWDhp/wxTfb2F2UaERs8ClYttGcpvcznle862KY3gV00wQojw1pvK1UqI6LjTNVleprB
 FBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779316996; x=1779921796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dd83DKF3frqmG4DXmGPzNS34lS70vyOR5YrJhziAaCg=;
 b=s9j6S9MVV4++dajhBkQ2T9mG0PUHrxq26ZcMxY6CKF0FFLEn/9WkH+zg3LR2XdE540
 EXoa7VDAZ7cKfXI2qfMEnvBcyDjKCoIV0V1aqkTQDM5+QM8LtpIUfghEES5hv4r0W7vV
 WBf2ENzUow1u6liijZ+FPbIimJpATYCq8GLD+N9KF2mtmzbcN5sg4TG0mJws+ez6aar8
 Kbrk/xQNdm64ny63glRa8WHffpLSAgnycty7bCvdcwuz/HWPE636eG6yX97hdCppLuP4
 23s+WGdNbXW2nghISem2zwg0OkDmtY6d6/VFXaRQBnOXytkM2Ef92pwSpGO9QMEbEDwO
 1qZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JRKNc74TzJ5c6FUIhzV8hRQORebGGGLHXpO2co7lWN6Pa/66485BxrGKLYwglqSKTceVwyybx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuGmB+fqQgmRi1YtuE1RQ33yrxfJtThdQ2iWqnxC2zngw4Yg3j
 twfcDjwPIVQeQ7yB5OtMARVIfsCCdKDybn+AOOTWYSwa85OTeFlHPrMfIUj2ge6/QoY=
X-Gm-Gg: Acq92OEaJrXuxh2QP2ZcnhhuYvzxA23R2c9UdokAgnSMVzZDyvUTbwq8plSBgaO6EEZ
 MC7TuGB0qjloVvQakM5MMH7SUotM/EqAn1UJ9SNqKRNMExzMjWTu6CmEwufVrwGeEV5KMeRqtp7
 83SJRlopi5TMM2FjSDYf/7ZhBULlRf/H47plhUlr4iyvycyoffKnRJfiq2yE7z7WJzO615cOJLD
 +IZI7sQGsBhYBHq6CDWdiO+COFHdiSOCWVRIqzjiggFJwJnJNcp/UFFKMIXCWYDJwu0ptAg15Ku
 QR7r9GYobsayUwzDGR8WJCYkl/cwGQCrfj2sz7kJ1qCdbcThzuseppSGfSUDsfYUqhM20lGKVJj
 JZKJ4h4HH6N4lvdBavncs59GOx9dl6WMu+ngQTVPQ08zvqYe2d0tUEIFBYlYWv1m4cVvlziDwuu
 0fIcFIGrTfbw==
X-Received: by 2002:a05:6102:f91:b0:633:3040:ca5d with SMTP id
 ada2fe7eead31-6738e4da513mr294017137.9.1779316996343; 
 Wed, 20 May 2026 15:43:16 -0700 (PDT)
Received: from arch-ideapad ([2804:7f0:3df:2617:4b61:1102:6d3e:92b4])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95fc29cda8bsm11281113241.0.2026.05.20.15.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 15:43:15 -0700 (PDT)
From: Ryan Oliveira <ryan.oliveiraf@usp.br>
X-Google-Original-From: Ryan Oliveira
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ryan Oliveira <ryan.oliveiraf@usp.br>, Kaiky Cintra <kaikycintra@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Unify vm_fault_interrupt_state logic for gmc v10
 and v12_0
Date: Wed, 20 May 2026 19:42:13 -0300
Message-ID: <20260520224217.17615-1-ryan.oliveiraf@usp.br>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 07:01:28 +0000
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

