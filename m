Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3154CDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186CF10E4EA;
	Thu, 19 Oct 2023 13:33:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0142A10E4EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIYfxeDg30Juhi05lwmg3B3Zk0k9yPvy2YTN+8GFLURdz6nGMnJkPR5AWVKxJF+IlTT2CUjLcPybZ/tRpOvG8yZYlkO0L17hmkPg1C3/gYuKgcBCjyQIu4MrwYSmQl13dWJKU2eAsni7CABAkUk0lbqtZCM0NSR1gAaKkI2aRvHjoYhWwv2Gr+QEQEZISdlJpY1W0Dc7eXdXZjRpL4jrbX2sJwp8KuAi3rAwcwhu/jjHMgbDl1+k9nSLlGFAGM0mmehDzLTZ3/HLagyVNlwS7Reg3eE2AE1DlywWERclR75reTZjHsrY0VXh9jV4Q16m2xZyoZQ3Z0WujbTUQB35qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiaGTcaA1njzbJJCawl87kxuKbglDZbj/xoYtZ/kk0c=;
 b=QAE4DirQPy1LEkev5I5lb2KsrwEjZz1a4ENtGwN35x1P6aw/quc4Kxc6riLWnEPAtxTbiOBuL2XIJ283Hrg0meMoolCsHNuLdf8AsEOW7Bx2LiHNmH/txnIv5ULr3WdfHrL9BIIyQp3aaI4bVLM4OXa3SJ6Qb96cCvYJzXb+G/ZBHFPWJHl44dxpqu2Xg+QH8aMSDk0zyEPw6NOsHhvUwWOqTMY1B9vP8yeTsfYY+AMoTZmPiFcPPp1UMSSCqpfqf1vOf4ecKGCcnhQ1HVPQghueek4qEixuDRN6yeI+9i815AIB3F+o5DbSLhxmsBGiOaXyTcym1yzwqzqlPQtkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiaGTcaA1njzbJJCawl87kxuKbglDZbj/xoYtZ/kk0c=;
 b=RqxIhfMk7cZNuJUciqrsvhNXYFVK7ycJH5UKk/SD0/db9GnQ3UAxAc7Qmo/ySyGp/eqwg0zxEC+tvh0pmos6kNLon8oPK2zCqUiXIbHlhTolxKyR56dEiYHGfvn97puJG98NwCN2vY07+kRpzgxDFgokBNsTR/JNQukNfQtYOl8=
Received: from MN2PR04CA0007.namprd04.prod.outlook.com (2603:10b6:208:d4::20)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 13:33:13 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::39) by MN2PR04CA0007.outlook.office365.com
 (2603:10b6:208:d4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 13:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:33:13 +0000
Received: from david-laptop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:33:11 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Add EXT_COHERENT support for APU and NUMA
 systems
Date: Thu, 19 Oct 2023 09:32:49 -0400
Message-ID: <20231019133249.598193-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: d424f34a-a2b8-420f-3827-08dbd0a7f181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EfxEKJODie7qpYBOvri06Rq+qD0NL5PhfTNRig5dQgyoCS5TLWqVSxkgzQKrSfxWgH6tXaEMIrJwy6VuG/1MMKAvViivYRuMd2WRfYyvrciHtdP8RDtNvw+g1yz6uDuTD6+Gxl1oWkYSKangrrLQyaOZi1s56vbnif4/WinkB7NW+p1mwsAMtmVDmSUJJbiKTlK7O5hbj2MOLFuufODFd2bdeEI4ctQSVKk0dO94h6Fi8ANOy/TUVCLseZ9MdaYYZIVynNFznd4U5I68iK/o62VmxR1tEHRsyYuQGr6JePrxWowGcpZk0XELZQTWE4nMhnj4SMJuJpTuoUMMjfYJ/n5RobZDXZPdHpRUFqglvfdn1rvE7/wogDuoNh1WKeAZTO1prZxbIWiW5eK7FzgRDojWBnD7YrBs8vNU7KbW/wPRMcUKdOtO31DpSOyYZGrJbyv5ovMlsfMVONrRD8eQkSoywXD+uj5b1fMqm9fnsGsAVETe7lm/ijIQem8fss0f8pCn38hPIivilBHqc+OFolo69RwEh00O4q2L48nXVPbSbANBCG+6lg4RZTKsAoxYpL3/4dWP9u3JGkNcp+yVr+cHTWzTrvEsHhNjU+cqKDlUSglR3oQxivTK44+sVxm8TFbY9m/w2UkYOZU9s7p0/2DX7RfXZXLicoAYbgnsKMB6jrQT/KS3ax3zEB7H79YcHi3aP0nthEnQOhQi+Bekm4SdXXD0U7nZewdmAzGpB9SDpCkS16/jDtIEhOAmm4jXbATL7yBojQivTPCGQmpPAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(6666004)(478600001)(7696005)(47076005)(16526019)(426003)(26005)(83380400001)(2616005)(2906002)(336012)(316002)(86362001)(6916009)(5660300002)(70586007)(4326008)(70206006)(8936002)(41300700001)(81166007)(36756003)(36860700001)(356005)(82740400003)(1076003)(8676002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:33:13.2638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d424f34a-a2b8-420f-3827-08dbd0a7f181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 13 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  8 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 33 +++++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  8 +++---
 5 files changed, 42 insertions(+), 22 deletions(-)

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
index 7b81233bc9ae..87cd1ad14a72 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1286,7 +1286,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 			if (num_possible_nodes() <= 1)
 				mapping_flags |= mtype_local;
 			else
-				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		/* system memory accessed by the dGPU */
 		} else {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
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

