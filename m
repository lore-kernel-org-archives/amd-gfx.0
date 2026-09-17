Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66390C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F103D10E6E7;
	Thu, 17 Sep 2026 11:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IaEZJtfu";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E7010EDB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6U9xCN40Dsm3OeBzHwzKF+NnvxlK+mpk2+qdypEjpTV1Vd5aU7HkEJkVclzy+WbhhD8v1jvjzFurZpKE44yFkjFzsCd49sRX4YZ0LdPF15k13Ed1AGB5R72Z4du/0Hwq4IYtXt9pAQ9d4FKWpUzfvvR/PCI0hD8qbzKrbwqfXaCN/jm3abMeEfmXPWwlAG6Ae145y+KPe/c/QYRYTVUWwo3MPn+/dkKpWf+NAoFAe/rTXTsNtIrtz8j1/VwaaBSincS3DS4t3JiJjqdHZjXw4YCTH4CAGdN4xOvB33uIYizrgq4Sy6zI1sd6CvChDPuzwbCvMfPrr4v6d+YTQVCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tFh+ORj3tBGb7n2TQ7IyH8EU8ylejsKmETovEPs5R8=;
 b=fWY0kenswdc0p+j+vuJqFQZEy9wVw7lFDCTUQLVJE8N8ZaWUMnfOJTH1WJossW8ApgwH9I7eE5jsoCoILZhOKn2tDVA0tq7oEB8ecxy3T7r5tQPe0YoiLPpa5oOm+weNkbW6e87MJ5Pp2MWc88VxidW5zAxs7Z6aP+MDRKcRev1ecwunOx10RMoo6/2Mw0KLSdfHvpdjiq77tTenRN5vfuK2w7IeagW8b+hMPlnabjkE0PYNv94d6bj8fzc3wOIWukPTedJdjZLAbPv/Zb6JuLcDe6y/BAE+JI8SuMFp94JSW+KQ0mcKjvsSCQxewdqjifZW6G5TrlcSb/CeWxDX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tFh+ORj3tBGb7n2TQ7IyH8EU8ylejsKmETovEPs5R8=;
 b=IaEZJtfu08X0Y3ZqzKyGOwS/kJIQjQzmZuA1O+VLMGXd4c5C8+9s0NZZ/t9z0Qe3Dh1X+PwPN9WDK+REEhwTPCMjT9bnncSyCOiCtyKo1VUVRI6fIC8swu+wj2XorpvSl0rO6+lDuTfVWLilmOSTPlmjeem+kDovOwXWJYJXVCs=
