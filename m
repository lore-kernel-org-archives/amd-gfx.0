Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E974CD6E51
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DC310FDD5;
	Fri, 29 May 2026 11:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QoE1hck1";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 807FE10FDC9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:46 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso274736f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054845; x=1780659645; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=j80hSp/BtZjhlsnhGMKP1/AKaEvtzu5rqwpX5wqDE7g=;
 b=QoE1hck1+/zwu19FfNhoYHbXwJKTlf97qAH4y6z1VzTfVjKTa7T1d+HEX2nZnNB/1E
 opnuc0CRY1T4UD5D3cns3fBEjvIze65L0DB6bXxfM9BNQfrL81i+uAjnH3Uan+5RT7vL
 Tj/HObbh4AkocnfAq0xeHRgjhemCQ4g3w/HcSrU5aujk/FYdfU/4qzJWOI2Psh3UTQBw
 EvjHdclKQYLwH+Q53dOHEc4j9onKwrb7JTFivGI3yI6PwdGXGh7LusgbRagEx4p4x2vB
 B6DG+wOv6fNtgaz3CjkBP4ohO21D6UzUlX2eMXZhhGYuPS1ml2B3i6IOrnLsZRB5qCHO
 OHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054845; x=1780659645;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j80hSp/BtZjhlsnhGMKP1/AKaEvtzu5rqwpX5wqDE7g=;
 b=J6B3+K7EU5CuoHJpyDpsxjCSnWWcEsW4ksKlb3beNn3u6GZkqZeNbe5JuXzhRmgvqg
 jPWrw/aa9df8c4MMk6h/phF1s6ZMFYCd/uezXcYTGs5evPFK5xzAAyxDV7eaAydZDd77
 Zn4g+TBwuE1UQT6SFbNsxIe2wwjwgGViKrm7yM2td+aUC48ZpRGso6Q3xSZUfkREmsjU
 ervHKgbR6LSGQrUWMF6JPtBegLHtSkoCaz5T/e7A1waYBt2DPnvSAdV1JJFj+qkxe5L6
 We3USTCZmmACYOr49ptxO8t0a4PqoQMFJiNAOyia2nW0AZMhJ+eisiWTqhIc+TCFCqe1
 Ox8w==
X-Gm-Message-State: AOJu0Yxq6eig3a1bh3lKsKkFSsGb7pW2C82Pp8kZsU5JTh16tcioPK9B
 Vrkb7R3MQmsuDMwI/j4jHZ7GLWDwLz6pQsxdBZ3Wws3CKsW3at4QvaFR
X-Gm-Gg: Acq92OGq68Pozq9gHsUHsPTxm/4K27MeiBpF9eeQAsr7hhWrW/VZ29fhsIktTpLlGrR
 qIuY+76Dz+DhssBqldIOVQb1+uqd/A/SCVt9N//0ZzCTLoej7fJI4qeIXFyUpkIbaIO+bOS0gFR
 bcUSLuBCscm6rtZ+OW1GzcuzVKmt0SXktr9uZsuNLpBmXzJq6Z7WJsSEm+jAGH8+kaD12peRsOr
 pVO35mIlcWuO61869PNhgblMKcQcjRgFi1yhWnczGHd6s3sPrig0bpUrpa6bHuxRRVjuyrPboJE
 FUYp+aTzG45eALAtSdpdtOrhu9era/htAUmpSJ4rRsrkPWHInWkUbORmcSJAGQNKUZYV2NY2q5J
 0/NCs0cwKxKBXKTumgdMJ2ObpV1LYWYB9QAPVa4GyXf12xS7sQxDM8xBWPce9wM5touoJ5MosRD
 WjDRKTTqT7CLEBAMiWBydxdIJCuuHD9eNs4EsRgxlst00=
X-Received: by 2002:a05:6000:605:b0:452:8286:86bf with SMTP id
 ffacd0b85a97d-45ef14020eamr4433492f8f.1.1780054844954; 
 Fri, 29 May 2026 04:40:44 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:44 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/13] drm/amdgpu: nuke most amdgpu_vm_eviction_(try)lock uses
Date: Fri, 29 May 2026 13:24:13 +0200
Message-ID: <20260529114031.3714-12-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114031.3714-1-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
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

Use scoped_guard/scoped_cond_guard instead.

Saving and restoring the GFP flags is not necessary in those use case.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 29 +++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  9 ------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f81ddc6873a0..3ac083c9f77e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -616,9 +616,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 * As soon as all page tables are in place we can start updating them
 	 * again.
 	 */
-	amdgpu_vm_eviction_lock(vm);
-	vm->evicting = false;
-	amdgpu_vm_eviction_unlock(vm);
+	scoped_guard(mutex, &vm->eviction_lock)
+		vm->evicting = false;
 
 	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
 				 vm_status) {
@@ -676,9 +675,8 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 
 	amdgpu_vm_assert_locked(vm);
 
-	amdgpu_vm_eviction_lock(vm);
-	ret = !vm->evicting;
-	amdgpu_vm_eviction_unlock(vm);
+	scoped_guard(mutex, &vm->eviction_lock)
+		ret = !vm->evicting;
 
 	ret &= list_empty(&vm->kernel.evicted);
 
@@ -2308,9 +2306,10 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 {
 	struct amdgpu_vm_bo_base *bo_base = bo->vm_bo;
+	struct amdgpu_vm *vm;
 
 	/* Page tables of a destroyed VM can go away immediately */
-	if (!bo_base || !bo_base->vm)
+	if (bo_base || !bo_base->vm)
 		return true;
 
 	/* Don't evict VM page tables while they are busy */
@@ -2318,17 +2317,15 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 		return false;
 
 	/* Try to block ongoing updates */
-	if (!amdgpu_vm_eviction_trylock(bo_base->vm))
-		return false;
+	vm = bo_base->vm;
+	scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
 
-	/* Don't evict VM page tables while they are updated */
-	if (!dma_fence_is_signaled(bo_base->vm->last_unlocked)) {
-		amdgpu_vm_eviction_unlock(bo_base->vm);
-		return false;
-	}
+		/* Don't evict VM page tables while they are updated */
+		if (!dma_fence_is_signaled(vm->last_unlocked))
+			return false;
 
-	bo_base->vm->evicting = true;
-	amdgpu_vm_eviction_unlock(bo_base->vm);
+		vm->evicting = true;
+	}
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 16710017e8ca..7276d987e9a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -141,15 +141,6 @@ static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
 	vm->saved_flags = memalloc_noreclaim_save();
 }
 
-static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
-{
-	if (mutex_trylock(&vm->eviction_lock)) {
-		vm->saved_flags = memalloc_noreclaim_save();
-		return true;
-	}
-	return false;
-}
-
 static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
 {
 	memalloc_noreclaim_restore(vm->saved_flags);
-- 
2.43.0

