Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AAFCC6B2C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85C710F772;
	Wed, 14 Oct 2026 12:47:39 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D5C10EF7A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 18:53:21 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so33265365e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791917600; x=1792522400; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cypOpzY34BWVk7KWxl0N8XaliONtCyLhMkLvt1Yl0kM=;
 b=JZh6HLWD7GWH20CH0pVQspdsiopuDWckLi+jpJUl2RjGcSpiW6oHPq/rv3MwbEWnKQ
 625hw8xQlmsB2bE/opRIY1OfhY/W/EwGId4utaV+ceUgXBcUI2T51JE15s48AR0WWQc8
 5IUGx4HIPcjBuQVs9ouSnE1oZipEiRR6O3jf0qEFMrRSrXenN4yU6mgdDigRawWilzV5
 prdcorLduisdlG8UhcmYg/9PMmOK3qvxebTCdycmxJCiiS01flrlpHgvVH8/BVLokOSd
 YHuru95RmKaT7Dnd8dJrlTZvOTSCRuTxMnJh+BMbkuWS2jzSBAPDzhbEzoRa16K5Z8bw
 nLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917600; x=1792522400;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cypOpzY34BWVk7KWxl0N8XaliONtCyLhMkLvt1Yl0kM=;
 b=hAVaTDUpNyXYxV5ooxVd2Uifcuf9HpRUiiW7RGMHptb0RTNVFiYKsTK/z0ecwmve/K
 Wkj6uoJdqvrkx/XvytQOv9t9a4uTejy0exYlHxDoVWU2Wv5lobcjfebuO/fmoOMgA3It
 6QJrRLZ89mri6J1WF3QJqvpoqBcjZhe90YBbZgR56h2zl+OfLLl/aZiCWQ9Rj62jVVwm
 UYbXigca/vD+/EB2vuXebAscfhuRN4E27pGFKZhEEYSgxs6KW0wKRu05933+zN50CXIB
 uQdFtyK5bjzEqN82ro9nO4G/wQtdv1Adodx4BhaQNJVdHJSL9NoPSlji1QxSOnoR4ioz
 OxBA==
X-Gm-Message-State: AFq9FYLQV0/A/atKw40ufr7XPF1QObI29q8lTnGrBxX/EkRMmuBIlXuD
 7JM7oonrrQ+RQR2GbRXUUeyZU4e5BPKuSMsHLn8w0orAgMyH8VgqNgO64zeExQ==
X-Gm-Gg: AYBFou1l66FcwMCv74TCV/t0OhRZrH1vd5mml4VqvCZH+e7909zoR9+GjbrQaYnYe7F
 oMc6JT+jdM7q6pu0gIupPHlTW1KnmshJ0MqMXLFg0lRkUPS8u5ajxGi3jNZ1xdIi66EHSg0ByJb
 0LND3kYjxnQeiLx2pbNSzc0IL1/9pWRjerQAv/pGQVDemFbFTyWERqoAdOzeg99mFRuZFp2y025
 6QtVBohlu6MrIXgROOZDNu3IK5STto2hIXwDS7VqNXPUrSuMqcEQF+g99XYf281Dsatsqkbmvzj
 bPqzUXYqA0zKeRXlC1iv2W6L2JznJZ9/fH43n/hCUxBIVXrrBCICuO2H2Mva5G0GuvWrbq32CwS
 F0TO1qcgMbd9kY62ZupnOGH9Xl2Rwh4vvl1tzDI1E+9ptAQoUK8wdWXn97E98QdmVDYptpi5Ecv
 kpPL/UBvBRKjLUYkx3xSsUTfN0YdJM87q2r/EPZ9Fnwqkdpzy4PS1H55iQHOSDubtRFUEXQeQlw
 bIh3de3jId1tly42dayOZ22sX+GGKXawDkMfPMCwZkveUZg/qwC2dGkEv/Ds70Dw4TIDpo4Vbyk
 rLPeZai7TVrbZ6uwXRcBgbm141HgF3f0BIXJZmVgn+u1Y/5A6GJmenWqi+9sMlH4Ou6PO2pZOH5
 JFuJZynRWuaY8lFbqtwXxXjO5Ap8JRaHcNX8xdLqw6UmkPcFJrLlwGXlaSlSEdGsSspdRsKwHm5
 MFcWSkKBz9LyT3JA==
X-Received: by 2002:a05:600c:3f1a:b0:4a1:ac66:6ac6 with SMTP id
 5b1f17b1804b1-4a1ac667160mr65710545e9.26.1791917599515; 
 Tue, 13 Oct 2026 11:53:19 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:412d:e9fb:680d:a947:4b50:d9e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18d12fe05sm12340585e9.4.2026.10.13.11.53.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 11:53:18 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v6 3/3] drm/amdkfd: bound SVM migration fence wait and guard
 with drm_dev_enter
