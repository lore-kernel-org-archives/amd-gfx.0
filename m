Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2DECA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 18:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788B710E64E;
	Wed,  7 Oct 2026 18:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NaDENr7q";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B5B10E64E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 18:09:15 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so16904225e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791396554; x=1792001354; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RTm7SBx3r2f/ckfHw+Vrd1eMJiHM9g4f6MlXxk85iIg=;
 b=NaDENr7qLNRfphP3s9//mnsBftIoLOTz8ApbV7HNjLAmh9Ewhz8DEy8SC7XpdDDf+j
 eTTGOR63OsQbqsof3WrifwYofa9O03F+7qni4lAsXxu6h6iPqnuIDsXSbld/ebuPSiEh
 /RAeYOFn9P7FjHIFg0EBCRKYWTohYiw6CrCRmdj+8RKOSVQF3RkgzhC9/Q3B5yrEqEAC
 eUKeO9lf3xq8YXoZpI8GotE9uaXhCF3x+1MMEIBQGsHhkRWG+BORRyZKB7LFVFr6UlBE
 aeeiPKsqX6RdJ3KebsARkj2bOZuRD8AujTbSBHC0+PU51FdbS3Y97ap2OOdKSl1CQkqh
 zjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791396554; x=1792001354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RTm7SBx3r2f/ckfHw+Vrd1eMJiHM9g4f6MlXxk85iIg=;
 b=rbkgsYxwROBTT34AjJZPtHi0hZsv2aiGaBGUWm9Cul1QJU+QN2y4t0vJss0Vtol8Eg
 tn+2fN+zZy0szSXlCq1Q2P5r25ASvUxJJgqvB/7UDY2Q1gXtOJ5Myo/mHNG5l3D9Y5nl
 07WCicsIcW8AGTeVj06K7qFAollTVW9RPdL2fIsvjID3ER1qZ7nIleLT00wg6oj8wTZ0
 3h43YulUPzqmlcdofTOgiYhs31Uy2ZaBI4iM1mMBb552xk0ub7hNLnR86sNloFbUEuv9
 daHLA038xP13OplnAR289hquvh/jqeTUbpy52RQwPHJCFT+mycUL3dhR9U5Vs61o5ZZY
 udPw==
X-Gm-Message-State: AFuF++kOL+vmnL/b6kncnA6KnuDaYfDOQMy6u5IxurXBCdqs9MMlcdEo
 Gy85YzUa3G1DRIaDtDDhoY315ENndEzFWa+P+Y1+NbizIThw9pK5kMdzhPJzLLSP
X-Gm-Gg: AYBFou1NjPFq9dqY0C/wHnYf1ngzr0riF4NdT22573ceJlpgEtnIdLPQEEwH5iyhSgO
 m2Q3MP0nkNmmuWPeCL9qi20NDKzsAPuMOibGakqNagyfTi5WM2vc3brogAayBuJ3WNDt+w5ka4E
 5Fzg0Demmc2AryTxjTQ5lwrUHj+1KLdUFAGin8YdMVtiZ2snlZgZVhbgRYpT8e9FQ+5iJu8u2CN
 6vCRGLwGbrWefX90GP1/YumDPhHpH4L0byGv+Wl6gO7iAa35AH06j5FQS9L+niu5/Qg6j+uhGDj
 v7JoH9Oaoiojm6SrmZl5YsfGrn8yhmv6x8CWJ6umbqZa8JuaUjFY9yPASf+A/YerkXJDw5Hvx6A
 tDGTKiQzoyYo1HCH4472ujNBnDQzGxlc8sr87/4C6rMGAvFkgbeDCLlM0gLkvCvct7EgGAguqIT
 3xRr0AkwEKGv/tdl/JXGJ0Tq4RSHXDxiaR7RVYF3es0a0E7LB5vu74uovqgq05k5IDx/yNJloeM
 c3gp4O2eoCRkH2vM7sbPn5rnTmES60YxR478quwq6Fy8R9q4JtNrkMXaFoA69Z/lgayGtksvCBn
 +JFVRI7tDhSnvu2Eik9Kwnjb7Z4QoNgmmvFcvyh8BieCuDONMjZ25jj8afF8jhiX8NzuNApwYe6
 P4OmfDX+CNvQhuHVhBAhTFYSA5xNizKqoQkgraFjYg69kL3/BpnvwZsniajL8NSIpwslMKLejOj
 umMIQcwzXNpjEs38oRNsGDmsmUGQ==
X-Received: by 2002:a05:600c:3b2a:b0:49f:cc2a:f73a with SMTP id
 5b1f17b1804b1-4a1806502a2mr55001595e9.25.1791396554200; 
 Wed, 07 Oct 2026 11:09:14 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:e487:413e:676b:9d85:c07d:dc5e:c7c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a181aeaea2sm59416855e9.5.2026.10.07.11.09.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 11:09:13 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v4 3/3] drm/amdkfd: fail fast on unplugged device in SVM
 migration paths
