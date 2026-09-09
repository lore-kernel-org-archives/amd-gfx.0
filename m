Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6883DC79FA1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 02:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5DD10EE55;
	Wed,  9 Sep 2026 02:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x7BsscSt";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D7110EE55
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 02:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCaBO7H3ykd2AJ/NHaYLUnRKl2OHdGtZjdhrHBOQ8hP84uwq1sG7KFoPu3K7gPYq3lmpA1RsRlhdqJQnCms+pDO/3PB1Lt8qN0joVN3DXTYjNTxAcahUxFjretRCADeYWHGBvy1sgtYb/ljmiRKzz2sdopPxPUQH5/xRAFI41g497NcngydIyfTGfzS61x9LtImSWpTWJJjMtyoPhwVgDguWnFhMgWFOw1lltzYC2fV0J78a2ga13PixdPdrxvFazIqL+njcpu7zbg81iEQCmZGJuF2oWlZd4ulv6aliQK76xo9xxjYIaWP2rmc9XQEHODRKnxTPqCVD+3Nl4OCy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6XbTEpBOQ+JBKtVOvJRqBUDtX2nMOsB+Kt6FXz2Uec=;
 b=kLUrnU2Q7mLWt7GV02FvdGBUSLVWk1Wp/Oi1kJ68wAj/7+y4BRqm7BRqmfxqoO1TOKMZ9sgWEYE8IwEuYcs7tZMgHafrickJPBgBRkMoG+cWN1FS5MvOJfLVxWJkYyxMTrQdLuIURHDFzJT+zOlP7zkUbezNEmmvcUBjYJJwZ8RcCAYhFrQR+N2t0QhXHZxw07f4OAco6SAIHpiUW74ljVnozeql6Q5fFkAaKAc7r8a6CjA5h1rDGwYD+FjAeEI/7k9NyuQith50gs5oAvyUZzMR8weR67aVwGZGwaZFIwuLxbqU9Qdz7yiGp8HecnuE015LRGV/vDO+zH2zrNQH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6XbTEpBOQ+JBKtVOvJRqBUDtX2nMOsB+Kt6FXz2Uec=;
 b=x7BsscStUGhCXVYQF3QdG6baJkcyqmUW001inb9aAVrzMoukiuzzWDy+rlQ1Eu7/Lx/BbtznnA59iE9dUQlnzcYUWJKFuB83/wJEkg4W+4S8ztEIavMsQjojlKEMAU/I6OsDCOzDvSzOlb3C7o2gZw/4TsXk39HenrM6W8BOyvE=
