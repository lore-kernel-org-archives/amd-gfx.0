Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38198C61DE1
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Aug 2026 15:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C118F10E556;
	Sun, 30 Aug 2026 15:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kg4dHxa9";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A06810E221
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Aug 2026 15:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRI+kqpcqzifh82XHP48HHHSp9GIcKtlIZJmW8ruZHBb0ynxKey4AuirlGaz28UILnDh9VOvG84Kx48rSjWCgreayKRbqm4TQhgBCUOV9pfX7ZeZLvF+GFcWbg87fdpb7fdO8F3P7eirj5Eq7Vznq8sgdw1NMIO6RPioamUityzkWDKIktQr2ShZuO1nOgkqg/sZ1W4RcRDSdHJVJfyNQa16egQH/21ya1JiAe2BykQlitWSqJ4ucfVz71bFRCZuk3zpqzpuZF/zuxj0JGPoweVeCuQv0N5PI6lTowbx4rGNYBXkG78aSzoLDxSVbtyalLR2EJvAfdjuUHRiwzZmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K18zoEz+cJVrRfWA/yiHwhqMtwO0TYhhgWDtLQ92bY=;
 b=bUZNuAm1gmyLTDaIZJhiN5Wxi0egJmqinjxExgsiYolNy4go7hf9Cc+Jr9AkB/vuSmBqm4tQ++i+yC6ogjRS3WqW1rBkFkKZQbWrWjWsaG762ruukJm2sUOUXonA1Y/8laoYX7rd1l3vWygiLl5rgk3ZLfhXEaNO0kwAO+4lOv66A131a0x3Ge7fkI1kkSa4PYZyZbobDj7Q4NNPncoWYbOaDjzaCONgWPlUyTPaNWDofTY1XPIfkejwDV5R3B2gieUlAZdWB5N0s7/4nCjF30XVLs1VFtvWj9byKgWttujQvHlDnjiY3Ipmsj1rq55xhi4GlPVHFw3IcEgnFbbJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K18zoEz+cJVrRfWA/yiHwhqMtwO0TYhhgWDtLQ92bY=;
 b=Kg4dHxa9cUS//OBs20bBUh5yHbfBAV4D4HHP2eHmO6GCbXBkY1u+oyVBA++LcEEG2BcXYtX41HC1kP3soPtpMRwbE4pQV3vpzQjIlKlsXWXy5XWjV3+ZclttdyduocSiMY/kuDbLlHqYb9FEVxmBdzvCkDThov/PLOHun8O3aIk=
Received: from DS7PR03CA0124.namprd03.prod.outlook.com (2603:10b6:5:3b4::9) by
 DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Sun, 30 Aug 2026 15:40:57 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::9b) by DS7PR03CA0124.outlook.office365.com
 (2603:10b6:5:3b4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 15:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 15:40:57 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 10:40:53 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <timur.kristof@gmail.com>, <natalie.vock@gmx.de>
CC: <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC PATCH 3/3] drm/amdgpu: use drm_gpusvm notifier lock for VM
 eviction
