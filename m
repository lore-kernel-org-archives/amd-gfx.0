Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E253DC53209
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 20:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43FEA10E217;
	Mon, 27 Jul 2026 20:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WgklpZSO";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056EF10E217
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 20:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWNn6CqOPN7OsEdhYlxk4mbEliXT0TSc4/NFsoOdFNX2+z0IiZuamNBXfRY7n48gIK9jcAHZcuNjQacDy4N6p6Mo2Hm81H0VejpLAQETz1NRXRRo556/faoPUmpTb5CLTP50P/KxugZkGWc+KaT0mpaDDmUSj4s4F2wioTB3vccxnzVmNrd0kP513NOqihyx5ATwiQE803AI/ii9J40gV29qteOxIiEvqtT2W7IVUDFEB2O806I7T/0LFLDA7cWTM7KeJkYvnk+iH1MvPFySqNubXPuWrAF93XtbE6PYeYitzNHzPFt2a660yuy3bUha4xRtad6gHb/PbZY1vaCfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWq2VQhJflAgNlh/5YDkeHMHKbPI9y+y18qiSD+Seys=;
 b=k7CuL2U4M3G4W43hsSPlI55GJrjtTuSbsb5W5VgLWKM1mRo0jg3b4/Ntn3tvtCj427N1LK3BEWoRI0a+3GJ9VQuP5P8Gw6ziKko1YgbGEAwoxvNDyeM//2qJ54LkByF/OMQonKv7ZYZM0ANxhkIs/dlzJlD6z3EpFpQid1WIFLgeh5aLAa/Hcd4J27MPMKqUMuics9+NFnYNast13OCAvO2qD6qx5Y5AH9ijSBoe52H5wM91DGHodlJKVF61TbJ29U5fAMO4sg/6hTzwdpuy8MIzbFXMJ5htZPUH4ru3/0jkzNpJKml/NgH4ufZWlYun7FVTflnx1tV+xtAYdW1Wjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWq2VQhJflAgNlh/5YDkeHMHKbPI9y+y18qiSD+Seys=;
 b=WgklpZSOfsmuAeV/cKqVUNF4pVv7mOzbRKwe/BOOq9Are379LKl/Y4e/p5m2txgFVJD3uH95yM0hUXGCQmsBiHenkpPsUWscnk4IJ4B0gb47n5jFk07q1eEQAaljZhn6790mTwvfBoB1TWbHA2IWQsIVe/ak27blVfqc6XIdqMM=
