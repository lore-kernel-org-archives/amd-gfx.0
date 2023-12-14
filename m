Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7F0C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 22:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54ADA8826D;
	Thu, 14 Dec 2023 22:30:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C142F10E990
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 22:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJwEzHywef5IFPmcv34jx+VYSO6ZL5oqE16++8uhdJWP7fNJBFlTBSHTErKS/6PVffrqTOajpe5zHb9hvEktZJ+qogXw+IQYXeHrBPtI/ez028Krylh1jW9Eug39KjOYOlwi4wci0OAlKu+jikvsCmHW2zQUqD/7MKThMsIICflfAysHlBXWvXhabXfwprTb9xFA/jsvVTVV+oK6QEm39PqKYSrntlAxOD43JPnFtMSlIfP36k7FaDqaBCeqAp7WvlMG6YSEyTXDCXDpZ6BHXVKhvdC999CPE4cRST0v3oHdicy4WpX5G/DvMJENxIbivdwk/ygLFHuA0Qe2jT13Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HooCV4585HhfnyAjsMit7+VaGZTbREIbSXzjrdrEDjQ=;
 b=LP1G9gu2sOW59gF9XDVQ09XF/QooZyaDVr7plVTO7WQ/ismclFb1Qd8YFH0CHj6xC6ZUDWW9nNRL7JSEqgDbFJh5DMIwr5L7SmJoXt+aRNC2GnnMXnZQuCq+73OVT+tPAOeAHtKdNlkDV7W3d5n4qSsH19hgvFH/8eSmKGlZZcYstoPwufcaafRh1iMmbSsx2svXVOfLxZ/xChDnZnEk/ovBupVCCb05laEBrxv6bv3rpvfxuizvH9T7dlh5T5Vw0xK3QR1oj0hWJgh3KutAzOf7RyOEQjOgv2oNQ62Jo+yTY3BwXJnNfDnSZu2oTZwF6pfLd1b1YV5XsbUmEa3rEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HooCV4585HhfnyAjsMit7+VaGZTbREIbSXzjrdrEDjQ=;
 b=VLSpyP2fXLFXTiX0veB7zi65q0bewMIGjndKNWlVn/AZqteluQGYAYxXZ/9Oghlp6e2nl09fr26P2hDwD5fL/uaoQPo6WALneh4TE51IDVSg3kEWt+1lmHnvQ+26MJDObspEyowtaz9zf65PmQ/jy3Fm0EeWhOX4DXqDv53uUro=
Received: from BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::16)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 22:30:35 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::60) by BL1P221CA0022.outlook.office365.com
 (2603:10b6:208:2c5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 22:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 22:30:34 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 16:30:33 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/2] drm/amdgpu: Auto-validate DMABuf imports in compute VMs
Date: Thu, 14 Dec 2023 17:30:00 -0500
Message-ID: <20231214223001.218746-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 2959fc70-3308-4e11-69af-08dbfcf449c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHmquCSBoCJfO8fvtO3WBl82S5ZmPOmGZ/IpBFrr7HcoRBlP+QDIG+tuFsaw01kwMEoI2PF1rBiuiAYFDsia9g2j0uEGTeGCJWFtW59gtb25s1zD2Z2o+BDTZLl1pKo/N7993pQMT2V0e/Fy/csZrY+1BVHn2XlMZxw7H/IdOURRMEcjmQ4IwzlDbqwQqAeRj7Z2bjduVOi0sZVhv3aofbgqHdqe+e1Zk20Tx5MIG7JUFt2Ey5Ug/kmmChE5ww/Yx7MjYMpwwz5NatpvV5yyT2eTHYLKAQX/uawZkM8nzIKRdzxmLLBaX/N8MbxoPLIGEEtFZDFZD1qMPy16bKTuPJ38siax3ptwAGbjvH6e2qtTZRSIXTLWlzsZIyf1BRvOCe9KHBzFk7q7IhxOBdSzQ/QjtT0PzYo3IFHSl3c7Z6MlaiGDpEBeOhV46xtlzu6VJiUyB1nM78O99cL/Ezc6v65A4M98vFHDk5QhQyUg4ke7gzszI0SAue6OKlPhyKy7gAsz8w5r98dUMfTXuS7+1vSOgQ9x+m35UgyUJCVvzvaGSm+iqY9WsO92WZQ8RQOTqj6sXb0bdFMnVigbsLVfVtJDhrGgzJ5Q/9LBbARUnGqqsnZd4N+njHqjcahyYLyw0YN8lrLpd7mcgwf6m84O+9i+P3XsZOES/z+hg+XVKZJV4BpHuSkoI1ZIJ6wdXppd05y/MBG8zE7pIKoYmVIRTwZFyI7MJh2H49fqglJ1jsuSciCx3C6gUkQErcQWCNFmcIWTrpyPEoNSygmNV9jQcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(1076003)(7696005)(40480700001)(15650500001)(8936002)(4326008)(8676002)(82740400003)(2906002)(6666004)(478600001)(86362001)(30864003)(2616005)(26005)(41300700001)(16526019)(5660300002)(81166007)(356005)(40460700003)(36860700001)(47076005)(316002)(83380400001)(6916009)(36756003)(54906003)(70586007)(70206006)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 22:30:34.2744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2959fc70-3308-4e11-69af-08dbfcf449c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DMABuf imports in compute VMs are not wrapped in a kgd_mem object on the
process_info->kfd_bo_list. There is no explicit KFD API call to validate
them or add eviction fences to them.

