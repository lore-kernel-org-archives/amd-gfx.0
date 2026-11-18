Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E59606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3O68eXl0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4731410E76C;
	Wed, 18 Nov 2026 08:05:49 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1060210E76C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 08:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0GxiIdqFVN9aFWNa6H09twkbQXKDViTSPtMLtibZAAa43yXqtnjJUM7SHDCMgRuTlcPdegO3eUoqxdu8dqfDZNF0K4ZHcCuzUjrwtI8F4i5BAi/iBdxh0jwVRmIo27Qn8qLEpfUWmlWI46zteNwlol0CoU6fOTz3shNr8Uakl7m0LIcxi1z3f776LL7DnTWGIwNxgeebBqAWtKAnYMHdxJRjMBLIGwBlGXsupwlEccgw+a9Sn6eiH7ZMzNEtVbOr1jJ1f2nVko3q8WpoC1ZVmq7YuigHm4sHF1pZo7IIeg2cQ0tmR730eobgKnoeWacv4kFst4Hmy7eLtxSBPm2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pXhYo+q9g7b+DMQI6cgi+X9FCoraB3pHe2kTndQ4pA=;
 b=E8L4YVR2vVH4l9GjTquip4BbERTseYbhQSrF4yOpFtB7S277w3rPapFhXUw0Wvm5lwgBljGw42neRwIKbcDGagKoEZwg7o9V0Ghfg7EXP2B5FQuVQBqoVQTvHalM0KOZ4Juta43o02VPilJo6SuTbU9T7dJOkqbLrXVDO5Pk08c6Welx1bEev1NueFLCGKTpWVrs7eoVIZ6XRBc0wG+E0wD8W2VpYJ8cLuWYi6RTxZuHXQxgjzZILyUepZlmTSWNHZHuGIPsnIPh1ZXDtuBVJ2uHKwZWFecbmUHbFh2JS7GKbW3yoRS1ATum+DeoOrO4MmRDz1IvRPJGNXGbINll1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pXhYo+q9g7b+DMQI6cgi+X9FCoraB3pHe2kTndQ4pA=;
 b=3O68eXl0Js44sLUiGQO1SBn3iNhlbOFdchcRLESBlZrRdz9PKiwO6/OSQEoQwFZiI7z7eP8Bfgri+JjQH4IqnPqgCGHzRusOrtqaG38v0jNMn4dqLu7A3CQV+PFK2TFEc+ePR+Fr8G5X9RTkJMAjcl+fA/Jz5i9W38dbfHW2RMU=
