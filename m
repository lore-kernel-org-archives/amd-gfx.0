Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6D3606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 04:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mCjevdRI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F1410E108;
	Tue, 24 Nov 2026 04:46:18 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933B610E108
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 04:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smO26jkfojskGtTaMLYH+bwgoSqoXRdu566um+UR/EY6tPFUpxxg4zGpPFv8MyVOP7b4U402EAS0OiUCyXwMwZRYFF90+mFoHZk1O1hQ6dG+eGXsIevZZCydwYp7W7FAeaCh92TpKcNxO2geQi15f82VvKVO6TMEJ+DBpNHIaX9K0vAkvObrE48nFm0PfjGWM+7yT1TUA7PkHMXmPMp2qyDd6jUDH7eSQgyzkSAAFjNZKgNFGKevJsH5nC0Hem2WcAzCXJ4BMgneseMVJGs36d3DpNTvSpg8S5KTsdRQcELaCyKYtgPU0d2qr6Pf/PFLLEqfciqplmWtQfVCL4GzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2gyulYjl8fOW3DyEyERod5P263z7wLSNFSqqJyobPk=;
 b=epkCEOVgDIwSBKj0/AflbzjDojhIrkoVVQqzws8hLkDxUoR+cO6In86lLPuofbVx2MkOcaHepRM7xNvNhzf62LciJXziO0IpzltRlIweInnM3nXY9e9mi47iPJg84otR/VVVylJbzUOTKqMsmhLr5oHe5xHHxjhhlL2OvGmdjtdj3Av206BK5hTLHbkdU7DIPI22OkJOaxBavcAqRXcbhi4kf8ETXxh28za5LUC6YUn1xvcPNLUKyGtLeL4WE8rEViQJTR0KcCTfVc7K2ucgruqoG2QZjwOH51DZPUeFSPNsxCxISTNvT9TPAolYd+fsd7bY/ixwBUF0u95ReLq1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2gyulYjl8fOW3DyEyERod5P263z7wLSNFSqqJyobPk=;
 b=mCjevdRITGG6TqZ/GqE3z8HgYfBgyBu6BJ3VLD553TC8SJeCeTPgu5+bKLsf1vTOup5dT6HsvquwYwRJVdTC2zeyxat0occOg0uK1QNWiM0VRoCe8/brjd4mI3jrVIjPNQUti0l7naSYsrJmLzmJRUJRsDUjc+DtNSrN/ngWYMo=
