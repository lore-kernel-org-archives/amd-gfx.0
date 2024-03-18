Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17826C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 12:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F62510F613;
	Mon, 18 Mar 2024 12:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oQN6vJLh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9905A10F652
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 12:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2qMhlF7quK7oAFKJ3N9BY8M4+sZlpDv3KhLQdtJPtE6j2bb69E7Us3jgEHF6fzdBHOvxR2NxULPg4ogWz5BYzO77LA8dbw9V8MEG/fx3DVcIBNIrmVn+e5SxkA9farZ8MGORjiKd3mmz/jgqyHVYxG+1z0QPfa08T/A/ha1oFKS4349GdJ9HN7n6PdB4Q1r3XQ+1+pYNyXmVNuhtsKrjJNvm4P+FbyD3AtltweUrR0embi+yf7OE0X5kE2IJXRhNstfP4Vdk7E35++rZQRQlZa3o1bbdSdqNwoXOZvrimSMo7iWEr2aTf2irCSZbPZ8qQvsnKIK7Tjax0q3HYqJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmd/S5+dCZd1FBCt0Y9VQgHExhQtr42076rfRCJaido=;
 b=AdQcRbcr81CPjR492vEBPubW5bW+XQjBwJ3znGp+Y9YUyek0eAmlCnG1t6f4AxVJTFzoFe2FlwGNmm3Gk3a2PyvrLJaCEmZ2DqyEItALsar0YrUO6H0CUyheO5o5Ved6ahkCsWVroasztozmNVU7aPClUFkeIdgg9vFW/4vBNXpM6GX+tuhqDre/o6Ju9MQc+VpgLju2aXzc06H2/HXry6u8oU1rhKzxKQT5Iw4cqxobEbYmvy8YTXQr+hmAOxLjdlayAHOG2cr0GdqyhdZQ3vhUVWsnKdO15yMlGu8vtGvBaP/H8R0+G/J8r5uwFuagicFk21dwEmCgDchpKK74TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmd/S5+dCZd1FBCt0Y9VQgHExhQtr42076rfRCJaido=;
 b=oQN6vJLhRUT3RH+AAgmJRR6Yk4jagvS5o0v9qfEg9wzIpHhemh+cuXNTA3gr6ubA7qilBDoYPCsK31MvBpiM0gd+ZMxyTV+nXLf0Tf1p8m/3nKDNOqNJif8h2Vnp4D4Ahi5R4ko177lPUBsFBb0UXhuMqVwtGO024q5xzdvRMTM=
Received: from PH7PR17CA0037.namprd17.prod.outlook.com (2603:10b6:510:323::28)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 12:09:04 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:510:323:cafe::f2) by PH7PR17CA0037.outlook.office365.com
 (2603:10b6:510:323::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 12:09:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 12:09:03 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 07:08:59 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH v7 1/2] drm/amdgpu: implement TLB flush fence
Date: Mon, 18 Mar 2024 13:08:35 +0100
Message-ID: <20240318120837.2011-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 25db7a36-e23b-489c-820d-08dc4744342e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bv4APnEYaufkHjFixoKcQx6J2rkqKW9qGKZ7++tUTtd9ZdprJSAR8qQY/FJFimxEpYoOiL/P9cysgGLQaAHd8emEpaWcgsfuWHKb+XoLekaQ8ezB2loFT17PQcUHUemfzMofQIxesxR5XVgUAzEjcXBFbh+3RR+iQvOXJhxyf0uCk0WoheX+DkgDuXWX8cV4x24qVh0p6aoQTIlzAAYgY7XYEr4HCIQG5GFpHNoJvN1q36TIev4lCUsclZAmiIzVvs1/pAOtPOCpK62wr2oO/qEvb0fXClf44fvT4Pt+RSwJjeukDcHtLLOSugTAuMkrC0jiwuBEdCtop1P7XdtOzmf68k5OOf2liy7dW1tDe6cKN4GLtpwTRsa4tQbaa0p4V2jB/IgHI+F063eFt0ESToAzndMiR1Z86lprJJFSg6yNgIFtIl5J3JUJMRpz3VWHRvSXdsB49/gvcDt7t4sEAf7Ei7r9BxkD1YKqya/bP5vFFbKpOLnGnV/WwbiFbvFTY/HPIGqBSVruD/NSpCpfirGrKc71Jsm8E/hMP3knOeEJqSQrMf5zNoLSKSkmYKhelWtMM67kqKVw7yBuZjs/IAj/f1BAaoEaQ5wg0iugJHe/EVwnA0+2TPanlh39GkXPnM/s/JD0jKfmwW1MfgCgWFNmIkH7DQBv4bY6onKja5AZYdrv/0GAA+Mmwd5IR8UDuqTL4mlsuXBB9BgcUJUKBw+JT9C3BIeykHxNunwkvEW4uaXUUIeAe6I9coldz9pg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 12:09:03.7172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25db7a36-e23b-489c-820d-08dc4744342e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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

