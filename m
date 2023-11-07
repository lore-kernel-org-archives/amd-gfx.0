Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A66C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 16:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561C010E623;
	Tue,  7 Nov 2023 16:58:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD4310E151
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 16:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k77QK4zBkjaFBd0Aow18nbDLDyoqhdSRBodry9L5Tccy4k8MZHKRvcuoEGIrZWGAF6PIkIrwGVw0O5GbFUejxnGvSLdCqpt6QtyoEpd4c3K4UadjzX91OC8L4Z7dGh4VzbDw2I9YmmpLi+DcbdBZlToN0M0UZlutulYUYvuFUuiiwhIa3jH5wAf6hDfdu9bbFTVEZDZcnGESxCRTxHfuQa2wmFojQ97+qpYkobTuI/O0T/NC4Q4Rd3ISnQ4KxsyCEUtC+VzPYq5recnsCd7pjtVberatOQ6E8qtKz538KgUCOzvRvtL/1jaWjXvBWeybE6P8DHSotlSXlfQTEaP+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag/xAVlZcmxjV42/w2p9si+V1qSfwoBUtz7uOQTeCJw=;
 b=ajY7RBEOct/tT8Bd6iSnNqbeziY2sTwMDQy8VHpR1SoQ1P0nNSFt2edvBiAUV1ygUDb29XGeRkgLh+kCoaEAY3WDicw9fzAt7xIXRZ21ESHl96iS02soMJ/+FA6LvAgbZQRvGqp1OA1hB6i3arOrI9ZSmGyVwl94lntu36KfLyvLt3K/FI5JBvxzFYgAHRSBpdzA9tEULdYCHvbHb2GP3fullqZ3DpQczI5X5lkZrJBH8fM5Qa27ew3tHO3BBJmgGON1A3B0eEtWU4X5xqwvfOIwflQ3CkVZKEwU+JTGnJ1QDR8vfjeD1sVweoo3eix5tbKHgwiTU8BBtbjGcQU7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag/xAVlZcmxjV42/w2p9si+V1qSfwoBUtz7uOQTeCJw=;
 b=LjPqm10T1uPkD0jrCF6U8WMtrF44SsMRf5d5VRjuaxLHTaOrPp4W52FSNA3+YhjDLgyeGo4DQ4qFOw8gw0njO4GbsBGHPCgRskqpXQiTB00seqKJaXY2IRtZ0N7ZcGL0uSTkCnZpIW1KUakwGaN21qK/PFjEB9BX/9BrjifjSdY=
Received: from CH2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:610:4f::21)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 16:58:33 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::46) by CH2PR18CA0011.outlook.office365.com
 (2603:10b6:610:4f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 16:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 16:58:32 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 10:58:31 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: Auto-validate DMABuf imports in compute VMs
Date: Tue, 7 Nov 2023 11:58:11 -0500
Message-ID: <20231107165814.3628510-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 118524fe-345f-4b47-a04c-08dbdfb2c654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dS2d0pEFPFVbmPuCf+EhvLOvFoGQvqe5RcNjYT1YRKcUJr2b99+ebFuLZZrcJ98P1QmtcABgi+H/okm+GYif+sSTGBLFQHi5j1eYrtPp5Dm96PpKAD8K/eJ0j3hzm5PQBMZDOtKdNtvDtrxh0siVsPWBWNElWxoDYsxeFlB8Z9L2HE/IihEqsq+lZmoey8XEm9/PVHHgqzM8MOxZOSY8m7L3SO8kApYDj2H7ZJc0x6bS6AGHZOVD2Te8tW+8SwGK7zJt8qA/bPoMviMhrmivEWARQLF24gAUB01+OMTGViGm17PY4naOurWxCfF8vjR8XNXDhvSVGIsxoRHrfdmoXtoghYwVSheGOopVCjQh1j/fJ9DS4GuDX4FB0IadJXi/SlnaqzeVvCVXU5NTy71BrMFpMkOW12V3vjLJwY7cTNzW2+RPtCWBkohz8DB8d01e+Qeuwvo5bZTle4Ktqas3K90BHLoYH+Y3WdDb7n2yZYN2QW4b3Tt8DKvwGV2wG1EDCpCK/ZHaAqoY4qvi4UB/S2MOOuTYXVXIa1VTVsHvcLFKeEw5mE4qR/K4osNkWVvvSce63iZaZorKd13lXkCkAMn2NKxqGvjQUU13cR00TGAuMy6svXLIV2O8L4zpmGXs8UoSYPlIGF0f+Er7D6EYYOutUZkx4bNQqRBC9h/wN0aODCcE4n5o9Zxqm1Z2Wj6Blkapgtre5ebkk+mN5TeeXiN/NdhbsmJIG0/EiRmFAwnrgIq6QatxNo2K3w4QXzI8xCrs7BrpWBI+OdBz8nNBBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(47076005)(26005)(16526019)(426003)(2906002)(40460700003)(83380400001)(336012)(81166007)(356005)(82740400003)(41300700001)(36860700001)(8936002)(8676002)(478600001)(4326008)(6666004)(86362001)(7696005)(70586007)(316002)(70206006)(54906003)(6916009)(40480700001)(2616005)(5660300002)(30864003)(1076003)(15650500001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 16:58:32.6570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 118524fe-345f-4b47-a04c-08dbdfb2c654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DMABuf imports in compute VMs are not wrapped in a kgd_mem object on the
process_info->kfd_bo_list. There is no explicit KFD API call to validate
them or add eviction fences to them.

This patch automatically validates and fences dymanic DMABuf imports when
they are added to a compute VM. Revalidation after evictions is handled
in the VM code.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  15 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  26 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 117 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   6 +-
 7 files changed, 164 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index fcf8a98ad15e..68d534a89942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -178,6 +178,9 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
 				struct svm_range_bo *svm_bo);
+int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
+					uint32_t domain,
+					struct dma_fence *fence);
 #if defined(CONFIG_DEBUG_FS)
 int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2e302956a279..0c1cb6048259 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -423,9 +423,9 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
 	return ret;
 }
 
