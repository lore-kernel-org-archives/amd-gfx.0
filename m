Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E2CC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 23:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B02910E3F6;
	Tue, 20 Dec 2022 23:27:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 965A110E3FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 23:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIUOGXPddqSSTyA0AKEhvDG80HWy+xOKLd8KzhG8n6LlH0PYnncke1eF1SV/mzynqJ3yoC9d044LufGgT7YUV1BzUxK30VSZI3U1NQogyFhY/4rcp/ONZG5o05q9QJt28gXhbYVmTrbliON7sB9VJp4JTjP3qjIXdKk6SaoGLVkOINAajklIIXVSW9kVFACGZPwAicxEJpjBcyEzet2dQIOYsUT1Xxr64a09+ITYHPBH6S/e5dvEEm7b83px2X0uxpbNS4B3VADUBfNkJJlfEd4fGqx1fAnF1+wG/3oDT8JfCxOpJ7kkZ9DvV7pWd1fN69nnjtQdLiK4IHT3wbFjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHDHpgX/kNU7wcPglsydVd9pCpuxtsd299V5lLDAHs0=;
 b=S2f8n0530FGcBvo5kw/ep0PKbnZgPbDLOoekdlsEkf6ZcUsFoEn6sgCaBSQQGxCNPcNze6sAQvObgF2UIT7bWPpTCdcJa6nHE+urc7UjV5PFLUypGGDolmmoKQgwftF2HiSKv3RMDpIa9BetR2GeKAfl+RBiBDPmGJdgqYrp1gw4WLA7yPl6OmrpxvcZVsupGfsnIzW3EkXjdIzJDcBIWkALgVFVG773Jg1GvN4LViOChOdr2nkDz3slkwEmqisJI4u7PxFo61m/egiYGFJhSG3UssozO//YkGfL3i1+i7Mh0efWTKSJxi4/SOs6lwZQoh0nz9JFmo2Dmftbnzft3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHDHpgX/kNU7wcPglsydVd9pCpuxtsd299V5lLDAHs0=;
 b=QVGumyggK5qprHYyncdrpd87QPXdV1eH6fnj4+HzNeqElYntcnX8Cmkp+YYfuPI7f+ca0/iDcLDfoqNb7OCWC6ygYm3Ip4vUjMsXJIODJ2TO/IZ7jsOJd6PMIGFIbXrqTOiMDPs0QiTFiPLcgdkPXSAc4hhItjq60gloVSNyQvk=
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 23:27:21 +0000
Received: from CO1PEPF00001A61.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::3b) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 23:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A61.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 20 Dec 2022 23:27:21 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 17:27:19 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 2/3] drm/amdgpu: Add range param to amdgpu_vm_update_range
Date: Tue, 20 Dec 2022 18:27:03 -0500
Message-ID: <20221220232704.3394112-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221220232704.3394112-1-Felix.Kuehling@amd.com>
References: <20221220232704.3394112-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A61:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 57948404-e658-4788-0faa-08dae2e1be27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVFfG4P/7/N5oHBxSEwtowHQRF0x22GmQs30a29ga6S4dXY1Sg82l6CgPvtHimWVBrkbWXYPbegShLY2wqA6/8KGYsQSPW949UYwF/9a9MIdnvuWhIP3iID8XaA3eHZ8vDKqqTg/wZ6wR2dz9xwchUiArs5oDBVyfdE8S4m/+6Iz068W4OO8U6M3Arr83oT0628uRzp4PbEtswyu5rWjxIkdauD/6id/sAR7ah9Tl+rnvgp+NeFIn9uWgeSQaZJCcAWvWSccLcTy1ohU4HxD19kA5X5F9s4ozC3Bh6MaWo1+qK9eAnB2IQOkxyuu7NUmGiuOES+XDsojh4EUNoNIWX/RAGcLzYvYJ+8czV9t4O5PYu+6AfIryHwZU0pB0xqlNVdMm5wtBRkLqsEBjkR84r9a3djzTRVEw7en5Gg8UlQknCnO+IBbwKAM1N3rxJJPID7k8DW41+eJ8p2DYPFsJxBKoKzaumCLs5HyH78D4Ndg+Gi8jPZAzdWBHrk8AsWsB84y0mKrQbfS9K1CyVIY9GBQAUWYYgl6NEejCY7hb1Gvw49aMJZEiejaOrSVcEpVQvk+h7UzDYVplHeoJZX91OO8XHDJe0GqtfpfoT7H9YSodwGfL8dawMezmKjL9VdFJqGM6kSfOYXKuTr/ItcQGkTMcDX1XB+jEeVNr9fJYzAjuF24m0fkr5LBxwwZnaT5NJB28ERrboJHnZ4WOM+lywnhZA7haSSqECwbKyz3IA0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(66574015)(7696005)(6916009)(478600001)(82740400003)(54906003)(26005)(4326008)(1076003)(6666004)(8676002)(70206006)(16526019)(70586007)(316002)(2616005)(186003)(8936002)(5660300002)(426003)(83380400001)(2906002)(356005)(41300700001)(336012)(36860700001)(81166007)(47076005)(36756003)(40460700003)(82310400005)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 23:27:21.0533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57948404-e658-4788-0faa-08dae2e1be27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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
Cc: philip.yang@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows page table updates to be coordinated with interval notifiers
to avoid writing stale page table entries to the pabe table. Moving the
critical section inside the page table update avoids lock dependencies
with page table allocations under the notifier lock.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 27 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 58 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  6 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  4 +-
 4 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a04f7aef4ca9..556d2e5d90e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -768,6 +768,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  * @vram_base: base for vram mappings
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
+ * @range: optional HMM range for coordination with interval notifier
  * @fence: optional resulting fence
  *
  * Fill in the page table entries between @start and @last.