From: Christian Koenig <christian.koenig@amd.com>

The problem is that when (for example) 4k pages are replaced
with a single 2M page we need to wait for change to be flushed
out by invalidating the TLB before the PT can be freed.

Solve this by moving the TLB flush into a DMA-fence object which
can be used to delay the freeing of the PT BOs until it is signaled.

V2: (Shashank)
    - rebase
    - set dma_fence_error only in case of error
    - add tlb_flush fence only when PT/PD BO is locked (Felix)
    - use vm->pasid when f is NULL (Mukul)

V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
    - move the misplaced fence_create call to the end (Philip)

V5: - free the f->dependency properly

V6: (Shashank)
    - light code movement, moved all the clean-up in previous patch
    - introduce params.needs_flush and its usage in this patch
    - rebase without TLB HW sequence patch

V7:
   - Keep the vm->last_update_fence and tlb_cb code until
     we can fix the HW sequencing (Christian)
   - Move all the tlb_fence related code in a separate function so that
     its easier to read and review

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  68 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
 7 files changed, 171 insertions(+), 30 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4536c8ad0e11..f24f11ac3e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
 	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
-	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
+	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
+	amdgpu_ib.o amdgpu_pll.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
 	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 81fb3465e197..26f1c3359642 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -885,6 +885,40 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
 	kfree(tlb_cb);
 }
 
