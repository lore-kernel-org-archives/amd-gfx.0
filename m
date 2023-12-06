Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229F4C10DC1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 21:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CFF10E7B8;
	Wed,  6 Dec 2023 21:44:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C6C710E7B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 21:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSj3SYdg4SnxsncFw5vLD8bXCqfYGVXGhJwiebICguvtKLJduUNnSxeRG4c2Y36cCZscPILjt5Mnhv+X3NgFe8INo64dKFIiZHxiVn+XaTM3TO/GoP8z6lYidS4vduVoMnJAUQxOW9upV8rxQn8RZzeH7dzkHItnqKk6lqLM75xWMJMSemxcwoN8nww037aRbR+rXOzCImu18BwC/cFBhxFZPmXL1CSZHsXiEwK6uNPVKoUFf5DIdtdURmywnqE+dxwNN3/25VoJq6W873VLyBkmhokxgpY+V/riBDG0zztlwyX+r1zMDlvBXeMd/l+FPopeN5mBvA2yOA6nm0hD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oy4gHToZzKMMRUSa7cpXVDSAPJvp3NMQy6PPkEy6/I=;
 b=gXg/hccrHUFA5J/S6n7FTef+wZwNzxIxfO2ZfP72mZNudJpwcormKthhLc7Hu7DVKeS8VVb8lrQNPSGH4FI9lFiQ/CDWQ14Jd1mcpm2c7NSTlpyJn535c/QOa3k4GpudtsJHLd66WjLAeyHI7lHcSx6jo+/dwkuLLeEF0AAkp56MnAvdrHRU7YaAhKq4PckzNWqzIfhJ5iNXhAy4Qp34euhFvB8RyyabMlqUspn6SUVfZuOeNoCfPvUPl7m8poO08aB1MQ5jdAbGZnL1qvfy3HIWvvXdgkMhGWN/nIt7nmQqpwRKxOXXnSEuU5dK8uGdyP1cKQvFUGI2F1+gZXkFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oy4gHToZzKMMRUSa7cpXVDSAPJvp3NMQy6PPkEy6/I=;
 b=TJTlV6QyAuE3bLpiCSkUy7q4r4Jq16Bb5coV7tnkHI6p7LN6gfvpMNcwaIFWUB0lPwCWKBtOwQpFU2lqzRxj2xJg2QJrAT15pCl4Hj1Wv5eHoV8mb7inrN+ZT4D/ehVjgNg0UlB0W7D0puKZQB56aThBL7zk5vX9e9x0kGVDvKI=
