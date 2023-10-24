Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFA5C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 19:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F62610E476;
	Tue, 24 Oct 2023 19:08:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6817310E476
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 19:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI0uJF/q9rvQGangXogIJIlzRp4d/EN/sKaczbcngFAvBYOorVe9fBUqVDQ2/H1N9MgBavWMAe491Tdn5Ov1mkiPkl9OX5Imeu9TFlSjFp9KZWvU7x9+G8LmHZeUt26YNjlHrCJxDDKARMo1dGoywFA4AKBrR4Z3gCuAA43IfDFSuhA41XC/osbZvM6/+CmtBiKCWfVa96aqAveWe5gGFYqETySepuKXwfshnBCsG3FJR6lOd/xO5hKnBdqZiSpmlt89gz/lxxlOh7XnFPOgrSJmZNkzqwKUzeWNAgo1dHfiTJMLAFwgr1/jmwi/YxBsyh7KKEzjcc9oOVEPW0jLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5HE+bjsJITbnoFkXaTezW5v9fa8KplX1ACjbZmAGMw=;
 b=hk8nM/KnmJl+P63J6bf5kRuoxfZYNNbUuYgnKbhZcsPaJMH79LgRBq3TVkVjptIh/xOTL6t0GrfSrChkeNMLegnA9Kl7m4nERWOeurj1x9nv8xMXYkErEbaVkICDK3biy9Aqdf96CN4jiMpjaTm2IAevX9DDI7UP6f8XWtDYpI+TY5+RrpWjl2PVFgLhRps5e6s6i7agnltymE7xANGtRuDkiICWJD0k1cs0KNUvLyKY/z55Mp6XLmqa0yFH3ytrBgQ2jd/GOlRuPIFecBLXkcfpjDABVapfnxdBoee3hPwoi1OnnVCEDdwdmzcW5a7bDo9SGxTb8YKPegn1Zjr3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5HE+bjsJITbnoFkXaTezW5v9fa8KplX1ACjbZmAGMw=;
 b=X/+hIH91oBUzuFGuwCKLaF/mifvwcq/kYZnUbgqGJWNSdEFkisXXDXphnajTg+VBnNZ7CVVd5hMSsOoyNP1dP+dlkWhx9GhZIDxr/Zs2MPZjqUmwpL1LoNKFmmIP7xTV2zcDiBTWAqXsZQK1wdMrelUeYigYvLsr6Egs72iqudc=
