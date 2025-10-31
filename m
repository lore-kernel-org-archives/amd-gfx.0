Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C6BCCFA03
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309EE10EBB6;
	Fri, 31 Oct 2025 13:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ixTKoGpW";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05E210EB85
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:14 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-475dd559b0bso29845575e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918313; x=1762523113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SB79CwwhCHwtxvtNfrEHEKbzBpmOoJSFIgi6aldIl0=;
 b=ixTKoGpWNvZ9gGc0l4G6OQlSbC12C3Sj2YvWIPfwAkRkz6UJeFg7GnOZW2aozrCZl+
 Ei6xhUlhziclScs3+xEi4NyC54V1VFZZsl9YPFzSsCj3vU5KGbXz2oxrJ80sgJ/0eKQg
 gpVS5taA/+cVMjqg52bbYEEQKVn/lyhaWHS2lOCmmR8UptOA5XlT8OkDmbPUAzsWB/FP
 IjEgsM8HTYt4u4AuB+Qy4itzRmCkZRFdKrGLBOUv9a/WiwS1S99PXoCw4G0H2lQGP2Lk
 unosU5YnkqiHKhffUafwX1mmHal1I/N/gVQ7xJAsElCdIstnp8fdqDHm/qsYPfunFD4C
 DXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918313; x=1762523113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SB79CwwhCHwtxvtNfrEHEKbzBpmOoJSFIgi6aldIl0=;
 b=wHNeH10wW0SegczxKJKx45i9j9yWseTqdRgOiOuww711m7kKT5UJCQ50QCO/J9DpG7
 RXd2Rzfow7iroqYHOntqnVxdLQbWZL7W5AdQzcGpO3C5XkodKmJPRaqE96OcMX2i4BzZ
 YZt2ol/bg9IvoZgoFWibyQjsXN4eNe4g2NB+WOgLthtvO64xNy4cuY/iBypDfzjwZ1Ly
 Uf8iAuI5npG18QAgQ/5iFrMgu4loD51pkKbpQxjrkBlH88VlSJwCCBsJqvIehj3EdZqC
 tDvrt1xhbWRRKxUU5fAM2ij8j6Cxp4hj4nl/6oXLdYeFHM8iA04lbqGYS3mnfqC7lqDx
 sXeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU0tVbP9Vjk8VcCeR/a7H+5zUx3KoFdFiePnhoyZZQPAZ6feAhNmwFs6qoDL9Ld587XMnxRKXu@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7bHzMscfMxAqutKWYB0dXPgc6TeSDKxmeNA5Ca2hhKRQClr8C
 pIwiRCCgoLDJcCiiXfx7CAqHKRn25SM/j9BMvKAiHT+hs/wpxd722KGs
X-Gm-Gg: ASbGnctOwJvP2TyfU+h+/LL5nINwQQyL0Zw+2pd4y+b7hUDJXk14rgbw+fHhmoeT0uv
 AUEjTWjep1cQ/+GHM2F5nfeYY2LF+ELOarGEazkCeY0nyqCpkh7SxXNAE3KreYbNzqCUzWIWDJn
 BUP+b+U3Q/LqUA71DC6w462LmaVoJpE2rOnsuaBaDsPSCypjCusYgq3SyuLVXmcepEBvHnFTeLe
 V4ShDmsQWNdpk+gnZRx4mZcptaAcd+t6dTYlD2LvmxlUYS4toz9sHohFZjw0T0WNdVt0HgKboPe
 xBIpjoLwOHPl9Ovpz5Dqkv+o5264e+edu1N8aPlTAwlUvRTtz3meuMipVpnKDEv9Hy0gAle0HxP
 W2ZA4NH7vDU7Q0tuQ3+qpY9vLUjXjv55hDDLYLmn5LyqpBfiG1sqfaGvxAjIWVtvb0jaV/EsmM8
 Qnq40kfIYGOE7Pfg==
X-Google-Smtp-Source: AGHT+IH+UcH17rt6/K1nhyN2lX5mmbbLKFeEPPQDCmVGBsBJea7bkuHjJf7lpPZk5xaU+MkwrNHOMg==
X-Received: by 2002:a05:600c:3b14:b0:477:bb0:7528 with SMTP id
 5b1f17b1804b1-477308b72c6mr29639295e9.22.1761918313087; 
 Fri, 31 Oct 2025 06:45:13 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:45:11 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/20] drm/amdgpu: independence for the amdkfd_fence!