Date: Sun, 30 Aug 2026 23:40:27 +0800
Message-ID: <86be4118d42360f1abdd119e241158643fe92594.1788103444.git.honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788103444.git.honghuan@amd.com>
References: <cover.1788103444.git.honghuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 878e4789-2b0d-4d9e-9ee4-08df06ad15ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|18002099003|11062099010|22082099003|56012099006|7136999003|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: FDIShW7ynkunSf0XV45XL9kz1IvdCQxM+PU+MvhVwluFVtdjO25rJWh61A+0A5Il+VZNktLsl9038N7aHK4zc8pl1DBV543O0xWkM59eKOI6LPshePSqc6Cqc+sbG5HwY67Y+WCXqOrNa0MNwUhlOIzLHbyRO6lUSv1mMigbmvAL+OJVUlmJqaaeZkcF9LfXFv+UWUwndgmdZwbKgr/HswnbGLNtCRw1ASD4xSmumUZiRG1n4RgU0VES7jBWP0AF666yHRWlzTlEVmDUgU3rI5+0LGKURk0H9LPV9y3b8qspTFYYUNgfYTYo7vTLUhq/rdCLTtXPSL0AP7wCa8R7lWfj49Q8cD/9xQzFEKtrm+FHPGvU5RA3xc4oQ6Fn5bbj6BgeM2DoUNhpWpwaSRnCfff/X1l+ZVxtAaG9VXEIb2NEMjNvkse/ILKLKatTkXW2dkvoOZCDRnFC9fGsf5ErLOfDhWqgPr0nmSmBorsi4MxTLYK68SLEErZL+QIyD6q2Tw5nRm4USEVFPMnf88ggZhmlm+hkpL7UYl9GpPR443vXsPB6M+xfUsRK5Xj7gDYGW8oVQt9XjCfrAaFnjfLSDptJIiMw0pL/El2FFVGTjJmsScYA/sOn6wrXTPyUCirMaJWtEqJMzaB9DNZMR8SPMMxa3e2l3ASD/2O964MnuVH+SYvb8s4FHpHKq3vtZIj1E2we0woa9jEaFb8RULSjxmjH9CmFhg9ebj7XOwiOIbJHBTbhROLtFdYWN+6FO7Zs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(18002099003)(11062099010)(22082099003)(56012099006)(7136999003)(11063799006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kSafwwL2FtyiddBAV8yui5hc1bk4b8emyXFC++TnhOitrIjYfgZzvi2yI+9+ZALvNrHy8NWsbokToUIm5HnbP3cwMNVpOYUBHa8Y30a5ngUAa6BvMj+1LsCWm3XKheludirQlupnRvdbh9+E7wsKWVWPxsvxdVy906MwSXNPRJcwLJRgil+0fy1ZOLe3rDP4o6/JuuMG1vH1c3JRY6o2i/YQUH58oDukbUzfoBcL/a2Pem8thMbGv+EONV/s5I6YPMZI+/s+DlpUEdr0NWo6Pl/rF/mMCMD6+6XTf5xG5Vnd4uM4IGS/mZqkfBr1WyjFLgr3soF0Y+Rl0jQmojyhOKIb+nqrlUchafAWwYGYz++UzaL01fWWA5eQnDgsB26Q33dJ2VWby02iOdFLnk8yTXxVzxz7YfML0diSWk8gaR63yXY/OVMRTy/TlOzXT54c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:40:57.2042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 878e4789-2b0d-4d9e-9ee4-08df06ad15ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
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

From: Honglei Huang <honghuan@amd.com>

SVM mapping updates, MMU notifier unmaps and VM eviction need to use the
same lock. Separate locks cannot guarantee the order of GPU page table
updates when CPU mappings are invalidated concurrently.

Point vm->eviction_lock at the drm_gpusvm notifier rwsem for SVM VMs.
Hold the read side across range validation, PTE and PDE updates, and
mapping publication. Use the write side for MMU notifier invalidation,
attribute PTE zaps and VM eviction.

Publish the selected lock before making vm->svm visible. During
teardown, reserve the root BO and remove the MMU notifiers while the
alias is still valid, then restore the default lock before releasing the
SVM context.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 37 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 53 ++++++++-----------
 2 files changed, 50 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index c0db597b1e..fcbe23cf7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -157,10 +157,13 @@ amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev, uint32_t pasid)
 	amdgpu_pasid_lock(&irqflags);
 	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
 	vm = fpriv ? &fpriv->vm : NULL;
-	if (vm && vm->svm) {
-		svm = vm->svm;
+	/*
+	 * eviction_lock changes when SVM is enabled, so acquire vm->svm
+	 * after the new lock alias is published.
+	 */
+	svm = vm ? smp_load_acquire(&vm->svm) : NULL;
+	if (svm)
 		kref_get(&svm->refcount);
-	}
 	amdgpu_pasid_unlock(irqflags);
 
 	return svm;
