Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFC5C531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 20:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB9C10E4D8;
	Mon, 27 Jul 2026 20:17:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ONLSillh";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30EC210E4D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 20:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyKAr7a4BPffs6ujrhdyNdiibBdONfy/bvqN6QxFUUpimS8rjpqytvewtRLAWv7xS1SUamAF9mJ43vWhcemHvQ1uL9SOkSwtOx7qpfjTyre7m/Y/nx72mHI0IseXrFGTzk9apzkSdG8ZyBdlFPcq7gABH6XFCZlDTWjSDBn7PLQX2vCmRaBc/+XwPUU4lT4j8QLdVFw6OrOOfJPRKT6h+cl1uo9IqJi35ueakzo7X/t38K6jwCqduyukxMwCw4jEknSy8MH9r6BO5j46N2wUcOBGZt/BbUpoDWsXt2Se8ZnfxugijREEPXxcHUUt0QZV8WqxNqUf3XGIdSykll3lpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhnR7EQjcs6ZfKiZKNYl7QBInYVWfSId9/iuBaJJHFg=;
 b=cMsn/r0YkDB0yIRXkRACXOWdNqT/s6xUnqTiXjJ6w4ceSwDYF/iji7fUHsiwtkGc1VH4IQJ9297k08+t1tYuJXbHfUXIWrkFgHMhTMb7xuYvbKsVQtaKRZ6Sb620SK4A+fqczXAOyPn59UjskI59DmwCKaBL8GgVxV8tTn9//HqE3RLqovgxWIyDIKExW866RXYWSUfvMCUZWDsn8q0UcsFanjMoggO9KQKByUzJrqVoiPK1ZDeOZ3JsskyDvkrAJK8lhXv+tIm4lVi+425cp5uYDupZu3plCwshbUejr8JdYeVi3A2XOFcng1X/fmxy7JFjCA6vszXnlVAX95E52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhnR7EQjcs6ZfKiZKNYl7QBInYVWfSId9/iuBaJJHFg=;
 b=ONLSillhC2CFvxLIFB33owdOz+VsR/g6BU5T5VDvBWYBE4qyOX5WgWJpdvLQ59gjdHG/yj2Lr3PVRhdcfmqlMM3+TwyzAjnaKz0aikKp0cU3Cz0KtRFVLpbRNiaQXyjAvOB9iSbK3oUvRz255GzbGYlUNxftOe1JJlDa3QRKibk=