Received: from SJ0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:a03:333::29)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:17:30 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::6a) by SJ0PR03CA0114.outlook.office365.com
 (2603:10b6:a03:333::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 20:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 20:17:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 15:17:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Evict SVM BOs synchronously from TTM eviction
Date: Mon, 27 Jul 2026 16:16:51 -0400
Message-ID: <20260727201652.765882-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e0e46e-3e66-4285-4c37-08deec1c14f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|56012099006|10067099003|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: COWE35GkJ2QuhUT4It+WOEFHXWWMNKqgcu0OOHvTDsdOIRkQ+HGOgMcuquyuCHZLXFdk83BOdNdciUUHwSr3l0+yjKhm5/3drpNVGhf61uJio9Ow7+n3Elx4UzOxZJsiXaCnEkUWscQHGeXgMtywBGrYOZvDQOQTi0KEYIK/dEbhSOXEia+tDapk54CBmVyEb1islVrMzjr+THP7JeiWPb6gUdxqaEBNDCdD4iL6KMsHYQZKkYaPK+VxV3VtLwW6x6YtuLkWd0HUZaszxlyQRRnUijCrAC3Gr5qcYhcZL75qmG2poYhVmhSp0vEVqI+WIdEWSBqi6R1/v350TFW6C8IfHtmRIjrKUD0yQIM6BIP+Ol6dpIJqR1M6P0lW4ozcb0TLAGTeKsTzsHm2LpzRLCr1WvORVp4MXEtipJeub5q1nxD/sU/zV+5fH8caLcKsfX9VbOKEQNOoOTiSSMN1+YTzD5MgqRIFtvx/za0s6YCZYwTzxayQH1VfKjwZ3viZ1dq0GUyEZ8J4FNkD+juk/rnUzHZ9aC0TmvFDCheBxF0wG2Y8fVbHHedBHs0cmoqF1wCBCl1vm2PSyl7E+uO6y36Rajie9ABkcITIgCAdhXUOh+/ktpoe3MCL++caiTILBs9lVGrUqT71btxV0lT3h0Dw1uWbuoxy3ROmmptFe1pMj1ap+OjmYIgtCLFbufDetD998y31evbHu/OcGw4D+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kbQu9Vw6oHq+9OFaciJojB2/RtkXFCtYBgRDJa3+YXMtg7eXSkuOB/KQ9clevYMr4g/zGl9MJapzjMr7cnRwOGNC0RnC2p50tA1j4pCrcxz2cAkpII8bpFzyfC8Io806imFFtmqbuuuF1El4QzpGu2b0GVx1oxSRbtp1SwLUbRThmvWV8fZFMQBBDEoFTkd4u3SuBDOOdoKiAfWySFCTon0Qpw+mfQRBaVjw6esjL9uFDrvgTfOv6IMoA+UW8nMQtcYDIJxORO+7SYwlVMzkd9ItYFo6MxL/c16xvWZbZY2tH9Thu0GUv81e/BliFQ1Fq0AAoH95Nbj3ES2qZWhooKIb4ZOXFHyGNSGYlJSk82rUIe5qIaG0n/9em7CnSphN/wkyxZMwHWwrIUi7ZC0/GuB1gPtcfi1n7JTXjRqrqOjYBUqWv4qdk3Ds3YGCA/us
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:17:28.6430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e0e46e-3e66-4285-4c37-08deec1c14f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F
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

svm_range_evict_svm_bo_worker() migrated an SVM BO's pages back to system
memory from a work item that took mmap_read_lock. When an mmap writer was
pending, that read lock blocked behind the writer while the thread
allocating a new migration VRAM BO waited on this BO's eviction fence - a
circular wait that hung the SVM workers.

Evict the SVM BO synchronously from the TTM eviction path
(amdgpu_ttm_bo_eviction_valuable) instead of deferring to a work item.
The BO is already reserved and the lock order is mmap_lock -> BO
reservation, so only trylock the owning process's mmap lock; on
contention return -EBUSY so TTM skips this BO. This removes the eviction
work item and the enable_signaling path, so no worker can block on
mmap_read_lock.

The SVM BO uses AMDGPU_GEM_CREATE_DISCARDABLE, so ttm_bo_evict takes the
pipeline_gutting path and skips allocating a system memory placement.
That would be wasted work, since svm_migrate_vram_to_ram allocates the
system pages and copies the data back itself.

Eviction now migrates ranges directly, so it must serialize with the
owning process: it trylocks migrate_mutex under svm_bo->list_lock before
unlinking the range, and svm_range_free() unlinks the range then waits on
migrate_mutex, so a concurrent eviction cannot free a range under it.

Drop the mm reference with mmput_async so exit_mmap() does not run under
the BO reservation.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 22 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 16 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 88 ++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          | 10 +--
 6 files changed, 100 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 121282dd30c1..be764b6802b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -39,6 +39,7 @@
 #if IS_ENABLED(CONFIG_HSA_AMD)
 #include "kfd_priv.h"
 #endif
+#include "kfd_svm.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -972,3 +973,24 @@ int amdgpu_amdkfd_reset_mes_queue(struct amdgpu_device *adev,
 	return kgd2kfd_reset_mes_queue(adev->kfd.dev, node_id, queue_type,
 				       pipe, queue, db);
 }
+
+int amdgpu_amdkfd_evict_svm_bo(struct amdgpu_bo *bo)
+{
+	struct dma_resv_iter cursor;
+	struct dma_fence *fence;
+	int r = 0;
+
+	dma_resv_iter_begin(&cursor, bo->tbo.base.resv, DMA_RESV_USAGE_BOOKKEEP);
+	dma_resv_for_each_fence_unlocked(&cursor, fence) {
+		struct amdgpu_amdkfd_fence *f = to_amdgpu_amdkfd_fence(fence);
+
+		if (f && f->svm_bo) {
+			r = svm_range_evict_svm_bo(f->svm_bo);
+			if (r)
+				break;
+		}
+	}
+	dma_resv_iter_end(&cursor);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 338412a750ed..b4840ee36f2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -286,6 +286,7 @@ int amdgpu_amdkfd_reset_mes_queue(struct amdgpu_device *adev,
 				  int queue_type,
 				  int pipe, int queue,
 				  unsigned int db);
+int amdgpu_amdkfd_evict_svm_bo(struct amdgpu_bo *bo);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index b0299d861903..553d26c2744e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -135,9 +135,6 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
 	if (!fence->svm_bo) {
 		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, fence->context_id, f))
 			return true;
