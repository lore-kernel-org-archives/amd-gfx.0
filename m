Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C33CA600A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E535C10FC99;
	Thu,  8 Oct 2026 07:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AuhRmu4O";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0171610FC8F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 07:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRIdwA07/TPC9Lbp6Zld5IfVBv50VnHoAZRPLP563VyLJq/sLUCGQOx7kMfs/5wrnAWGauqyu/RvnUjKgd/X2f+Arp5ismkV8it5z5spKmhQUjmhq7Na7/KQxaev6Xd5kdrPIaO5vruO8kH6YEF+RrOGpt/wNfywX1VlgRiPpaXIQDEoZZ4XMaE7hPEURL+PSQuzYWp9fQLkOp4DEYlHf4cC/8L4Maio19gnkZ4z72q5PuUsb9hNSilutj8ty/zFSyBBlI4Vr8Txb00yYWZgFqXGif4ceWP4cHMkaA/TUPr7Q9A4I2WWgRjEVSktNzE6SD6rmUggRw6OhrIBu37Ukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br7vVqzH916AW1McJJsYIYBH58N+fUsJblf31cjUhr4=;
 b=xSOr/8zfb30ZTQgnx65ttfeponXaxYbhhc2wIGZ+wjucNpFOGZU/FOEn+BENxdM5/5EPnjJ4avFRNZGS/N8UU6glKYXq5LXRQ/VOdROjDSD1rHFndRuzgG66nvjvl7Wx9ZRdWd0xaCaWKA3EwbzB2M6eQyGomM8+sC/ejuUkNFH1DCfYBPtNWzw5bfabHUc1SWt2qe2Jeh/gJe+xferFYsGk1T6AJl9UbE2fClmZIOBNOCt6kIhX8NEloeZdErmxgbzDuTdL47HSoj1bYlsal50DqrI+MD1WSbg2GRVelCiGI/783XM7idiJrOosObkfzxL6VheJlRhyi7qUAms9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br7vVqzH916AW1McJJsYIYBH58N+fUsJblf31cjUhr4=;
 b=AuhRmu4OEKr0fZh5D+DRz/dMgHW9mfxelvP17/PncfGSydUFMNxdH7aevMA8QQIj9y8u3gFbESAIlPADmYJR+r8YKTERfZM7+WHYFGej/kXks3HAC9DoUWQltDoCv7bA5RwyaCRMyH5TDv485oYG0fleTehIwhRUiV+QIlE+3bw=