-static int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
-					       uint32_t domain,
-					       struct dma_fence *fence)
+int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
+					uint32_t domain,
+					struct dma_fence *fence)
 {
 	int ret = amdgpu_bo_reserve(bo, false);
 
@@ -2948,7 +2948,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 		struct amdgpu_device *adev = amdgpu_ttm_adev(
 			peer_vm->root.bo->tbo.bdev);
 
-		ret = amdgpu_vm_handle_moved(adev, peer_vm, &ctx.ticket);
+		ret = amdgpu_vm_handle_moved(adev, peer_vm, &ctx.ticket, true);
 		if (ret) {
 			pr_debug("Memory eviction: handle moved failed. Try again\n");
 			goto validate_map_fail;
@@ -3001,7 +3001,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 				   &process_info->eviction_fence->base,
 				   DMA_RESV_USAGE_BOOKKEEP);
 	}
-	/* Attach eviction fence to PD / PT BOs */
+	/* Attach eviction fence to PD / PT BOs and DMABuf imports */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
 		struct amdgpu_bo *bo = peer_vm->root.bo;
@@ -3009,6 +3009,11 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 		dma_resv_add_fence(bo->tbo.base.resv,
 				   &process_info->eviction_fence->base,
 				   DMA_RESV_USAGE_BOOKKEEP);
+
+		ret = amdgpu_vm_fence_imports(peer_vm, &ctx.ticket,
+					      &process_info->eviction_fence->base);
+		if (ret)
+			break;
 	}
 
 validate_map_fail:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index aafedb344c1b..20f4be8cd635 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1165,7 +1165,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			return r;
 	}
 
-	r = amdgpu_vm_handle_moved(adev, vm, &p->ticket);
+	r = amdgpu_vm_handle_moved(adev, vm, &p->ticket, false);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e7e87a3b2601..234244704f27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -373,6 +373,10 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	struct amdgpu_vm_bo_base *bo_base;
 	int r;
 
+	/* FIXME: This should be after the "if", but needs a fix to make sure
+	 * DMABuf imports are initialized in the right VM list.
+	 */
+	amdgpu_vm_bo_invalidate(adev, bo, false);
 	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
@@ -409,7 +413,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 		if (!r)
 			r = amdgpu_vm_clear_freed(adev, vm, NULL);
 		if (!r)
-			r = amdgpu_vm_handle_moved(adev, vm, ticket);
+			r = amdgpu_vm_handle_moved(adev, vm, ticket, false);
 
 		if (r && r != -EBUSY)
 			DRM_ERROR("Failed to invalidate VM page tables (%d))\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 849fffbb367d..755cc3c559f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -186,6 +186,32 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 	amdgpu_bo_unreserve(abo);
+
+	/* Validate and add eviction fence to DMABuf imports with dymanic
+	 * attachment in compute VMs. Re-validation will be done by
+	 * amdgpu_vm_handle_moved and the fence will be updated by
+	 * amdgpu_vm_fence_imports in amdgpu_amdkfd_gpuvm_restore_process_bos.
+	 *
+	 * Nested locking below for the case that a GEM object is opened in
+	 * kfd_mem_export_dmabuf. Since the lock below is only taken for imports,
+	 * but not for export, this is a different lock class that cannot lead to
+	 * circular lock dependencies.
+	 */
+	if (!vm->is_compute_context || !vm->process_info)
+		return 0;
+	if (!obj->import_attach ||
+	    !dma_buf_is_dynamic(obj->import_attach->dmabuf))
+		return 0;
+	mutex_lock_nested(&vm->process_info->lock, 1);
+	if (!WARN_ON(!vm->process_info->eviction_fence)) {
+		r = amdgpu_amdkfd_bo_validate_and_fence(abo, AMDGPU_GEM_DOMAIN_GTT,
+							&vm->process_info->eviction_fence->base);
+		if (r)
+			dev_warn(adev->dev, "%d: validate_and_fence failed: %d\n",
+				 vm->task_info.pid, r);
+	}
+	mutex_unlock(&vm->process_info->lock);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0d685577243c..b2c7449ab561 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1307,6 +1307,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  * @vm: requested vm
  * @ticket: optional reservation ticket used to reserve the VM
+ * @valitate: whether to auto-validate invalid DMABuf imports
  *
  * Make sure all BOs which are moved are updated in the PTs.
  *
@@ -1317,7 +1318,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
  */
 int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm,
-			   struct ww_acquire_ctx *ticket)
+			   struct ww_acquire_ctx *ticket,
+			   bool validate)
 {
 	struct amdgpu_bo_va *bo_va;
 	struct dma_resv *resv;
@@ -1337,6 +1339,12 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		spin_lock(&vm->status_lock);
 	}
 