@@ -488,6 +491,8 @@ static int amdgpu_svm_init_compute(struct amdgpu_device *adev,
 	struct amdgpu_svm *svm;
 	int ret;
 
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
 	if (vm->svm)
 		return 0;
 
@@ -522,7 +527,9 @@ static int amdgpu_svm_init_compute(struct amdgpu_device *adev,
 	       1UL << (svm->default_granularity + PAGE_SHIFT),
 	       svm->xnack_enabled ? "enabled" : "disabled");
 
-	vm->svm = svm;
+	vm->eviction_lock = &svm->gpusvm.notifier_lock;
+	/* Publish the context after its notifier lock alias. */
+	smp_store_release(&vm->svm, svm);
 	return 0;
 
 err_free:
@@ -598,31 +605,43 @@ void amdgpu_svm_close(struct amdgpu_vm *vm)
  * amdgpu_svm_fini() - Finalize and release a VM's SVM context
  * @vm: The VM whose SVM context is being torn down.
  *
- * Close the context, tear down the embedded drm_gpusvm under the SVM lock,
- * destroy the attribute tree and work queues, and drop the context
- * reference. Safe to call on a VM without an SVM context.
+ * Tear down the embedded drm_gpusvm, attribute tree and work queues, and drop
+ * the context reference.
  */
 void amdgpu_svm_fini(struct amdgpu_vm *vm)
 {
 	struct amdgpu_svm *svm = vm->svm;
+	struct amdgpu_bo *root;
 
 	if (!svm)
 		return;
 
 	amdgpu_svm_close(vm);
 	amdgpu_svm_lock(svm);
+
+	root = amdgpu_bo_ref(vm->root.bo);
+	amdgpu_bo_reserve(root, true);
+
 	drm_gpusvm_fini(&svm->gpusvm);
+
+	vm->eviction_lock = &vm->default_eviction_lock;
+	/* Publish the lock reset before making SVM unavailable. */
+	smp_store_release(&vm->svm, NULL);
+
 	amdgpu_svm_unlock(svm);
 
 	amdgpu_svm_attr_tree_destroy(svm->attr_tree);
 	amdgpu_svm_work_fini(svm);
-	vm->svm = NULL;
 	amdgpu_svm_put(svm);
+
+	amdgpu_bo_unreserve(root);
+	amdgpu_bo_unref(&root);
 }
 
 bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
 {
-	return vm->svm != NULL;
+	/* Pairs with publishing vm->svm after its lock alias is initialized. */
+	return smp_load_acquire(&vm->svm) != NULL;
 }
 
 static int amdgpu_svm_copy_attrs(const struct drm_amdgpu_gem_svm *args,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 3e622ac059..046910c2a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -65,16 +65,14 @@ amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
 			  unsigned long last_page)
 {
 	struct dma_fence *fence = NULL;
-	unsigned int flags;
 	int ret;
 
 	if (last_page < start_page)
 		return 0;
 
-	flags = memalloc_noreclaim_save();
-	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, NULL,
-				    start_page, last_page, 0, NULL, &fence);
-	memalloc_noreclaim_restore(flags);
+	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, NULL, start_page,
+				    last_page, 0, svm->vm->eviction_lock,
+				    &fence);
 
 	if (fence) {
 		dma_fence_wait(fence, false);
@@ -210,20 +208,11 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 		mapped_pages += seg_pages;
 		is_last_seg = mapped_pages == npages;
 
-		/*
-		 * The struct hmm_range hmm_range field inside amdgpu_hmm_range
-		 * is drm_gpusvm internal state. It is not exposed to the
-		 * implementing driver and is managed entirely by the framework
-		 * as part of the framework logic. This amdgpu_vm_map_range call
-		 * always runs inside the drm_gpusvm notifier, so omitting
-		 * hmm_range here is safe.
-		 */
-		ret = amdgpu_vm_map_range(svm->adev, svm->vm,
-					  flush_tlb && is_last_seg, true, NULL,
-					  start_page, last_page, pte_flags,
-					  0, entry->addr, NULL, NULL, NULL,
-					  NULL, NULL,
-					  wait_fence && is_last_seg ? fence : NULL);
+		ret = amdgpu_vm_map_range(
+			svm->adev, svm->vm, flush_tlb && is_last_seg, true,
+			NULL, start_page, last_page, pte_flags, 0, entry->addr,
+			NULL, NULL, NULL, svm->vm->eviction_lock, base,
+			wait_fence && is_last_seg ? fence : NULL);
 		if (ret)
 			return ret;
 	}
@@ -304,14 +293,12 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
 {
 	struct drm_exec exec;
 	struct dma_fence *fence = NULL;
-	unsigned int flags;
 	int ret;
 
 	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, intr);
 	if (ret)
 		return ret;
 
-	flags = memalloc_noreclaim_save();
 	drm_gpusvm_notifier_lock(&svm->gpusvm);
 
 	if (!amdgpu_svm_range_pages_valid(svm, range)) {
@@ -323,24 +310,25 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
 							wait, wait ? &fence : NULL);
 	}
 
-	drm_gpusvm_notifier_unlock(&svm->gpusvm);
-	memalloc_noreclaim_restore(flags);
-
-	if (!ret && fence)
-		dma_fence_wait(fence, intr);
-	dma_fence_put(fence);
-
 	if (!ret)
-		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false, NULL);
+		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false,
+					    svm->vm->eviction_lock);
 
 	if (!ret) {
-		if (flush_tlb)
-			amdgpu_svm_flush_tlb(svm);
 		WRITE_ONCE(range->attr_flags, attrs->flags);
 		WRITE_ONCE(range->gpu_mapped, true);
 		range->validate_timestamp = ktime_get_boottime();
 	}
 
+	drm_gpusvm_notifier_unlock(&svm->gpusvm);
+
+	if (!ret && fence)
+		dma_fence_wait(fence, intr);
+	dma_fence_put(fence);
+
+	if (!ret && flush_tlb)
+		amdgpu_svm_flush_tlb(svm);
+
 	drm_exec_fini(&exec);
 	return ret;
 }
@@ -583,9 +571,12 @@ amdgpu_svm_range_invalidate_interval(struct amdgpu_svm *svm,
 					crosses_boundary ? "ATTR DESTROY" :
 							   "ATTR ZAP PTE");
 
+				/* Use the unified eviction/MMU notifier lock for PTE zaps. */
+				down_write(svm->vm->eviction_lock);
 				ret = amdgpu_svm_range_zap_ptes(svm, svm_range,
 						drm_gpusvm_range_start(range) >> PAGE_SHIFT,
 						(drm_gpusvm_range_end(range) >> PAGE_SHIFT) - 1);
+				up_write(svm->vm->eviction_lock);
 				if (ret < 0) {
 					drm_exec_fini(&exec);
 					return ret;
-- 
2.34.1