@@ -780,7 +781,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct dma_resv *resv, uint64_t start, uint64_t last,
 			   uint64_t flags, uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
-			   struct dma_fence **fence)
+			   struct hmm_range *range, struct dma_fence **fence)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
@@ -794,7 +795,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
 	if (!tlb_cb) {
 		r = -ENOMEM;
-		goto error_unlock;
+		goto error_dev_exit;
 	}
 
 	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
@@ -811,6 +812,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
+#ifdef CONFIG_MMU_NOTIFIER
+	params.range = range;
+#endif
 	params.immediate = immediate;
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
@@ -823,12 +827,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	else
 		sync_mode = AMDGPU_SYNC_EXPLICIT;
 
-	amdgpu_vm_eviction_lock(vm);
-	if (vm->evicting) {
-		r = -EBUSY;
-		goto error_free;
-	}
-
 	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
 
@@ -893,7 +891,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		start = tmp;
 	}
 
+	r = amdgpu_vm_pts_lock(&params);
+	if (r)
+		goto error_free;
 	r = vm->update_funcs->commit(&params, fence);
+	amdgpu_vm_pts_unlock(&params);
 
 	if (flush_tlb || params.table_freed) {
 		tlb_cb->vm = vm;
@@ -911,8 +913,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 error_free:
 	kfree(tlb_cb);
 
-error_unlock:
-	amdgpu_vm_eviction_unlock(vm);
+error_dev_exit:
 	drm_dev_exit(idx);
 	return r;
 }
@@ -1058,7 +1059,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 					   resv, mapping->start, mapping->last,
 					   update_flags, mapping->offset,
 					   vram_base, mem, pages_addr,
-					   last_update);
+					   NULL, last_update);
 		if (r)
 			return r;
 	}
@@ -1253,7 +1254,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		r = amdgpu_vm_update_range(adev, vm, false, false, true, resv,
 					   mapping->start, mapping->last,
 					   init_pte_value, 0, 0, NULL, NULL,
-					   &f);
+					   NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -2512,7 +2513,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	r = amdgpu_vm_update_range(adev, vm, true, false, false, NULL, addr,
-				   addr, flags, value, 0, NULL, NULL, NULL);
+				   addr, flags, value, 0, NULL, NULL, NULL, NULL);
 	if (r)
 		goto error_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 07af80df812b..8fad51d66bce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -31,6 +31,8 @@
 #include <drm/drm_file.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <linux/sched/mm.h>
