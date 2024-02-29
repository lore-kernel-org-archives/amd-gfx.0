Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48226C54798
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 06:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABECC10E0B8;
	Thu, 29 Feb 2024 06:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kjX0nKp3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF13910E0AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 06:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnj2hqyDVk00F2MhZR3qpLpXL4QpwUSvC8/Ylm0Go2g8RId2+hqpsvaPh9KNSXRIM5xgCq6pqhM01HncyvH9X5/Om8qbOhR2R2yD0yklafDKBWFgR7tEnOfwgh+V+9GGj2bZUEY+SYcjO2fBxLKPxn8qP3qB/S4FmTN+H6P5RyX8LI7T2p3PvQSHbLeELHSlpw9XZuC8+4UvNi4f7kUCCQkkPezKQD3LsS63TdiA5JR3z0YAInlRRzpuUNY/ImUpBvBbSIsvDoXqCBxEnsZeHGLhOqFvwPbCdpKF2V7VHbSnE69eTyXJKsGB5J1rday+pOYKcRgekgay5bgWaCDtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbntPjFwY6hjw/pLAIZAldgk481IXyrICfy+vMkscx8=;
 b=b9eLSv4Sl4ytAK0HrtLNLO0ywSmAeaU7gx1eekdXXzMTZlAs8mDZh0v5Mj7k2lzCJ148IyrhXi3WA9UgVyDNLZDFk89KAYAs0hYHnWPqR5OrYIDX2Ziowv34tlUTIXdb5gVMjqwgIIGBfEMjH6fMAXX00l577zboZ6WjDr++pOvOpVodbwgy0oYh+nM81V/FNL2oi+LyJo0MVDVGxCHUBJ6AY/Qf5ZF7/+r5iWUQETT0V8FZn38V3/z2QZRUhcrQgiyOfGwK/nYpdfQORBBx2fqVsXKPe7t9ps9mXDdFGBQdC96qGDzG1CTPrE+4SC8FbsFw5umFAHsc8QMSsPTGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbntPjFwY6hjw/pLAIZAldgk481IXyrICfy+vMkscx8=;
 b=kjX0nKp3mKnVG0jcZckBj76T6UgsnT2YcXyZtIljeqpQYhKjWRTwqLfLHm9rupDaTN8NvGprIXEnEFq+uq3nQVlkPEbowlOm/JDDRlIcoHUzDW2kNkmn0hLrh0Dv3sB+S2TxruvaepWRXtWvh2V/xDk7/LTMV/inL6fVZtJ1kMM=