+	/* If we're validating user BOs, splice all evicted user BOs into
+	 * the list of invalid BOs for revalidation
+	 */
+	if (validate)
+		list_splice_init(&vm->evicted_user, &vm->invalidated);
+
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
@@ -1357,17 +1365,120 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			unlock = false;
 		}
 
+		/* Automatically validate DMABuf imports in compute VMs, if we
+		 * have a reservation, or remember them for later validation.
+		 */
+		if (vm->is_compute_context && bo_va->base.bo &&
+		    bo_va->base.bo->tbo.base.import_attach &&
+		    (!bo_va->base.bo->tbo.resource ||
+		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM)) {
+			struct ttm_operation_ctx ctx = { true, false };
+			struct amdgpu_bo *bo = bo_va->base.bo;
+
+			if (!validate) {
+				r = amdgpu_vm_bo_update(adev, bo_va, clear);
+				if (!r)
+					amdgpu_vm_bo_evicted_user(&bo_va->base);
+				goto unlock;
+			}
+
+			if (clear) {
+				pr_warn_ratelimited("Invalid DMABuf import is busy in pid %d\n", vm->task_info.pid);
+				r = -EBUSY;
+				goto unlock;
+			}
+
+			amdgpu_bo_placement_from_domain(bo,
+							bo->preferred_domains);
+			r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+			if (r)
+				goto unlock;
+			r = amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD,
+						true);
+			if (r)
+				goto unlock;
+		}
+
 		r = amdgpu_vm_bo_update(adev, bo_va, clear);
+unlock:
+		if (unlock)
+			dma_resv_unlock(resv);
 		if (r)
 			return r;
+		spin_lock(&vm->status_lock);
+	}
+	spin_unlock(&vm->status_lock);
+
+	return 0;
+}
+
+/**
+ * amdgpu_vm_fence_imports - add fence to valid DMABuf imports
+ *
+ * @vm: requested vm
+ * @ticket: optional reservation ticket used to reserve the VM
+ * @fence: fence to add
+ *
+ * Add the specified fence to all dymanic DMABuf imports that are valid.
+ *
+ * Returns:
+ * 0 for success.
+ */
+int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
+			    struct ww_acquire_ctx *ticket,
+			    struct dma_fence *fence)
+{
+	struct amdgpu_bo_va *bo_va, *tmp;
+	struct dma_resv *resv;
+	LIST_HEAD(imports);
+	bool unlock;
+	int ret = 0;
+
+	if (!vm->is_compute_context)
+		return 0;
+
+	/* Move all the DMABuf imports to a private list so I can reserve
+	 * them while not holding te status_lock.
+	 */
+	spin_lock(&vm->status_lock);
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
+		if (bo_va->base.bo && bo_va->base.bo->tbo.base.import_attach &&
+		    dma_buf_is_dynamic(bo_va->base.bo->tbo.base.import_attach->dmabuf))
+			list_move(&bo_va->base.vm_status, &imports);
+	}
+	spin_unlock(&vm->status_lock);
+
+	list_for_each_entry(bo_va, &imports, base.vm_status) {
+		resv = bo_va->base.bo->tbo.base.resv;
+
+		/* Try to reserve the BO */
+		if (dma_resv_trylock(resv)) {
+			unlock = true;
+		/* The caller is already holding the reservation lock */
+		} else if (ticket && dma_resv_locking_ctx(resv) == ticket) {
+			unlock = false;
+		} else {
+			WARN_ONCE(1, "Failed to reserve DMABuf import");
+			ret = -EBUSY;
+			break;
+		}
+
+		ret = dma_resv_reserve_fences(resv, 1);
+		if (!ret)
+			dma_resv_add_fence(resv, fence,
+					   DMA_RESV_USAGE_BOOKKEEP);
 
 		if (unlock)
 			dma_resv_unlock(resv);
-		spin_lock(&vm->status_lock);
+		if (ret)
+			break;
 	}
+
+	spin_lock(&vm->status_lock);
+	list_splice(&imports, &vm->idle);
 	spin_unlock(&vm->status_lock);
 
-	return 0;
+	return ret;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 939d0c2219c0..2db04b8fef97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -443,7 +443,11 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			  struct dma_fence **fence);
 int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm,
-			   struct ww_acquire_ctx *ticket);
+			   struct ww_acquire_ctx *ticket,
+			   bool validate);
+int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
+			    struct ww_acquire_ctx *ticket,
+			    struct dma_fence *fence);
 int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm,
 				uint32_t flush_type,
-- 
2.34.1

