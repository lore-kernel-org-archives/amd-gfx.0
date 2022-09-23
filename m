Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E585C07E9D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 22:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B0710EB22;
	Fri, 23 Sep 2022 22:25:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC1310EB22
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 22:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB80vF3jlD238vCjz2ruTcKUopb9oh63vDNTXHni+qr2f74NGGTqMkRLIuDgD9i/g+K97+OzfSzThkzODcXx1N3AluKHbpLBqiLzGwUT0WLQObIvuXs+Ozdlj8jBXbUio62ySQZmHr8M65X5X0qVNg/6aGO8/rgyimYnxy2DvAf/gtB7+Fpb4QCfIaSZnAfMNsmGAMfWBFPdlesALqcxKbAenAqy4lnZADoes4oB+NIJMyrhWrqL/qOAbuN1E5LvMVDMpYeOxZiSj+EmilGNaQDMATRe6rulmY5HufPO09KlIpJeUyblSDoeILZAXKtooJEiU/3VZHZrjNAHLvSIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdAG2DOZv3LQO28JHMflJBh7rNl90SDsVmqqYvP3c68=;
 b=JgCYYGg7SvLA6R9othtZo97ObENzDJIWLZCyoHxcTR6sD58nWtZBnCW1yOzmF4ruaCmAi78DO8ozP3PTyYVt+43tCWErE/NvuICxuwwUzarb9jJCIhSOQ+SP9JPoGCPhuM3zZFk/rCMn2Nl4Q3VBCjpEzLKW6rH3fb/8MXZJ6SKmM7kzNoWAL0bRn4mCDKSVQ4KdNtO75bACpeLCoIgTQt1nq20itqyAUpoWhvLlWrg92saQc1k5n+/2rMMUMGB/ehTz2Mx4SfLny43Iqtd6/r4NV/jGGIjZpBA9cM/ABi/zx+Hjh3w5zBcUWoNnkmJB0T3wJRLwW/eGiVA3jP8DVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdAG2DOZv3LQO28JHMflJBh7rNl90SDsVmqqYvP3c68=;
 b=4kuqqVk+UMG3gVU52bbr3xPJKx7327h9BnR7tIbNtPeUU5lolCdiLCUElsnB+s2bweEPl6HBVkLryDMMAKW3qN8SLhQMJMY8AadKDV3vkov8nKnuFHY6afoBkQdhVvC0jfUamLczpN9DwiPaQu9gQPP09zZNFMAnla9R4BmTCXk=
