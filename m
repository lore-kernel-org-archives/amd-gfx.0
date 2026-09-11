Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D506C88E53
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 16:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 720A010E3FD;
	Fri, 11 Sep 2026 16:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U61eWThJ";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE72610E3FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 16:48:04 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso16793205e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789145283; x=1789750083; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2VpNw7spc6pHiQlKXxN6lubcVAEgDKI8LDADcCUsz7o=;
 b=U61eWThJ/gHcf7VUS99pgB3tmJA3HEu3mPCwPlXESP02HKHBWym7ooVo59CRhMUNiM
 aqbGVP4bXxBIaML2Qr+fA2vFTllMxDwA4/N4LOkvIZDa4nHi8wtRY/QcdIwh2K1XMH09
 z020l++rogpiXridZa/6wjaukoZkmecQjfmItklnXCOasMaetdXbCUf2lMPqnEpNGEHD
 lh+ScrgKGw/Xmv6Gj7KpyXUat4IYlTqQHYrOik79FNRz7MR0eqQ9PcJie3lppWHc8zoE
 +EwqF5bLBNuKuaGCM6eKjB4FX02JvnaX9MdpMTBk8tuSa9mqg9lLWUsEqpzrKGT/9hu5
 NWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789145283; x=1789750083;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2VpNw7spc6pHiQlKXxN6lubcVAEgDKI8LDADcCUsz7o=;
 b=eQyp49W4KxgwbZ0/gFAVkOa0waeIPF7hiq3HaZrPjpOW9Y7ssfNKaQYwx1rlx7eOpr
 lmcSmZeCPWz0n+LepahLFUkqkICwtVe9cQM73XtV1e/Es9ld/KdyeaE0rQyqstzhTYly
 22UV6PoLrugap3FTvBByw+SewAb+VtmmCo56jOMM9QtUE/LjM2TKabKme+iHvSxP/GBv
 Yfgnxo04EGlIOdONiPUT3fWMR+4jyKv2thAwq2YMBDmvKtHUyJCgMI0hoxbTKnVFef4+
 Wdz54cwfCE3An7lj8ytxV9AEw+ww/0Zz/fdt1gbC6vsz8pokx6wPjzRRrn1HtmGX1NpR
 s1iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzM3o5aV33ZeK0WqQGyop1Dbr28Hn9rG+YWXLL24GsmficwlKBHyd1QKJOnC3kzMRHhHsmbypZK@lists.freedesktop.org
X-Gm-Message-State: AFuF++kym5bdFyeQIgFIEX2UFy725EMj0Lv2419/Cinj33OJAjYcLbTB
 HUB7HCARgVyV477vHTImap+AgVUKvxutWkeCItNx1kriiPMUknyIlCLo
X-Gm-Gg: AYBFou1s1i1OVTcxG7iVBt9a66rDJurNbAyK6wToD49L2ElKbMHbNMwvAplp8uDj3No
 b5W3lbgG0h+Lm9Ht2f75q1FBa5ZHyeeKoIQ3I2KCTj79yvHn/sYI50B+VuqcJsU/uSHf8/fnKfi
 J5y/SSDHfd1VHUqNdTUGpAyw6aMdk0hg9OrtRM3Lc4otjEJGlDJHp17tfFUqsxHHFFJmj4Eps8O
 UXsftJ3UnDFk7Us3joGn8jcOkmxW/J2KlcnP8r5xA/z2BJ3mZ1npFk1ONnqxUhdnsrQ72d/vq3G
 8e8AHBoWi1vbdvT2r4skaxn0xhOSU7TQXGtNXvCD+wPCzVsu6Bz3SMV0Fz0UhJgwLCHGso3X0ya
 j41mj3zscr6lhuY8Ps2iAqcAtwC8q6xv3RJHWOclj/BtqsJIhoMemFI7gGc41KnL7M4rYp7GOUe
 tAxDgUMy/dGGFzUxGW9tGWWlrsII5wYq/41cmg0LANdXi48/BELnko+bqQc6jf+81EHTnkSlvl9
 vkXVMf9c1DA
X-Received: by 2002:a05:600c:8b22:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-49e61888908mr61296355e9.4.1789145282702; 
 Fri, 11 Sep 2026 09:48:02 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1598:3600:fdfa:c947:bca7:ed36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486f0403125sm4927578f8f.8.2026.09.11.09.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:48:02 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Honglei1.Huang@amd.com, timur.kristof@gmail.com, natalie.vock@gmx.de,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: nuke most amdgpu_vm_eviction_(try)lock uses
Date: Fri, 11 Sep 2026 18:48:00 +0200
Message-ID: <20260911164801.50175-1-christian.koenig@amd.com>
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

Use scoped_guard/scoped_cond_guard instead.

Saving and restoring the GFP flags is not necessary in those use case.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 27 +++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  9 -------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 47cde54594693..7ced26c9c651b 100644
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
@@ -678,9 +677,8 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 
 	amdgpu_vm_assert_locked(vm);
 
-	amdgpu_vm_eviction_lock(vm);
-	ret = !vm->evicting;
-	amdgpu_vm_eviction_unlock(vm);
+	scoped_guard(mutex, &vm->eviction_lock)
+		ret = !vm->evicting;
 
 	ret &= list_empty(&vm->kernel.evicted);
 
@@ -2274,6 +2272,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 {
 	struct amdgpu_vm_bo_base *bo_base = bo->vm_bo;
+	struct amdgpu_vm *vm;
 
 	/* Page tables of a destroyed VM can go away immediately */
 	if (!bo_base || !bo_base->vm)
@@ -2284,17 +2283,15 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
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
index 447195cc45932..ca86eaac75235 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -137,15 +137,6 @@ static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
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