Received: from SJ0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:a03:333::12)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 20:17:48 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::94) by SJ0PR03CA0097.outlook.office365.com
 (2603:10b6:a03:333::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 20:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 20:17:47 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 15:17:45 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Remove svm_bo eviction fence
Date: Mon, 27 Jul 2026 16:16:52 -0400
Message-ID: <20260727201652.765882-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260727201652.765882-1-Philip.Yang@amd.com>
References: <20260727201652.765882-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2671af-6231-4573-4587-08deec1c2058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YDCu/YHzXmvHyW/MvZIrtX+PYNOtfO0s6t8udC8s+BWdumW3rFMSuHMZibT452uyjlFbkijJXiG5olbjWvW83Ipt/5nx5qg8Xd7ByHXnqRgAKuJwlOp6Zje5ygQ2lW1kc/FaLm9IOHCP9U1b7f5KnszIwcrK8hjJca1RP1CgutNrFbdvzj9dFmbgGhKLV1gLlOiLj7m8JRGy8hEcRNNX9WpZNSbpgxAjnUa2uupbjYzscdGbrk22BLIrDJ43jVhiuF1CUeK6JAC3tqhd4TUsJuOWccW9Y5sDatXDm+04U+Ahq/fqForFXtwHeCFfIoHrtYXSwBC7BXVyxAJW5TcxfFktUbyGCYvSl4Q07OF/Y4eGGmwvmWsAYlw7UCYRd1pfY4bUwAUlJu4ptzLi/gq3XCfIqeJlEZZHTS03jFKMWOfg9tJLmgU3sGubz2QwxVFNcNey8iD4UvOeZDXPYbt/akufiIvRr/sErW+fBiSRAaikSfG+Lupg7par3aJ4zvLH2AfRmQ3rNUUKNHZ+QRyMnbMRnMBz6OZgdEA4xzZC0qShwuqgxVx14CQnjOp8ZqjHWpVV3GgEtzfcwcdFYv9suCpOsEGlX/z3lgYnMDUiUKlQ/v3jofeiR/ZALrI2j2zyL09QAsApXHORp/tZzgko7y8xIrth3mUNZfqUOy11MDk+oKQqcXTHG56ouDXcejLsztu4on7aIZdXC0F6okxM3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cHXXzC5hCOEBCpRQBXvNlAXPeaa78cswMgW6UfyrosDcYiZdz7zFM6jTv4FtK+rT1ylIiJM6JIyMdclSoaG1MGktuYBQhXig8B5fWiyvs4JUrScUsWaY3Ci5Y8Bgerm2n5MZM27gH/xWEzTt5JtShG7BP/aStTG4+1vDRxNWDt0X2rbdYGmA9wxYL7d54FaqjebTdCyaP7AKc0qfZnsXM2UiP7ccmBmgRskY2yEAWgd5/MUVC1RidXt0zZcvjIkP+/cEhEe6rdYBa/r1f0nYigErLyxNEQoutehaJqw4HENksF5Z5bWBBIaVuVbKKnShE74g7JUlSsjqJB9w82jAGSeuos4+0n58FGObnliJ9i4jGL3PmNr5/zQkgL2OhxSCMZLKNFcFfvxK6kNw5tDLgxnGyMVUbuHIgCssQBtnyEPrR4OR597XscIkxhuzlwPy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 20:17:47.7736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2671af-6231-4573-4587-08deec1c2058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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

SVM BOs are now migrated back to system memory synchronously from the TTM
eviction path (svm_range_evict_svm_bo), so the per-svm_bo eviction fence
is no longer used.

Remove the eviction fence from svm_range_bo, drop the
amdgpu_amdkfd_fence->svm_bo back pointer and the
amdgpu_amdkfd_evict_svm_bo() helper, and stop special-casing svm_bo
fences in the KFD fence enable_signaling and check_mm paths. Embed struct
amdgpu_bo directly in svm_range_bo with a dedicated svm_range_bo_destroy()
callback, and keep the owning mm via mmgrab()/mmdrop() instead of through
the fence.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  21 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 -
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  15 +--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 109 +++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |  13 ++-
 9 files changed, 64 insertions(+), 115 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index be764b6802b5..816d8817f0b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -973,24 +973,3 @@ int amdgpu_amdkfd_reset_mes_queue(struct amdgpu_device *adev,
 	return kgd2kfd_reset_mes_queue(adev->kfd.dev, node_id, queue_type,
 				       pipe, queue, db);
 }
-
-int amdgpu_amdkfd_evict_svm_bo(struct amdgpu_bo *bo)
-{
-	struct dma_resv_iter cursor;
-	struct dma_fence *fence;
-	int r = 0;
-
-	dma_resv_iter_begin(&cursor, bo->tbo.base.resv, DMA_RESV_USAGE_BOOKKEEP);
-	dma_resv_for_each_fence_unlocked(&cursor, fence) {
-		struct amdgpu_amdkfd_fence *f = to_amdgpu_amdkfd_fence(fence);
-
-		if (f && f->svm_bo) {
-			r = svm_range_evict_svm_bo(f->svm_bo);
-			if (r)
-				break;
-		}
-	}
-	dma_resv_iter_end(&cursor);
-
-	return r;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b4840ee36f2b..1b7dc0d3963b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -99,7 +99,6 @@ struct amdgpu_amdkfd_fence {
 	struct mm_struct *mm;
 	spinlock_t lock;
 	char timeline_name[TASK_COMM_LEN];
-	struct svm_range_bo *svm_bo;
 	uint16_t context_id;
 };
 
@@ -194,7 +193,6 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
-				struct svm_range_bo *svm_bo,
 				u16 context_id);
 
 int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev);