Date: Wed,  7 Oct 2026 20:09:09 +0200
Message-ID: <20261007180909.34013-4-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261007180909.34013-1-olivier.kaloudoff@gmail.com>
References: <20261007180909.34013-1-olivier.kaloudoff@gmail.com>
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
an unplug check, svm_migrate_vram_to_ram() submits an SDMA copy job to
an already-killed drm_sched entity (observed as
"drm_sched_rq_add_entity: Trying to push to a killed entity" plus
refcount_t saturation warnings), then svm_migrate_copy_done() waits
uninterruptibly on a job fence that can never signal. The task dies in
D state holding svms->lock, which wedges svm_range_restore_work() on
the rwsem writer side, so kfd_processes_count never drains and the
pciehp removal thread wedges for good.

Block unplug for the duration of a migration with drm_dev_enter()/
drm_dev_exit() instead of racy flag checks: the enter section covers
both the job submission and the fence wait, so the sched entity cannot
be torn down underneath. pci_dev_is_disconnected() is kept as an
early-out since the PCI flag can be set well before drm_dev_unplug()
runs. The fence wait in svm_migrate_copy_done() is additionally
bounded by AMDGPU_FENCE_JIFFIES_TIMEOUT as a fallback for the
submit->wait window on a device that dies electrically without a
running removal.

Verified on MI50 behind Thunderbolt: with these checks the workload
takes SIGBUS, coredump completes, kfd_processes_count drains in ~4s,
pciehp removal finishes, and the device re-enumerates cleanly on slot
re-power. Previously the same repro wedged the host.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
Changes in v4 (per Felix Kuehling's review):
- replace the bare drm_dev_is_unplugged()/pci_dev_is_disconnected()
  checks with drm_dev_enter()/drm_dev_exit() around the migration;
  pci_dev_is_disconnected() is kept as the early-out for the
  physically-gone-before-unplug window
- bound the fence wait with AMDGPU_FENCE_JIFFIES_TIMEOUT instead of an
  open-coded 10 s
- move the svm_range_restore_work() -ENODEV hunk to patch 2

New in v3.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 253365a..e5faa2b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -202,7 +202,21 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
 	int r = 0;
 
 	if (mfence) {
-		r = dma_fence_wait(mfence, false);
+		/* Job fences on a dead device never signal */
+		if (drm_dev_is_unplugged(adev_to_drm(adev)) ||
+		    pci_dev_is_disconnected(adev->pdev)) {
+			r = -ENODEV;
+		} else {
+			long ret;
+
+			/* survive unplug between submit and wait */
+			ret = dma_fence_wait_timeout(mfence, false,
+					AMDGPU_FENCE_JIFFIES_TIMEOUT);
+			if (!ret)
+				r = -ETIMEDOUT;
+			else if (ret < 0)
+				r = ret;
+		}
 		dma_fence_put(mfence);
 		pr_debug("sdma copy memory fence done\n");
 	}
@@ -494,6 +508,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	u64 ttm_res_offset;
 	struct kfd_node *node;
 	unsigned long mpages = 0;
+	int idx;
 	long r = 0;
 
 	if (start_mgr < prange->start || last_mgr > prange->last) {
@@ -507,6 +522,12 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
 		return -ENODEV;
 	}
+	/* The device may be electrically gone before drm_dev_unplug() runs */
+	if (pci_dev_is_disconnected(node->adev->pdev))
+		return -ENODEV;
+	/* Block unplug while the migration submits jobs and waits on them */
+	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
+		return -ENODEV;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
 		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
@@ -521,6 +542,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 					node->xcp ? node->xcp->id : 0);
 	if (r) {
 		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
+		drm_dev_exit(idx);
 		return -ENOSPC;
 	}
 
@@ -565,6 +587,7 @@ out:
 					prange->npages * PAGE_SIZE,
 					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
 					node->xcp ? node->xcp->id : 0);
+	drm_dev_exit(idx);
 	return r < 0 ? r : 0;
 }
 
@@ -821,6 +844,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	unsigned long start;
 	unsigned long end;
 	unsigned long mpages = 0;
+	int idx;
 	long r = 0;
 
 	/* this pragne has no any vram page to migrate to sys ram */
@@ -841,6 +865,12 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
 		return -ENODEV;
 	}
+	/* The device may be electrically gone before drm_dev_unplug() runs */
+	if (pci_dev_is_disconnected(node->adev->pdev))
+		return -ENODEV;
+	/* Block unplug while the migration submits jobs and waits on them */
+	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
+		return -ENODEV;
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
 		 prange->svms, prange, start_mgr, last_mgr,
 		 prange->actual_loc);
@@ -885,6 +915,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 		}
 	}
 
+	drm_dev_exit(idx);
 	return r < 0 ? r : 0;
 }
 
