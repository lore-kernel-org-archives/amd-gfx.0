Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE80FC38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 00:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F0510E06C;
	Wed,  7 Sep 2022 00:04:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50A510E06C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 00:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWFAhlwFY+F52WTmKbYn6NvBkQbF+Bci7AyNZJ1rjrSh9Z1mpnrhzY9V5JGVDdvTKBTDJA1kF77TeXBajFvSlRwsjytY7fxi223obuy4dk8VrcdSvzgpYjC0UsOK3toIG+QmluCmwNHRG+kvAZXGCc1kJhwyfXkax0DmAOkgjYD7CyQqGeJ+FpA70G7JGb1EnHQ74zK/9Xt2wvfTORkmTiRXuy3I6P0Swef45VYwyLs3/8PZ2hFjMoKV/ib/KCl1DRbRA028rH6AeeUAC4UkKk36c7FcvmzPUABfOSIEDlFwlcgmRuPv4n3yUy7lRy7lZgnr2yDe66YcHpxl9xOFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i24C3zIFdap5woSXBAuuuvdfrcSRcbDvDpCHfEdC+LA=;
 b=Ldvght+GrMYhxDcRNXgjwj/Keen3qcdu+48mzkPqRdfvhLkLKzkRPVMHfpo2Xp9z0yZpnf0moIBjtq1UTD699Nw/IpUEWU+WVKgbzsi0Tb0PtS1M3h6RfSLiIhRksdMEm2x3aFFKmNAKlPG+jn3dlsV0V3vuXPMdX/T21/dFLxdQSqroKtBrnpk31oOzBgS4loLaMcx5JX0r6L5VtlSP6jjoOTFamhJyl8VDWzdFBSSuNz1ut2NFZIuRQcDhrph0IU4uzCgSIeCR3HfZjQRArzLo8etufINNf8pOhMo15GD72rJKN78qdwy0TmKmJ7UpISxsmsmUDCDcKnLUo4CQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i24C3zIFdap5woSXBAuuuvdfrcSRcbDvDpCHfEdC+LA=;
 b=JFAyy8S/L2vACoIIitCmmJG/CdagWeMiFJwvYUPHvy+boEbRWbYyoYGNbZtrAYrZrTFJ9XCzQd215NCaLphcKpd1nnYjITNqVHAo3+BuqSuv9l+NcZrwwQJs/eq4pkUYSQjdyRzZy3A/H2SPIs11yMDrLWetNmMWlNFS/twuaK4=
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 00:04:15 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::64) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 7 Sep 2022 00:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 00:04:14 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 6 Sep
 2022 19:04:13 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH] drm/amdgpu: Set MTYPE in PTE based on BO flags
Date: Tue, 6 Sep 2022 20:02:56 -0400
Message-ID: <20220907000256.452005-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|BL1PR12MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: ad76040d-9f4e-43a3-c7c7-08da9064803e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwczzmRSsmI5BqKitvV9wyfmNwD75YgYXvE3nx2Un1cLe9wQNH8EVGl6yy2jHsirP4xKpHKKFBowz70FIfKQBzH/0YjBx5XlXpCbV0jUsiw7owXwNblU0NqJ2EhPIRL9O3F5YMlO+bTgY4tqYg1valQLPtWwNq/ERDt2z76hjJ3/Y+juaNd811uTKsXKOq86J75DnbeaHIaJFxXpvOm99AZd5+tEfvvpfDkpM+iPvrsiK0jUDZlaIG+j/LI3aRmrORGfH49J3G4AHl7OvWVtuJjBpdOokYEhARZSI3G1irMUflSCGlzWGhmNuiv282GfsLebGTxlkBrkJrDkcesVwoN+gfP1BT4T18JNzZUTfs85Pmy5GFaI7JgGsFWsOl8t3wn9uEN8wKpA+QkE5/uc6x6gFyjpgDAfnshg9Bq9NXMh1VXUoO2c9bo/9qhredDvUD5LJS/ciMIsrbx8GBpRk057s3n/uK7ANTVToIZz3qUkrVJr2wuK1sc/+Jxjn3OWFOdhm4iW7KuagRDcNQgV3JKU6MLVBI7K3/Rq4MMiikmz8q0H5l9+L00Gf73ib2TgWe3a41t2s7WR41OnjO1asBBYe7IhFRqFz2MhXzEWPtiYYGoaz8a3fycQ0u1Elva5k9Of6Zk2YntLdQuKDd+Ol9jS4WCnVqaBsTeybZ7pTZKzxWbjVUnhRzjvMfOmnDUlx4AGWgJyN5I0jtK8MJ/64c7yciHv8IOMwbid2sU1f48ZvL5XXm3lzSu2W2S0Cqg5z8pDy8txa2C7w7fteaC/u8YsEWxdYMgEAxsd5g/4AA0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(36840700001)(40470700004)(46966006)(478600001)(26005)(6666004)(7696005)(41300700001)(316002)(6916009)(82310400005)(86362001)(82740400003)(36860700001)(40460700003)(81166007)(1076003)(336012)(186003)(356005)(16526019)(83380400001)(2616005)(2906002)(47076005)(36756003)(426003)(66574015)(8936002)(5660300002)(40480700001)(4326008)(70206006)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 00:04:14.7042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad76040d-9f4e-43a3-c7c7-08da9064803e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
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

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 59 ++------------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  7 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  7 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 77 +++++++++++++++++--
 include/uapi/drm/amdgpu_drm.h                 | 14 ++++
 5 files changed, 105 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cbd593f7d553..19d72d323355 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -404,63 +404,15 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 
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
@@ -1670,6 +1622,11 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
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
index f513e2c2e964..f14db7d3c33d 100644
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
+	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			 AMDGPU_GEM_CREATE_UNCACHED))
+		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
+			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
 }
 
 static unsigned gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 846ccb6cf07d..6ff4de7d8709 100644
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
+	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			 AMDGPU_GEM_CREATE_UNCACHED))
+		*flags = (*flags & AMDGPU_PTE_MTYPE_NV10_MASK) |
+			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
 }
 
 static unsigned gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4603653916f5..58a2d1c8a188 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1110,6 +1110,74 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 	}
 }
 
+static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
+					 struct amdgpu_bo_va_mapping *mapping,
+					 uint64_t *flags)
+{
+	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
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
@@ -1125,14 +1193,7 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
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
+	gmc_v9_0_get_coherence_flags(adev, mapping, flags);
 }
 
 static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c2c9c674a223..f9bdc4f388ef 100644
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