+static int
+amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params, struct dma_fence **fence)
+{
+	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
+	struct amdgpu_vm *vm = params->vm;
+
+	if (!fence || !*fence)
+		return 0;
+
+	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
+	if (!tlb_cb)
+		return -ENOMEM;
+
+	tlb_cb->vm = vm;
+	if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
+				    amdgpu_vm_tlb_seq_cb)) {
+		dma_fence_put(vm->last_tlb_flush);
+		vm->last_tlb_flush = dma_fence_get(*fence);
+	} else {
+		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
+	}
+
+	/* Prepare a TLB flush fence to be attached to PTs */
+	if (!params->unlocked && vm->is_compute_context) {
+		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
+
+		/* Makes sure no PD/PT is freed before the flush */
+		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_vm_update_range - update a range in the vm page table
  *
@@ -917,7 +951,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct dma_fence **fence)
 {
 	struct amdgpu_vm_update_params params;
-	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_res_cursor cursor;
 	enum amdgpu_sync_mode sync_mode;
 	int r, idx;
@@ -925,12 +958,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
-	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
-	if (!tlb_cb) {
-		r = -ENOMEM;
-		goto error_unlock;
-	}
-
 	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
 	 * heavy-weight flush TLB unconditionally.
 	 */
@@ -948,6 +975,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.immediate = immediate;
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
+	params.needs_flush = flush_tlb;
 	params.allow_override = allow_override;
 
 	/* Implicitly sync to command submissions in the same VM before
@@ -961,7 +989,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	amdgpu_vm_eviction_lock(vm);
 	if (vm->evicting) {
 		r = -EBUSY;
-		goto error_free;
+		goto error_unlock;
 	}
 
 	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
@@ -974,7 +1002,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = vm->update_funcs->prepare(&params, resv, sync_mode);
 	if (r)
-		goto error_free;
+		goto error_unlock;
 
 	amdgpu_res_first(pages_addr ? NULL : res, offset,
 			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
@@ -1024,29 +1052,18 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		tmp = start + num_entries;
 		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
 		if (r)
-			goto error_free;
+			goto error_unlock;
 
 		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start = tmp;
 	}
 
 	r = vm->update_funcs->commit(&params, fence);
+	if (r)
+		goto error_unlock;
 
-	if (flush_tlb || params.table_freed) {
-		tlb_cb->vm = vm;
-		if (fence && *fence &&
-		    !dma_fence_add_callback(*fence, &tlb_cb->cb,
-					   amdgpu_vm_tlb_seq_cb)) {
-			dma_fence_put(vm->last_tlb_flush);
-			vm->last_tlb_flush = dma_fence_get(*fence);
-		} else {
-			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
-		}
-		tlb_cb = NULL;
-	}
-
-error_free:
-	kfree(tlb_cb);
+	if (params.needs_flush)
+		r = amdgpu_vm_tlb_flush(&params, fence);
 
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
@@ -2391,6 +2408,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
+	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
 				false, &root, xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8efa8422f4f7..b0a4fe683352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -257,9 +257,9 @@ struct amdgpu_vm_update_params {
 	unsigned int num_dw_left;
 
 	/**
-	 * @table_freed: return true if page table is freed when updating
+	 * @needs_flush: true whenever we need to invalidate the TLB
 	 */
-	bool table_freed;
+	bool needs_flush;
 
 	/**
 	 * @allow_override: true for memory that is not uncached: allows MTYPE
@@ -342,6 +342,7 @@ struct amdgpu_vm {
 	atomic64_t		tlb_seq;
 	struct dma_fence	*last_tlb_flush;
 	atomic64_t		kfd_last_flushed_seq;
+	uint64_t		tlb_fence_context;
 
 	/* How many times we had to re-generate the page tables */
 	uint64_t		generation;
@@ -611,5 +612,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub);
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct dma_fence **fence);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 6e31621452de..3895bd7d176a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -108,7 +108,9 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 				struct dma_fence **fence)
 {
-	/* Flush HDP */
+	if (p->needs_flush)
+		atomic64_inc(&p->vm->tlb_seq);
+
 	mb();
 	amdgpu_device_flush_hdp(p->adev, NULL);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 124389a6bf48..601df0ce8290 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -972,7 +972,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn < frag_start) {
 				/* Make sure previous mapping is freed */
 				if (cursor.entry->bo) {
-					params->table_freed = true;
+					params->needs_flush = true;
 					amdgpu_vm_pt_free_dfs(adev, params->vm,
 							      &cursor,
 							      params->unlocked);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 349416e176a1..66e8a016126b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -126,6 +126,10 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 
 	WARN_ON(ib->length_dw == 0);
 	amdgpu_ring_pad_ib(ring, ib);
+
+	if (p->needs_flush)
+		atomic64_inc(&p->vm->tlb_seq);
+
 	WARN_ON(ib->length_dw > p->num_dw_left);
 	f = amdgpu_job_submit(p->job);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
new file mode 100644
index 000000000000..51cddfa3f1e8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/dma-fence.h>
+#include <linux/workqueue.h>
+
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_gmc.h"
+
+struct amdgpu_tlb_fence {
+	struct dma_fence	base;
+	struct amdgpu_device	*adev;
+	struct dma_fence	*dependency;
+	struct work_struct	work;
+	spinlock_t		lock;
+	uint16_t		pasid;
+
+};
+
+static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
+{
+	return "amdgpu tlb fence";
+}
+
+static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
+{
+	return "amdgpu tlb timeline";
+}
+
+static void amdgpu_tlb_fence_work(struct work_struct *work)
+{
+	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
+	int r;
+
+	if (f->dependency) {
+		dma_fence_wait(f->dependency, false);
+		dma_fence_put(f->dependency);
+		f->dependency = NULL;
+	}
+
+	r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
+	if (r) {
+		dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
+			f->pasid);
+		dma_fence_set_error(&f->base, r);
+	}
+
+	dma_fence_signal(&f->base);
+	dma_fence_put(&f->base);
+}
+
+static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_tlb_fence_get_driver_name,
+	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
+};
+
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+				struct dma_fence **fence)
+{
+	struct amdgpu_tlb_fence *f;
+
+	f = kmalloc(sizeof(*f), GFP_KERNEL);
+	if (!f) {
+		/*
+		 * We can't fail since the PDEs and PTEs are already updated, so
+		 * just block for the dependency and execute the TLB flush
+		 */
+		if (*fence)
+			dma_fence_wait(*fence, false);
+
+		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
+		*fence = dma_fence_get_stub();
+		return;
+	}
+
+	f->adev = adev;
+	f->dependency = *fence;
+	f->pasid = vm->pasid;
+	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
+	spin_lock_init(&f->lock);
+
+	dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
+		       vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
+
+	/* TODO: We probably need a separate wq here */
+	dma_fence_get(&f->base);
+	schedule_work(&f->work);
+
+	*fence = &f->base;
+}
-- 
2.43.2

