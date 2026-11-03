Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F17606A337
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oXKXYmJd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DB310F315;
	Tue,  3 Nov 2026 02:30:05 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D9B210F315
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 02:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ib2sMRvErQhHhVBeCHPdYup1ZlPNo1rC+yW9U6kq41Y8GcyCEaTuJWaNgUOe6cMXRTnZLvx+UwO0HXmHpJPKsoMlpEQxy4FbVoCC7tz3+jRGFliyPDLM7PD8mAM7nfN7QPjUyw9CiVuLhoBX35wpASubicPcbviV3meqQU7vpdyaQr/otYIfBYm2XCEnYfkw+7RuIJGOVU/GzRo10EXB3eojfWeVFonTn++8d6lhJWng0nR7WYxEDLS030PA4Q9iuophnnQa/L0HUTihEsvRjgCXzMYh9mk1Ya2tRACewonIpjkAHwndmbviZaZcqig5bOykEwLa9kBdG4NxiZGUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rXCA7eRzTR/KrlvZ2fxONn9Huar2UZWyul2At6RpFA=;
 b=LWlH8i3UGFFkuy7Of4V4RySJMdiBCCSOr1oBnmjHhLPH+f6LOYphIXt2+ZvIV18il77gqrysEOG/LDm2AglK8JSoK30CYh6Ypi1FylTQLHLc9BQ7x3VL8HEUHZJmJQflBaRObNXhpoJcsMy4a9xDwGwjgoZNmJA+I6IA9GCz24ll6nq/HD24efHsqg9Z6zo0q+xUOz6U2xRxo2bhs8VlRdB//pPd4nxtT1PDbxC4Hxnpqx54aw+8Y3/tCrAmKDtXJv60V/uopNtQPuYaZDHQqOFmxPrSG2DjBRezTxAywhIq6MnhDFb3qt2sSyZjQlQbmDmiNVwrId9R0DymaxzSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rXCA7eRzTR/KrlvZ2fxONn9Huar2UZWyul2At6RpFA=;
 b=oXKXYmJdsRnVQtHtW6FvHJDBJPZATLLL8Ty57T9Oq8pRrazKxbsOK0xjKr5btejMBhGcjOpmxkhGWqsmM8hWVnLMQXTnaEqsTeuYRGyPfD3uZlOrwyXlNgMIRRqpuhD4xDNhNDOyYnnUuGtrh4w9RT9YLMhKVA3NfLS8xgVPDc8=
Received: from CH2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:610:52::38)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Tue, 3 Nov 2026 02:29:52 +0000
Received: from CH01EPF000BE940.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::90) by CH2PR04CA0028.outlook.office365.com
 (2603:10b6:610:52::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 02:29:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE940.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 02:29:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 2 Nov 2026 20:29:49 -0600
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
Subject: [PATCH v3 5/7] drm/amdgpu: Make first-level trap state GPUVM-owned
Date: Tue, 3 Nov 2026 07:59:22 +0530
Message-ID: <20261103022924.1495748-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103022924.1495748-1-srinivasan.shanmugam@amd.com>
References: <20261103022924.1495748-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE940:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 299a8e87-7a0b-479b-c232-08df3952577e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|10067099003|261102123227099003|22082099003|18002099003|56012099006|11063799006|261022075727099003|261026121527099003|261021121427099003|261026140227099003|261022105027099003|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: EpAKNDDGQGx9l/JT+DlPgBIOvSPvbJ7tR8bo0GvrhOYDmfoCxZ84NsUFn7iWjsBKMsVtUmZNfrxQMhT8cIqQfPCiCEVAMc0rLu1H902bTTf/NTCbo3ICyPBo2WWsR7zt+Eh2h51RxKt8KAmjpNnvTA1RjwML6dLAjW7CWgeJZqkzt1q916ZJ/AjLDDmCuq1oiZ1Mmrj92OdTHxUf76QW8a/t41m/1TKgElC6Mxy52/8xiRfELmRyMwJeKkACXdaeRvi8iAVdWsWOoOW5Jvt9dkR5cLfujdOeyHELQgsGGoiZEOImTR6VvYXwxVILZ2JKz5GDB90++Ns7M1ILOI+NIPBUbKlhtw0Bu94eB+Swrota6QwlYWAlOu7nBsg3sfBUm1LjeSJekqXgMiZUvzfjyY20sCL77kTk3E8gBmha2rErcrdzfsJrbhhLT53KZ0bBClysBcs2B/46Qfimp39hOdPlXH6rEfF3wEwhDCMsU1V6NivvilPSaCDbtotB/hkW45+cgJ+iU/Dl42d4n4g3v8Zwz6EV7Bh9AYzhWZNMQ+Ns0zwoTzYtc9ECJLAL1rLbqy5y2eqi3X9S0uIhYg3vO2POViFGb6vZldiOyEa6+vbqnZwrMWUOtkF/j+gKiNQWqKJAcSJ/Gg+Nua2EOifaXvqDBCtpmUOZ9yb4RBN34T1hOODTv20mjydOeYMMqkS7xFmLqo6e1rl+p8MVBRFc7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(261102123227099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rTo0Bp3gTs+7Y9SK+n0HxIUmuBKTrQYcmyllFZQ/IrJWBBRCp5NOhHET7p8DyxgUSW6kvK7UKYJN5euDHj9a9YuVR4mqJdirhMtH9zmK08OujEoSmQ7zAtA25Kqeb11gkSiLLaxVa9CN3B2CvLjBjwoCW3bHk+CxTtzZEQ8qJ3BKpIIpz2VF0XEJT1V2ibhMBkpKhoyAnC0rdtOX+mGEZTG1xs5lCRSGu0SbZtE2ScnBaVGUjhILKTCX15Qjgh1e8v+ID3miYHpD5Gmnyz28x/6Xpv4ySfMeqysFrZpF24EP9Ngf3SRrnTROdmWuQJ9hfXlXbnbCEJ1MRmhziJzHDSjqQtWBygNfK17JnZDK23mPzycJNXzsOyT2bDtS8Q1hJaWtaYQ2jHmO0CWdlsh/kVI7OQlVZtEhx6ZKIp8EFjUVeeDlPYgd6Wr/H8e7dDqo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:29:52.7361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 299a8e87-7a0b-479b-c232-08df3952577e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE940.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 62 +++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ++
 2 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 65974c0e7a16..188b7ac347a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -45,6 +45,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_trap.h"
 #include "kfd_svm.h"
 
 /**
@@ -2636,6 +2637,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   int32_t xcp_id)
 {
+	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
 	int r, i;
@@ -2644,6 +2646,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 
+	vm->trap_obj = NULL;
+
 	amdgpu_vm_bo_status_init(&vm->kernel);
 	amdgpu_vm_bo_status_init(&vm->always_valid);
 	spin_lock_init(&vm->individual_lock);
@@ -2710,10 +2714,28 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -2858,22 +2880,39 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
@@ -2885,16 +2924,18 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
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
@@ -2903,9 +2944,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	dma_fence_put(vm->last_update);
 
-	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		amdgpu_vmid_free_spm(adev, vm, i);
-	}
 
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
 
@@ -2914,14 +2954,16 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
-- 
2.34.1

