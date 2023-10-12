Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2993CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 16:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85CB610E194;
	Thu, 12 Oct 2023 16:40:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E267110E194
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 16:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+j/i1T1eOpCQ3s4swpeOL1YY11LDbaVcS3bVkNbaJeKBqhh1p6dNDkaSYEIcbRModiizdGmSUw4OtRZkMG4QqV3d6uIVJEwKRODHaJo1jRQLxN+vaCcDB6TCQSCCPzkKaHOeAdkmGabYdzNOkUa8RgTt8ICzK+1dgfRk3jJohgavGWeqLQ8VBdTFCBdmqiDzuOvkEF/mgJmrH4d8gEOOnGjn+RnuiVbfMBqBloMbX1kPXvkxHEKD+1EiAHZP6huGQVfLXf0NLSq2zgIEOO7RDn4BX4UWQxs8smMZNonXgdSzgRlSQc8/OV8gKIRHfuz5pQ6HdUWLgvwlV/YPfsE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9Ie8AGpfCGjLh/+r6QPd0E6pC4Xr6vnz3+kTCWRhDU=;
 b=Bg2VqJUACUPk1CzOnCP1kwFsFJqiS0BJekbE6kzPgBsxcen0Qx15oneB/ByHrDa19fxBGLBblZvNzaLBT+gwhgmMmKcNu3OJE6EmWPpYt8BcQRjGIlpq0a/kbmm0jbbqrABlvAKOBuS/LKbHCK/k32UWwm+ue18EdLnhvVhAMAbOw7EoiJ6vxac/04tqEWr3JB/F8nnDllYE077nokIo7nRKBL0+71hsK32sVEAr7tbsNtQmC8rcwCCL/rs0+Sjlp0KNpb97hR9biAR7WEsGfLbYFHtsCSds2r0c4UXQt6wXCQWLX6sgIixSRaEknkr4lCyfGwVgQLzpc6JqNWqmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9Ie8AGpfCGjLh/+r6QPd0E6pC4Xr6vnz3+kTCWRhDU=;
 b=lOo03rmrlE330CllXv5u/Ps78LuaTiwjH393VpDraUMGUhdMdzXduMZvsV3nxiI/SyP70AgJWi9bI+s845ax7sM3HLI8xFuWP7LotTQ+xYUmhJ7wEB/p9igHOOM2RW7J/xdJH/Oyo/d/Od9rLkD2cvOUrE1reQ0eWwXeBdeUkN0=