Received: from CY8PR10CA0047.namprd10.prod.outlook.com (2603:10b6:930:4b::25)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 07:06:26 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::77) by CY8PR10CA0047.outlook.office365.com
 (2603:10b6:930:4b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 07:06:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 07:06:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 02:06:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Lancelot Six <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie
 Vock <natalie.vock@gmx.de>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: Make first-level trap state GPUVM-owned
Date: Thu, 8 Oct 2026 12:35:40 +0530
Message-ID: <20261008070542.1111149-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: d800942c-fe32-471e-fdbc-08df250aab82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: nMeFpnKO4kNJf1BC/Jh09En6QBTT5g8UOsU0TFhO2NJ61eH0gCKptH+kjDDm0aXbqxYYZ2zMpPTQjyguJvercMpXFNpYy9wam6jtMzWPTEBlEXFaTskoCwRsfHbNv3sFhEbo1uQwmTdcEenlYWgC9ns5TRn1Oo1sy4i6ZyubNeSO+AplcidkLnqj3lMi8r0uuikFSJjvrfap6bXhhdq/e4y/jkp2NdnUJE++Ku60hMbm3f1BM9zOPVZya4BD5c7vqmZuxUtjmAI1sP+jTDi8GLz7/196qlkIyEdEO0rgplmz2/Pt9dlyI2qwUIUWvKlWmBYVwy1ouim4cZUK50PIoBSAXI9ZgIYRaUj/zTodnkkVogqHltr0i4+/YxMDg7et6QKg+vf73ZQQZmOC2JuHjY9Q1I8iNUartxS4adpLPyEuhrAYj1gT3klBBCEC0qNgn1HdL6hb5YJdk/l7xu4XemFBMS86uQUkBab0gIw7YuVxUCGvB9jWWZenWVox7eCKf6B3s98oXeTwMJ1N5gOvtKCr9tmnPl01bdc1B/l1UI1GM6PRS8LFPZA4hjDx7A0BJb5+QDUMaJJ0roGJVNJuO91nv4RdcuFOi+5lW+oFNgoaMDuHrMrmdY1bCxMdPVN+17WMzdNbnqXTLLSKP8sDdlvIj6HUc6zfWYrpMNaI+kAvLF5TKga/x4siU0EfSlMNFt3SUYzUE1VzI3aJFBjvmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JSoM0XMc2nVSTHPL3lr217CUUKImWk6AmefWeoV1jMC35lS2++YmlDJMjat0GppDTg5vkvFnRni3qHoWU1WyzYlub87wMzRKtimK90ziQ+ytE5Q9K+QJeqQFgI2F8FKRWgteeDlPjgGppP9uNt4zqPtgksrP2Bm3nnIlCZxaLu4kV70TR36ltQ5k+9Q0FqJZzbbikRVzLr2xJVV5I4tdVmupRwgCvOh8LVuJXcW5VTeAiV3sIeJTJsqq73BZNF6eFo3RTS9h8Cl/dZOfCuHerfMHBcJ2swYr1TM2wqwLez4waC79vdWP/MzibEZfIWfCiOLxCTn9ISrURBpLDvApBMMZNNA9L+ydpJRSbvSPjLacyVQjjtTEjZllaDfgbioaIbY316kDmrlyi9UtrC1aIPD0RImAs4zCyLSPT75xYwKyqOEBvwmo4ZndRRw9FwIc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 07:06:26.6670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d800942c-fe32-471e-fdbc-08df250aab82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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

The first-level trap state belongs to the GPUVM because the TBA and TMA
are mappings in that GPUVM.

User queues and kernel queues using the same GPUVM use the same
first-level trap state. There is no need to keep a separate trap object
in the file-private data.

Move the trap object into struct amdgpu_vm. Create it when the GPUVM is
initialized and free it when the GPUVM is destroyed.

Create the trap state after releasing the initial VM root reservation.
The trap allocation locks the VM internally, so doing this while the VM
root is already reserved could lock the same reservation again.

For the same reason, free the trap state before reserving the VM root
during VM cleanup.

Keep the first-level trap ISA buffer shared at the device level. The ISA
is the same for all GPUVMs on the same device, while each GPUVM keeps
its own trap mapping and TMA state.

Update the user queue path to get the first-level TBA and TMA from its
GPUVM.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   | 41 ++--------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 31 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 ++--
 6 files changed, 41 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e55496f5ecdd..acd27ff6e0e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -333,7 +333,6 @@ struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_video_codecs;
 struct amdgpu_trap_isa;
-struct amdgpu_trap_obj;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -422,7 +421,6 @@ struct amdgpu_fpriv {
 	struct xarray		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
-	struct amdgpu_trap_obj *trap_obj;
 
 	/* Eviction fence infra */
 	struct amdgpu_eviction_fence_mgr evf_mgr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 6839d92b9730..45fa77c924a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1434,7 +1434,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		int num_xcc, r;
 
 		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
-		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
+		if (!amdgpu_trap_is_enabled(adev) || !fpriv->vm.trap_obj)
 			return -EOPNOTSUPP;
 		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
 		cwsr_info.ctl_stack_size =
@@ -1576,12 +1576,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
 
-	if (amdgpu_trap_is_enabled(adev)) {
-		r = amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_obj);
-		if (r)
-			dev_dbg(adev->dev, "trap handler not enabled");
-	}
-
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1651,7 +1645,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
-	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 12e37d0467f9..89968b5b7ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -326,8 +326,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 	va &= AMDGPU_GMC_HOLE_MASK;
 	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
 	if (r) {
-		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
-			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		*bo_va = NULL;
 		return r;
@@ -335,9 +333,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 
 	r = amdgpu_vm_bo_update(adev, *bo_va, false);
 	if (r) {
-		dev_err(adev->dev,
-			"failed to do page table update of %s region, err=%d\n",
-			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		*bo_va = NULL;
 		return r;
@@ -351,39 +346,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
-				    struct amdgpu_trap_obj *cwsr,
-				    enum amdgpu_trap_region region)
-{
-	struct amdgpu_bo_va **bo_va;
-	uint64_t va;
-	int r;
-
-	if (!cwsr)
-		return -EINVAL;
-
-	if (region == AMDGPU_TRAP_TBA) {
-		bo_va = &cwsr->tba_va;
-		va = cwsr->tba_gpu_va_addr;
-	} else {
-		bo_va = &cwsr->tma_va;
-		va = cwsr->tma_gpu_va_addr;
-	}
-
-	r = amdgpu_vm_bo_unmap(adev, *bo_va, va);
-	if (r) {
-		dev_err(adev->dev,
-			"failed to do bo_unmap on CWSR trap handler, err=%d\n",
-			r);
-		return r;
-	}
-
-	amdgpu_vm_bo_del(adev, *bo_va);
-	*bo_va = NULL;
-
-	return r;
-}
-
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj)
 {
@@ -464,7 +426,8 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
 	if (r) {
-		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
+		amdgpu_vm_bo_del(adev, cwsr->tma_va);
+		cwsr->tma_va = NULL;
 		goto err_tma;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7d3659ef11e5..de4071db94f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -45,6 +45,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_trap.h"
 #include "kfd_svm.h"
 
 /**
@@ -2606,6 +2607,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   int32_t xcp_id)
 {
+	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
 	int r, i;
@@ -2614,6 +2616,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 
+	vm->trap_obj = NULL;
+
 	amdgpu_vm_bo_status_init(&vm->kernel);
 	amdgpu_vm_bo_status_init(&vm->always_valid);
 	spin_lock_init(&vm->individual_lock);
@@ -2680,10 +2684,28 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
 
 	amdgpu_bo_unreserve(vm->root.bo);
+
+	if (amdgpu_trap_is_enabled(adev)) {
+		r = amdgpu_trap_alloc(adev, vm, &vm->trap_obj);
+		if (r)
+			goto error_free_trap;
+	}
+
 	amdgpu_bo_unref(&root_bo);
 
 	return 0;
 
+error_free_trap:
+	amdgpu_bo_reserve(root_bo, true);
+
+	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
+		list_del(&mapping->list);
+		amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
+	}
+
+	amdgpu_vm_put_task_info(vm->task_info);
+	dma_fence_put(vm->last_update);
+
 error_free_root:
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(vm->root.bo);
@@ -2830,6 +2852,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
+	/*
+	 * Free trap state before reserving root. amdgpu_trap_free()
+	 * uses drm_exec to lock the page directory internally; calling
+	 * it after amdgpu_bo_reserve(root) would deadlock on the same
+	 * ww_mutex.
+	 */
+	if (vm->trap_obj)
+		amdgpu_trap_free(adev, vm, &vm->trap_obj);
+
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	dma_fence_wait(vm->last_unlocked, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 226caa99f6ee..2750123dd7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_trap_obj;
 
 /*
  * GPUVM handling
@@ -385,6 +386,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* First-level trap state for this GPUVM; NULL if unavailable. */
+	struct amdgpu_trap_obj *trap_obj;
 };
 
 struct amdgpu_vm_manager {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 07b653909943..8ffbf93ff0fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -116,7 +116,6 @@ static int convert_to_mes_priority(int priority)
 static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
-	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -148,9 +147,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
-	if (fpriv->trap_obj) {
-		queue_input.tba_addr = fpriv->trap_obj->tba_gpu_va_addr;
-		queue_input.tma_addr = fpriv->trap_obj->tma_gpu_va_addr;
+	if (queue->vm->trap_obj) {
+		queue_input.tba_addr = queue->vm->trap_obj->tba_gpu_va_addr;
+		queue_input.tma_addr = queue->vm->trap_obj->tma_gpu_va_addr;
 		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
 	}
 
-- 
2.34.1