This patch automatically validates and fences dymanic DMABuf imports when
they are added to a compute VM. Revalidation after evictions is handled
in the VM code.

v2:
* Renamed amdgpu_vm_validate_evicted_bos to amdgpu_vm_validate
* Eliminated evicted_user state, use evicted state for VM BOs and user BOs
* Fixed and simplified amdgpu_vm_fence_imports, depends on reserved BOs
* Moved dma_resv_reserve_fences for amdgpu_vm_fence_imports into
  amdgpu_vm_validate, outside the vm->status_lock
* Added dummy version of amdgpu_amdkfd_bo_validate_and_fence for builds
  without KFD

v4: Eliminate amdgpu_vm_fence_imports. It's not needed because the
reservation with its fences is shared with the export, as long as all
imports are from KFD, with the exports already reserved, validated and
fenced by the KFD restore worker.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 10 ++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39 ++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 29 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 52 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  7 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 10 ++--
 8 files changed, 121 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f262b9d89541..584a0cea5572 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -191,6 +191,9 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
 int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
 int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
 				unsigned long cur_seq, struct kgd_mem *mem);
+int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
+					uint32_t domain,
+					struct dma_fence *fence);
 #else
 static inline
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
@@ -216,6 +219,13 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
 {
 	return 0;
 }
+static inline
+int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
+					uint32_t domain,
+					struct dma_fence *fence)
+{
+	return 0;
+}
 #endif
 /* Shared API */
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5f445d856769..6f3a4cb2a9ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -426,9 +426,9 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
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
 
@@ -464,13 +464,15 @@ static int amdgpu_amdkfd_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
  * again. Page directories are only updated after updating page
  * tables.
  */
-static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
+static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm,
+				 struct ww_acquire_ctx *ticket)
 {
 	struct amdgpu_bo *pd = vm->root.bo;
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
 	int ret;
 
-	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate_vm_bo, NULL);
+	ret = amdgpu_vm_validate(adev, vm, ticket,
+				 amdgpu_amdkfd_validate_vm_bo, NULL);
 	if (ret) {
 		pr_err("failed to validate PT BOs\n");
 		return ret;
@@ -1310,14 +1312,15 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 	return ret;
 }
 
-static int process_validate_vms(struct amdkfd_process_info *process_info)
+static int process_validate_vms(struct amdkfd_process_info *process_info,
+				struct ww_acquire_ctx *ticket)
 {
 	struct amdgpu_vm *peer_vm;
 	int ret;
 
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
-		ret = vm_validate_pt_pd_bos(peer_vm);
+		ret = vm_validate_pt_pd_bos(peer_vm, ticket);
 		if (ret)
 			return ret;
 	}
@@ -1402,7 +1405,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	ret = amdgpu_bo_reserve(vm->root.bo, true);
 	if (ret)
 		goto reserve_pd_fail;
