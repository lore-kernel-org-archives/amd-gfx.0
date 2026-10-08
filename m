Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAB3CA600D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 17:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D87710FADD;
	Thu,  8 Oct 2026 17:33:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j5D/R+83";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA50310FAD1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 17:33:56 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso32233665e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791480835; x=1792085635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IMfOEjm+b8+5KYi7J2kPCMcS8t0fPf3DU9mcOn+Qnjs=;
 b=j5D/R+83AGs+gPiJfefIayEn2CSmB/XBo9FrbBFe8OZ4eGCfX/4IZrJWhxpI60AUCn
 Yo0aEUci51ixUu2PaPB9o7zTu/OSjLrWzueKwpHjD5LgwF+AiYedbpdrsILYe138O761
 C7FyoUePzrD5eGeoAnMS+OkPrIbIixV4lvVZuHYkBbs9c7QM5/uScDVoOGqK40NovUZA
 IpmUPms47/8NfiJxXoo3DtOOLOO9VNRuBvhLhEPc5s5fsDnXCdO1kHKi+WSthsD0XG0I
 ob9WTBcGQhfSY+eiWS58EBf39RsOvTkcWbutHL6YAgFdKtfQjyki/Y1uFzdZlecWlxN/
 UXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480835; x=1792085635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IMfOEjm+b8+5KYi7J2kPCMcS8t0fPf3DU9mcOn+Qnjs=;
 b=Dqhu69E9fNleagt/vBLf0zfZmELSvUpHZvtDoSrWzqZn744B59eHsNb72VwULozxNm
 1ZWOc/ysQeEJEouUnqa9bXt13S675bTVGcpjLs1eCT59oe+UU0Uoz+d/KqUHgjOQD9YO
 JrDbkkNVaOBjGO/Gvhnsdh4CKRG945mKnDRx5TUR5h9+LFkHi8NQENka0MksxhIqmHuF
 ajSHMLJC/AkPhC2MeVaP8Qtnrgnk30XFdE6s6rYZI2HAo2/WFNTN8QxCSOasBwQMoY4X
 ejtmnViRWojBdQUZBbPKVkhfIXhMo1Z38VaaM86dBh9MCv6/iVLzuHBrB9FCnD3nv4KG
 qkrQ==
X-Gm-Message-State: AFuF++nfqD36MBKdXWnaVuKBG5I+8l8VghcwAaqlM0+UMYnznlPN+aNL
 R7qWsWSpP+BsjLhRIqrChWlSFwLPsXrPOaY7qplAv4pt8ORaI0zPFPs6fftHHiFqpu8=
X-Gm-Gg: AYBFou1MGxBPlxpg+T+FfwTaY1gvEos9PyncMZcz3Fhv9AM2WTsno+eOLcBJz4mi8YS
 y1tBoaWRoKf4C2aphZXAOIZ07mwe9rFNcUO1fSeSmUDw4tzEzuPCMiuUwLblMpPx1oRHdPpP6G7
 9OZVf2MM5yPkeFpcExA6pABZjID3xRKoeQ56o6877EW6M3TnITbB1YmSfAlAQoqUfR1/xdHVn8D
 n+6EoBSWO4uQ7Vo0j8zbixiWzgoq2OtitQ0csulJ1HC63/rW+Hcf4eKYVfoF0zDIxECYdV5adCy
 04s/iRQ8M6UIqoyAtMr/bo49NQjxGKd74mX1FE6pGzpj3b1z6zMs0ggeQlV+5eC5bB1yuoqmLTC
 bmTeyTBQwkwx/sxHVpUXBdZAeLlaQ1JotWOVueUJ6PMGUMo8pVO+mQqHHAvWD5kEgDusBwFtMtj
 60RDjf5+hPG/57aEFuzWburr1Qeg2adO4INWxQdbLCJARMv/HsQBPiCOkjzaBdKrI75VUa+ffVe
 bSC2bUFZ3qmuofkJFXcE/qYp45yXO0nTroCjb+CVNC8PFdFLQVl/70Q2StPMdA0pBmXM81YCbtt
 RRCdUu9OlHc+9FtxI0yNfDiOE4m1GVfCcIIDr7ntjLahWqQz0IY6PkpTenKLc9zVrHtBqo/uTSu
 Fn1s0stJn8jsPmzEK7XWLWy7KhlbqfZ6r5sNlBEJ/i/g5qh9qdnAbA3HDH9EgiHOrvfk9f6y4RP
 hQbYT08dRJY+0w5qEq
X-Received: by 2002:a05:600c:3b9b:b0:49f:ed8c:6cad with SMTP id
 5b1f17b1804b1-4a180420135mr131774315e9.19.1791480834955; 
 Thu, 08 Oct 2026 10:33:54 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:415e:bf71:e574:69b7:f11e:4204])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db652e593sm659451f8f.34.2026.10.08.10.33.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 10:33:54 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Olivier Kaloudoff <kaloudoff@icloud.com>
Subject: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and guard
 with drm_dev_enter
Date: Thu,  8 Oct 2026 19:33:50 +0200
Message-ID: <20261008173350.40455-4-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
References: <20261008173350.40455-1-olivier.kaloudoff@gmail.com>
MIME-Version: 1.0
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

Verified on MI50 behind Thunderbolt: the workload takes SIGBUS,
coredump completes, kfd_processes_count drains in ~7s, pciehp
removal finishes, and the device re-enumerates cleanly on slot
re-power. Previously the same repro wedged the host.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
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
index 253365a..14f2273 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -202,7 +202,17 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
 	int r = 0;
 
 	if (mfence) {
-		r = dma_fence_wait(mfence, false);
+		/* Bound the wait: on a dying device the fence may never
+		 * signal.
+		 */
+		long ret;
+
+		ret = dma_fence_wait_timeout(mfence, false,
+				AMDGPU_FENCE_JIFFIES_TIMEOUT);
+		if (!ret)
+			r = -ETIMEDOUT;
+		else if (ret < 0)
+			r = ret;
 		dma_fence_put(mfence);
 		pr_debug("sdma copy memory fence done\n");
 	}
@@ -494,6 +504,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	u64 ttm_res_offset;
 	struct kfd_node *node;
 	unsigned long mpages = 0;
+	int idx;
 	long r = 0;
 
 	if (start_mgr < prange->start || last_mgr > prange->last) {
@@ -507,6 +518,9 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
 		return -ENODEV;
 	}
+	/* Block unplug while the migration submits jobs and waits on them */
+	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
+		return -ENODEV;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
 		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
@@ -521,6 +535,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 					node->xcp ? node->xcp->id : 0);
 	if (r) {
 		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
+		drm_dev_exit(idx);
 		return -ENOSPC;
 	}
 
@@ -565,6 +580,7 @@ out:
 					prange->npages * PAGE_SIZE,
 					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
 					node->xcp ? node->xcp->id : 0);
+	drm_dev_exit(idx);
 	return r < 0 ? r : 0;
 }
 
@@ -821,6 +837,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	unsigned long start;
 	unsigned long end;
 	unsigned long mpages = 0;
+	int idx;
 	long r = 0;
 
 	/* this pragne has no any vram page to migrate to sys ram */
@@ -841,6 +858,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
 		return -ENODEV;
 	}
+	/* Block unplug while the migration submits jobs and waits on them */
+	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
+		return -ENODEV;
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
 		 prange->svms, prange, start_mgr, last_mgr,
 		 prange->actual_loc);
@@ -885,6 +905,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 		}
 	}
 
+	drm_dev_exit(idx);
 	return r < 0 ? r : 0;
 }
 
-- 
2.47.3