Received: from BN1PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:e1::34)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 04:46:08 +0000
Received: from BN3PEPF00022BD9.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::6c) by BN1PR12CA0029.outlook.office365.com
 (2603:10b6:408:e1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 04:46:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD9.mail.protection.outlook.com (10.167.248.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 04:46:08 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 22:46:06 -0600
From: chong li <chongli2@amd.com>
To: <christian.koenig@amd.com>, <timur.kristof@gmail.com>
CC: <amd-gfx@lists.freedesktop.org>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: track finished page table updates with a fence
 chain
Date: Tue, 24 Nov 2026 12:45:44 +0800
Message-ID: <20261124044544.3561866-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD9:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: bb24bfbc-c89a-4bbb-5111-08df49e5db1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|18002099003|3023799007|261028144727099003|11063799006|56012099006|5023799004|261022075727099003|261009223027099003|261022105027099003|261026140227099003|261021123027099003|261021121427099003|261009221227099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: PYkDJq80QIZk7SmfBLYsMd6OBkURBQCLJvFxIjdgPxwH/1UIxxB6bQSq9j6wozqLkeXrkuWA/UCkN3Jk6XJO3M+YBv2kB9GPBysnKbNfn0MLBuYQoFVbNJ0gdyUXT/APoWGAYS/D7wlYuPisV+KtLtePcbEhhmNjJyMLfGehxSmSYMAr/UR8shQNG+zt/eqggHA3RvejEtAliODUTvkGosQ3PirkRiFaGoTw0nPUdjw+VnJ+2zxARce3i9nOQix5gYk1jHpqwc+/vJrbvWRaADavclgHG4IobjLUhDOmzE5KrSFcqVCG3WZ2H7LsqJw/PlE1bXsEcIv6t+Yo4fH9Gz2J6dFe4BpIj7hFu2MC/+7xxj9imrgtsTbPTjD+zmwUsDQQ7THdORG+tgtp26Ll9y58bRNEpr42dR0hoY1KLn4/OKEqCsLZTPL7/aSJDoFsY1K7ZLz2QTwTQOn94C+mB1P0JbxvN/c+q01EN5+JeE0/xmj10Zn/+P45MU5W0DeEF6IK+Wb2Gf/xSzHlReyi4G15cjim5yBR5Qulo/Q1T463yvi1Jzebcy6bqRkMYkr572QijjP6uob4Yww06c2T3+w/1nXBm9tHG+eoCMt9NZB2KS00y9vU6/9rQVR2uh7adENBxCz0p43OkHY4cc8mEk3bbLqHYcMtUMg9NoYPMwkx8bXPplgQ+BGZOsD9vS2UVoSGjGTGYhlFsKTFyPB02g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(18002099003)(3023799007)(261028144727099003)(11063799006)(56012099006)(5023799004)(261022075727099003)(261009223027099003)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009221227099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N8kUHJ1i+ufIWcqCZCB/0DoEB5PZu7l94XHJ9Eg7xCf10Non90Pbqt7YrFmPXBVRbJaue3G/zj3JsorcX2Q0ICXZS0zwIdbpPOte05cws3jx+UDVbWnvHKniHAh2C7oMolvszdBmV6P/OETdkyRQQmjd3/+dIDWJM5tvs+2sNFwxCihwiTeigXuhUMvFRj2sScu8fNRE+wccQVbuQYNNRYYcnhqfAzOCFugGCuXd2L/29uUQ/CXKBbN2jXI4f7U21uoaDNTLtPesxI1a0s58vN96GB7AcH/UYpvxmydUfOtDQSySrgJhVW9iZUzvxBXGw0NDXPeMTSC2Ez8GjQ8ZTXyuAPpCsjpZS8/BTPbjjZGmlRRWK6YgxetC9z15amFaxZnqYgVRWH47aBjw0Bbq1Wc5L+qdIBH31p15mhkkDYZ299i61Y7KnsALKMXQASRO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 04:46:08.2071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb24bfbc-c89a-4bbb-5111-08df49e5db1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981
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

amdgpu_vm_tlb_seq() waits for the tlb_seq callback of a page table update
by taking the lock of vm->last_seq_flush. But every fence has its own
lock, and a newer update replaces vm->last_seq_flush without waiting for
the callbacks of older updates. A job scheduled after an older fence has
signaled, but before its callback has finished, takes the lock of the
newer fence, misses the tlb_seq increment and can reuse a VMID without
flushing the TLB after the page table update it waited for.

how to fix:
Stop incrementing tlb_seq from a fence callback. Put the fences of the
updates which need a TLB flush into a dma_fence_chain and let
amdgpu_vm_tlb_seq() add the number of updates which have signaled. A
dependent job then sees the sequence change together with the signaled
bit of the fence it waited for. The chain nodes are numbered
consecutively. The number of the newest node minus the number of
unsignaled nodes therefore also counts the signaled nodes which were
already pruned, in any completion order. Nothing references the VM from
a fence callback any more, so amdgpu_vm_fini() no longer needs to wait
for vm->last_seq_flush.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 77 +++++++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 31 ++++++-----
 2 files changed, 38 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a627a3092990..dafcebd95555 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -114,21 +114,6 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
-/**
- * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
- */
-struct amdgpu_vm_tlb_seq_struct {
-	/**
-	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
-	 */
-	struct amdgpu_vm *vm;
-
-	/**
-	 * @cb: callback
-	 */
-	struct dma_fence_cb cb;
-};
-
 /**
  * amdgpu_vm_assert_locked - check if VM is correctly locked
  * @vm: the VM which schould be tested
@@ -1089,47 +1074,33 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	return r;
 }
 
-/**
- * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
- * @fence: unused
- * @cb: the callback structure
- *
- * Increments the tlb sequence to make sure that future CS execute a VM flush.
- */
-static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
-				 struct dma_fence_cb *cb)
-{
-	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
-
-	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
-	atomic64_inc(&tlb_cb->vm->tlb_seq);
-	kfree(tlb_cb);
-}
-
 /**
  * amdgpu_vm_tlb_flush - prepare TLB flush
  *
  * @params: parameters for update
  * @fence: input fence to sync TLB flush with
- * @tlb_cb: the callback structure
+ * @chain: preallocated chain node to track the update with
  *
  * Increments the tlb sequence to make sure that future CS execute a VM flush.
  */
 static void
 amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 		    struct dma_fence *fence,
-		    struct amdgpu_vm_tlb_seq_struct *tlb_cb)
+		    struct dma_fence_chain *chain)
 {
 	struct amdgpu_vm *vm = params->vm;
+	struct dma_fence *prev, *iter;
 
-	tlb_cb->vm = vm;
-	if (fence && !dma_fence_add_callback(fence, &tlb_cb->cb,
-					     amdgpu_vm_tlb_seq_cb)) {
-		dma_fence_put(vm->last_seq_flush);
-		vm->last_seq_flush = dma_fence_get(fence);
-	} else {
-		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
-	}
+	/* The reference of vm->last_seq_flush to prev moves into the chain */
+	prev = rcu_dereference_protected(vm->last_seq_flush,
+					 lockdep_is_held(&vm->eviction_lock));
+	dma_fence_chain_init(chain, prev,
+			     fence ? dma_fence_get(fence) : dma_fence_get_stub(),
+			     prev ? prev->seqno + 1 : 1);
+	rcu_assign_pointer(vm->last_seq_flush, &chain->base);
+
+	/* Prune signaled nodes, not every VM reads the sequence */
+	dma_fence_chain_for_each(iter, &chain->base);
 
 	/* Prepare a TLB flush fence to be attached to PTs */
 	/* The check for need_tlb_fence should be dropped once we
@@ -1177,7 +1148,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
 			   struct dma_fence **fence)
 {
-	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
+	struct dma_fence_chain *chain;
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_res_cursor cursor;
 	int r, idx;
@@ -1185,8 +1156,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
-	tlb_cb = kmalloc_obj(*tlb_cb);
-	if (!tlb_cb) {
+	chain = dma_fence_chain_alloc();
+	if (!chain) {
 		drm_dev_exit(idx);
 		return -ENOMEM;
 	}
@@ -1291,14 +1262,14 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error_free;
 
 	if (params.needs_flush) {
-		amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
-		tlb_cb = NULL;
+		amdgpu_vm_tlb_flush(&params, *fence, chain);
+		chain = NULL;
 	}
 
 	amdgpu_vm_pt_free_list(adev, &params);
 
 error_free:
-	kfree(tlb_cb);
+	dma_fence_chain_free(chain);
 	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
@@ -2685,7 +2656,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
-	vm->last_seq_flush = dma_fence_get_stub();
+	RCU_INIT_POINTER(vm->last_seq_flush, NULL);
 	vm->last_tlb_inv = dma_fence_get_stub();
 	vm->generation = amdgpu_vm_generation(adev, NULL);
 
@@ -2730,7 +2701,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free_delayed:
 	dma_fence_put(vm->last_update);
-	dma_fence_put(vm->last_seq_flush);
 	dma_fence_put(vm->last_tlb_inv);
 	dma_fence_put(vm->last_unlocked);
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
@@ -2863,7 +2833,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
 	struct amdgpu_bo *root;
-	unsigned long flags;
 	int i;
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
@@ -2876,11 +2845,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 				      false, MAX_SCHEDULE_TIMEOUT);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
-	dma_fence_wait(vm->last_seq_flush, false);
-	/* Make sure that all fence callbacks have completed */
-	dma_fence_lock_irqsave(vm->last_seq_flush, flags);
-	dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
-	dma_fence_put(vm->last_seq_flush);
+	dma_fence_put(rcu_dereference_protected(vm->last_seq_flush, true));
 	dma_fence_put(vm->last_tlb_inv);
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f6285a9d9e98..6142a86a8b80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -24,6 +24,7 @@
 #ifndef __AMDGPU_VM_H__
 #define __AMDGPU_VM_H__
 
+#include <linux/dma-fence-chain.h>
 #include <linux/idr.h>
 #include <linux/kfifo.h>
 #include <linux/rbtree.h>
@@ -330,7 +331,7 @@ struct amdgpu_vm {
 
 	/* Last TLB seq/fence */
 	atomic64_t		tlb_seq;
-	struct dma_fence	*last_seq_flush;
+	struct dma_fence __rcu	*last_seq_flush;
 	atomic64_t		kfd_last_flushed_seq;
 	uint64_t		tlb_fence_context;
 	struct dma_fence	*last_tlb_inv;
@@ -554,22 +555,24 @@ bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo);
  */
 static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
 {
-	unsigned long flags;
-	spinlock_t *lock;
+	u64 seq = atomic64_read(&vm->tlb_seq);
+	struct dma_fence *head, *iter;
 
-	/*
-	 * Workaround to stop racing between the fence signaling and handling
-	 * the cb. The lock is static after initially setting it up, just make
-	 * sure that the dma_fence structure isn't freed up.
-	 */
 	rcu_read_lock();
-	lock = dma_fence_spinlock(vm->last_seq_flush);
+	head = dma_fence_get_rcu_safe(&vm->last_seq_flush);
 	rcu_read_unlock();
-
-	spin_lock_irqsave(lock, flags);
-	spin_unlock_irqrestore(lock, flags);
-
-	return atomic64_read(&vm->tlb_seq);
+	if (!head)
+		return seq;
+
+	/* Add the updates in the chain which have finished, in any order */
+	seq += head->seqno;
+	dma_fence_chain_for_each(iter, head) {
+		if (!dma_fence_is_signaled(dma_fence_chain_contained(iter)))
+			--seq;
+	}
+	dma_fence_put(head);
+
+	return seq;
 }
 
 void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
-- 
2.48.1