Date: Tue, 13 Oct 2026 20:53:13 +0200
Message-ID: <20261013185313.33496-4-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013185313.33496-1-olivier.kaloudoff@gmail.com>
References: <20261013185313.33496-1-olivier.kaloudoff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

On surprise removal the killed process's own exit path can fault on
its SVM managed ranges: SIGBUS -> coredump -> get_dump_page() ->
__get_user_pages() -> do_swap_page() -> svm_migrate_to_ram(). Without
protection, svm_migrate_vram_to_ram() submits an SDMA copy job to an
already-killed drm_sched entity (observed as
"drm_sched_rq_add_entity: Trying to push to a killed entity" plus
refcount_t saturation warnings), then svm_migrate_copy_done() waits
uninterruptibly on a job fence that can never signal. The task dies
in D state holding svms->lock, which wedges svm_range_restore_work()
on the rwsem writer side, so kfd_processes_count never drains and the
pciehp removal thread wedges for good.

Guard the hardware-accessing migration sections with
drm_dev_enter()/drm_dev_exit() so unplug cannot proceed while a
migration submits jobs and waits on them, and bound the job fence
wait in svm_migrate_copy_done() with AMDGPU_FENCE_JIFFIES_TIMEOUT so
a fence that can never signal does not stall the critical section
(or the faulting task) indefinitely.

Handle the new failure case properly: if the copy times out or fails,
release the migration pages and clear migrate->dst before
migrate_vma_finalize() so a failed copy cannot complete as a
successful migration, and propagate the error to the caller. The
cleanup is shared with the copy functions' existing error paths via
new svm_migrate_vram_pages_put() / svm_migrate_ram_pages_put()
helpers.

Verified on MI50 behind Thunderbolt: the workload takes SIGBUS,
coredump completes, kfd_processes_count drains in ~9s, pciehp
removal finishes, and the device re-enumerates cleanly on slot
re-power. Previously the same repro wedged the host.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
Changes in v6:
- check svm_migrate_copy_done() return in both callers: on failure
  release dst pages, clear migrate->dst before finalize, propagate
  the error (Felix Kuehling)
- drop the dead ret < 0 branch; a non-interruptible wait can only
  return 0 on timeout (Christian König)

Changes in v5:
- dropped drm_dev_is_unplugged()/pci_dev_is_disconnected() checks;
  drm_dev_enter()/exit() alone is sufficient (Felix Kuehling)

Changes in v4:
- use AMDGPU_FENCE_JIFFIES_TIMEOUT instead of an open-coded 10s
  (Felix Kuehling)
- guard migration sections with drm_dev_enter()/exit() instead of
  racing flag checks (Felix Kuehling)
- keep pci_dev_is_disconnected() early-out for the dead-link window
- moved svm_range_restore_work() change to patch 2

Changes in v3:
- new
---
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8b96e1f..40e993a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -204,7 +204,12 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
 	int r = 0;
 
 	if (mfence) {
-		r = dma_fence_wait(mfence, false);
+		/* Bound the wait: on a dying device the fence may never
+		 * signal.
+		 */
+		if (!dma_fence_wait_timeout(mfence, false,
+					    AMDGPU_FENCE_JIFFIES_TIMEOUT))
+			r = -ETIMEDOUT;
 		dma_fence_put(mfence);
 		pr_debug("sdma copy memory fence done\n");
 	}
@@ -239,6 +244,24 @@ svm_migrate_put_vram_page(struct amdgpu_device *adev, unsigned long addr)
 	put_page(page);
 }
 
