Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D8AC88E73
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA25B10FAAC;
	Tue, 15 Sep 2026 07:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uKOS+Etw";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27FA10FAA7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgrwNTjBWJSEZrnFf5lwi1pbUDE+6kfUG/8yjpEg1xBaeWZJJw2BNSm3k2r5Adq0dklt8UyfjcENiHzxukzZ6Naq7Xds6vvRPHjZcOiFb3OO4mGbp2KFDHUB/BPF1WX7spCj3uaK5Rzzdi4/sqNn9yVbgdhwMzwh9WsF+A0eckzHSKDnMYx3DdvIuw05QzLwV39p+ajxRVq4S5PPZtjbTWLjZDqzcC7nxtWdQnoZXr0stV71KsTvqDw4oIoucsGp7gPoX9clYDFweeIuIBsSHZLIofyyLOhPNepJr/fXOgEani28/ya4WkZkv7gTkdsMuhOTciv1j/AXTo1o4U5ocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJKlsPTuEtNUFl4lLxC1Higl/SeSXpAvFZl73m7gMwg=;
 b=fpuCJmnPakzU3vSJawRqyOxXfHzyjMwSuAGOgUN6sUydyk7RErtnQFaNI8rsWGdu22WPcKWGogURahDe2Bp9OBq91e49Bk7MTE33aDLlQ5MFGC9C/0BurwxZsuPtaYbllzcKp8Ac73vIhLIs0Z+86zR2NNnHVjOumpaAnKQNZJ7CdXAwYhdpuKwWz8rlXbvCesfqvzGC2SgnP/XM74M1jSPBZP57+3EwWj302JKyuZFHIMi68MkqU0RgKjoe0giS+riyPqqzEC6/8zDlqUsFsPHKD5h5jPgDHT9wkE81Bite5ZUHnqGO+/UcO7lj9co8cbL1sjJWUOPF+WF7eAvmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJKlsPTuEtNUFl4lLxC1Higl/SeSXpAvFZl73m7gMwg=;
 b=uKOS+EtwOwkCUE5guB1pbTxzL95Zeso/LGxuig9ZuQTm5nPCDv4g5Ryh4vMyMB7ex/Mo0fc0UEbFDa6gA6JgENL0yrH5KRLJm5mpSciUCc9q56uw/wDsIRk6oGy/fG8jkR4OHsiHWVZL2LvxsSmDyISCovvlP2Gx3zO6Z9gB9nQ=