Received: from BN0PR08CA0019.namprd08.prod.outlook.com (2603:10b6:408:142::12)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 02:44:20 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::2f) by BN0PR08CA0019.outlook.office365.com
 (2603:10b6:408:142::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Wed, 9
 Sep 2026 02:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 02:44:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 21:44:17 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix recursive ww_mutex lock in
 amdgpu_trap_alloc
Date: Wed, 9 Sep 2026 08:13:59 +0530
Message-ID: <20260909024359.395479-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 3584331e-2f43-4854-ba43-08df0e1c3f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|6133799003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: l9kgrl+fCblDSqaMOGizjaR1zxKoAHLMr3s7riX4z5X/KsMrWGc+1IKF8On3A8IoI3sTs2FFmoIe7+D2Fj8Zt0tBHvqDUx1PS5+1gLJ0Yxt8rrQgAsBj9bb7sRzRg3wypi2GqFXT4sOgUDkBXM4zzApb9w2CIvbSeh6A4sohW/1Atql6sGp0UpMKnJn5XqEPiYdYBV3IYxiy0Ff3OacJKs8vszr4rJILbv0ZxBdIqDcn2s6nvYaarcrfW1OCRbehg/wMaPEETq40oOm4lfod54Lg5WxtPI9tAE1hGw+S4OkWpWGzwHG+aIKkO043yfItAMtgR/qz+FQ07RYnHHH0FMZbp2BpKnHpAVx6xenYl6uUarDhKK28Zre1lc4IUBYDjU6m5d6tliEJEu960Gmv3Nlwf0iJoqysMfxUO+gn7oqosCrl9Uu+OLMGIcGuKyve3gWeDTix7J8Nb8AZEw6pAKO2xSwJ9ZusUqdWL3uhql/fj5DJ6bLlfgn71SKrRtyq9j+3YSb21TgxbHQWrIdPwuMy6wbVo5HE7iXzwUzuN/0pp4RkPYbniqfq1+INHWsx21vYy4fQMOKfMfuMPNvpay1sDiwLwnxAMqe9eidpg960+PKp6Ds8ybl+VKg9ofP61ytq6o/p7PFdppdI44SzXwboxLqt0ywIz0JU3KuMFA/lGYIGqrHJlXzB/snpeTMrFPdMMyG/qb/guwxlHMzCCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(6133799003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: av+yIO40/+RQEnrREth+UyWzgx0v7/1hoXv5bUbhnmTAGJ30AbPiutVBv1MYIyn10o3jkNAVHerClPkBtVxxf2iD79kjp2RIMiDZ/Ds8hExpryAnV1eDFuJ7aARaqVyeiI3KLjVMF1bX3u0B635BuwR5GGKQtxUzzhxud8l0GyhBMp2X4g+rHBgoK4yOIp7r4FB2xwvTgXyGeUfN6J3Ihsyz2fOZgpXLA+B+wQAVkeNCyKpoygJMRfIlu8VCH7hRpZHj4CejGDbWdpZ/p87B6KTHlRONn76fIQo/21XSDzJOtjH94+4DtT9dfnQ5JOZt9Ay6Z5pxMscGqw1YlCYDZ4OD9OJyA/5Y/xSRMMDuW3Hq0FJSwUYELZUsLTa9zP6v+t2JTL6ArvfxyfT0mE14RjzDzkzGuO1iNH1i8skDEoPpfaoDbdU9/BbIJXh9AV6f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 02:44:19.5406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3584331e-2f43-4854-ba43-08df0e1c3f6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

Fix this by creating the TMA buffer object before drm_exec is
initialized, so the lock is not held during BO creation. Then lock
the TMA BO together with the TBA BO inside the drm_exec section as
required for the subsequent map operations.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 74 ++++++++++++++++++------
 1 file changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 31f653ec3fb1..d2ef8e2d108d 100644
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
@@ -390,46 +391,81 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!cwsr)
 		return -ENOMEM;
 
+	/*
+	 * Create TMA BO as an unpinned kernel BO. amdgpu_bo_create_kernel()
+	 * is for pinned FW BOs only — it internally calls amdgpu_bo_reserve()
+	 * which acquires reservation_ww_class_mutex and conflicts with drm_exec.
+	 * Use amdgpu_bo_create() instead, similar to VM page table allocation
+	 * in amdgpu_vm_pt.c. The BO is added to the VM's BO list via
+	 * amdgpu_vm_bo_add() in amdgpu_trap_map_region(), which ensures it is
+	 * validated before GPU access — no pinning needed.
+	 */
+	memset(&bp, 0, sizeof(bp));
+	bp.size        = AMDGPU_TRAP_TMA_MAX_SIZE;
+	bp.byte_align  = PAGE_SIZE;
+	bp.domain      = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags       = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
+			 AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	bp.type        = ttm_bo_type_kernel;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
+	r = amdgpu_bo_create(adev, &bp, &cwsr->tma_bo);
+	if (r)
+		goto err;
+
 	bo = adev->trap_info->isa_bo;
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
 			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &cwsr->tma_bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r)) {
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
-	if (r)
-		goto err;
-
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
 	if (r)
-		goto err;
+		goto err_exec;
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
 	if (r) {
 		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
-		goto err;
+		goto err_exec;
 	}
 
-err:
+err_exec:
 	drm_exec_fini(&exec);
-	if (r) {
-		amdgpu_bo_free_kernel(&cwsr->tma_bo, NULL, NULL);
-		kfree(cwsr);
-		*trap_obj = NULL;
-	} else {
-		*trap_obj = cwsr;
-	}
+	if (r)
+		goto err_bo;
+
+	/* Get CPU mapping and zero TMA memory */
+	r = amdgpu_bo_reserve(cwsr->tma_bo, false);
+	if (r)
+		goto err_unmap;
+	r = amdgpu_bo_kmap(cwsr->tma_bo, &cwsr->tma_cpu_addr);
+	amdgpu_bo_unreserve(cwsr->tma_bo);
+	if (r)
+		goto err_unmap;
+
+	memset(cwsr->tma_cpu_addr, 0, AMDGPU_TRAP_TMA_MAX_SIZE);
+
+	*trap_obj = cwsr;
+	return 0;
 
+err_unmap:
+	amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TBA);
+	amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
+err_bo:
+	amdgpu_bo_unref(&cwsr->tma_bo);
+err:
+	kfree(cwsr);
+	*trap_obj = NULL;
 	return r;
 }
 
@@ -500,7 +536,9 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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