-	} else {
-		if (!svm_range_schedule_evict_svm_bo(fence))
-			return true;
 	}
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 03c1e5e3580c..746290216aae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1488,6 +1488,7 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 					    const struct ttm_place *place)
 {
 	struct dma_resv_iter resv_cursor;
+	struct amdgpu_bo *abo;
 	struct dma_fence *f;
 
 	if (!amdgpu_bo_is_amdgpu_bo(bo))
@@ -1497,6 +1498,21 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	if (bo->resource->mem_type == TTM_PL_SYSTEM)
 		return true;
 
+	abo = ttm_to_amdgpu_bo(bo);
+	if (abo->flags & AMDGPU_GEM_CREATE_DISCARDABLE) {
+		/*
+		 * SVM BOs are migrated to system memory synchronously in this
+		 * TTM eviction context. The migration needs the owning
+		 * process's mmap lock, but the normal lock order is
+		 * mmap_lock -> BO reservation and the BO is already reserved
+		 * here. svm_range_evict_svm_bo() only trylocks the mmap lock;
+		 * if the eviction fails for any reason, we return false so TTM
+		 * skips this BO instead of risking a deadlock.
+		 */
+		if (amdgpu_amdkfd_evict_svm_bo(abo) < 0)
+			return false;
+	}
+
 	if (bo->type == ttm_bo_type_kernel &&
 	    !amdgpu_vm_evictable(ttm_to_amdgpu_bo(bo)))
 		return false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 30ad10bbd47e..4c6700c6e88d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -69,7 +69,6 @@ struct criu_svm_metadata {
 	struct kfd_criu_svm_range_priv_data data;
 };
 
-static void svm_range_evict_svm_bo_worker(struct work_struct *work);
 static bool
 svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 				    const struct mmu_notifier_range *range,
@@ -97,7 +96,7 @@ static void svm_range_unlink(struct svm_range *prange)
 
 	if (prange->svm_bo) {
 		spin_lock(&prange->svm_bo->list_lock);
-		list_del(&prange->svm_bo_list);
+		list_del_init(&prange->svm_bo_list);
 		spin_unlock(&prange->svm_bo->list_lock);
 	}
 
@@ -286,6 +285,17 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms, prange,
 		 prange->start, prange->last);
 
+	/* Unlink from range_list; no-op if already unlinked. */
+	if (prange->svm_bo) {
+		spin_lock(&prange->svm_bo->list_lock);
+		list_del_init(&prange->svm_bo_list);
+		spin_unlock(&prange->svm_bo->list_lock);
+	}
+
+	/* Wait for any in-flight eviction of this range to finish. */
+	mutex_lock(&prange->migrate_mutex);
+	mutex_unlock(&prange->migrate_mutex);
+
 	svm_range_vram_node_free(prange);
 	if (do_unmap)
 		svm_range_dma_unmap(prange);
@@ -588,7 +598,6 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 					   mm,
 					   svm_bo, p->context_id);
 	mmput(mm);
-	INIT_WORK(&svm_bo->eviction_work, svm_range_evict_svm_bo_worker);
 	svm_bo->evicting = 0;
 	memset(&bp, 0, sizeof(bp));
 	bp.size = prange->npages * PAGE_SIZE;
@@ -3631,39 +3640,36 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 	return 0;
 }
 