Received: from CH2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:610:58::32)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:43:02 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::a) by CH2PR20CA0022.outlook.office365.com
 (2603:10b6:610:58::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 07:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:43:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 02:42:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix recursive ww_mutex lock in
 amdgpu_trap_alloc
Date: Tue, 15 Sep 2026 13:12:45 +0530
Message-ID: <20260915074245.457529-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 31105c84-204f-4a49-3ca1-08df12fcf889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Vg+2DJkODfNOVOJYwF4J2SXmhUYmxa48Vz4RzePQqSmPhSBpgikNO2VoV0ssa4j0jrvwiZkd3PcMi8GIaXway8jpUbYUEB+4tH0eUAu7GPn3ORH8LbAVsDBPvR6Tn6GrhKtd1Q3kxCR0qIzjARpVQxMTxjAeOWKhNsgKbmEx0QlHwiDQbyYNkEJ1deeHmwnVOX46bxZUZ0NGQXmgtwCI8JZw4OmvqE6OScqMRjb2awxMvuwO0dzrbqp/KvJ1QUsqF5lsDKgFIXmiRgCKp+gsnVfMtwGbvgarG+kBIZq9n1Urc3U13tD81/tAnZffj1tPHhzAOOyiDLp/+hdyOT6MrnYhP5rSOu1tsqHssZdona3WgC80thgY06FlHbqxUMeboDeaepXnTYhPmOUiw5sSrlYXeeFCyeXB19MI8aQSyB8ep70pWzptLvm3T9tAgeB3Cp4inP2F1Ch76XJdHzwGpSzUgdwaRE61T0fdFyC7DXWyfBImrL88kBvJWXLp6usEjGXz0PxIZuXTF/y4kqFPyLzByPy0Aiwe80FT6CvBtB/U3lPqjGErAjyO9kQ3/LB4LP++MOskPueTGSLVftK9lx6TrDONCiP0yEYmzemnYo+SQ6b7BD8KvaYllAyamBXzvIcoKG+1HFWp866XTavfZt3WKheISNqa5A04ORGfI5mL1F8EifasRKKl00aMKqN/MD42lXHpOzbpQ0VtVM6v5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: frLvaar5pv8SvOiaLHu6kZE/9cnKg3jsJrt3kA8tggs6cZHea4UVxUjiuMwcf61VTLmK1aADW1iR0EJFUKpaIUZnXX1IGtW+FDBeYB3N7wEnzaU34fGaqmI5GG74fAeGy7VkeMudWUMbxY5hJb6HcyDMMgbAQ/bjRTfibcJd3y/bKwDjvWrrdhAGaGql4s3nVIqEDqOve0vsIHS5Fs/4/Gto0m/pGhuIvu+4Bt0d2DIH0v0Ckm6HoruLQJ+19HnME7uxMSiI8ws4AmVvmgIVMzht47BHfTMBUd22YoyLit+aC0PyKEcHl4q38hGoEuGvUHqbFiCaXKW8YzC2juEcpvwi6/bAMsno/VM2fLL6VOAPdRn0m5lSa/c9pEkOA1VVW+Dof1/m3Hgnu9PkVl7T3+CY9ruFzf3mOnvP7mUKghkqaq+Gv/m51a2Z5lJyXdTE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:43:02.0396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31105c84-204f-4a49-3ca1-08df12fcf889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
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

amdgpu_trap_alloc() first acquires reservation_ww_class_mutex via
drm_exec, and then calls amdgpu_bo_create_kernel() while still holding
that lock. amdgpu_bo_create_kernel() internally calls
amdgpu_bo_create_reserved() which tries to acquire the same
reservation_ww_class_mutex again — causing a recursive lock and
triggering a lockdep deadlock warning on Navi44:

  WARNING: possible recursive locking detected
  6.19.0-kfd-root #38 Not tainted
  --------------------------------------------
  kworker/0:2/959 is trying to acquire lock:
  ffff8bb17995d9e8 (reservation_ww_class_mutex){+.+.}-{4:4}, at: amdgpu_bo_create_reserved+0xd2/0x2a0 [amdgpu]

  but task is already holding lock:
  ffffcc23c3397ba0 (reservation_ww_class_mutex){+.+.}-{4:4}, at: amdgpu_trap_alloc+0xac/0x230 [amdgpu]

  Possible unsafe locking scenario:
        CPU0
        ----
   lock(reservation_ww_class_mutex);
   lock(reservation_ww_class_mutex);

   *** DEADLOCK ***

  Call Trace:
   amdgpu_bo_create_kernel+0x1a/0x80 [amdgpu]
   amdgpu_trap_alloc+0x18d/0x230 [amdgpu]
   amdgpu_driver_open_kms+0x2f1/0x390 [amdgpu]
   drm_file_alloc+0x20a/0x2d0 [drm]
   drm_client_init+0x75/0x100 [drm]
   amdgpu_amdkfd_drm_client_create+0x53/0x90 [amdgpu]
   amdgpu_pci_probe+0x463/0x630 [amdgpu]

Fix this by setting bp.resv = vm->root.bo->tbo.base.resv when calling
amdgpu_bo_create() inside the drm_exec locked section. This causes
amdgpu_bo_create() to reuse the VM's already-held reservation object
instead of acquiring a new one, eliminating the recursive lock entirely.
The TMA BO requires no separate drm_exec_lock_obj() call since it shares
the VM's resv and is implicitly covered by amdgpu_vm_lock_pd().

v3 (Christian):
- Set bp.resv = vm->root.bo->tbo.base.resv so amdgpu_bo_create() reuses
  the VM's already-held lock, keeping TMA BO creation inside the locked
  section without a recursive acquire.

v2 (Christian):
- Use amdgpu_bo_create() instead of amdgpu_bo_create_kernel() for the
  per-VM TMA BO; eviction is handled by the VM's BO list via
  amdgpu_vm_bo_add(), no pinning needed.

Fixes: c50a45b2e98d ("drm/amdgpu: Add cwsr functions")
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 67 ++++++++++++++++--------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 31f653ec3fb1..29eba2968350 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -377,6 +377,7 @@ static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj)
 {
+	struct amdgpu_bo_param bp;
 	struct amdgpu_trap_obj *cwsr;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
@@ -386,6 +387,7 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -EOPNOTSUPP;
 	if (!vm || !trap_obj)
 		return -EINVAL;
+
 	cwsr = kzalloc(sizeof(*cwsr), GFP_KERNEL);
 	if (!cwsr)
 		return -ENOMEM;
@@ -401,35 +403,59 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			dev_err(adev->dev,
 				"failed to reserve for CWSR allocs: err=%d\n",
 				r);
-			goto err;
+			goto err_exec;
 		}
 	}
 
