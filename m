Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8522CCA5FDD
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 04:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C2310E739;
	Sat,  3 Oct 2026 04:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3v4D3fcV";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC0D10E72F
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 04:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrOaV+G6fIxkGpboAvVkGROjus/hTj//xkKqP8clH6wdDWTyzJfk1BtI+PIi5p/nsmF8gHfvWb+rkL1CWVzUdR5omutODjFgVu10/Hx+oYBbRFLt5Jp6h8yxgdnoDo99lEB+CZT2CNDRLBGK4/llW8WLmTowx+/suvDG6NL42f8bpFBh8Lje9Ba/prYHVUzN/KTfoTCY7di52VtPXG11E3h9m2bDCCIwOLeKx2bcL+nFuXp7iEDqeAQVFmqQLfoGv/35mwQw0M/a24WbDSJou4GmPAgG9/5av4y1UGXB6qhqgvyIVkr+6mcex1G3x1+12uzvSqb0TvjczPnXyBUkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZTEIZPlQvbiSHXuurKKw1cwAaMbIjr6bAAuCHXp820=;
 b=Rc7qsJTkde+r+er5V2Lj/J0/saj9F6ZQy3FTp9JIxFLTWUd+WDJanwUP5XWn/BdRBPx41kFytup/vasmeXL/XFEHcQ0YgKqEGToZ7w46CkbNCmnBGzJVe3GtQVqVN5+792y3Z/9F44NIfQ39vKs/hHhsmMQKH0eFvyFncCNuJWzQt883M44exEcoQBHPtXfzhTFzlLXb/Lu/uq4rmrxztWHnfGdSGYdfYbc2Oympi+LosWH2+oSudAo9dS+16iUo0WdG1IiSC6X6mU/2DmihxoWdR9jdfUmSIazkcpNKpD4ztgHvv1blA7WdQzZw+I/XREfktU0bdFZbxJf3Rbbiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZTEIZPlQvbiSHXuurKKw1cwAaMbIjr6bAAuCHXp820=;
 b=3v4D3fcVRVEcfLRc205wvzoQ0XY+ta7D0Lli/U0i9taTCRr2NuokjmLJT6tGII9hkLF1s6rTLeNUoEr49K9cT5pLp+VYSaWq9bxZCoFS0moJ5c4guti497fYcXqTZgoN1zU71JNoPWzBvYyfriC6dvICUTBDsoIuOEZSFn4RV0c=
Received: from DM6PR07CA0119.namprd07.prod.outlook.com (2603:10b6:5:330::11)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Sat, 3 Oct
 2026 04:40:21 +0000
