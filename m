Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DEFC982D3
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B29CC10ED8E;
	Thu, 17 Sep 2026 11:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tH6ZIqP0";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CA110ED8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+sxC13/Cn71IXT2eXyRnJht0P5iwscCQkGTJUz/T40tE3YgAn8aLKhZfgWQn3sZcavbkbc1Mb4mcbk3zwhQSwuECMRyi/X6lAAHONR8GPgfeyUT1JBvMpUBOJsssFr482vkwF/j7Y5tnHElA1PwhWWv1F3eiLEDRVzoJWWKh5awBn2XNdnhcsEl93gpfVSXRKj1S8fQHEGKawrF4uIQThoTkAYCFFiR4dS7Iv5aBbcf4hZ0ORWXewWPuKJ+MD3z0FYISGuoq90jeKjUppcxTJXqVCXwop0e78QUBgJk2NFsKzVxz1xwN3SJGuGkHbq8KdZgNPH4lzw1v92Mof4+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ88kpWlPVwc4haOWfu+sdiXunO+xX7NpD5XymM3oPY=;
 b=IXE1g4+2rZshRNs7ejjcXm8Y9oXN+lKcWLyQBqCpAx2wO9z6/4jOByVp0yqNW+AluLul4kURub7wn2+xc5xoAJG0fcwVkrJOQigQVZIiguWd8L5JejVma7y6IheUYQJ16PlwpLS+Hel+dfVgzZ2hnHOXrhsSSUB1B6YaTbceygtP+2fZ3pBmZD/iftfnuPD+8Cg1YyJ4QJGy/E7vT4r8PPn8i0Ns0mRXKSrcBO/wmqxEmNobHMn8cjWjLkiikcjjYm+7rr56ssIBhC0TAGXxJDBOfJ6vVn30+L1fqhoVgsPyuLCPIJjOl5YLokGFY9VKKRmUQmvJDTQSq/LyeYLQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ88kpWlPVwc4haOWfu+sdiXunO+xX7NpD5XymM3oPY=;
 b=tH6ZIqP0Pf1AFFSsvp1Kfgeqn15FVSkW27oqqVvs2bHyox0SD658J20QsiT4udZ1aZPLL7+tteeEu1bqRCOenPhR94ZFyUZREUF8vB6CPqJUSBNpHkLWYudjk2EoTV2r5nDH5I0BFHjBAP+A+uHRbetm5Leuy8hcyvr29IZVZJc=