+/* Release VRAM dst pages of a failed migration and clear migrate->dst
+ * so migrate_vma_finalize() leaves the source pages unmigrated.
+ */
+static void
+svm_migrate_vram_pages_put(struct amdgpu_device *adev,
+			   struct migrate_vma *migrate, u64 *dst, u64 npages)
+{
+	u64 i;
+
+	for (i = 0; i < npages; i++) {
+		if (!dst[i])
+			continue;
+		svm_migrate_put_vram_page(adev, dst[i]);
+		dst[i] = 0;
+		migrate->dst[i] = 0;
+	}
+}
+
 static unsigned long
 svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
 {
@@ -359,13 +382,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free_vram_pages:
 	if (r) {
 		pr_debug("failed %d to copy memory to vram\n", r);
-		for (i = 0; i < npages && mpages; i++) {
-			if (!dst[i])
-				continue;
-			svm_migrate_put_vram_page(adev, dst[i]);
-			migrate->dst[i] = 0;
-			mpages--;
-		}
+		svm_migrate_vram_pages_put(adev, migrate, dst, npages);
 	}
 
 #ifdef DEBUG_FORCE_MIXED_DOMAINS
@@ -441,7 +458,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	unsigned long mpages = 0;
 	dma_addr_t *scratch;
 	void *buf;
-	int r = -ENOMEM;
+	int ret, r = -ENOMEM;
 
 	/* Avoid unnecessary migrations and MMU notifiers if all the data is
 	 * already resident in VRAM.
@@ -493,7 +510,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&migrate);
 
-	svm_migrate_copy_done(adev, mfence);
+	ret = svm_migrate_copy_done(adev, mfence);
+	if (ret) {
+		svm_migrate_vram_pages_put(adev, &migrate,
+					   (u64 *)(scratch + npages), npages);
+		if (!r)
+			r = ret;
+	}
 	migrate_vma_finalize(&migrate);
 
 	mpages = svm_migrate_successful_pages(&migrate);
@@ -542,6 +565,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	u64 ttm_res_offset;
 	struct kfd_node *node;
 	unsigned long mpages = 0;
+	int idx;
 	long r = 0;
 
 	if (start_mgr < prange->start || last_mgr > prange->last) {
@@ -555,6 +579,9 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
 		return -ENODEV;
 	}
+	/* Block unplug while the migration submits jobs and waits on them */
+	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
+		return -ENODEV;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
 		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
@@ -569,6 +596,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 					node->xcp ? node->xcp->id : 0);
 	if (r) {
 		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
+		drm_dev_exit(idx);
 		return -ENOSPC;
 	}
 
@@ -613,6 +641,7 @@ out:
 					prange->npages * PAGE_SIZE,
 					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
 					node->xcp ? node->xcp->id : 0);
+	drm_dev_exit(idx);
 	return r < 0 ? r : 0;
 }
 
@@ -627,6 +656,32 @@ static void svm_migrate_folio_free(struct folio *folio)
 	}
 }
 
+/* Release system RAM dst pages of a failed migration and clear
+ * migrate->dst so migrate_vma_finalize() leaves them unmigrated.
+ */
+static void
+svm_migrate_ram_pages_put(struct device *dev, struct migrate_vma *migrate,
+			  dma_addr_t *dst, u64 npages)
+{
+	u64 i;
+
+	for (i = 0; i < npages; i++) {
+		struct page *dpage;
+
+		if (dst[i]) {
+			dma_unmap_page(dev, dst[i], PAGE_SIZE,
+				       DMA_BIDIRECTIONAL);
+			dst[i] = 0;
+		}
+		dpage = migrate_pfn_to_page(migrate->dst[i]);
+		if (!dpage)
+			continue;
+		unlock_page(dpage);
+		put_page(dpage);
+		migrate->dst[i] = 0;
+	}
+}
+
 static int
 svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct migrate_vma *migrate, struct dma_fence **mfence,
@@ -717,22 +772,7 @@ out_oom:
 		}
 
 		/* release previous allocated sys pages and unmap dma address */
-		while (i--) {
-
-			if (dst[i]) {
-				dma_unmap_page(dev, dst[i], PAGE_SIZE,
-					       DMA_BIDIRECTIONAL);
-				dst[i] = 0;
-			}
-
-			dpage = migrate_pfn_to_page(migrate->dst[i]);
-			if (!dpage)
-				continue;
-
-			unlock_page(dpage);
-			put_page(dpage);
-			migrate->dst[i] = 0;
-		}
+		svm_migrate_ram_pages_put(dev, migrate, dst, npages);
 	}
 
 	return r;
@@ -770,7 +810,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	struct migrate_vma migrate = { 0 };
 	dma_addr_t *scratch;
 	void *buf;
-	int r = -ENOMEM;
+	int ret, r = -ENOMEM;
 
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
@@ -821,11 +861,17 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    scratch, npages);
 	migrate_vma_pages(&migrate);
 
+	ret = svm_migrate_copy_done(adev, mfence);
+	if (ret) {
+		svm_migrate_ram_pages_put(adev->dev, &migrate, scratch, npages);
+		if (!r)
+			r = ret;
+	}
+
 	mpages = svm_migrate_successful_pages(&migrate);
 	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
 		 mpages, cpages, migrate.npages);
 
-	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
@@ -869,6 +915,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	unsigned long start;
 	unsigned long end;
 	unsigned long mpages = 0;
+	int idx;
 	long r = 0;
 
 	/* this pragne has no any vram page to migrate to sys ram */
@@ -889,6 +936,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
 		return -ENODEV;
 	}
+	/* Block unplug while the migration submits jobs and waits on them */
+	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
+		return -ENODEV;
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
 		 prange->svms, prange, start_mgr, last_mgr,
 		 prange->actual_loc);
@@ -933,6 +983,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 		}
 	}
 
+	drm_dev_exit(idx);
 	return r < 0 ? r : 0;
 }
 
-- 
2.47.3