-	ret = vm_validate_pt_pd_bos(vm);
+	ret = vm_validate_pt_pd_bos(vm, NULL);
 	if (ret) {
 		pr_err("validate_pt_pd_bos() failed\n");
 		goto validate_pd_fail;
@@ -2043,7 +2046,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	    bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		is_invalid_userptr = true;
 
-	ret = vm_validate_pt_pd_bos(avm);
+	ret = vm_validate_pt_pd_bos(avm, NULL);
 	if (unlikely(ret))
 		goto out_unreserve;
 
@@ -2122,7 +2125,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		goto unreserve_out;
 	}
 
-	ret = vm_validate_pt_pd_bos(avm);
+	ret = vm_validate_pt_pd_bos(avm, NULL);
 	if (unlikely(ret))
 		goto unreserve_out;
 
@@ -2620,7 +2623,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 		}
 	}
 
-	ret = process_validate_vms(process_info);
+	ret = process_validate_vms(process_info, NULL);
 	if (ret)
 		goto unreserve_out;
 
@@ -2880,11 +2883,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 
 	amdgpu_sync_create(&sync_obj);
 
-	/* Validate PDs and PTs */
-	ret = process_validate_vms(process_info);
-	if (ret)
-		goto validate_map_fail;
-
 	/* Validate BOs and map them to GPUVM (update VM page tables). */
 	list_for_each_entry(mem, &process_info->kfd_bo_list,
 			    validate_list) {
@@ -2935,6 +2933,13 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 	if (failed_size)
 		pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
 
+	/* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
+	 * validations above would invalidate DMABuf imports again.
+	 */
+	ret = process_validate_vms(process_info, &exec.ticket);
+	if (ret)
+		goto validate_map_fail;
+
 	/* Update mappings not managed by KFD */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			vm_list_node) {
@@ -3006,7 +3011,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 				   &process_info->eviction_fence->base,
 				   DMA_RESV_USAGE_BOOKKEEP);
 	}
-	/* Attach eviction fence to PD / PT BOs */
+	/* Attach eviction fence to PD / PT BOs and DMABuf imports */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
 		struct amdgpu_bo *bo = peer_vm->root.bo;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e50be6500030..dc7fac778417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -952,10 +952,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	p->bytes_moved = 0;
 	p->bytes_moved_vis = 0;
 
-	r = amdgpu_vm_validate_pt_bos(p->adev, &fpriv->vm,
-				      amdgpu_cs_bo_validate, p);
+	r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
+			       amdgpu_cs_bo_validate, p);
 	if (r) {
-		DRM_ERROR("amdgpu_vm_validate_pt_bos() failed.\n");
+		DRM_ERROR("amdgpu_vm_validate() failed.\n");
 		goto out_free_user_pages;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index decbbe3d4f06..055ba2ea4c12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -377,6 +377,10 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	struct amdgpu_vm_bo_base *bo_base;
 	int r;
 
+	/* FIXME: This should be after the "if", but needs a fix to make sure
+	 * DMABuf imports are initialized in the right VM list.
+	 */
+	amdgpu_vm_bo_invalidate(adev, bo, false);
 	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b1ce22a9b186..7bd32601c2a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -187,7 +187,34 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 	amdgpu_bo_unreserve(abo);
-	return 0;
+
+	/* Validate and add eviction fence to DMABuf imports with dynamic
+	 * attachment in compute VMs. Re-validation will be done by
+	 * amdgpu_vm_validate. Fences are on the reservation shared with the
+	 * export, which is currently required to be validated and fenced
+	 * already by amdgpu_amdkfd_gpuvm_restore_process_bos.
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
+	return r;
 }
 
 static void amdgpu_gem_object_close(struct drm_gem_object *obj,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7da71b6a9dc6..49b3f90be527 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -426,24 +426,29 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 }
 
 /**
- * amdgpu_vm_validate_pt_bos - validate the page table BOs
+ * amdgpu_vm_validate - validate evicted BOs tracked in the VM
  *
  * @adev: amdgpu device pointer
  * @vm: vm providing the BOs
+ * @ticket: optional reservation ticket used to reserve the VM
  * @validate: callback to do the validation
  * @param: parameter for the validation callback
  *
- * Validate the page table BOs on command submission if neccessary.
+ * Validate the page table BOs and per-VM BOs on command submission if
+ * necessary. If a ticket is given, also try to validate evicted user queue
+ * BOs. They must already be reserved with the given ticket.
  *
  * Returns:
  * Validation result.
  */
-int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			      int (*validate)(void *p, struct amdgpu_bo *bo),
-			      void *param)
+int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		       struct ww_acquire_ctx *ticket,
+		       int (*validate)(void *p, struct amdgpu_bo *bo),
+		       void *param)
 {
 	struct amdgpu_vm_bo_base *bo_base;
 	struct amdgpu_bo *shadow;
+	struct dma_resv *resv;
 	struct amdgpu_bo *bo;
 	int r;
 
@@ -464,8 +469,27 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		spin_unlock(&vm->status_lock);
 
 		bo = bo_base->bo;
+		resv = bo->tbo.base.resv;
 		shadow = amdgpu_bo_shadowed(bo);
 
+		if (resv != vm->root.bo->tbo.base.resv) {
+			if (!ticket) {
+				/* We need to move the BO out of the evicted
+				 * list to avoid an infinite loop. It will be
+				 * moved back to evicted in the next
+				 * amdgpu_vm_handle_moved.
+				 */
+				amdgpu_vm_bo_invalidated(bo_base);
+				spin_lock(&vm->status_lock);
+				continue;
+			}
+			if (dma_resv_locking_ctx(resv) != ticket) {
+				pr_warn_ratelimited("Evicted user BO is not reserved in pid %d\n",
+						    vm->task_info.pid);
+				return -EINVAL;
+			}
+		}
+
 		r = validate(param, bo);
 		if (r)
 			return r;
@@ -475,7 +499,9 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				return r;
 		}
 