-int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
-{
-	/* Dereferencing fence->svm_bo is safe here because the fence hasn't
-	 * signaled yet and we're under the protection of the fence->lock.
-	 * After the fence is signaled in svm_range_bo_release, we cannot get
-	 * here any more.
-	 *
-	 * Reference is dropped in svm_range_evict_svm_bo_worker.
-	 */
-	if (svm_bo_ref_unless_zero(fence->svm_bo)) {
-		WRITE_ONCE(fence->svm_bo->evicting, 1);
-		schedule_work(&fence->svm_bo->eviction_work);
-	}
-
-	return 0;
-}
-
-static void svm_range_evict_svm_bo_worker(struct work_struct *work)
+int svm_range_evict_svm_bo(struct svm_range_bo *svm_bo)
 {
-	struct svm_range_bo *svm_bo;
 	struct mm_struct *mm;
 	int r = 0;
 
-	svm_bo = container_of(work, struct svm_range_bo, eviction_work);
+	if (!svm_bo_ref_unless_zero(svm_bo))
+		return 0;
 
-	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
-		mm = svm_bo->eviction_fence->mm;
-	} else {
+	if (!mmget_not_zero(svm_bo->eviction_fence->mm)) {
 		svm_range_bo_unref(svm_bo);
-		return;
+		return 0;
 	}
+	mm = svm_bo->eviction_fence->mm;
+
+	/*
+	 * Called with the BO reserved; lock order is mmap_lock -> BO
+	 * reservation. Only trylock mmap to invert that order safely: a
+	 * trylock never blocks, so it cannot deadlock against the reservation
+	 * and lockdep records no reverse dependency. On contention return
+	 * -EBUSY so TTM skips this BO.
+	 */
+	if (!mmap_read_trylock(mm)) {
+		pr_debug("skip eviction, contended to take mmap_read lock\n");
+		mmput_async(mm);
+		svm_range_bo_unref(svm_bo);
+		return -EBUSY;
+	}
+
+	WRITE_ONCE(svm_bo->evicting, 1);
 
-	mmap_read_lock(mm);
 	spin_lock(&svm_bo->list_lock);
 	while (!list_empty(&svm_bo->range_list) && !r) {
 		struct svm_range *prange =
@@ -3671,13 +3677,24 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 						struct svm_range, svm_bo_list);
 		int retries = 3;
 
+		/*
+		 * Trylock migrate_mutex under list_lock, before unlinking the
+		 * range, so svm_range_free() cannot free it under us. On
+		 * contention the owner is migrating this range; skip the BO.
+		 */
+		if (!mutex_trylock(&prange->migrate_mutex)) {
+			pr_debug("skip eviction, contended migrate_mutex\n");
+			/* Clear evicting so the BO keeps being reused. */
+			WRITE_ONCE(svm_bo->evicting, 0);
+			r = -EBUSY;
+			break;
+		}
 		list_del_init(&prange->svm_bo_list);
 		spin_unlock(&svm_bo->list_lock);
 
 		pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms,
 			 prange->start, prange->last);
 
-		mutex_lock(&prange->migrate_mutex);
 		do {
 			/* migrate all vram pages in this prange to sys ram
 			 * after that prange->actual_loc should be zero
@@ -3701,15 +3718,24 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	}
 	spin_unlock(&svm_bo->list_lock);
 	mmap_read_unlock(mm);
-	mmput(mm);
+	/* Defer mmput: exit_mmap() must not run under the BO reservation. */
+	mmput_async(mm);
 
-	dma_fence_signal(&svm_bo->eviction_fence->base);
+	/*
+	 * Only signal the eviction fence once the ranges have been processed.
+	 * On -EBUSY we bailed out without migrating; leave the BO in VRAM and
+	 * let TTM retry later.
+	 */
+	if (r != -EBUSY)
+		dma_fence_signal(&svm_bo->eviction_fence->base);
 
 	/* This is the last reference to svm_bo, after svm_range_vram_node_free
 	 * has been called in svm_migrate_vram_to_ram
 	 */
 	WARN_ONCE(!r && kref_read(&svm_bo->kref) != 1, "This was not the last reference\n");
 	svm_range_bo_unref(svm_bo);
+
+	return r;
 }
 
 static int
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index a63dfc95b602..4232c47422e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -44,7 +44,6 @@ struct svm_range_bo {
 	struct list_head		range_list; /* all svm ranges shared this bo */
 	spinlock_t			list_lock;
 	struct amdgpu_amdkfd_fence	*eviction_fence;
-	struct work_struct		eviction_work;
 	uint32_t			evicting;
 	struct work_struct		release_work;
 	struct kfd_node			*node;
@@ -175,7 +174,8 @@ void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
-int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
+int svm_range_evict_svm_bo(struct svm_range_bo *svm_bo);
+
 void svm_range_add_list_work(struct svm_range_list *svms,
 			     struct svm_range *prange, struct mm_struct *mm,
 			     enum svm_work_list_ops op);
@@ -229,11 +229,9 @@ static inline int svm_range_restore_pages(struct amdgpu_device *adev,
 	return -EFAULT;
 }
 
-static inline int svm_range_schedule_evict_svm_bo(
-		struct amdgpu_amdkfd_fence *fence)
+static inline int svm_range_evict_svm_bo(struct svm_range_bo *svm_bo)
 {
-	WARN_ONCE(1, "SVM eviction fence triggered, but SVM is disabled");
-	return -EINVAL;
+	return 0;
 }
 
 static inline void svm_range_get_info(struct kfd_process *p,
-- 
2.50.1