Received: from DM6PR11CA0044.namprd11.prod.outlook.com (2603:10b6:5:14c::21)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 21:44:49 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::5) by DM6PR11CA0044.outlook.office365.com
 (2603:10b6:5:14c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 21:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 21:44:48 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 15:44:47 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: Auto-validate DMABuf imports in compute VMs
Date: Wed, 6 Dec 2023 16:44:12 -0500
Message-ID: <20231206214413.2440998-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: f26827ae-f5e0-42a0-4896-08dbf6a491fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uj1Vzwi0Z71zQo8RiSVG4pMlGz3DP517hs8ZLQd7cRXEELqjt8Ach0zOSrHF28Y0gewqbz3TJe4uigT6DrRXrViewHjNPR062++LO7EolZcEIkQomEsIBofekL+bO5x+Pi+vmhqMBy4MR1SLV93PQ93pBsVXyvIFkIMYQjyge/iRXUdtit1TC+pR92JwctMKa2AngJvgSqdQmdbphDQfTdd2ieBMDgm4i3QOX/QtsHAJs4qEE2HP1/59SKtXOFZ3xjz+d8b/35RCfndrzjsjZfEog9GlWQOqkWGk1QmFUs2MnNLDMMQgSmdFdLiom8H2Z4mJNnErDemJ9wOaHW5a5nnLr2rFLjT0RnG3sIGoTnaWE79yvh8fcgIP7a/9KYxUnGPDFmk0/0CfavFQ8U4MiKBUSnDblXA0/ckhOKbCgefjMfSxvuFuT0Nw/7w+CkhNvMUErysa7BZBSIz4KMcFi1XI/h4qau99U/nFju8e7Jstb/mHe22/7KlU5Ghyn+MX3TohFHB/Mi9/cgMdI4V0Cmt/xUyix3uWaEV57Y5YS2BS3iBI3NInYgT0/t01+XAeZsXe86CiPN4ly2DCaC9IxUwgwnCJUap2q+2ORxnYMSrRouEVyacsYEHN4hDt1tJ5A65CuCGuj6RWTqAuewm60qjjsGELUtDqrnZaIyVKeKyyrQOVvgohdhT2MPZh2yVpN8U1jNIn70CqCbYfvif4fdjT+a56mIy3q0DxaW8rnXDPBZhisAqJ8nmhGrZb/W4zwCl4en95V7kMB+tqz9y1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(1076003)(41300700001)(2616005)(36756003)(86362001)(426003)(40460700003)(83380400001)(26005)(336012)(16526019)(54906003)(316002)(70206006)(6916009)(8676002)(6666004)(4326008)(70586007)(8936002)(7696005)(478600001)(82740400003)(81166007)(356005)(36860700001)(40480700001)(2906002)(47076005)(30864003)(15650500001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 21:44:48.6575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26827ae-f5e0-42a0-4896-08dbf6a491fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917
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

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  10 ++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  44 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  28 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 101 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  10 +-
 8 files changed, 177 insertions(+), 36 deletions(-)

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
index 5f445d856769..fbabb1e63a67 100644
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
@@ -3014,6 +3019,11 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 		dma_resv_add_fence(bo->tbo.base.resv,
 				   &process_info->eviction_fence->base,
 				   DMA_RESV_USAGE_BOOKKEEP);
+
+		ret = amdgpu_vm_fence_imports(peer_vm, &exec.ticket,
+					      &process_info->eviction_fence->base);
+		if (ret)
+			break;
 	}
 
 validate_map_fail:
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
index b1ce22a9b186..68bab2879696 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -187,7 +187,33 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 	amdgpu_bo_unreserve(abo);
-	return 0;
+
+	/* Validate and add eviction fence to DMABuf imports with dynamic
+	 * attachment in compute VMs. Re-validation will be done by
+	 * amdgpu_vm_validate and the fence will be updated by
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
+	return r;
 }
 
 static void amdgpu_gem_object_close(struct drm_gem_object *obj,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7da71b6a9dc6..ab2662ab4ab8 100644
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
@@ -475,7 +499,13 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				return r;
 		}
 
-		if (bo->tbo.type != ttm_bo_type_kernel) {
+		if (resv != vm->root.bo->tbo.base.resv) {
+			/* Fence reservation for amdgpu_vm_fence_imports */
+			r = dma_resv_reserve_fences(resv, 1);
+			if (r)
+				return r;
+			amdgpu_vm_bo_invalidated(bo_base);
+		} if (bo->tbo.type != ttm_bo_type_kernel) {
 			amdgpu_vm_bo_moved(bo_base);
 		} else {
 			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
@@ -1425,11 +1455,21 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
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
@@ -1437,6 +1477,51 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	return 0;
 }
 
+/**
+ * amdgpu_vm_fence_imports - add fence to valid DMABuf imports
+ *
+ * @vm: requested vm
+ * @ticket: reservation ticket used to reserve the VM
+ * @fence: fence to add
+ *
+ * Add the specified fence to all dynamic DMABuf imports that are valid.
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
+
+	if (!vm->is_compute_context)
+		return 0;
+	if (!ticket)
+		return -EINVAL;
+
+	spin_lock(&vm->status_lock);
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
+		if (!bo_va->base.bo || !bo_va->base.bo->tbo.base.import_attach ||
+		    !dma_buf_is_dynamic(bo_va->base.bo->tbo.base.import_attach->dmabuf))
+			continue;
+
+		resv = bo_va->base.bo->tbo.base.resv;
+		if (dma_resv_locking_ctx(resv) != ticket) {
+			pr_warn_ratelimited("Imported BO is not reserved in pid %d\n",
+					    vm->task_info.pid);
+			continue;
+		}
+		dma_resv_add_fence(resv, fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
+
+	}
+	spin_unlock(&vm->status_lock);
+
+	return 0;
+}
+
 /**
  * amdgpu_vm_flush_compute_tlb - Flush TLB on compute VM
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b6cd565562ad..eff301976eee 100644
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
@@ -446,6 +447,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm,
 			   struct ww_acquire_ctx *ticket);
+int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
+			    struct ww_acquire_ctx *ticket,
+			    struct dma_fence *fence);
 int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm,
 				uint32_t flush_type,
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