Received: from MN2PR13CA0018.namprd13.prod.outlook.com (2603:10b6:208:160::31)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 06:04:16 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:160:cafe::94) by MN2PR13CA0018.outlook.office365.com
 (2603:10b6:208:160::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12 via Frontend
 Transport; Thu, 29 Feb 2024 06:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 06:04:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 00:04:15 -0600
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 29 Feb 2024 00:04:14 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>, <Yifan1.Zhang@amd.com>,
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Date: Thu, 29 Feb 2024 14:04:13 +0800
Message-ID: <20240229060413.2521976-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a6c21b-2a1b-445b-4397-08dc38ec42eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7lhCxXe4ClGbPApM5Z7mbpk3RrWUDpg3VlX3FA22NlO6/mpwDwgLBSLoUYiRkXCOO7CO8Kh/epM1OV4au+Fh84V6H3J6Fu/FMkSj2S5bKbkn3fl1qJ8tjRxufuagaNMsisNvUUci2s2LkloJxLIakagh8U4Khd9WvDYYFvNlg6T8iURvzQYj+WeYZ6CQtja4Y2wKxDcoeel9B20FQYZO1FvoOHh2DI9t71uRYu2d5jR+myonGtrwEeX8XndczbyJOnDjx3HxG17rKskpRHwiLMwXxOMe4AUVrf1vY81P0EbH4UEP7LdMGraBzVFD0l0E0ZCUQlief0r2vG0a9JCH0JBzzQybIf4qp4GUxQGSQOGZULsm+ka6RZj0JEIjeMpU5qYZ9c8X3yRMbpyvy0GQu/1XzwIMRLHFffCUq/PbmHVKRmbN5zAhVkMsQW+7m++/kB/RMmW03/o4G09HhpWL3jXtwafoHiURDOrE8yCQjhsI/bv8MeZXOug4YsysHd+hbrEzpIKQ6e4Gr+LY5cxDnVM6HITiDhjqYujkyPb7BPftQn8KeF9jjb/mKyFj1Xlw+EaFJGE8ET92SSjALNhAHObu3dXZWtx7gT+Xo+uxM5lk4MGyMDnLYXdkWkcb99rIGSHh1mF4iFcBa2J50hIBn/12Quu5Y+5OpRZ9OKdxwZJKEqGJfajd4FqJre8a5tSfvG8RtsZw6VJaS8mzR2F4y6PUvm+k+ByQhXGUk6vUHZTwXsE60Z+vJ/TSwP1DiZX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 06:04:16.5607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a6c21b-2a1b-445b-4397-08dc38ec42eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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

fix the issue:
"amdgpu: Failed to create process VM object".

[Why]when amdgpu initialized, seq64 do mampping and update bo mapping in vm page table.
But when clifo run. It also initializes a vm for a process device through the function kfd_process_device_init_vm and ensure the root PD is clean through the function amdgpu_vm_pt_is_root_clean.
So they have a conflict, and clinfo  always failed.

v1:
  - remove all the pte_supports_ats stuff from the amdgpu_vm code (Felix)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 23 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 56 +----------------------
 3 files changed, 1 insertion(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ed4a8c5d26d7..d004ace79536 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1385,10 +1385,6 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
-		if (vm->pte_support_ats &&
-		    mapping->start < AMDGPU_GMC_HOLE_START)
-			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
-
 		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
 					   resv, mapping->start, mapping->last,
 					   init_pte_value, 0, 0, NULL, NULL,
@@ -2264,7 +2260,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		return r;
 
-	vm->pte_support_ats = false;
 	vm->is_compute_context = false;
 
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
@@ -2350,30 +2345,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  */
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
 	int r;
 
 	r = amdgpu_bo_reserve(vm->root.bo, true);
 	if (r)
 		return r;
 
-	/* Check if PD needs to be reinitialized and do it before
-	 * changing any other state, in case it fails.
-	 */
-	if (pte_support_ats != vm->pte_support_ats) {
-		/* Sanity checks */
-		if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
-			r = -EINVAL;
-			goto unreserve_bo;
-		}
-
-		vm->pte_support_ats = pte_support_ats;
-		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
-				       false);
-		if (r)
-			goto unreserve_bo;
-	}
-
 	/* Update VM state */
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_COMPUTE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 42f6ddec50c1..9f6b5e1ccf34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -357,9 +357,6 @@ struct amdgpu_vm {
 	/* Functions to use for VM table updates */
 	const struct amdgpu_vm_update_funcs	*update_funcs;
 
-	/* Flag to indicate ATS support from PTE for GFX9 */
-	bool			pte_support_ats;
-
 	/* Up to 128 pending retry page faults */
 	DECLARE_KFIFO(faults, u64, 128);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a160265ddc07..2835cb3f76eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -89,22 +89,6 @@ static unsigned int amdgpu_vm_pt_num_entries(struct amdgpu_device *adev,
 	return AMDGPU_VM_PTE_COUNT(adev);
 }
 
-/**
- * amdgpu_vm_pt_num_ats_entries - return the number of ATS entries in the root PD
- *
- * @adev: amdgpu_device pointer
- *
- * Returns:
- * The number of entries in the root page directory which needs the ATS setting.
- */
-static unsigned int amdgpu_vm_pt_num_ats_entries(struct amdgpu_device *adev)
-{
-	unsigned int shift;
-
-	shift = amdgpu_vm_pt_level_shift(adev, adev->vm_manager.root_level);
-	return AMDGPU_GMC_HOLE_START >> (shift + AMDGPU_GPU_PAGE_SHIFT);
-}
-
 /**
  * amdgpu_vm_pt_entries_mask - the mask to get the entry number of a PD/PT
  *
@@ -379,7 +363,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct ttm_operation_ctx ctx = { true, false };
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_bo *ancestor = &vmbo->bo;
-	unsigned int entries, ats_entries;
+	unsigned int entries;
 	struct amdgpu_bo *bo = &vmbo->bo;
 	uint64_t addr;
 	int r, idx;
@@ -394,27 +378,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	entries = amdgpu_bo_size(bo) / 8;
-	if (!vm->pte_support_ats) {
-		ats_entries = 0;
-
-	} else if (!bo->parent) {
-		ats_entries = amdgpu_vm_pt_num_ats_entries(adev);
-		ats_entries = min(ats_entries, entries);
-		entries -= ats_entries;
-
-	} else {
-		struct amdgpu_vm_bo_base *pt;
-
-		pt = ancestor->vm_bo;
-		ats_entries = amdgpu_vm_pt_num_ats_entries(adev);
-		if ((pt - to_amdgpu_bo_vm(vm->root.bo)->entries) >=
-		    ats_entries) {
-			ats_entries = 0;
-		} else {
-			ats_entries = entries;
-			entries = 0;
-		}
-	}
 
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (r)
@@ -445,23 +408,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto exit;
 
 	addr = 0;
-	if (ats_entries) {
-		uint64_t value = 0, flags;
-
-		flags = AMDGPU_PTE_DEFAULT_ATC;
-		if (level != AMDGPU_VM_PTB) {
-			/* Handle leaf PDEs as PTEs */
-			flags |= AMDGPU_PDE_PTE;
-			amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
-		}
-
-		r = vm->update_funcs->update(&params, vmbo, addr, 0,
-					     ats_entries, value, flags);
-		if (r)
-			goto exit;
-
-		addr += ats_entries * 8;
-	}
 
 	if (entries) {
 		uint64_t value = 0, flags = 0;
-- 
2.34.1