Received: from CH2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:610:4d::38)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 16:40:12 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:610:4d:cafe::31) by CH2PR19CA0028.outlook.office365.com
 (2603:10b6:610:4d::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Thu, 12 Oct 2023 16:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 16:40:12 +0000
Received: from david-laptop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 11:40:04 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add EXT_COHERENT override for NUMA local nodes
Date: Thu, 12 Oct 2023 12:39:41 -0400
Message-ID: <20231012163941.553980-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 495f04c0-3972-4e3b-37dd-08dbcb41e79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIPYKfoDg/O49BXIDYm6OFpDzmMH0zWSRXLvOF+laauQbfFp0PsS6DVjnKSreqc6pT9lRUNMaCmcJi8f52/hK6XZw4BEB91LQB1JUNqIFmzcukVeW8ev/BYwoR6IbnnAz0k3eI/VizXl8s/M4VAPjliwEsZGhKaN1OCGGRDvef4246FgQJzRaYnFQvESCU6UIiN69cjt/62abipfBtMIKeuVxkN2Ec+3gcbwkPHtnA0k/8X5iQrPxunUJD/OB991eKpDqNAzWHFNv1ArRnJ+1PCA1wxHY4Tli9g1cChxo/sCAjimts0iQ6IZP587BrxS0QmfjaO98XURw2JG5Tt+yE7sT/3eFoYr2yU2HZfGuR4LtPCk6lr/WlW1cCxy5YVLomb52mK3/MPWXWHUTMEnXJFE9u7BMTAH7GhyqXtO5g1PKX3Ndvvjt5OW5rvI7EZuJi+nRAsKy+46bmVOHqMn9ce6Gsx3cSurX4oNL+NWzrOuRdYEnWzwNiYJaMQqofgyTlZ+aTLNluN5XJZB/8Ku7t42Udb2c6VvSbv6x0FNRVFGZ61N8czY89om3m0GMtHbc3yLYkkYJaO2HxgrpVkHKF6gSGQzEC9pbUN811yNoe1nEJBK+XYsdM/36tsFy9LREFhqlgyl0ATCyLcPY28R/iCtQoz8DIhJukgwFpEwSSggiXV1h03Og/uMow8tD07astlYQrW3QhIgFrL7AjJmF+Ep/DJZknVRqYup65Vji26Htd6MC0VmESmYS2tuw05LcjwtcMew9RmPGCwg01/Ahg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(86362001)(36756003)(40460700003)(40480700001)(1076003)(7696005)(2616005)(2906002)(6666004)(478600001)(70586007)(70206006)(6916009)(5660300002)(316002)(47076005)(426003)(16526019)(26005)(336012)(83380400001)(36860700001)(4326008)(8676002)(8936002)(41300700001)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 16:40:12.1338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495f04c0-3972-4e3b-37dd-08dbcb41e79e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
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
Cc: David Francis <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On NUMA systems, local memory gets the local mtype, set by an
override callback. If EXT_COHERENT is set, memory will be set as
MTYPE_UC by default, with local memory MTYPE_CC.

Add an option in the override function for this case, and
add a check to ensure it is not used on UNCACHED memory.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 13 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  8 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 33 +++++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  6 ++---
 5 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 46d27c8ffff7..189341944bf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -761,6 +761,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  * @immediate: immediate submission in a page fault
  * @unlocked: unlocked invalidation during MM callback
  * @flush_tlb: trigger tlb invalidation after update completed
+ * @allow_override: change MTYPE for local NUMA nodes
  * @resv: fences we need to sync to
  * @start: start of mapped range
  * @last: last mapped entry
@@ -777,7 +778,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  * 0 for success, negative erro code for failure.
  */
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool immediate, bool unlocked, bool flush_tlb,
+			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
 			   struct dma_resv *resv, uint64_t start, uint64_t last,
 			   uint64_t flags, uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
@@ -815,6 +816,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.immediate = immediate;
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
+	params.allow_override = allow_override;
 
 	/* Implicitly sync to command submissions in the same VM before
 	 * unmapping. Sync to moving fences before mapping.
@@ -1062,6 +1064,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		trace_amdgpu_vm_bo_update(mapping);
 
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
+					   !(bo->flags & AMDGPU_GEM_CREATE_UNCACHED),
 					   resv, mapping->start, mapping->last,
 					   update_flags, mapping->offset,
 					   vram_base, mem, pages_addr,
@@ -1257,8 +1260,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		    mapping->start < AMDGPU_GMC_HOLE_START)
 			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, true, resv,
-					   mapping->start, mapping->last,
+		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
+					   resv, mapping->start, mapping->last,
 					   init_pte_value, 0, 0, NULL, NULL,
 					   &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
@@ -2546,8 +2549,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unlock;
 	}
 
-	r = amdgpu_vm_update_range(adev, vm, true, false, false, NULL, addr,
-				   addr, flags, value, 0, NULL, NULL, NULL);
+	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
+				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
 	if (r)
 		goto error_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 6e71978db13f..9ea8b5b644e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -244,6 +244,12 @@ struct amdgpu_vm_update_params {
 	 * @table_freed: return true if page table is freed when updating
 	 */
 	bool table_freed;
+
+	/**
+	 * @allow_override: true for memory that is not uncached: allows MTYPE
+	 * to be overridden for NUMA local memory.
+	 */
+	bool allow_override;
 };
 
 struct amdgpu_vm_update_funcs {
@@ -436,7 +442,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool immediate, bool unlocked, bool flush_tlb,
+			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
 			   struct dma_resv *resv, uint64_t start, uint64_t last,
 			   uint64_t flags, uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 9b025fd17b84..80273809c93f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -842,7 +842,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 	 * to be on the same NUMA node.
 	 */
 	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
-	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
+	    params->allow_override && adev->gmc.gmc_funcs->override_vm_pte_flags &&
 	    num_possible_nodes() > 1 && !params->pages_addr)
 		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3a1050344b59..1456f76b7fb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1251,12 +1251,15 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 		return;
 	}
 
-	/* Only override mappings with MTYPE_NC, which is the safe default for
-	 * cacheable memory.
+	/* MTYPE_NC is the same default and can be overridden.
+	 * MTYPE_UC will be present if the memory is external-coherent
+	 * and can also be overridden.
 	 */
 	if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
-	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
-		dev_dbg_ratelimited(adev->dev, "MTYPE is not NC\n");
+	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC) &&
+	    (*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
+	    AMDGPU_PTE_MTYPE_VG10(MTYPE_UC)) {
+		dev_dbg_ratelimited(adev->dev, "MTYPE is not NC or UC\n");
 		return;
 	}
 
@@ -1283,15 +1286,23 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 			    vm->mem_id, local_node, nid);
 	if (nid == local_node) {
 		uint64_t old_flags = *flags;
-		unsigned int mtype_local = MTYPE_RW;
+		if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) ==
+			AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
+			unsigned int mtype_local = MTYPE_RW;
 
-		if (amdgpu_mtype_local == 1)
-			mtype_local = MTYPE_NC;
-		else if (amdgpu_mtype_local == 2)
-			mtype_local = MTYPE_CC;
+			if (amdgpu_mtype_local == 1)
+				mtype_local = MTYPE_NC;
+			else if (amdgpu_mtype_local == 2)
+				mtype_local = MTYPE_CC;
+
+			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
+				 AMDGPU_PTE_MTYPE_VG10(mtype_local);
+		} else {
+			/* MTYPE_UC case */
+			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
+				 AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
+		}
 
-		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
-			 AMDGPU_PTE_MTYPE_VG10(mtype_local);
 		dev_dbg_ratelimited(adev->dev, "flags updated from %llx to %llx\n",
 				    old_flags, *flags);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7b81233bc9ae..bbaec633a806 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1321,7 +1321,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	pr_debug("[0x%llx 0x%llx]\n", start, last);
 
-	return amdgpu_vm_update_range(adev, vm, false, true, true, NULL, start,
+	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
 				      last, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
 }
@@ -1428,8 +1428,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		 * different memory partition based on fpfn/lpfn, we should use
 		 * same vm_manager.vram_base_offset regardless memory partition.
 		 */
-		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
-					   last_start, prange->start + i,
+		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
+					   NULL, last_start, prange->start + i,
 					   pte_flags,
 					   (last_start - prange->start) << PAGE_SHIFT,
 					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-- 
2.25.1