+#include <linux/hmm.h>
+#include <linux/mmu_notifier.h>
 
 #include "amdgpu_sync.h"
 #include "amdgpu_ring.h"
@@ -196,6 +198,13 @@ struct amdgpu_vm_update_params {
 	 */
 	struct amdgpu_vm *vm;
 
+#ifdef CONFIG_MMU_NOTIFIER
+	/**
+	 * @range: optional HMM range for coordination with interval notifier
+	 */
+	struct hmm_range *range;
+#endif
+
 	/**
 	 * @immediate: if changes should be made immediately
 	 */
@@ -411,7 +420,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct dma_resv *resv, uint64_t start, uint64_t last,
 			   uint64_t flags, uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
-			   struct dma_fence **fence);
+			   struct hmm_range *range, struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
@@ -535,4 +544,51 @@ static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
 	mutex_unlock(&vm->eviction_lock);
 }
 
+/*
+ * Make page tables safe to access without a reservation and ensure that the
+ * ptes being written are still valid. This can fail if page tables are being
+ * evicted (-EBUSY) or an HMM range is being invalidated (-EAGAIN).
+ */
+static inline int amdgpu_vm_pts_lock(struct amdgpu_vm_update_params *params)
+{
+	int r = 0;
+
+#ifdef CONFIG_MMU_NOTIFIER
+	if (params->range) {
+		mutex_lock(params->vm->notifier_lock);
+		if (mmu_interval_read_retry(params->range->notifier,
+					    params->range->notifier_seq)) {
+			r = -EAGAIN;
+			goto error_unlock_notifier;
+		}
+	}
+#endif
+	amdgpu_vm_eviction_lock(params->vm);
+	if (params->vm->evicting) {
+		r = -EBUSY;
+		goto error_unlock;
+	}
+
+	return 0;
+
+error_unlock:
+	amdgpu_vm_eviction_unlock(params->vm);
+#ifdef CONFIG_MMU_NOTIFIER
+error_unlock_notifier:
+	if (params->range)
+		mutex_unlock(params->vm->notifier_lock);
+#endif
+
+	return r;
+}
+
+static inline void amdgpu_vm_pts_unlock(struct amdgpu_vm_update_params *params)
+{
+	amdgpu_vm_eviction_unlock(params->vm);
+#ifdef CONFIG_MMU_NOTIFIER
+	if (params->range)
+		mutex_unlock(params->vm->notifier_lock);
+#endif
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index b5f3bba851db..2891284eba1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -597,9 +597,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 	if (entry->bo)
 		return 0;
 
-	amdgpu_vm_eviction_unlock(vm);
 	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
-	amdgpu_vm_eviction_lock(vm);
 	if (r)
 		return r;
 
@@ -960,6 +958,9 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		entry_end += cursor.pfn & ~(entry_end - 1);
 		entry_end = min(entry_end, end);
 
+		r = amdgpu_vm_pts_lock(params);
+		if (r)
+			return r;
 		do {
 			struct amdgpu_vm *vm = params->vm;
 			uint64_t upd_end = min(entry_end, frag_end);
@@ -992,6 +993,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 					break;
 			}
 		} while (frag_start < entry_end);
+		amdgpu_vm_pts_unlock(params);
 
 		if (amdgpu_vm_pt_descendant(adev, &cursor)) {
 			/* Free all child entries.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2dc3b04064bd..cc46878901c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1217,7 +1217,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	return amdgpu_vm_update_range(adev, vm, false, true, true, NULL, start,
 				      last, init_pte_value, 0, 0, NULL, NULL,
-				      fence);
+				      NULL, fence);
 }
 
 static int
@@ -1323,7 +1323,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 					   pte_flags,
 					   (last_start - prange->start) << PAGE_SHIFT,
 					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					   NULL, dma_addr, &vm->last_update);
+					   NULL, dma_addr, NULL, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
-- 
2.32.0

