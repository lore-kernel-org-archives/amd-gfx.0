Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24B6C79F99
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 13:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69FA110E0F2;
	Tue,  8 Sep 2026 13:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D1l6rbBQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9C210E0F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 13:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w891lkTECe6spjhpNVtbwYBxOZ3oTp4kpSkmvxoZQFhKbcctDuSb7W9BuIxVqLtFCy/CCwda0hATTGnFQbO4N67w57Y8qpVjugo9FTH27rcTc831TvNaWa/MfYTnjInH4SfvVJm764P955V6yIt+MzPLOBFTyvdYQOWOHGOCTk4SETta4K68ULzV54LzJPiL8/idP3OD420i9P+v+JOs+M+PRK2HrluILP0L4F2+L6DuhfrPzd+lKuC+JFDvMuwvLcInwoDudy6utG3dZhgbdViY63o+keEqU0gY/4ZcrHw7QbJ6ytVExxIO5LQmQ5+rIPPOK7S51E3nctJnIPJ9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31IetvvbZbBRw71pRYf9SS9pZG5y47Xt0WFItRHkf0E=;
 b=EbPL44QwdeKdsrIuWx6NnQUm9xIe+j9FKYxULoQL8hJX0u8KMG5BsbSoVQX7kruDnSW9X/vWApM+nNUZcsYGx9VXaSUU11Wrk8GdhrEkimcp1EhsO5MRaIraBIlWqmHtojaU2Cm7qt/7qxg6YhESJL30FDozOzFBJvrgPTG8T6lXucyB2wxsheqWN1cgfeVSOVON6KpdxEI9c9DHooJo/wyOegGAaX3yD90+ndU+6aZWRv7QM97Sm6VAi6wu35xz/kABlFRxj34e9FksLAz7May0XrkqkQmMZ4Q7amOp1kz5l2a1SgvzxZbxuKdAwVU0YYTh4RhoW5NX3vMpWfj5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31IetvvbZbBRw71pRYf9SS9pZG5y47Xt0WFItRHkf0E=;
 b=D1l6rbBQoe8n7tTmQLn/hxkJUoy6sLREISSU8y19HiXoEY51uVZvFcPUcoPH3vvv9WVCIIrHHslN3vryUdqT2Yp1iRer+gu1hMCH05KbDEcqJeBloeET2j+POM/nJc2S2c+HblEF9U5+6/7UkzI93j+/3Bj540QQgol/OvDDaM4=
Received: from SJ0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:a03:333::13)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Tue, 8 Sep 2026 13:25:56 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::74) by SJ0PR03CA0098.outlook.office365.com
 (2603:10b6:a03:333::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 13:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:25:55 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 08:25:50 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix recursive ww_mutex lock in amdgpu_trap_alloc
Date: Tue, 8 Sep 2026 18:55:37 +0530
Message-ID: <20260908132537.388980-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c2c76e-f58e-4707-054c-08df0dacb65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: SCOehzukYKZ6H5mLmPX8nsDgLFnBGwIK7npY0HFPmfpUHu3odyWafduPVx0xpBCIWaAFiEmVx9CBUvAZJMLQ8lpZZalHmIhgVMnx8ZkmZA/J0RlZtXMudyX0JznHQEPX9EMYfYKs0PoCN9vzQ244zfQ0EMy4V98oxuWoRcaMs681ZIJI06CQXtHX/Uhzv9xSC7dCHR9pu+cDbql0Ta4be2KroZGnoQpy0w3ydc3NB+ETSLhWDK8JZBRfsIX3R1XFJIPdYJY66esjkgTxvzkAukFnSDj+waRgt2sUQWmCEhp02CbiSa9i0aG/a8D90lvy6yXxonS9vPolLAZNwHbCTxyTzsO199+tn7M5Y4zVOcRjx5BZoh/jdEpOTawdXstj6BDNkaCdv0/R34xoJofMPO0Qoz89VQ997o10vFphDwdNRsTL3HNJIl72y/4igIu06JtdC1Sftawb61rv7xbRdNO+QGcRTEjGeQXnJUMSIxKo0LkEHe/mgVoS00lOoYJLoAI9Lb2dUK4cqvNFTOaiNLEL69l0UKxaN0XQGRrqB5kpeczWvRboT6e1C5wPmvxAKXH3iLsAGmvusZVWsL/SvyDtgmnAdCvH4eaUH6B9+yuxag+qN+MW5Ls/n1zRtgR+mwiZrOXrn3Bpwt1bROTw5fOQZmZgAaB+vV4yx1LANoXVZiZf7oJQHWpVZTIuh/ww4rGApenV++FLhGj9+6GaaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PIsPCGd74b5GmE8t+u7IhUVNYdToC3SMK4GdWGgFR9C3kaMHP+EOfyesIMi46LFh9v2jB04iE1vjsztzjcG1NXLFbCsQzKbheAAABtXf1d3RT83rXcTej13xSNGMNFvhQIhE1EYCwr27KAZrom0FMQeKlrz2QdKXtK3wir0MyRccv/9Tg/MUx2iSj9o+WHSwvxVInFmmLTWFTGBS5Q38yHRE4jcCk1f1weXtZ3Nwiwnfx6GgdA0gPOGMmC+GiB08UOBp9EZuf7cXtmLK71/ck3I9cqd2w5Ua1KPUVjhLbJzEp4SHs0RrtBrOwpGPHTmG9SLh3jH8O9s+T5Kt+XslHVg+4ndmr8nW6g+VWEqfRKL8VB56KrNmp+U0GQjKtDedviZC7izYACDnmWjNQkB50yl2572+Nx8wc3oa8TrM0KRq7H70QenywEFXK4jtI0n5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:25:55.3451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c2c76e-f58e-4707-054c-08df0dacb65b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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

Fixes: c50a45b2e98d ("drm/amdgpu: Add cwsr functions")
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 32 ++++++++++++++++--------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 31f653ec3fb1..3981e9447a26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -390,40 +390,50 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!cwsr)
 		return -ENOMEM;
 
+	/*
+	 * Create TMA BO before acquiring drm_exec locks to avoid recursive
+	 * ww_mutex acquisition. amdgpu_bo_create_kernel() calls
+	 * amdgpu_bo_create_reserved() which acquires reservation_ww_class_mutex,
+	 * but drm_exec already holds it — causing a lockdep deadlock warning.
+	 */
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
+				    &cwsr->tma_cpu_addr);
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
+	if (r)
 		amdgpu_bo_free_kernel(&cwsr->tma_bo, NULL, NULL);
+err:
+	if (r) {
 		kfree(cwsr);
 		*trap_obj = NULL;
 	} else {
-- 
2.34.1