Received: from BN1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:408:e2::35)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Fri, 23 Sep
 2022 22:24:59 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::49) by BN1PR13CA0030.outlook.office365.com
 (2603:10b6:408:e2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7 via Frontend
 Transport; Fri, 23 Sep 2022 22:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 22:24:59 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 17:24:58 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Set MTYPE in PTE based on BO flags
Date: Fri, 23 Sep 2022 18:24:32 -0400
Message-ID: <20220923222432.877832-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ec94ee-ca79-4e84-2c0e-08da9db273b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrAbObnrAnk6ia/ypHEo05BRVqtEweh0DjTRKG98ZXn8r8LJ0axO+VoNOPjYnZawRhI01i1Mlg/d+7JIgdoRIVKQxX0TznOxh1RRq9tp7w+w3anghYUBOroHuHh72ylWpuFbOAHWfBpENw9hxdMGSWIL0zaCQ7CfKFodm+TibmnytHxcGcyMiaC2YFUOP/U0aEGPaaYpBxt1yqKWxRYKm+Y0s+VZRMIeJJgOHEn1pkfOA/RwlXsatRYI/8n1NQ+QMWbTPxkfQE54oy4xYX4TdjgpfVdAyw4D5U4KRL3JUzgUMS2SHfS5rNiMExgZNIKWye1zILgCy8BhkXBacoRh5mdw7oPGALXx0Q81hhCtie/CtJAnVQKvrGyyI8VONgE6X1TWN9Wohwik0TiE2f/RvqRQ6OUIuCXw0lQzC1frsGEPn+GssUF7UahEA58Pi97b32tbBdbqnNqtGYfnM0Je39QDlfWuxrSaslxY7yKLBvgy2dM++wN3P2p5kIJM3iRoRzQ3Isuq1l2v8hFn00BSuGVnQ47byXy33QjEl/K6wKbs0TvRNKm0XtdnuRvuqTw5LHgDA9GrogZ11tYsQLvcEEnRw1hkCdg33a8Nfn3OK3B02+TBsj6PWou9W4zbr4pUZFeBJei+aAp7/bDBdY9jSDfZTikK5c/x3RDYO1/qNyJiGEXUb7QWXzwU2AjN1VzFTCk0bGmLT8AxODqFIFiuP+X7lmdbR7vFtTh+ESBw3puEc/s7kkeO6LUujVIAHZsK+4+r4m+iMhI1VIOAJTuCbbSZ52/LiLiu6ZAF+lIK5ZI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(36756003)(40460700003)(47076005)(6916009)(316002)(41300700001)(6666004)(36860700001)(26005)(8936002)(4326008)(2906002)(7696005)(70206006)(8676002)(82740400003)(70586007)(81166007)(66574015)(356005)(426003)(40480700001)(83380400001)(336012)(16526019)(1076003)(186003)(5660300002)(86362001)(82310400005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 22:24:59.6845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ec94ee-ca79-4e84-2c0e-08da9db273b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same BO may need different MTYPEs and SNOOP flags in PTEs depending
on its current location relative to the mappint GPU. Setting MTYPEs from
clients ahead of time is not practical for coherent memory sharing.
Instead determine the correct MTYPE for the desired coherence model and
current BO location when updating the page tables.

To maintain backwards compatibility with MTYPE-selection in
AMDGPU_VA_OP_MAP, the coherence-model-based MTYPE selection is only
applied if it chooses an MTYPE other than MTYPE_NC (the default).

Add two AMDGPU_GEM_CREATE_... flags to indicate the coherence model. The
default if no flag is specified is non-coherent (i.e. coarse-grained
coherent at dispatch boundaries).

Update amdgpu_amdkfd_gpuvm.c to use this new method to choose the
correct MTYPE depending on the current memory location.

v2:
* check that bo is not NULL (e.g. PRT mappings)
* Fix missing ~ bitmask in gmc_v11_0.c

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 59 ++------------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  7 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  7 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 79 +++++++++++++++++--
 include/uapi/drm/amdgpu_drm.h                 | 14 ++++
 5 files changed, 107 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 978d3970b5cc..f846ff119784 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -405,63 +405,15 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 
 static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 {
-	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
-	bool coherent = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
-	bool uncached = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED;
-	uint32_t mapping_flags;
-	uint64_t pte_flags;
-	bool snoop = false;
+	uint32_t mapping_flags = AMDGPU_VM_PAGE_READABLE |
+				 AMDGPU_VM_MTYPE_DEFAULT;
 
-	mapping_flags = AMDGPU_VM_PAGE_READABLE;
 	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE)
 		mapping_flags |= AMDGPU_VM_PAGE_WRITEABLE;
 	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
 		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
 
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
-		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-			if (bo_adev == adev) {
-				if (uncached)
-					mapping_flags |= AMDGPU_VM_MTYPE_UC;
-				else if (coherent)
-					mapping_flags |= AMDGPU_VM_MTYPE_CC;
-				else
-					mapping_flags |= AMDGPU_VM_MTYPE_RW;
-				if (adev->asic_type == CHIP_ALDEBARAN &&
-				    adev->gmc.xgmi.connected_to_cpu)
-					snoop = true;
-			} else {
-				if (uncached || coherent)
-					mapping_flags |= AMDGPU_VM_MTYPE_UC;
-				else
-					mapping_flags |= AMDGPU_VM_MTYPE_NC;
-				if (amdgpu_xgmi_same_hive(adev, bo_adev))
-					snoop = true;
-			}
-		} else {
-			if (uncached || coherent)
-				mapping_flags |= AMDGPU_VM_MTYPE_UC;
-			else
-				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-			snoop = true;
-		}
-		break;
-	default:
-		if (uncached || coherent)
-			mapping_flags |= AMDGPU_VM_MTYPE_UC;
-		else
-			mapping_flags |= AMDGPU_VM_MTYPE_NC;
-
-		if (!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
-			snoop = true;
-	}
-
-	pte_flags = amdgpu_gem_va_map_flags(adev, mapping_flags);
-	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
-
-	return pte_flags;
+	return amdgpu_gem_va_map_flags(adev, mapping_flags);
 }
 
 /**
@@ -1673,6 +1625,11 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		}
 	}
 
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
+		alloc_flags |= AMDGPU_GEM_CREATE_COHERENT;
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
+		alloc_flags |= AMDGPU_GEM_CREATE_UNCACHED;
+
 	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
 	if (!*mem) {
 		ret = -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f513e2c2e964..a83efdc8aa0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -612,6 +612,8 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 				 struct amdgpu_bo_va_mapping *mapping,
 				 uint64_t *flags)
 {
+	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
+
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
 
@@ -628,6 +630,11 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags |= AMDGPU_PTE_SYSTEM;
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
+
+	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_UNCACHED))
+		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
+			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
 }
 
 static unsigned gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 846ccb6cf07d..0b515a6dd4aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -499,6 +499,8 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 				 struct amdgpu_bo_va_mapping *mapping,
 				 uint64_t *flags)
 {
+	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
+
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
 
@@ -515,6 +517,11 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags |= AMDGPU_PTE_SYSTEM;
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
+
+	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_UNCACHED))
+		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
+			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
 }
 
 static unsigned gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 67ca16a8027c..50386eb2eec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1113,6 +1113,74 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 	}
 }
 
+static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
+					 struct amdgpu_bo *bo,
+					 struct amdgpu_bo_va_mapping *mapping,
+					 uint64_t *flags)
+{
+	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
+	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
+	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
+	unsigned int mtype;
+	bool snoop = false;
+
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		if (is_vram) {
+			if (bo_adev == adev) {
+				if (uncached)
+					mtype = MTYPE_UC;
+				else if (coherent)
+					mtype = MTYPE_CC;
+				else
+					mtype = MTYPE_RW;
+				/* FIXME: is this still needed? Or does
+				 * amdgpu_ttm_tt_pde_flags already handle this?
+				 */
+				if (adev->ip_versions[GC_HWIP][0] ==
+					IP_VERSION(9, 4, 2) &&
+				    adev->gmc.xgmi.connected_to_cpu)
+					snoop = true;
+			} else {
+				if (uncached || coherent)
+					mtype = MTYPE_UC;
+				else
+					mtype = MTYPE_NC;
+				if (mapping->bo_va->is_xgmi)
+					snoop = true;
+			}
+		} else {
+			if (uncached || coherent)
+				mtype = MTYPE_UC;
+			else
+				mtype = MTYPE_NC;
+			/* FIXME: is this still needed? Or does
+			 * amdgpu_ttm_tt_pde_flags already handle this?
+			 */
+			snoop = true;
+		}
+		break;
+	default:
+		if (uncached || coherent)
+			mtype = MTYPE_UC;
+		else
+			mtype = MTYPE_NC;
+
+		/* FIXME: is this still needed? Or does
+		 * amdgpu_ttm_tt_pde_flags already handle this?
+		 */
+		if (!is_vram)
+			snoop = true;
+	}
+
+	if (mtype != MTYPE_NC)
+		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
+			 AMDGPU_PTE_MTYPE_VG10(mtype);
+	*flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+}
+
 static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 				struct amdgpu_bo_va_mapping *mapping,
 				uint64_t *flags)
@@ -1128,14 +1196,9 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if ((adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
-	     adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) &&
-	    !(*flags & AMDGPU_PTE_SYSTEM) &&
-	    mapping->bo_va->is_xgmi)
-		*flags |= AMDGPU_PTE_SNOOPED;
-
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
-		*flags |= mapping->flags & AMDGPU_PTE_SNOOPED;
+	if (mapping->bo_va->base.bo)
+		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.bo,
+					     mapping, flags);
 }
 
 static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 7ee65c0b4f70..5941bc2bc27f 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -144,6 +144,20 @@ extern "C" {
  * content.
  */
 #define AMDGPU_GEM_CREATE_DISCARDABLE		(1 << 12)
+/* Flag that BO is shared coherently between multiple devices or CPU threads.
+ * May depend on GPU instructions to flush caches explicitly
+ *
+ * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
+ * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
+ */
+#define AMDGPU_GEM_CREATE_COHERENT		(1 << 13)
+/* Flag that BO should not be cached by GPU. Coherent without having to flush
+ * GPU caches explicitly
+ *
+ * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
+ * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
+ */
+#define AMDGPU_GEM_CREATE_UNCACHED		(1 << 14)
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
-- 
2.32.0