@@ -286,7 +284,6 @@ int amdgpu_amdkfd_reset_mes_queue(struct amdgpu_device *adev,
 				  int queue_type,
 				  int pipe, int queue,
 				  unsigned int db);
-int amdgpu_amdkfd_evict_svm_bo(struct amdgpu_bo *bo);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 553d26c2744e..9b10d015671c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -62,7 +62,6 @@ static atomic_t fence_seq = ATOMIC_INIT(0);
 
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
-				struct svm_range_bo *svm_bo,
 				u16 context_id)
 {
 	struct amdgpu_amdkfd_fence *fence;
@@ -76,7 +75,6 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 	fence->mm = mm;
 	get_task_comm(fence->timeline_name, current);
 	spin_lock_init(&fence->lock);
-	fence->svm_bo = svm_bo;
 	fence->context_id = context_id;
 	dma_fence_init(&fence->base, &amdkfd_fence_ops, &fence->lock,
 		   context, atomic_inc_return(&fence_seq));
@@ -128,14 +126,8 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
 	if (dma_fence_is_signaled(f))
 		return true;
 
-	/* if fence->svm_bo is NULL, means this fence is created through
-	 * init_kfd_vm() or amdgpu_amdkfd_gpuvm_restore_process_bos().
-	 * Therefore, this fence is amdgpu_amdkfd_fence->eviction_fence.
-	 */
-	if (!fence->svm_bo) {
-		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, fence->context_id, f))
-			return true;
-	}
+	if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, fence->context_id, f))
+		return true;
 	return false;
 }
 
@@ -169,7 +161,6 @@ static void amdkfd_fence_release(struct dma_fence *f)
  *
  * Check if @mm is same as that of the fence @f, if same return TRUE else
  * return FALSE.
