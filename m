Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478FAC48BF6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 05:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADC610E012;
	Thu, 29 Feb 2024 05:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PocKGWSs";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E064710E012
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 05:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dImUL3wIRUT8PeHrWP7qx4ojVCUWMJsjqEDZRTTalO1mY/l1ZAIRaioqR9NMax7Ulc3XwMrb0wQmWTe77VAL+queA+KZRze3VNQK47MwlNb5aF1rcn5tEBM/NWrmj4YsKcmrLcJojJISJMLSxlYsPUC2vRgZDB3rOapyE+M6dZuXdNB2mBfZNw08iHNSsxn3TckqZomEPzt2W7LIUyt3XKSVaGwYM7ehitnCAL4kTvxMTlLhPtAig0gUwNkJpsuPTJctkuzS/e9Ul8OKQB3KESuD1r6FT4lGHU/TF23vKXXyszK1XXN0EKUvA3X4qX8zZgNYAXeDnrYMTvvCcschvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V98BNkjE/is/R7i54twRe04K+ev6G6t7DZmwOe6P/Y=;
 b=nQ5pG8DHdcvhDxyIffbU8njpj2c4M94R0EzYWB6tRzFhz3Z9L0KuXGjXaiwm+ZfZxIVUxxy/v2wz7/yE5VGZvh6rJbIpZm++2qra2VpJKEhnUsF8YmjvCYXciHLoMboo47EagC+L9JWCJ4vulY0IC3kJznAAI5jLUACqZQ1tQPp1MgLijOcAyxk+nDxNdNKPIPAiXvlsPGr9R4vbfLMRdT1BgrWCzKLD5NoAn+7/7wTy7S53o8r0WMMGrXUI5xYwSWO7dRBrHDpDbd5WUoKGr/HuS305PwWT/wFdC8hQXUZyk2v0YWNLalv6bayUtli/BHp8NhyMIvh9IkSNBhG8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V98BNkjE/is/R7i54twRe04K+ev6G6t7DZmwOe6P/Y=;
 b=PocKGWSsiqoq9tgGm1aCKYBJ0Mj00APJzSVONSo53u+c+ELTCNMNZx2hRZjewCz2y8UXGipZSIyhw1ebySUoXYCWJ1N3Y+quK3yDVJD9/QIIim285mRIxVAgz2F1imlcc9+jEhNQflahBSYejdnsq0HJVpdlMg/a+4L2w5m0mFU=
Received: from CY8PR12CA0065.namprd12.prod.outlook.com (2603:10b6:930:4c::9)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 05:51:34 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::7c) by CY8PR12CA0065.outlook.office365.com
 (2603:10b6:930:4c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Thu, 29 Feb 2024 05:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 05:51:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 23:51:26 -0600
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 28 Feb 2024 23:51:25 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>, <Yifan1.Zhang@amd.com>,
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Date: Thu, 29 Feb 2024 13:51:24 +0800
Message-ID: <20240229055124.2094798-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 08788e2c-ef8a-4975-82ca-08dc38ea7cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epaoaGvteCeDIhCPBLf1wJfq6+mKk4ZfdvTgtZmUHJPXSIfUIH4doL3sD30MDAIpNw6chvEbGDvjc03W0GYY6dQ3CWQ+eWLKt1YgX6jyzqFJHH1J4DCE6htP+PDtdD9Ga05QYBwMPLv7wYzblRaTv2S8zBP+YXgXdFws2GPYT6itOYZ/wz3UYXPu/G66a1XVEB5Z1Sq2JQA+gDTYUi6nUgJaSKxKKGSeds+36kC2tTKr2+cTr8DynT8AuBW6z8yfPtzC6peBoEiTk77KmZDE5+u7+FuW8NVKjSszq2YmbqTbAUINmaic9fKdtByTEToWp+KkBKBDd16RJDsDvKVLFo8KqS6wjKRKtp5w05m0q0+Kvhe90ItJuHdHzfaytuoKX8JxQY0Twyv1lopCbgRYZIstkYR9SGax8+9A3dk0T5SVTxhpmNXswPG8g2fsaprrRXYYj0djVyx5ewFQLs479Ex+GVBAWKEZJ9PavQbx4oRxkpHGCtCyJkeb76s7OQ1KMtxWlQRpjWfNvRYtCfnzEIskpBFR8xrzCKXvt3kar0gWpONaXddMpCL/cclNvBvWdNRnPsb+3/gVeOSiSUjNLaVnlXG+8KB84yNXNrZQpIxE4PSzCTKM0Vtoj1nXAJSkcQ4N0EWC0yfZZrW1bp3k2lpZT9orZu3uB9qPleNNyrX2mVblYpYZXzwfTs+Z6Ot2kAstP2tLJZ8ajgr2NRTeGSGBFfqZYA+enhvgYp1EJ6L6/u5MwBqYeKN0r+3bD/U9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 05:51:34.4709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08788e2c-ef8a-4975-82ca-08dc38ea7cb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 55 +----------------------
 3 files changed, 1 insertion(+), 80 deletions(-)

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
index a160265ddc07..f07255532aae 100644
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
@@ -394,27 +378,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
+	ats_entries = 0;
 
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (r)
@@ -445,23 +409,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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