Date: Fri, 31 Oct 2025 14:16:49 +0100
Message-ID: <20251031134442.113648-16-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031134442.113648-1-christian.koenig@amd.com>
References: <20251031134442.113648-1-christian.koenig@amd.com>
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

This should allow amdkfd_fences to outlive the amdgpu module.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  | 36 +++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  7 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +--
 4 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 9e120c934cc1..35c59c784b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -196,6 +196,7 @@ int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
 #endif
 #if IS_ENABLED(CONFIG_HSA_AMD)
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
+void amdkfd_fence_signal(struct dma_fence *f);
 struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
 void amdgpu_amdkfd_remove_all_eviction_fences(struct amdgpu_bo *bo);
 int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
@@ -210,6 +211,11 @@ bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
 	return false;
 }
 
+static inline
+void amdkfd_fence_signal(struct dma_fence *f)
+{
+}
+
 static inline
 struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 09c919f72b6c..69bca4536326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -127,29 +127,9 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
 		if (!svm_range_schedule_evict_svm_bo(fence))
 			return true;
 	}
-	return false;
-}
-
-/**
- * amdkfd_fence_release - callback that fence can be freed
- *
- * @f: dma_fence
- *
- * This function is called when the reference count becomes zero.
- * Drops the mm_struct reference and RCU schedules freeing up the fence.
- */
-static void amdkfd_fence_release(struct dma_fence *f)
-{
-	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
-
-	/* Unconditionally signal the fence. The process is getting
-	 * terminated.
-	 */
-	if (WARN_ON(!fence))
-		return; /* Not an amdgpu_amdkfd_fence */
-
 	mmdrop(fence->mm);
-	kfree_rcu(f, rcu);
+	fence->mm = NULL;
+	return false;
 }
 
 /**
@@ -174,9 +154,19 @@ bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
 	return false;
 }
 
+void amdkfd_fence_signal(struct dma_fence *f)
+{
+	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
+
+	if (fence) {
+		mmdrop(fence->mm);
+		fence->mm = NULL;
+	}
+	dma_fence_signal(f);
+}
+
 static const struct dma_fence_ops amdkfd_fence_ops = {
 	.get_driver_name = amdkfd_fence_get_driver_name,
 	.get_timeline_name = amdkfd_fence_get_timeline_name,
 	.enable_signaling = amdkfd_fence_enable_signaling,
-	.release = amdkfd_fence_release,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ddfe30c13e9d..779d7701bac9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1177,7 +1177,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 	synchronize_rcu();
 	ef = rcu_access_pointer(p->ef);
 	if (ef)
-		dma_fence_signal(ef);
+		amdkfd_fence_signal(ef);
 
 	kfd_process_remove_sysfs(p);
 	kfd_debugfs_remove_process(p);
@@ -1986,7 +1986,6 @@ kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
 static int signal_eviction_fence(struct kfd_process *p)
 {
 	struct dma_fence *ef;
-	int ret;
 
 	rcu_read_lock();
 	ef = dma_fence_get_rcu_safe(&p->ef);
@@ -1994,10 +1993,10 @@ static int signal_eviction_fence(struct kfd_process *p)
 	if (!ef)
 		return -EINVAL;
 
-	ret = dma_fence_signal(ef);
+	amdkfd_fence_signal(ef);
 	dma_fence_put(ef);
 
-	return ret;
+	return 0;
 }
 
 static void evict_process_worker(struct work_struct *work)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9d72411c3379..5d62d231a865 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -428,7 +428,7 @@ static void svm_range_bo_release(struct kref *kref)
 
 	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
 		/* We're not in the eviction worker. Signal the fence. */
-		dma_fence_signal(&svm_bo->eviction_fence->base);
+		amdkfd_fence_signal(&svm_bo->eviction_fence->base);
 	dma_fence_put(&svm_bo->eviction_fence->base);
 	amdgpu_bo_unref(&svm_bo->bo);
 	kfree(svm_bo);
@@ -3622,7 +3622,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	mmap_read_unlock(mm);
 	mmput(mm);
 
-	dma_fence_signal(&svm_bo->eviction_fence->base);
+	amdkfd_fence_signal(&svm_bo->eviction_fence->base);
 
 	/* This is the last reference to svm_bo, after svm_range_vram_node_free
 	 * has been called in svm_migrate_vram_to_ram
-- 
2.43.0