- * For svm bo, which support vram overcommitment, always return FALSE.
  */
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
 {
@@ -177,7 +168,7 @@ bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
 
 	if (!fence)
 		return false;
-	else if (fence->mm == mm  && !fence->svm_bo)
+	else if (fence->mm == mm)
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 451d7f7ef5c1..1e71829e0fc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1423,7 +1423,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		info->eviction_fence =
 			amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 						   current->mm,
-						   NULL, process->context_id);
+						   process->context_id);
 		if (!info->eviction_fence) {
 			pr_err("Failed to create eviction fence\n");
 			ret = -ENOMEM;
@@ -3093,7 +3093,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 			amdgpu_amdkfd_fence_create(
 				process_info->eviction_fence->base.context,
 				process_info->eviction_fence->mm,
-				NULL, process_info->context_id);
+				process_info->context_id);
 
 		if (!new_fence) {
 			pr_err("Failed to create eviction fence\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d4a9d5e8fb42..5d9d137209b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -43,6 +43,7 @@
 #include "amdgpu_vram_mgr.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_dma_buf.h"
+#include "kfd_svm.h"
 
 /**
  * DOC: amdgpu_object
@@ -93,7 +94,8 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
 bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
 {
 	if (bo->destroy == &amdgpu_bo_destroy ||
-	    bo->destroy == &amdgpu_bo_user_destroy)
+	    bo->destroy == &amdgpu_bo_user_destroy ||
+	    bo->destroy == &svm_range_bo_destroy)
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 746290216aae..0e7e586b217a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -60,6 +60,7 @@
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_res_cursor.h"
 #include "bif/bif_4_1_d.h"
+#include "kfd_svm.h"
 
 MODULE_IMPORT_NS("DMA_BUF");
 
@@ -1499,7 +1500,8 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 		return true;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	if (abo->flags & AMDGPU_GEM_CREATE_DISCARDABLE) {
+	if ((abo->flags & AMDGPU_GEM_CREATE_DISCARDABLE) &&
+	    bo->destroy == &svm_range_bo_destroy) {
 		/*
 		 * SVM BOs are migrated to system memory synchronously in this
 		 * TTM eviction context. The migration needs the owning
@@ -1509,7 +1511,7 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 		 * if the eviction fails for any reason, we return false so TTM
 		 * skips this BO instead of risking a deadlock.
 		 */
-		if (amdgpu_amdkfd_evict_svm_bo(abo) < 0)
+		if (svm_range_evict_svm_bo(abo) < 0)
 			return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index ed3649a81332..f5af1dd3b70e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -954,12 +954,12 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 		pr_debug("failed get device page at addr 0x%lx\n", addr);
 		return VM_FAULT_SIGBUS;
 	}
-	if (!mmget_not_zero(svm_bo->eviction_fence->mm)) {
+	if (!mmget_not_zero(svm_bo->mm)) {
 		pr_debug("addr 0x%lx of process mm is destroyed\n", addr);
 		return VM_FAULT_SIGBUS;
 	}
 
-	mm = svm_bo->eviction_fence->mm;
+	mm = svm_bo->mm;
 	if (mm != vmf->vma->vm_mm)
 		pr_debug("addr 0x%lx is COW mapping in child process\n", addr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4c6700c6e88d..18abef8918ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -390,8 +390,10 @@ static bool svm_bo_ref_unless_zero(struct svm_range_bo *svm_bo)
 static void svm_range_bo_release(struct kref *kref)
 {
 	struct svm_range_bo *svm_bo;
+	struct amdgpu_bo *bo;
 
 	svm_bo = container_of(kref, struct svm_range_bo, kref);
+	bo = &svm_bo->bo;
 	pr_debug("svm_bo 0x%p\n", svm_bo);
 
 	spin_lock(&svm_bo->list_lock);
@@ -417,12 +419,12 @@ static void svm_range_bo_release(struct kref *kref)
 	}
 	spin_unlock(&svm_bo->list_lock);
 
-	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
+	if (mmget_not_zero(svm_bo->mm)) {
 		struct kfd_process_device *pdd;
 		struct kfd_process *p;
 		struct mm_struct *mm;
 
-		mm = svm_bo->eviction_fence->mm;
+		mm = svm_bo->mm;
 		/*
 		 * The forked child process takes svm_bo device pages ref, svm_bo could be
 		 * released after parent process is gone.
@@ -431,18 +433,13 @@ static void svm_range_bo_release(struct kref *kref)
 		if (p) {
 			pdd = kfd_get_process_device_data(svm_bo->node, p);
 			if (pdd)
-				atomic64_sub(amdgpu_bo_size(svm_bo->bo), &pdd->vram_usage);
+				atomic64_sub(amdgpu_bo_size(bo), &pdd->vram_usage);
 			kfd_unref_process(p);
 		}
 		mmput(mm);
 	}
 
-	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
-		/* We're not in the eviction worker. Signal the fence. */
-		dma_fence_signal(&svm_bo->eviction_fence->base);
-	dma_fence_put(&svm_bo->eviction_fence->base);
-	amdgpu_bo_unref(&svm_bo->bo);
-	kfree(svm_bo);
+	amdgpu_bo_unref(&bo);
 }
 
 static void svm_range_bo_wq_release(struct work_struct *work)
@@ -504,20 +501,11 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
 			return false;
 		}
 		if (READ_ONCE(prange->svm_bo->evicting)) {
-			struct dma_fence *f;
-			struct svm_range_bo *svm_bo;
 			/* The BO is getting evicted,
 			 * we need to get a new one
 			 */
 			mutex_unlock(&prange->lock);
-			svm_bo = prange->svm_bo;
-			f = dma_fence_get(&svm_bo->eviction_fence->base);
 			svm_range_bo_unref(prange->svm_bo);
-			/* wait for the fence to avoid long spin-loop
-			 * at list_empty_careful
-			 */
-			dma_fence_wait(f, false);
-			dma_fence_put(f);
 		} else {
 			/* The BO was still around and we got
 			 * a new reference to it
@@ -526,7 +514,7 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
 			pr_debug("reuse old bo svms 0x%p [0x%lx 0x%lx]\n",
 				 prange->svms, prange->start, prange->last);
 
-			prange->ttm_res = prange->svm_bo->bo->tbo.resource;
+			prange->ttm_res = prange->svm_bo->bo.tbo.resource;
 			return true;
 		}
 
@@ -545,19 +533,22 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
 	return false;
 }
 
-static struct svm_range_bo *svm_range_bo_new(void)
-{
-	struct svm_range_bo *svm_bo;
+#define to_svm_range_bo(bo) container_of((bo), struct svm_range_bo, bo)
 
-	svm_bo = kzalloc_obj(*svm_bo);
-	if (!svm_bo)
-		return NULL;
-
-	kref_init(&svm_bo->kref);
-	INIT_LIST_HEAD(&svm_bo->range_list);
-	spin_lock_init(&svm_bo->list_lock);
+void svm_range_bo_destroy(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct svm_range_bo *svm_bo = to_svm_range_bo(bo);
 
-	return svm_bo;
+	drm_gem_object_release(&bo->tbo.base);
+	/*
+	 * svm_bo->mm is only set once the BO is fully created. If
+	 * ttm_bo_init_reserved() fails (e.g. no VRAM could be evicted), it
+	 * calls this destroy callback with mm still NULL, so guard the drop.
+	 */
+	if (svm_bo->mm)
+		mmdrop(svm_bo->mm);
+	kvfree(svm_bo);
 }
 
 int
@@ -567,7 +558,6 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct amdgpu_bo_param bp;
 	struct svm_range_bo *svm_bo;
-	struct amdgpu_bo_user *ubo;
 	struct amdgpu_bo *bo;
 	struct kfd_process *p;
 	struct mm_struct *mm;
@@ -581,26 +571,16 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	if (svm_range_validate_svm_bo(node, prange))
 		return 0;
 
-	svm_bo = svm_range_bo_new();
-	if (!svm_bo) {
-		pr_debug("failed to alloc svm bo\n");
-		return -ENOMEM;
-	}
 	mm = get_task_mm(p->lead_thread);
 	if (!mm) {
 		pr_debug("failed to get mm\n");
-		kfree(svm_bo);
 		return -ESRCH;
 	}
-	svm_bo->node = node;
-	svm_bo->eviction_fence =
-		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
-					   mm,
-					   svm_bo, p->context_id);
-	mmput(mm);
-	svm_bo->evicting = 0;
+
 	memset(&bp, 0, sizeof(bp));
 	bp.size = prange->npages * PAGE_SIZE;
+	bp.bo_ptr_size = sizeof(struct svm_range_bo);
+	bp.destroy = svm_range_bo_destroy;
 	bp.byte_align = PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
@@ -611,12 +591,23 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	if (node->xcp)
 		bp.xcp_id_plus1 = node->xcp->id + 1;
 
-	r = amdgpu_bo_create_user(node->adev, &bp, &ubo);
+	r = amdgpu_bo_create(node->adev, &bp, &bo);
 	if (r) {
 		pr_debug("failed %d to create bo\n", r);
+		mmput(mm);
 		goto create_bo_failed;
 	}
-	bo = &ubo->bo;
+
+	svm_bo = to_svm_range_bo(bo);
+	svm_bo->evicting = 0;
+	kref_init(&svm_bo->kref);
+	INIT_LIST_HEAD(&svm_bo->range_list);
+	spin_lock_init(&svm_bo->list_lock);
+
+	svm_bo->node = node;
+	svm_bo->mm = mm;
+	mmgrab(svm_bo->mm);
+	mmput(mm);
 
 	pr_debug("alloc bo at offset 0x%lx size 0x%lx on partition %d\n",
 		 bo->tbo.resource->start << PAGE_SHIFT, bp.size,
@@ -637,16 +628,8 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 		}
 	}
 