Received: from CY8PEPF00000057.namprd21.prod.outlook.com
 (2603:10b6:5:330:cafe::88) by DM6PR07CA0119.outlook.office365.com
 (2603:10b6:5:330::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Sat, 3
 Oct 2026 04:40:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000057.mail.protection.outlook.com (10.167.247.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Sat, 3 Oct 2026 04:40:21 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 23:40:17 -0500
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
Subject: [PATCH v3 2/4] drm/amdgpu: Make first-level trap state GPUVM-owned
Date: Sat, 3 Oct 2026 10:09:51 +0530
Message-ID: <20261003043953.936202-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261003043953.936202-1-srinivasan.shanmugam@amd.com>
References: <20261003043953.936202-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000057:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: f7483de1-2966-4b5c-9d1b-08df21086edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|6133799003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: z+FJ8GJC24xgsCziUOLnqUfZNBmhZmajyYxp9TqOGUMXAKntynuvvZaP/TQoWA/St37iZKYXYp8EBDJfpvWICIJJLiuwU2oax7qhPllAm3Nrq2rtzkjzG7E/jnK2Qqzt/ePwlGoI70fxZQ+3syp8O8K9U0+Aa0nZg0CzB5biWMaqFt1LmaeyA5TMGYekYDHGphMrCI97nb4r9fa+87Mve6pWFdXrrtSRgK0NWrUe//r31kKjAIKHlXvtsUriqbGUmomQq7y61iGbDyX99ITY7QZsxLBO0cpL2T9osDNiyUGun+QnJneHfc2l4FQYs/mYDQhI0DVnGFR/vKD1J+tgnYFtD+/UwVlAbo0O4M53C7dPlo8ozI58RCcBQLExUkRHOk8In7mNTowUKOCy5b75SCT7rfG4ZIyP2xoT0lgES3ebvmEgZbffCPxIZIhsf5Q4OfPZ+Ly0uD09BWvJsCBnCQw0kjrBEiTL5HPLp5SxdGmpEZu0lUX4RNljvywqHrEQbTpZhihWHqBiSMrCsUt9bx2WSjtbJFpKG21iegFrDlQGIB5kiwReiD2yPAzvfdsAENkKicqh8oZzel1lZs2njka756CInWu0wJet2lw/h34RvWF9HO85VFixdxLkt7j84YUVNbBICe0Iz6V7SgInyo9xS+fwIbBnrfjd1Mt973A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d8H40hF11gcaNb73X7wTyc/h5cFj/hcGQIkBpLqNwwReaWT3pe7LPz8IbpeZ98Ww6sLyzyMeW76pZ4zVZHybuDaFqitELxc0aA2E80BrlZ96Fa/HiWRydahg9KJwzCPlliFnOIWGd2bfeHOxXBeT6BdGmhrvNoJGurUx76JwPibq0UV/IbRXYNozT7CzOZPTjrdf+JYQYw62Yszf4lBhRAPigfu4bvzfz4PkQVIYrFIaQujhjOFkfBvhMt6snMkrCz+380ghZh1oF+u5yrVS6/GnBDbgBblNbWhIctfThfwPOG1DWl8hdBrBZgxzUay55o6+g5gyPeE7Gf413+m++bCuF4FbtzfFkmyl9GYWqzIA/YhNHq10WeQXTL5jYLPtGEIzDKTL3G1AiwB0S69u9dtxquIwpu3/avUn3ImQxrFZsTMRC7x0OTA/LxiYgwcr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 04:40:21.2613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7483de1-2966-4b5c-9d1b-08df21086edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000057.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
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
Changes in v3:
- Initialize the GPUVM trap object explicitly during VM setup.
- Improve cleanup when trap allocation fails during VM initialization.
- Free the trap state before reserving the VM root during VM teardown to
  avoid locking the same reservation recursively.
- Simplify trap mapping cleanup and remove unnecessary error messages.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   | 41 ++--------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 31 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 ++--
 6 files changed, 41 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e3763c197138..f810946b2ace 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -328,7 +328,6 @@ struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_video_codecs;
 struct amdgpu_trap_isa;
-struct amdgpu_trap_obj;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -417,7 +416,6 @@ struct amdgpu_fpriv {
 	struct xarray		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
-	struct amdgpu_trap_obj *trap_obj;
 
 	/* Eviction fence infra */
 	struct amdgpu_eviction_fence_mgr evf_mgr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 47e4680db797..1e23a68b5c5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1499,7 +1499,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		int num_xcc, r;
 
 		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
-		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
+		if (!amdgpu_trap_is_enabled(adev) || !fpriv->vm.trap_obj)
 			return -EOPNOTSUPP;
 		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
 		cwsr_info.ctl_stack_size =
@@ -1641,12 +1641,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
 
-	if (amdgpu_trap_is_enabled(adev)) {
-		r = amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_obj);
-		if (r)
-			dev_dbg(adev->dev, "trap handler not enabled");
-	}
-
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1716,7 +1710,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
-	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index b55b5d016148..02d29e884206 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -327,8 +327,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 	va &= AMDGPU_GMC_HOLE_MASK;
 	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
 	if (r) {
-		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
-			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		*bo_va = NULL;
 		return r;
@@ -336,9 +334,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 
 	r = amdgpu_vm_bo_update(adev, *bo_va, false);
 	if (r) {
-		dev_err(adev->dev,
-			"failed to do page table update of %s region, err=%d\n",
-			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		*bo_va = NULL;
 		return r;
@@ -352,39 +347,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
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
@@ -468,7 +430,8 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
 	if (r) {
-		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
+		amdgpu_vm_bo_del(adev, cwsr->tma_va);
+		cwsr->tma_va = NULL;
 		goto err_tma;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 930b744c5f5f..fe1289abb56c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -43,6 +43,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_trap.h"
 #include "kfd_svm.h"
 
 /**
@@ -2570,6 +2571,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   int32_t xcp_id)
 {
+	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
 	int r, i;
@@ -2578,6 +2580,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 
+	vm->trap_obj = NULL;
+
 	amdgpu_vm_bo_status_init(&vm->kernel);
 	amdgpu_vm_bo_status_init(&vm->always_valid);
 	spin_lock_init(&vm->individual_lock);
@@ -2644,10 +2648,28 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -2753,6 +2775,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
index dd825e179979..d7d5620e2385 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_trap_obj;
 
 /*
  * GPUVM handling
@@ -488,6 +489,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* First-level trap state for this GPUVM; NULL if unavailable. */
+	struct amdgpu_trap_obj *trap_obj;
 };
 
 struct amdgpu_vm_manager {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2150973b947d..1cce81914be9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -138,7 +138,6 @@ static int convert_to_mes_priority(int priority)
 static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
-	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -172,9 +171,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 		queue_input.is_kfd_process = 1;
 		queue_input.is_aql_queue = 1;
 	}
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

