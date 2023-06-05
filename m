Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D507C77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 09:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4BF010E248;
	Mon,  5 Jun 2023 09:11:28 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E6410E248
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 09:11:26 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9745d99cfccso567406266b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jun 2023 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685956284; x=1688548284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XckwVVk7cUBN/anX4oxrufuUSrCpGL64BI886zWXU+0=;
 b=PdPXcQB4x2o2dI1vbdqcMNn7KEndUe1/NAr2IvB9ii6THWe1G/6yJfs7H0AggFF5Ch
 oVajMRtmTMTEk356zmxupeYkaI2pXu0IwNZYfTTCqaa4m2L0p6bNto4FFj/Z+cceMNwi
 XKS2xPyvi3cyR1l6VoE5UBPGTd96KXZ1byFfKWqfOattBinZYoez8v6lvdjRGksXf9c3
 ay9A613+Sb1lnQEGNBHyaXAvhygz8UQ2uyj3Q8ffzgL/hPARMnLgtNbtBvkguDAp4dF+
 QFuSmiBQIZOgsaH0wCPzNcoW6bFre1ish+oPgf/q57q/NBjK+vGmpB4JVnuDjPF29564
 Wh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685956284; x=1688548284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XckwVVk7cUBN/anX4oxrufuUSrCpGL64BI886zWXU+0=;
 b=CcMxbJmqJBgqjREUToJQQQOqJGR2xBlhBlg6vy8L89FO6zVAzSDAK764R5mJUbWC0Q
 MFv3vF8New5QJ8tgJR2UmHs1Ks+yEFqgeCUVQ4Z/R71POlFHKMEZZajcADK7ygMFSZN0
 p2foeYOJNgo6Zni2sCSwiVm2eUYeSYVQoWCdpx2Q6PiJlAH0z8GgRF1iV1rT3qdmxmTA
 MGj6FDaYmCQcQLInml4LLY+1Qm6TR4c3uAcjOWKuWgv0n8Uf8kNnL+V72dHShZXwS0SD
 ADiXybJ27GMCmYhotrJ2V3Iat+rQmlp0y+3VlQUFaNrthyIGPzP+q/pb93ZduqYe+Yk2
 KYjA==
X-Gm-Message-State: AC+VfDw87WuF/UiRR5qUQ3WzUbavwnor0U4R9lZ4Xz7bPbyhayJMwU4D
 V4f5vRCpeVUPtkrmpaDHgHSn+mD71/c=
X-Google-Smtp-Source: ACHHUZ46z5I8W0YjF7H4gcCaKgdWDv25BYF1qmDXBOAddeyTTe8LFwiqKOHV7rsjSmiJSQcJA5aZ5w==
X-Received: by 2002:a17:907:9405:b0:973:8198:bbfb with SMTP id
 dk5-20020a170907940500b009738198bbfbmr6221357ejc.31.1685956283800; 
 Mon, 05 Jun 2023 02:11:23 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:156f:3500:5740:cdd2:425c:f4f3])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a1709060a1100b009655eb8be26sm4043134ejf.73.2023.06.05.02.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:11:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, mikhail.v.gavrilov@gmail.com,
 Guchun.Chen@amd.com
Subject: [PATCH 1/2] drm/amdgpu: make sure BOs are locked in
 amdgpu_vm_get_memory
Date: Mon,  5 Jun 2023 11:11:21 +0200
Message-Id: <20230605091122.3363-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

We need to grab the lock of the BO or otherwise can run into a crash
when we try to inspect the current location.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 69 +++++++++++++++-----------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3c0310576b3b..2c8cafec48a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -920,42 +920,51 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
+static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
+				    struct amdgpu_mem_stats *stats)
+{
+	struct amdgpu_vm *vm = bo_va->base.vm;
+	struct amdgpu_bo *bo = bo_va->base.bo;
+
+	if (!bo)
+		return;
+
+	/*
+	 * For now ignore BOs which are currently locked and potentially
+	 * changing their location.
+	 */
+	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
+	    !dma_resv_trylock(bo->tbo.base.resv))
+		return;
+
+	amdgpu_bo_get_memory(bo, stats);
+	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
+	    dma_resv_unlock(bo->tbo.base.resv);
+}
+
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats *stats)
 {
 	struct amdgpu_bo_va *bo_va, *tmp;
 
 	spin_lock(&vm->status_lock);
-	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
 	spin_unlock(&vm->status_lock);
 }
 
-- 
2.34.1

