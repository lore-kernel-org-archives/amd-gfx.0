Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5166DCA5FA9
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 15:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2455A10EAB8;
	Mon, 28 Sep 2026 15:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jGrWA/WY";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5159110E8F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 15:10:46 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48884b926f0so1969575f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608245; x=1791213045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AD1hxgSWrVHz3P8LApjr4+6DDKbmlHd+2wB+HwsBvV0=;
 b=jGrWA/WY+t9LEdmyPR5LP+ecaupoDC8I0ZnYK2+fqahNxjK2+U+7tbd80EIKBIJxMW
 Jtpit6FZI9TfDrv2ooRDvu6poZyCHtapmXCbMUGiW4+tLuba/D3i9Rb4UjRbhaKUS3Np
 aDtrpD19HKyNEn2s6pXQo8SZ7lL+wt/inl+aqN3W9zjgxXKfSAPSuue0JTkj3wRX17Nx
 fsD4UVHiVC/PGSumH1f0KGlWm1x5RJsE8XSxFy57rcvB7BanpUW9iQGrPIQ3ms+W93qZ
 e0RP2ok02bZS1UTpE68OkltRUVETOew0N1M13rt7GXXql1R/ZI1sKenhCPnqZRQ36uB0
 8MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608245; x=1791213045;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AD1hxgSWrVHz3P8LApjr4+6DDKbmlHd+2wB+HwsBvV0=;
 b=R4yAkaL222gxhAMqDgYL66j+JMfjguFgz8tYAsjisjUWFmox42Wl6VnQ1M/Rylgafz
 kJh7C0hZrugCD23dExfRExUIYR1Pap3R5hIgjWq8BET4wC5FEnt+3puadkT1X6Mus39a
 ZnI6VHu8Qqr9LV51c14yRXYRs6383Njk0NPoHjmpPIWsvvJMgarj8K5larAscejruaqu
 uQYoWcjiOZ+fJaj48v1X69e8x9MqjSkVIBOPv4K+PZAueKIhTQGWHbm/dA6KifVLrIIB
 vwehmsvadL1PKzimSVGZZhHpZ2MoNwQdKLvsH34TL4Yi80YeXa9ShrxL4cQmsvCtg900
 Z/WQ==
X-Gm-Message-State: AFq9FYKgsHW8amy66q6zc+p28CGgsxmQ+MURoIj9noVfi+0zmEgiW6hx
 4SMeFjSIScF7kO5elz2f0K/MRMKYojNK8XzXyQ8YsEF5fOnf7c/wYUbk
X-Gm-Gg: AYBFou3wdrguqVt//tvlbSfzdgAqDXci0+M6cd7baynOTK5krAhGvouPFbVSrdBitbD
 W3WDqk/p4fBJ1Zzdo4hQ0ceeV5ixkgM7bHbQ6z35tqXR7DdcdRJ14NkY/vNEpHp21No9KvzVAE5
 7lmVzW+r72+oL1tXwOcYhA2Vgi8wNyxdc0W2bJRhcbtSnUE8lrnZN7kCvKxV3JRSlhJPS9BjGNt
 dSIn3lGnZqbDBcuZCxr1e/BAgGXDGF+B0Mw3SRpj31BB0cL9LjZeuYHBg1pd+DskPr2EblLt0yJ
 5g4s/yj8jGMwgq9+V2PcZ7eQFsQJTIygp4LnQX6xLE31SN9w3gk+lXNV0jlnmjREk8h1o6LiMhE
 eu7C+9QbvVHBEga9JPm/TRKz+4jpBez8cxFu0g2lLhyMubfVKH/4QvZeXgovsC9i2nb6SUEXrzD
 n5B33LHpH1Umq1bg85wcYZb7agg5+ssC2WBlrrSovT6WumYZB2b7EoB8Dl1rPYiWrsorWyF8k/o
 6pwWcNteHc=
X-Received: by 2002:a05:6000:3104:b0:48a:eff0:c31d with SMTP id
 ffacd0b85a97d-48aeff0c6e7mr83056f8f.38.1790608244555; 
 Mon, 28 Sep 2026 08:10:44 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:152b:4800:8072:ed4c:898d:d82d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm31513965f8f.20.2026.09.28.08.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:10:44 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/9] drm/amdgpu: fix cleared PDE/PTE flag generation
Date: Mon, 28 Sep 2026 17:10:34 +0200
Message-ID: <20260928151041.1857-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928151041.1857-1-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
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

