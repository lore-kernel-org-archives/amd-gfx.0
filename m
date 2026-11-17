Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4414B606A333
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jNtN6TNr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97ED610F76D;
	Tue, 17 Nov 2026 14:17:34 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1015410F770
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:17:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUq2vqZ+oPU1Fx1mVwQS5HX1DE3y7CsmQKoMh5KBQtuzp58TBQ9H51M4Ix9VADJsEvHZ2Jy3PVP0KcUadp/8PsxALxD13gOJoTpPgnqIy0ZtaZHwIDw7Zaq462f4WxN/DIYSJ2/bzR6eMdabgaNS39KveMCZQJRNmTw5zweulUhbXYrvfHOPiT+zhBq8JMjZu+bik//Uqj+Lt0eQg2uuzTTtsAFJ7BTIPJcn2l+cTTf+DOkb3HjO2DcaAJSxUG6iZjovzO8vo8yUHU5nBSK2fF+qn31WQCJA2nGSEPGbcajHte9MSb4z0JSlXNxUIMzsVcLFjUoB5mj8LmKPWu1TXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pXhYo+q9g7b+DMQI6cgi+X9FCoraB3pHe2kTndQ4pA=;
 b=fYuPJZgrf31m021hAyO10hOFfNeh3DEaBZRJ6jlb7JKaLyNcfcxR/PpnjrapGhpC99ZeeXRMT3vCfVfQttyiy5X00wxU/eE0AMvLc6PxWtZyPK9pKMw4hMonwBIpuTop4AcBevHpE1mG6rn/5yc4OO41o0uNcVtG2VAGCq90uxRPG56GCIXk0D3yuSNYshtY8yB1RY7I4nfXxLgySPBwM/uhX8orGBzmvcjW8j9q+f/B1ln8RThlHSaoV+IOcPHVGipkj1g8Gn6FsmPJN3gwojjjnp0bEeHkAtSlA86H7JUzcFSPm27cfNpgKyr0478r3ViPftK7oPKA8Wvmpi7qYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pXhYo+q9g7b+DMQI6cgi+X9FCoraB3pHe2kTndQ4pA=;
 b=jNtN6TNr6uwMQvufIUYMReEwPQrjCLhW75v0nqGS2zgJ2uu4gla51q5l26zRXodRdV3r30fvbhVElBgMD9cjZDwedt5V+/4H3I4UUDgndAGP4WrI/5Zy5GYB9cE6Mqqa+5wCfZelOWppPHuwQNbEDXcujSZZh5c8SOcqP7PpCdI=
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:17:20 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::12) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 14:17:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 14:17:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 08:17:12 -0600
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
Subject: [PATCH 2/4] drm/amdgpu: Make first-level trap state GPUVM-owned
Date: Tue, 17 Nov 2026 19:46:47 +0530
Message-ID: <20261117141649.1658444-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117141649.1658444-1-srinivasan.shanmugam@amd.com>
References: <20261117141649.1658444-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 8821278b-a1f7-45cb-cd3c-08df44b57dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|18002099003|6133799003|261009223027099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261022075727099003|261021121427099003|261022105027099003|261026121527099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: b3hQUmft8dxHjYiVVn7cDpRxZNo1N0Qy02ZRTrCYS4OBgJLahwyLSfqWthF8JhfMr2YXovPecadVYRUpbMjPfB2LvvqXCDiwwrigSGHJzBFxfDTcTVPLL7TwSkXKYlaD3XyG32tqTu8xU+/rJr/+N1JdbN59+RifCcuJEGxCudzTSO+bJJBLA47rk8ljZ3R6/coEFGKzYravOE5/XTETyQVw73mcO864DCJG1mkFWeHhr91Bqm+9nPqGhbv/rIo7y1O2uCF4ofxTGdRAZ9jMwTwiF7nhUjq8wxlwhDlUFP0iX+LZFBhNVRC6Q8i+etb6ZwMSU/PU3OQ2JvVjuRftLMmWxxLAB5qgRxc6JscMKxvb7ECIkQxRGYdBl+pVjaz6GUNMOpyMinKxQAUEb8EXMkYKq4+AX52/vxD+G6HszK6jhGSwS476udwzLbH8jjwuaCnwaPUJgS/Rlj0SywjsnMSiGxRkV218MOIpYr/Xw4ZMh2+f+EaKZK6q6QJQKv/yb1h+ERnmTiOToIthJmlHxTGU/PsLwxNXTz+ri6QXNz6jodwpOt1TNSmYM2lt+unuWJRLHb1uUkfyMcOPIGSjCy6z8skIs0V4BjL+oqdt9H7ILbgjD2V5QYKZ4xDX9Xw042Vur8raeOQbcbLCZkYCodiKJJQ9++tDiVQlvp9kEj3sE0RbzK9hxdBmfM2XX7sqD3VcNGNJA1T0SoAEUhABfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /kHQLbdE5RhwsES5SDhaWxmDQK83ckch5uvcjXianOuFWli9ID4d0gZxK2+DZ9rnO7KTuuqgXhUX43Y9aWaSdCG4CmEidZm9r0twSa4opklBOXcEBOsZl0XWudB2PIR26dRyd8E0Na1I4mgVxPfU3ZhGhEYsLKriDcnTqI/nUMSqUp0PFn51hUrSjWVZv5k+CO/MupH920CioojOelObmxFK1HuiGKq5YMdUskt0G6DE5vy/Kp/wrzlTsTO37TiB/n+qo1M3sviPkROHZsnCtcUbtEz6zK6tlrIRdWCRtphVPeCho6KIDZ6cMQo8MmPPzoQTa274dGjk1Xvmer8k12eGOcIs84c8k8WqUjIMUfvFv1bXascu9LDczmCO96O370Of0jvd8uDgXWlYcUfNoXdFw/gj5hP5q/tLYpaQVmueOtGgcasDiq3QCZ4BMzp2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:17:19.8886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8821278b-a1f7-45cb-cd3c-08df44b57dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587
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