Received: from RI1P284CA0020.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:150::9) by
 PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 17 Sep
 2026 11:03:08 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10d6:10:150:cafe::32) by RI1P284CA0020.outlook.office365.com
 (2603:10d6:10:150::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 11:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:03:07 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:03:04 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amdgpu: fix the HMM range handling for KFD SVM
Date: Thu, 17 Sep 2026 19:01:55 +0800
Message-ID: <20260917110158.296198-11-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 5313465d-ae99-431a-4999-08df14ab40ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zCGqthDfkTwOvMkcYezSxWB4jAw3vbMFv7tLpUkP8St8MMiq6tVRpHO0WFVifRS52/8R+he8pw9xGzx9S+BCNTNN0q7UyRKG3F53vkfysIVRgp1woL1aiIjKbGSgcYo5pwtZ96o6SoPh8qGztNvhre4pkpVSciT+UnkE+KiRSlQpXGsmJCJnzbCO342SsarWJa853kyXpL5F1qNdtGlb8r6M/g4FYFu7nK1H4WBKW3HE+DSGybN3oQoisqa5WPQkfW8cMIwZo/axH0kHPoOsFpGb+HCUoMZHsE8t5PQBJthnFwc5SxIZXT/WqP2bVV5qhe/AiifAL13eVVciAc8mMYXxblZO/RHSK4DWHrX3QMdaOSvpyOl6h5bxaLtNEwLMePuT9qs0lnjkZ8YS6c8yGTuSi4SskpRNB91rSjEN4O//slYGfYtpfcfUAbE7RiX3E9w/hdnMAwIBEV4Q6/58tDeVtUdz35SbDRXfwfxn8gPkBPDtHfKjHSq+oNSLj1Zr0p3/qOJAyIQMLpC/fC0Yfkb0E0uxDoChcvFDgur0aoIXPgxViZEwmnYVNZQIUnTY71VDL2/JtZmhtfoZTyVoi4uJ8Nc2XSsss86DZppjZQ8Wc2Wqr3O2AGqupN28Dx2oCHZlSjTbUWGr5BtFSB5NNipw3K8Uk4xdlh+kAixtZdUjYIxNKut6fIdCJ4CtTL407AupYTWWQkCYXZQLzrQXpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WLF9Exr2Dt5SvjvlCAvb3BBED5DKC9ASu6UCVd+PLjBYj7XplVpNUoj0agl7IMW6tTRaryWvRNEGPhFVrN/4YE9ALx+L8+0Hy1HeiFA6zKpmlfcCUDNW/Ja9qw7CUxISei8h/sgmj7Wyg+u+XloLtLOV9/yV6qFCu5m1qch2do04jllo/XX4Pq9wMIZW5OeLrj5BBkYQePxzHqfnTh1bpIJww7zxUJd3W9PBnt900v9LY4Xd/WaVt7LIk2Q8oQXpnFZNSMyN95hTYzgz9o4Lse3CJgb70eea9kwc10kZhd199tZOWz6GthakIGsTMM4BrxTuKOPxbNybysOiJtdGf+U2F9VW2MUmKZTT5gI4wnnx5TAPNoTSlFlRsLkkuM6Of7knXbqKWwkUeZd84lmwuypZDJlMIF7wTEAi3/Ze+3f1sNYy8DJF1bjP+GnuP08+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:03:07.0177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5313465d-ae99-431a-4999-08df14ab40ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

It's mandatory that we have this check inside the VM handling or
otherwise page table allocation and filling PTEs doesn't work correctly.

This allows to remove the buggy SVM range lock, but that's not part of
this patch set.

Only compile tested!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 10 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 10 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 32 ++++++++-----------
 4 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a994141e9df5..9ea1a07577c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1117,6 +1117,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * @vram_base: base for vram mappings
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
+ * @hmm_range: to check validity of DMA addresses
  * @fence: optional resulting fence
  *
  * Fill in the page table entries between @start and @last. Allocate and free
@@ -1130,7 +1131,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			struct amdgpu_sync *sync, uint64_t start,
 			uint64_t last, uint64_t flags, uint64_t offset,
 			uint64_t vram_base, struct ttm_resource *res,
-			dma_addr_t *pages_addr, struct dma_fence **fence)
+			dma_addr_t *pages_addr,
+			struct amdgpu_hmm_range *hmm_range,
+			struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
@@ -1163,6 +1166,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.adev = adev;
 	params.vm = vm;
 	params.pages_addr = pages_addr;
+	params.hmm_range = hmm_range;
 	params.needs_flush = flush_tlb;
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
@@ -1456,7 +1460,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
 					mapping->start, mapping->last,
 					update_flags, mapping->offset,
-					vram_base, mem, pages_addr,
+					vram_base, mem, pages_addr, NULL,
 					last_update);
 		if (r)
 			goto error_free;
@@ -1666,7 +1670,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 
 		r = amdgpu_vm_map_range(adev, vm, true, false,
 					&sync, mapping->start, mapping->last,
-					0, 0, 0, NULL, NULL, &f);
+					0, 0, 0, NULL, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index fbbd9e725799..2def386c4f95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -461,7 +461,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			struct amdgpu_sync *sync, uint64_t start,
 			uint64_t last, uint64_t flags, uint64_t offset,
 			uint64_t vram_base, struct ttm_resource *res,
