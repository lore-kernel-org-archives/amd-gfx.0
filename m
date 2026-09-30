Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BDACA5FC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5433510F3ED;
	Wed, 30 Sep 2026 13:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qrn/3G+q";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBAB10F3ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:18 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ff9642c57so9206365e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775197; x=1791379997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k9zibmQW1zZ3+7ob49IAkB3UCtsq5eaWsCQEpx+br6c=;
 b=qrn/3G+qZPhu2W9obz++QxDnAyZE5Z4BBUGND3LQlBtYy6VpFpM2cDpTta6NycDb16
 PlB4ALd7DG7MRyyR7aODMVJfcIJmSZ6YK+q1sh8DfJT/2CwU5lp91hWNyWZz76dgJoIb
 oBSEbqeviwK6rMEm5KguTfyaLiIrZMYVx8U/eixAinW8dDTTw75feKp5a/LBn4kxuwhX
 O6Wx6vYBoG3WqXNc50A0JZ37MHWzzTVMnHkVcuvXdVu42Tz5dROhKE4ZWBNiFn/YfpFw
 K45xRS0o/6eip8xJRodZMilI3/5Q2WpdFb2KxRxw87hFioSkHFuPMwRAsEUS+KBZ7Q/n
 p/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775197; x=1791379997;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k9zibmQW1zZ3+7ob49IAkB3UCtsq5eaWsCQEpx+br6c=;
 b=YhGxef0K/s2az+A8Ad9Y7nGlmalZcQ9FTP+5X2f5m7KQOx9Vx7fxdHW2D7l5+7l8kf
 tptQhBHZgUw7NUjpL9XUuQVxNZEsbRlsX+R1UUTCwMlHUKe6HZ2H3+XXx4dfzUQP4yUy
 Ku/ggJJkBaV04L2NcnCIHW0sTuLrtrytAeLzTFup/7J30tAUZcooK6AoUG2osK9weFcD
 dRWXmdxYoYMnruzNeXFscYsaI05xWIQr+B3cNsrIf8H0ooZL7QILDVA/Nvn8C22ycWXE
 uADvpw8d/oZwYL8yLXxmM1yrZr3cxh1ctbYTD30qCzR6FLUkzduFd64seAHVYMoHvTXL
 v4Pg==
X-Gm-Message-State: AFuF++mmEvgfGuHtEHXncG8Dh1cK7WdxvETAUZdbSwTmaIBWcnfS/lqX
 JXNIkIXJ5js1uWMro3lDphVzAH4EKx/xGoLPQLxgS8X4BLSaGm+GFbpW
X-Gm-Gg: AYBFou0DeY+z6NHyHJCz6IvBEENIXsaB2kPafKaHdSyHmRaigEaVrzQv4JpY4luJz99
 /kbFj9HRPH+aVJEQcwHaNFZpoc0/Mdga2rsRykVSp+gEAXPH3Pso0EAFC4ckGKcZHuku4O30owL
 sjodg3ibBrilAUu+Ddn0Bs8OM1GvyUKO+N2k4G7vjIXSiBXYN9IrWH4ijd3UeXNIDfa/FVWlEdG
 3nPHy2U5xeeRV+y3bcD00+p5QmbiiSwwwPV8LnrOsuDZBw9lfTSzEh1pcj6VYsw7VZH5+tBvQeR
 RWajgOa2Av/cgVP0Qg4wcaMuDrCiEPeel4zj3Fhfu9Hn3ZyKH93SRiq8x8Tfkd+JcDEXJSuFIkt
 R1TI1++Iz7jJ2WYLkOYPxHviz6Kr26QfT9CR+xQ3fC87eR2j869WpgDHp/HUDnNG129QGPOw6+R
 ggDAFdVj7lDHN6GvP3l3BiLz8qbloDLrrRTxMdnrWrkWw0Wou3ws/qefd3vEYqEYVA6XYDhQTDb
 pCX88h1hb0=
X-Received: by 2002:a05:600c:4e04:b0:4a0:1b14:d009 with SMTP id
 5b1f17b1804b1-4a01b188d8bmr25441315e9.1.1790775197039; 
 Wed, 30 Sep 2026 06:33:17 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:155e:6500:f261:39ca:dadd:d0c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01771cf9fsm60407975e9.14.2026.09.30.06.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:16 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com, olivier.kaloudoff@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amdgpu: fix cleared PDE/PTE flag generation
Date: Wed, 30 Sep 2026 15:33:07 +0200
Message-ID: <20260930133315.12270-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That was broken since adding the NPA support.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 64 ++++++++++++-----------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c03327f1242d3..e8f441e018839 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -346,6 +346,33 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
 	     amdgpu_vm_pt_continue_dfs((start), (entry));			\
 	     (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev), &(cursor)))
 
+/* Return the flags used for cleared PDEs/PTES */
+static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
+					struct amdgpu_vm *vm,
+					unsigned int level)
+{
+	uint64_t flags;
+
+	if (adev->asic_type < CHIP_VEGA10)
+		return 0;
+
+	if (level != AMDGPU_VM_PTB) {
+		uint64_t value = 0;
+
+		flags = AMDGPU_PDE_PTE_FLAG(adev);
+		if (vm->is_npa)
+			flags |= adev->gmc.noretry_flags;
+		amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
+	} else if (vm->is_npa) {
+		flags = adev->gmc.noretry_flags;
+	} else {
+		/* Workaround for fault priority problem on GMC9 */
+		flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
+	}
+
+	return flags;
+}
+
 /**
  * amdgpu_vm_pt_clear - initially clear the PDs/PTs
  *
@@ -366,10 +393,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct ttm_operation_ctx ctx = { true, false };
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_bo *ancestor = &vmbo->bo;
-	unsigned int entries;
 	struct amdgpu_bo *bo = &vmbo->bo;
-	uint64_t value = 0, flags = 0;
-	uint64_t addr;
+	unsigned int entries;
+	uint64_t flags;
 	int r, idx;
 
 	/* Figure out our place in the hierarchy */
@@ -404,26 +430,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto exit;
 
-	addr = 0;
-
-	if (adev->asic_type >= CHIP_VEGA10) {
-		if (level != AMDGPU_VM_PTB) {
-			if (vm->is_npa)
-				flags = adev->gmc.noretry_flags;
-			/* Handle leaf PDEs as PTEs */
-			flags |= AMDGPU_PDE_PTE_FLAG(adev);
-			amdgpu_gmc_get_vm_pde(adev, level,
-					      &value, &flags);
-		} else if (vm->is_npa) {
-			flags = adev->gmc.noretry_flags;
-		} else {
-			/* Workaround for fault priority problem on GMC9 */
-			flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
-		}
-	}
-
-	r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
-				     value, flags);
+	flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
+	r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0, flags);
 	if (r)
 		goto exit;
 
@@ -712,15 +720,9 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		flags |= AMDGPU_PDE_PTE_FLAG(params->adev);
 		amdgpu_gmc_get_vm_pde(adev, level, &addr, &flags);
 
-	} else if (adev->asic_type >= CHIP_VEGA10 &&
-		   !(flags & AMDGPU_PTE_VALID) &&
+	} else if (!(flags & AMDGPU_PTE_VALID) &&
 		   !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
-
-		/* Workaround for fault priority problem on GMC9 and GFX12,
-		 * EXECUTABLE for GMC9 fault priority and init_pte_flags
-		 * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
-		 */
-		flags |= AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
+		flags |= amdgpu_vm_pt_clear_flags(adev, params->vm, level);
 	}
 
 	/*
-- 
2.43.0