-	r = dma_resv_reserve_fences(bo->tbo.base.resv, TTM_NUM_MOVE_FENCES);
-	if (r) {
-		amdgpu_bo_unreserve(bo);
-		goto reserve_bo_failed;
-	}
-	amdgpu_bo_fence(bo, &svm_bo->eviction_fence->base, true);
-
 	amdgpu_bo_unreserve(bo);
 
-	svm_bo->bo = bo;
 	prange->svm_bo = svm_bo;
 	prange->ttm_res = bo->tbo.resource;
 	prange->offset = 0;
@@ -664,9 +647,6 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 reserve_bo_failed:
 	amdgpu_bo_unref(&bo);
 create_bo_failed:
-	dma_fence_put(&svm_bo->eviction_fence->base);
-	kfree(svm_bo);
-	prange->ttm_res = NULL;
 
 	return r;
 }
@@ -3640,19 +3620,20 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 	return 0;
 }
 
-int svm_range_evict_svm_bo(struct svm_range_bo *svm_bo)
+int svm_range_evict_svm_bo(struct amdgpu_bo *bo)
 {
+	struct svm_range_bo *svm_bo = to_svm_range_bo(bo);
 	struct mm_struct *mm;
 	int r = 0;
 
 	if (!svm_bo_ref_unless_zero(svm_bo))
 		return 0;
 
-	if (!mmget_not_zero(svm_bo->eviction_fence->mm)) {
+	if (!mmget_not_zero(svm_bo->mm)) {
 		svm_range_bo_unref(svm_bo);
 		return 0;
 	}
-	mm = svm_bo->eviction_fence->mm;
+	mm = svm_bo->mm;
 
 	/*
 	 * Called with the BO reserved; lock order is mmap_lock -> BO
@@ -3721,14 +3702,6 @@ int svm_range_evict_svm_bo(struct svm_range_bo *svm_bo)
 	/* Defer mmput: exit_mmap() must not run under the BO reservation. */
 	mmput_async(mm);
 
-	/*
-	 * Only signal the eviction fence once the ranges have been processed.
-	 * On -EBUSY we bailed out without migrating; leave the BO in VRAM and
-	 * let TTM retry later.
-	 */
-	if (r != -EBUSY)
-		dma_fence_signal(&svm_bo->eviction_fence->base);
-
 	/* This is the last reference to svm_bo, after svm_range_vram_node_free
 	 * has been called in svm_migrate_vram_to_ram
 	 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 4232c47422e6..284c4cd5aa0f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -39,11 +39,11 @@
 			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
 
 struct svm_range_bo {
-	struct amdgpu_bo		*bo;
+	struct amdgpu_bo		bo;
 	struct kref			kref;
 	struct list_head		range_list; /* all svm ranges shared this bo */
 	spinlock_t			list_lock;
-	struct amdgpu_amdkfd_fence	*eviction_fence;
+	struct mm_struct		*mm;
 	uint32_t			evicting;
 	struct work_struct		release_work;
 	struct kfd_node			*node;
@@ -168,13 +168,14 @@ struct svm_range *svm_range_from_addr(struct svm_range_list *svms,
 				      struct svm_range **parent);
 struct kfd_node *svm_range_get_node_by_id(struct svm_range *prange,
 					  uint32_t gpu_id);
+void svm_range_bo_destroy(struct ttm_buffer_object *tbo);
 int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
-int svm_range_evict_svm_bo(struct svm_range_bo *svm_bo);
+int svm_range_evict_svm_bo(struct amdgpu_bo *bo);
 
 void svm_range_add_list_work(struct svm_range_list *svms,
 			     struct svm_range *prange, struct mm_struct *mm,
@@ -229,7 +230,11 @@ static inline int svm_range_restore_pages(struct amdgpu_device *adev,
 	return -EFAULT;
 }
 
-static inline int svm_range_evict_svm_bo(struct svm_range_bo *svm_bo)
+static inline void svm_range_bo_destroy(struct ttm_buffer_object *tbo)
+{
+}
+
+static inline int svm_range_evict_svm_bo(struct amdgpu_bo *bo)
 {
 	return 0;
 }
-- 
2.50.1