-		if (bo->tbo.type != ttm_bo_type_kernel) {
+		if (resv != vm->root.bo->tbo.base.resv) {
+			amdgpu_vm_bo_invalidated(bo_base);
+		} if (bo->tbo.type != ttm_bo_type_kernel) {
 			amdgpu_vm_bo_moved(bo_base);
 		} else {
 			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
@@ -1425,11 +1451,21 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		}
 
 		r = amdgpu_vm_bo_update(adev, bo_va, clear);
-		if (r)
-			return r;
 
 		if (unlock)
 			dma_resv_unlock(resv);
+		if (r)
+			return r;
+
+		/* Remember evicted DMABuf imports in compute VMs for later
+		 * validation
+		 */
+		if (vm->is_compute_context && bo_va->base.bo &&
+		    bo_va->base.bo->tbo.base.import_attach &&
+		    (!bo_va->base.bo->tbo.resource ||
+		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
+			amdgpu_vm_bo_evicted(&bo_va->base);
+
 		spin_lock(&vm->status_lock);
 	}
 	spin_unlock(&vm->status_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b6cd565562ad..40254f564e6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -434,9 +434,10 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 		      unsigned int num_fences);
 bool amdgpu_vm_ready(struct amdgpu_vm *vm);
 uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			      int (*callback)(void *p, struct amdgpu_bo *bo),
-			      void *param);
+int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		       struct ww_acquire_ctx *ticket,
+		       int (*callback)(void *p, struct amdgpu_bo *bo),
+		       void *param);
 int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2834fb351818..9f29bbdb9050 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1509,9 +1509,9 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
 			goto unreserve_out;
 		}
 
-		r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
-					      drm_priv_to_vm(pdd->drm_priv),
-					      svm_range_bo_validate, NULL);
+		r = amdgpu_vm_validate(pdd->dev->adev,
+				       drm_priv_to_vm(pdd->drm_priv), NULL,
+				       svm_range_bo_validate, NULL);
 		if (r) {
 			pr_debug("failed %d validate pt bos\n", r);
 			goto unreserve_out;
@@ -1630,7 +1630,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		goto free_ctx;
 	}
 
-	svm_range_reserve_bos(ctx, intr);
+	r = svm_range_reserve_bos(ctx, intr);
+	if (r)
+		goto free_ctx;
 
 	p = container_of(prange->svms, struct kfd_process, svms);
 	owner = kfd_svm_page_owner(p, find_first_bit(ctx->bitmap,
-- 
2.34.1