Received: from BY5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:1d0::35)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 08:05:38 +0000
Received: from CO1PEPF00018864.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::5a) by BY5PR04CA0025.outlook.office365.com
 (2603:10b6:a03:1d0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 18
 Nov 2026 08:05:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018864.mail.protection.outlook.com (10.167.249.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 08:05:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 18 Nov 2026 02:05:34 -0600
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
Subject: [PATCH v6 2/4] drm/amdgpu: Make first-level trap state GPUVM-owned
Date: Wed, 18 Nov 2026 13:35:11 +0530
Message-ID: <20261118080513.1677783-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118080513.1677783-1-srinivasan.shanmugam@amd.com>
References: <20261118080513.1677783-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018864:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 991ddb5b-7faa-424f-4baa-08df454abb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|6133799003|11063799006|56012099006|261022075727099003|261028144727099003|261021121427099003|10067099003|261021123027099003|261009223027099003|261102123227099003|261026140227099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: U3f3u7hnjXFsi9coCmCVPuQkxAhYPPJ0hICvmRbWkswI1Ymdde+FyTR1h/mhkuUTBcw/5lETJDprqUsy1SPoZH/pMGWyhFOzpiodzqXQsDs47fQDt9HaPXty9Bzqwl2GZh9v2y26pPJN5Ilj8ElVWOOd7DDRjDQbi4KyRojJE9cRMyD/PMHRzn7Ih3m5UWnyE/enN+OiG1q8zOjtx3t9VXz9W3ri32WWde8yPSEWkb6mNOCaZgYkNxLOUwvr5aHctbQFthQJ+fbXSG9efwhnXTVkEmTgVYQpmY3E2Fbv57OBLHuUbAn83p0YjjZYw2neXDGhHGIZxv6RFZwmo16WZT0IwY+fZh2yetdQh1x7vHWx5vqN/5loCIlQeu9b58eTxsP6r7WATcEV0dZxaZayuyak7LhauaXbGewg9LFk4lqHjuzzdze1eX2OK/2qylIE1Tn1Kxtb8DKTJGdIwpxcqvFhzkwWioyCSkNHyCVHYVI7jE2CLbrKqAzReuLOG+yw5r6i679FOXuNtCXxQxLwue8WMrVQrCqR17x4qTJ+R/cya4X1s0SdIzWL4yqV2NN2o3cQTQznIiQqNkeHWKxpWemLpnGZJYtArkC6nfq9vcXFUBGKgnYaHn/2NW7IqzlJR+k2fVMRSliw4RXMccX3ywYR+NNr+7X0vQPATA4o9o4jt8nj8zRUGa9jIttd9PAFQx3Ju9Oyd8NSSvCqRKTsGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(261022075727099003)(261028144727099003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CHVYtSekufVoG4HYcADN6vQJ2YcPp7NxgYmIX4wfJ1rZcHNCPPfr8SyERfTyTBrQm+eWaWv2/FqiBt723ixCEbvWh1tSDCh5CdvJXDAfh0zGSwQiHe6X5ylVHvlR03WfXNV+aOrw2c0PHL/eIwcUUu+wjI1LW3TqVQavMuZMkcEhepylZEg9GAncof3Tg7hS9jUqHnh9mlBBFE1Ga0nz62+grNBOA24fiEyFOg1Bjt3RxVnIYVq8/U/g1hXJ3zzk2MzRiIK4OBU73EkA0cCZaRQGfRp8NeEKqKRZ6tOmCVWsR4n+Hso/ELhmhwsJipw9oM062te4m23aAIGdHGm5+u2EsrcbC/A7f+8KBwcmQcpSDAdajqwjcGIEmhhDFAyScu8Xq9+6HUIb3J96P5kOouxF6Jye77/Au+db9aQvseGicfsY+qu6JpYIAyhlmjJT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 08:05:37.9221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991ddb5b-7faa-424f-4baa-08df454abb2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018864.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 62 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  6 +--
 4 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 201c167577c6..bc623eeee4bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1460,7 +1460,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		int num_xcc, r;
 
 		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
-		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
+		if (!amdgpu_trap_is_enabled(adev) || !fpriv->vm.trap_obj)
 			return -EOPNOTSUPP;
 		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
 		cwsr_info.ctl_stack_size =
@@ -1604,12 +1604,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
 
-	r = amdgpu_trap_alloc(adev,
-			      &fpriv->vm,
-			      &fpriv->trap_obj);
-	if (r == -EOPNOTSUPP)
-		r = 0;
-
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1679,7 +1673,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
-	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2ba33212d507..eafd4367d3b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -45,6 +45,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_trap.h"
 #include "kfd_svm.h"
 
 /**
@@ -2644,6 +2645,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   int32_t xcp_id)
 {
+	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
 	int r, i;
@@ -2652,6 +2654,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 
+	vm->trap_obj = NULL;
+
 	amdgpu_vm_bo_status_init(&vm->kernel);
 	amdgpu_vm_bo_status_init(&vm->always_valid);
 	spin_lock_init(&vm->individual_lock);
@@ -2718,10 +2722,28 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -2866,22 +2888,39 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
+
 	/* Wait for the jobs which might still use the reserved VMID */
 	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
-		dma_resv_wait_timeout(root->tbo.base.resv, DMA_RESV_USAGE_READ,
-				      false, MAX_SCHEDULE_TIMEOUT);
+		dma_resv_wait_timeout(root->tbo.base.resv,
+				      DMA_RESV_USAGE_READ,
+				      false,
+				      MAX_SCHEDULE_TIMEOUT);
+
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
+
 	dma_fence_wait(vm->last_tlb_flush, false);
+
 	/* Make sure that all fence callbacks have completed */
 	dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
 	dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);
+
 	dma_fence_put(vm->last_tlb_flush);
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
-		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
+		if (mapping->flags & AMDGPU_VM_PAGE_PRT &&
+		    prt_fini_needed) {
 			amdgpu_vm_prt_fini(adev, vm);
 			prt_fini_needed = false;
 		}
@@ -2893,16 +2932,18 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(root);
 	amdgpu_bo_unref(&root);
+
 	WARN_ON(vm->root.bo);
 
 	amdgpu_vm_fini_entities(vm);
 
-	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
+	if (!RB_EMPTY_ROOT(&vm->va.rb_root))
 		dev_err(adev->dev, "still active bo inside vm\n");
-	}
+
 	rbtree_postorder_for_each_entry_safe(mapping, tmp,
 					     &vm->va.rb_root, rb) {
-		/* Don't remove the mapping here, we don't want to trigger a
+		/*
+		 * Don't remove the mapping here, we don't want to trigger a
 		 * rebalance and the tree is about to be destroyed anyway.
 		 */
 		list_del(&mapping->list);
@@ -2911,9 +2952,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	dma_fence_put(vm->last_update);
 
-	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		amdgpu_vmid_free_spm(adev, vm, i);
-	}
 
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
 
@@ -2922,14 +2962,16 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 		dev_warn(adev->dev,
 			 "VM memory stats for proc %s(%d) task %s(%d) is non-zero when fini\n",
-			 ti->process_name, ti->task.pid, ti->task.comm, ti->tgid);
+			 ti->process_name, ti->task.pid,
+			 ti->task.comm, ti->tgid);
 	}
 
 	if (vm->task_info && vm->task_info->task.pid) {
 		int major, minor;
 
 		amdgpu_vm_render_devt(adev, &major, &minor);
-		trace_amdgpu_deregister_pid(vm->task_info->task.pid, major, minor);
+		trace_amdgpu_deregister_pid(vm->task_info->task.pid,
+					    major, minor);
 	}
 
 	amdgpu_vm_put_task_info(vm->task_info);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d8e17f493f61..3201397eeec5 100644
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
index a80d4dba758e..c77128acdcfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -153,9 +153,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
-	if (fpriv->trap_obj) {
-		queue_input.tba_addr = fpriv->trap_obj->tba_gpu_va_addr;
-		queue_input.tma_addr = fpriv->trap_obj->tma_gpu_va_addr;
+	if (fpriv->vm.trap_obj) {
+		queue_input.tba_addr = fpriv->vm.trap_obj->tba_gpu_va_addr;
+		queue_input.tma_addr = fpriv->vm.trap_obj->tma_gpu_va_addr;
 		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
 	}
 
-- 
2.34.1