-			dma_addr_t *pages_addr, struct dma_fence **fence);
+			dma_addr_t *pages_addr,
+			struct amdgpu_hmm_range *hmm_range,
+			struct dma_fence **fence);
 int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct amdgpu_sync *sync, uint64_t start,
 			   uint64_t last, uint64_t flags,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index a3328a48fecd..3d4a80fd7661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -26,6 +26,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include "amdgpu_hmm.h"
 #include "amdgpu_vm.h"
 
 struct amdgpu_device;
@@ -72,6 +73,13 @@ struct amdgpu_vm_update_params {
 	 */
 	dma_addr_t *pages_addr;
 
+	/**
+	 * @hmm_range:
+	 *
+	 * Used to check the validity of pages_addr.
+	 */
+	struct amdgpu_hmm_range *hmm_range;
+
 	/**
 	 * @job: job to used for hw submission
 	 */
@@ -153,6 +161,8 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 	p->saved_flags = memalloc_noreclaim_save();
 	if (p->vm->evicting)
 		return -EBUSY;
+	if (p->hmm_range && !amdgpu_hmm_range_valid(p->hmm_range))
+		return -EAGAIN;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 93e490f00c83..3a224dac7b1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1461,7 +1461,8 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 static int
 svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		     unsigned long offset, unsigned long npages, bool readonly,
-		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
+		     dma_addr_t *dma_addr, struct amdgpu_hmm_range *hmm_range,
+		     struct amdgpu_device *bo_adev,
 		     struct dma_fence **fence, bool flush_tlb)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
@@ -1521,7 +1522,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 					gpu_start, gpu_end, pte_flags,
 					(last_start - prange->start) << PAGE_SHIFT,
 					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					NULL, dma_addr, &vm->last_update);
+					NULL, dma_addr, hmm_range, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
@@ -1548,7 +1549,9 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 }
 
 static int
-svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
+svm_range_map_to_gpus(struct svm_range *prange,
+		      struct amdgpu_hmm_range *hmm_range,
+		      unsigned long offset,
 		      unsigned long npages, bool readonly,
 		      unsigned long *bitmap, bool wait, bool flush_tlb)
 {
@@ -1584,7 +1587,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		set_bit(gpuidx, prange->bitmap_mapped);
 
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
-					 prange->dma_addr[gpuidx],
+					 prange->dma_addr[gpuidx], hmm_range,
 					 bo_adev, wait ? &fence : NULL,
 					 flush_tlb);
 		if (r)
@@ -1855,18 +1858,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		svm_range_lock(prange);
 
-		/* Free backing memory of hmm_range if it was initialized
-		 * Override return value to TRY AGAIN only if prior returns
-		 * were successful
-		 */
-		if (range && !amdgpu_hmm_range_valid(range) && !r) {
-			pr_debug("hmm update the range, need validate again\n");
-			r = -EAGAIN;
-		}
-
-		/* Free the hmm range */
-		amdgpu_hmm_range_free(range);
-
 		if (!r && !list_empty(&prange->child_list)) {
 			pr_debug("range split by unmap in parallel, validate again\n");
 			r = -EAGAIN;
@@ -1878,11 +1869,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			if (map_start_vma <= map_last_vma) {
 				offset = map_start_vma - prange->start;
 				npages = map_last_vma - map_start_vma + 1;
-				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-							  ctx->bitmap, wait, flush_tlb);
+				r = svm_range_map_to_gpus(prange, range, offset,
+							  npages, readonly,
+							  ctx->bitmap, wait,
+							  flush_tlb);
 			}
 		}
 
+		/* Free the hmm range */
+		amdgpu_hmm_range_free(range);
+
 		if (!r && next == end)
 			prange->mapping_done = true;
 		else
-- 
2.53.0