Received: from MW4PR04CA0380.namprd04.prod.outlook.com (2603:10b6:303:81::25)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 19:08:32 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::53) by MW4PR04CA0380.outlook.office365.com
 (2603:10b6:303:81::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 19:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 19:08:32 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 14:08:31 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Add EXT_COHERENT support for APU and NUMA
 systems
Date: Tue, 24 Oct 2023 15:08:16 -0400
Message-ID: <20231024190816.312852-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 602fb789-6df9-43ed-907d-08dbd4c49d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjCDmIkPb4Avo3goX5NnNJYUwBCSXgqVTN0bXGIQsn9IPlYx+4LeC0CStv4LJfCP5aUcMI90sRQc9DGUzZNNy0j+Hbroy+vTB7Vj/IFuXVEOSmixiU/pdpWHtqKQ7tSDLxMYpmItz0kYb33sqZIgKbhERpAJQLaObMcpl1prFBHowOmgTFWQ60Nuylme+BWujgMg5p3MwpsBIaZn/sFHUYQ2DFNeN38YCM4Yo/k8JOn7bx4dMtrxrwOkg3RfxwZgJXC0XdYh/B6ULp/yIxeTweI4dtE6BzZsQx5Y4cKYnNU/0OrBA8nlQGcOOvjbj+J0N1JmTMEPqDAgQ+Maj+pqSpee9O3ofsgZ7kquUgN01DQwNT56tkZeoDSeTPPD2/Ys9PFk10EO4h4z5a0ft0UmFIfMAecTSVFo+c+JM1/6H77NIQzdQgTmktx7yab7HnFWCjpgEQVhMH//ck/JOxFjSWYcK4L/Acn3SLTHkb/JJF8K3KvXbOA3POfiag99X9osYO5l/ivnJ2YPT0DRPhWtDtvuCP2JRm0XQtzXPNSTSXXdtWzD7aG14yPfhoeGAWInywm4ijbrBE5wqZqMnuER8Y+11le6m5Nd/FmCoQF6j5CzwO6CYK2qH93ERM4a+67+ffJXtHOf5pb+fCzVYMts6ywkJ8+Up6r69Ido4c5QY/FybzrhqIIj+te8NRNx/qpIi1E92bjWDI6fpnCrjOVXiZTaXNYc5Dg5B2BWjyZTjgD4u5IBHOOgejUtBQy8o4RQ1p+dgVDFNqZlbcutROdDqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(41300700001)(40460700003)(40480700001)(8936002)(8676002)(4326008)(2616005)(82740400003)(426003)(336012)(83380400001)(1076003)(16526019)(70586007)(316002)(6916009)(70206006)(36756003)(7696005)(26005)(86362001)(6666004)(478600001)(356005)(36860700001)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 19:08:32.2450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 602fb789-6df9-43ed-907d-08dbd4c49d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973
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

On gfx943 APU, EXT_COHERENT should give MTYPE_CC for local and
MTYPE_UC for nonlocal memory.

On NUMA systems, local memory gets the local mtype, set by an
override callback. If EXT_COHERENT is set, memory will be set as
MTYPE_UC by default, with local memory MTYPE_CC.

Add an option in the override function for this case, and
add a check to ensure it is not used on UNCACHED memory.

V2: Combined APU and NUMA code into one patch
V3: Fixed a potential nullptr in amdgpu_vm_bo_update

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 17 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  8 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 33 +++++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  8 +++---
 5 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d72daf15662f..155c04589753 100644
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
@@ -990,6 +992,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	struct ttm_resource *mem;
 	struct dma_fence **last_update;
 	bool flush_tlb = clear;
+	bool uncached;
 	struct dma_resv *resv;
 	uint64_t vram_base;
 	uint64_t flags;
@@ -1027,9 +1030,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 		bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
 		vram_base = bo_adev->vm_manager.vram_base_offset;
+		uncached = (bo->flags & AMDGPU_GEM_CREATE_UNCACHED) != 0;
 	} else {
 		flags = 0x0;
 		vram_base = 0;
+		uncached = false;
 	}
 
 	if (clear || (bo && bo->tbo.base.resv ==
@@ -1063,7 +1068,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		trace_amdgpu_vm_bo_update(mapping);
 
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
-					   resv, mapping->start, mapping->last,
+					   !uncached, resv, mapping->start, mapping->last,
 					   update_flags, mapping->offset,
 					   vram_base, mem, pages_addr,
 					   last_update);
@@ -1258,8 +1263,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		    mapping->start < AMDGPU_GMC_HOLE_START)
 			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, true, resv,
-					   mapping->start, mapping->last,
+		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
+					   resv, mapping->start, mapping->last,
 					   init_pte_value, 0, 0, NULL, NULL,
 					   &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
@@ -2547,8 +2552,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
index 9b025fd17b84..a2287bb25223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -843,7 +843,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 	 */
 	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
 	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
-	    num_possible_nodes() > 1 && !params->pages_addr)
+	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
 		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
 
 	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index fee3141bb607..b66c5f7e1c56 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1251,12 +1251,15 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 		return;
 	}
 
-	/* Only override mappings with MTYPE_NC, which is the safe default for
-	 * cacheable memory.
+	/* MTYPE_NC is the same default and can be overridden.
+	 * MTYPE_UC will be present if the memory is extended-coherent
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
index 640ada95e2c3..fe937670c927 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1280,7 +1280,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 			if (num_possible_nodes() <= 1)
 				mapping_flags |= mtype_local;
 			else
-				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		/* system memory accessed by the dGPU */
 		} else {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
@@ -1315,7 +1315,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	pr_debug("[0x%llx 0x%llx]\n", start, last);
 
-	return amdgpu_vm_update_range(adev, vm, false, true, true, NULL, start,
+	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
 				      last, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
 }
@@ -1422,8 +1422,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
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
2.34.1