Received: from SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::22)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 11:03:02 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::8d) by SJ0P220CA0014.outlook.office365.com
 (2603:10b6:a03:41b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 11:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:03:01 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:02:59 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amdgpu: rework eviction lock handling into critical
 section v2
Date: Thu, 17 Sep 2026 19:01:53 +0800
Message-ID: <20260917110158.296198-9-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ecce69-bb39-4b0a-2501-08df14ab3de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|11063799006|6133799003|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: fD69EL48+k/WQeSd1KYm79+Rf2BfYZuu9Z3iNVvJbtymIKI5N/HhDgxvy0GbqWrWP12M7UnQ5/6Bofe5kpACmPkBP4c8wtMLlmCVbVpIhc611Yoz9EGaWeo1lxkWx9yRKT3wBDdL4mhFFKS4rRH3yB0im26bZlReRnUdwbk+qScrK/HK995rk0yDzvT/emvgRw9/FnVCSAIF6wQ/91uE8COCc439M3d4k7vUFOf7FiG6yQ8WDGql3e06/zab6zzJfaM3Rc+Wru+1cI/pyuiBIPyXYx7O4yKYWjsDe7fdc/yZCvXT7rPfDI1nF1Setn8Are7UCx+gNXP8/+lV3TFW9taP/L4jzvn3EkBQ0l4fK8DMkeTOQUaPauGONga3CP9v+TRrRIHgHtwTByUze3Q5l21ObNIYRbHvb1p9GeHSK4t4M00duPNbvdVItieXrQXhNbRgtUytiR4BP8CghwwlpWhZcxg9Y27jnKLI0/ROmOYCPsWkwzYkykS32IuhBaHuRDss/a6u2hBg6+jAf+S5IuGRy1Fp/LvHeVkFRb/ylgsc8y3yUCljGDknt4KMS+AjHLnssOOoWydYW7vVJ8ar8b0uhrI/OE9L54gf5DGC1GYACYSwmFAvr37YrEF2neMYOVf/msxWUk1TCY65PuGPDHr0bmm/57qBM+7fVqiQISOQT8xYK9RZCHnS7O4l8joicMDGtrYdo0+Z0H7cKtWsXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FhdnwvVePlQeHi9YHNVnoDWDHCSgKGONURjuQwYC4l5nLyd/2HTNLqTdedHhgKdO8kVh+9Oe1IZscCxuvaFUtAf+zB2Pu/MRq485F9Xun4Xl7EaF399yEKcyM+VSVewFefYNZvuJaVYRjRgbfHNzs0i32W6P+VdJRyiC1fzUwFYt0hz4ebQHzvcJ3WDL0YHz+yJDgKDoCGMJPW9Kr3pFbtq0wi/8jlRzyi1TVqh3gOd1cs3K/SMmLtMvLHMdCqpLCU6TOY4vKUAEVpbaXp7xmOulezzhOvijnHENz2dCYy9hGgpcqqFf0qkH5uDexvb10knKfppr+PGSJkE2yQzbStUlb/iVVLY1XJO6qNA0cCj/g/fT4pnSOnEr5UiDlmLAC/82w/nVrCZBUTwI2pj7JBPJWAzrPC33AHvTrZGyk3NUnp5jHamE+5jZIKvNYg8m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:03:01.9409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ecce69-bb39-4b0a-2501-08df14ab3de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Taking the eviction lock is actually just one step which we need to do
in the critical section handling.

Rename the functions to reflect that, use the update parameters instead of the
vm to save the GFP flags.

v2: rebased and reordered

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 36 ++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 41 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 28 ++++++-------
 4 files changed, 58 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0930b3fdade7..a994141e9df5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1167,11 +1167,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
-	amdgpu_vm_eviction_lock(vm);
-	if (vm->evicting) {
-		r = -EBUSY;
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
 		goto error_free;
-	}
 
 	if (!dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
@@ -1253,7 +1251,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
-	amdgpu_vm_eviction_unlock(vm);
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -1301,11 +1299,9 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.unlocked = true;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
-	amdgpu_vm_eviction_lock(vm);
-	if (vm->evicting) {
-		r = -EBUSY;
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
 		goto error_free;
-	}
 
 	r = vm->update_funcs->prepare(&params, sync,
 				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
@@ -1324,7 +1320,7 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
-	amdgpu_vm_eviction_unlock(vm);
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -3156,32 +3152,26 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unlock;
 	}
 
-	amdgpu_vm_eviction_lock(vm);
-	if (vm->evicting) {
-		r = -EBUSY;
-		goto error_dev_exit;
-	}
-
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
 	params.immediate = true;
 	params.pages_addr = NULL;
 
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error_end_critical;
+
 	r = vm->update_funcs->prepare(&params, NULL,
 				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
 	if (r)
-		goto error_dev_exit;
+		goto error_end_critical;
 
 	amdgpu_vm_pt_leaves(&params, addr, addr, values, flags);
-
 	r = vm->update_funcs->commit(&params, &vm->last_update);
-	if (r)
-		goto error_dev_exit;
-
-	amdgpu_vm_eviction_unlock(vm);
 
-error_dev_exit:
+error_end_critical:
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 
 error_unlock:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index e871a9e3e1a9..fbbd9e725799 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -287,7 +287,6 @@ struct amdgpu_vm {
 	 */
 	struct mutex		eviction_lock;
 	bool			evicting;
-	unsigned int		saved_flags;
 
 	/* Memory statistics for this vm, protected by stats_lock */
 	spinlock_t		stats_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 7f6442d0b647..a3328a48fecd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -93,6 +93,11 @@ struct amdgpu_vm_update_params {
 	 */
 	bool override_pte;
 
+	/**
+	 * @saved_flags: Saved flags for GFP reduction.
+	 */
+	unsigned int saved_flags;
+
 	/**
 	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
 	 */
@@ -130,21 +135,37 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_pt_alloc_dummies(struct amdgpu_device *adev);
 void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
 
-/*
- * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
- * happens while holding this lock anywhere to prevent deadlocks when
- * an MMU notifier runs in reclaim-FS context.
+/**
+ * amdgpu_vm_begin_critical - start the critical section of the update
+ * @p: The update parameters
+ *
+ * Serialize all updates, check parameters and make sure that memory allocations
+ * don't enter the reclaim path so that we don't deadlock with MMU notifiers.
+ *
+ * Returns:
+ *
+ * 0 on success or a negative error code on failure.
+ * Even on error amdgpu_vm_end_critical() must still be called to clean up!
  */
-static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
+static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 {
-	mutex_lock(&vm->eviction_lock);
-	vm->saved_flags = memalloc_noreclaim_save();
+	mutex_lock(&p->vm->eviction_lock);
+	p->saved_flags = memalloc_noreclaim_save();
+	if (p->vm->evicting)
+		return -EBUSY;
+	return 0;
 }
 
-static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
+/**
+ * amdgpu_vm_end_critical - end the critical section of the update
+ * @p: The update parameters
+ *
+ * Restore the GFP flags and drop the lock.
+ */
+static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
 {
-	memalloc_noreclaim_restore(vm->saved_flags);
-	mutex_unlock(&vm->eviction_lock);
+	memalloc_noreclaim_restore(p->saved_flags);
+	mutex_unlock(&p->vm->eviction_lock);
 }
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 5bb1a3300aa4..5385f662d0ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -478,42 +478,42 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 /**
  * amdgpu_vm_pt_alloc - Allocate a specific page table
  *
- * @adev: amdgpu_device pointer
- * @vm: VM to allocate page tables for
+ * @p: see amdgpu_vm_update_params definition
  * @cursor: Which page table to allocate
  *
  * Make sure a specific page table or directory is allocated.
  *
  * Returns:
- * 1 if page table needed to be allocated, 0 if page table was already
- * allocated, negative errno if an error occurred.
+ *
+ * 0 on success or a negative error code on failure.
  */
-static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
-			      struct amdgpu_vm *vm,
+static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 			      struct amdgpu_vm_pt_cursor *cursor)
 {
 	struct amdgpu_vm_bo_base *entry = cursor->entry;
 	struct amdgpu_bo *pt_bo;
 	struct amdgpu_bo_vm *pt;
-	int r;
+	int r, r2;
 
 	if (entry->bo)
 		return 0;
 
-	amdgpu_vm_eviction_unlock(vm);
-	r = amdgpu_vm_pt_create(adev, vm, cursor->level, &pt,
-				vm->root.bo->xcp_id);
-	amdgpu_vm_eviction_lock(vm);
+	amdgpu_vm_end_critical(p);
+	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, &pt,
+				p->vm->root.bo->xcp_id);
+	r2 = amdgpu_vm_begin_critical(p);
 	if (r)
 		return r;
+	if (r2)
+		return r2;
 
 	/* Keep a reference to the root directory to avoid
 	 * freeing them up in the wrong order.
 	 */
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
-	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
-	r = amdgpu_vm_pt_clear(adev, vm, pt);
+	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
+	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt);
 	if (r)
 		goto error_free_pt;
 
@@ -802,7 +802,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		/* make sure that the page tables covering the
 		 * address range are actually allocated
 		 */
-		r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
+		r = amdgpu_vm_pt_alloc(params, &cursor);
 		if (r)
 			return r;
 
-- 
2.53.0