-	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
-				    &cwsr->tma_cpu_addr);
+	/*
+	 * Create TMA BO using the VM's already-locked resv so no new
+	 * reservation_ww_class_mutex acquisition is needed — avoiding the
+	 * recursive ww_mutex deadlock. Unpinned; eviction is handled via
+	 * amdgpu_vm_bo_add() inside amdgpu_trap_map_region().
+	 */
+	memset(&bp, 0, sizeof(bp));
+	bp.size        = AMDGPU_TRAP_TMA_MAX_SIZE;
+	bp.byte_align  = PAGE_SIZE;
+	bp.domain      = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags       = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
+			 AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	bp.type        = ttm_bo_type_kernel;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.resv        = vm->root.bo->tbo.base.resv;
+
+	r = amdgpu_bo_create(adev, &bp, &cwsr->tma_bo);
 	if (r)
-		goto err;
+		goto err_exec;
+
+	/* VM resv already held — kmap directly, no separate reserve needed */
+	r = amdgpu_bo_kmap(cwsr->tma_bo, &cwsr->tma_cpu_addr);
+	if (r)
+		goto err_tma;
+
+	memset(cwsr->tma_cpu_addr, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
 
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
 	if (r)
-		goto err;
+		goto err_kmap;
+
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
 	if (r) {
 		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
-		goto err;
+		goto err_kmap;
 	}
 
-err:
 	drm_exec_fini(&exec);
-	if (r) {
-		amdgpu_bo_free_kernel(&cwsr->tma_bo, NULL, NULL);
-		kfree(cwsr);
-		*trap_obj = NULL;
-	} else {
-		*trap_obj = cwsr;
-	}
+	*trap_obj = cwsr;
+	return 0;
 
+err_kmap:
+	amdgpu_bo_kunmap(cwsr->tma_bo);
+err_tma:
+	amdgpu_bo_unref(&cwsr->tma_bo);
+err_exec:
+	drm_exec_fini(&exec);
+	kfree(cwsr);
+	*trap_obj = NULL;
 	return r;
 }
 
@@ -473,6 +499,7 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
 		return;
+
 	tba_bo = adev->trap_info->isa_bo;
 	tma_bo = (*trap_obj)->tma_bo;
 
@@ -480,15 +507,11 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return;
 
 	drm_exec_init(&exec, 0, 0);
-	drm_exec_until_all_locked(&exec)
-	{
+	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
 			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
-		if (likely(!r))
-			r = drm_exec_lock_obj(&exec, &tma_bo->tbo.base);
-		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r)) {
 			dev_err(adev->dev,
 				"failed to reserve CWSR BOs: err=%d\n", r);
@@ -500,7 +523,9 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
 err:
 	drm_exec_fini(&exec);
-	amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
+	/* TMA BO not pinned — release CPU mapping and free */
+	amdgpu_bo_kunmap((*trap_obj)->tma_bo);
+	amdgpu_bo_unref(&(*trap_obj)->tma_bo);
 	kfree(*trap_obj);
 	*trap_obj = NULL;
 }
-- 
2.34.1

