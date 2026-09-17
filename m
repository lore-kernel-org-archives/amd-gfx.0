Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC21BC88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6A610ED97;
	Thu, 17 Sep 2026 11:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lxABj8bI";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D08310ED97
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpEwhXdqWUOuYF6iOdEblnaLhrlpe5iDR0PFsJCy0Udsz1BFmc3sNK+uslKg5XBfMSDfNlZH9KSC2PQF2bgH+79BqQ/qyTjd7ZDlg8AWCSLlQulQdgzMB8GrbxY62JTinf8++W317NUIfTDNul+LW1X4n4OLU0vllgv0dGJJXp33m4JsyXemfxJPvg1Yg2w2HzAZl9l4oB5NZY2a/Ii9CFDoIfZ5VgrtHDugsl2bjhNH2wdtpBC+Ow7vPB7Md+hGwzrnZGKtGthM4qIa5nnpvJXkftMNKecVRj1DEBPtWaAPx/ON7QGZ6Ag/P+dyi39H9jhlvLX97XzC/gBaDAZwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9HVlLFwhoM3QqcEcx7fOU4ADAhPD2mXiwWZErCbgaY=;
 b=LbaH7lQN1RFyaXA9jJlfocZpG7ntIBoN7rikykwtPovzqPECYzNEnfBg44aiJ1TiXzE5AsFRx2Yr//GScuxeSH9A8Ckl2DjlvSBFbwwWfBhySHbKq6+N9VYNvT0NVszia9cae1i3N3itpW7wcQZXuETFXrYiglJ4jGbZGjrkhAyT97ISwIMUM7HDauw+LtdY4gn+6ALI6FBdS8wwuwHAopVknvpOM3Kh5QPMtpnsTbZMy0mdmz0iiaXaTTKs5pNczDbMTinrNCs+xgYQvkusnlP6JZ7nHg0tpomyRwAZ0LV7jCBfOIbfA7OAZjB7NUNkb0ne2IJG5RL7q4cW3eQ44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9HVlLFwhoM3QqcEcx7fOU4ADAhPD2mXiwWZErCbgaY=;
 b=lxABj8bISYTtd/dZyniO4k7AOX7jHDpoWGOebiFfl75GOxXnJTRrwyDysGHBwG7exI6uOvqojm1qXcswFCfY3xasJ9lhYf4KwE9j6uSF1clVa+6ssxQVGmmayQD/kZSmWHGVs7q37gsvIrNKAsoqVOa+tLucXSsrXJ6de6EH5vQ=
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 11:02:44 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::f) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 11:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:02:44 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:02:41 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amdgpu: start to move VM internals into
 amdgpu_vm_internal.h
Date: Thu, 17 Sep 2026 19:01:46 +0800
Message-ID: <20260917110158.296198-2-yhuang13@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca85c7d-04a8-45e5-8cb5-08df14ab3362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4OkBn4FocAKh1pPioyFxh/PkKghYlLmV9fYQPi+6IgwY3J+zVQQ1sArQq45LAJmv5vdudF9MohPBuWtLt+dzUxfdVELtCTV20x5x7KHXLQmFQ2pdh3TNvP8ji+tBxFmfhoJ9SzHY5kgN1hJBPEOqhSFE5s0R9QmzVW/tkXGHIjrdE4unC0NZhLHT3ZypiVZQWF/VerPxeGdO85FlomD8pSkcJrVqk2OMXuL0uDrkA2KRBqbNSkOKBXNh1yi5Zz7ni66REXLNYc2yB0jYn6qUhXE1YpZz7HRo8jfndFwq/P+CVTqf0slN73BO/buTGJNQ69jjTBYcqaFHFr9z1cIZu+LpahQjKztPtiXK3pYawi2rt+HoJYLJ/HCQ8IabC79Ctnndc1Uj3e6svbM9YJjV/MsjGRRDVXwuYMg5Mnv+uLm5NnjiAvpq2BkJfoMdCMnI+v+ZgefuWYaC3643ny66Ao8h55lUs7mMJ/2SxsivnBsvv/SkDCWCyrql4Zsds7b1fBbIkJ/15ZK/ZF4TRqzHd8eT1Xn7uM74mGcWZn1ARTJdgcmVjfDbezfTS10Gn+1qiQL+hoFOC94AyN84rzuezXXWB3ofw2qAyEndY7S3WMBUrEG9dmyNjNAPlKXE3pVB7IOx8ICadocKAWgT8kdVGyVJTLoBw9t4r0AOe4sBU23Buo2Ky6DlV0LAfsQRZsmZfQ6SReO1+JMEuT389bQ0QQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j+DFIzK8dxmBfMwo7347lay+YB0Q4c5eAo+KfFlUQdDioKtkyqjZ+2yG+03ZpgYn/04/d/1/sGhIW8rp536pyfshzPepgNVRiNRPD+0b772BnLPqPWl9j3jxPQ5q+QF7jKfcLE9HkqWq+jbrNeCM/24CE73alhkHV5AMOoYZ14NGAN8eD0+hWkXn4x7r3sUIXxJ2cEKWuvkHSelogNdAizWh+oYxATxI9H2VwPOJ60Igp3efnDtmnNC2Pw/6sFtL+aCE+OBbvEtaprfxA+/WzAo+6HpXAWvRRZfOpDxmn7dJT/F2Wsm84fLPmhqTUsXcwGW6yAGVXPxTLbGUrCND6IRLnntk/7mH/8mcJg50AFdY2zaxB4uFy6C7vbNt+LLbSX/17HKqUoUrbtOE5qWlq6bIy2OiBr526J9nK41GxGgDdREbqlEBEKnzowK8DSfQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:02:44.3309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca85c7d-04a8-45e5-8cb5-08df14ab3362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560
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

Avoid exposing some defines outside of the VM code.

Co-developed by Claude Sonnet 4.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_trace_points.c  |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 116 -------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 155 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   1 +
 8 files changed, 162 insertions(+), 116 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5324030a13f5..784adf975b04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -37,6 +37,8 @@
 #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
 	 job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished)
 
+struct amdgpu_vm_update_params;
+
 TRACE_EVENT(amdgpu_device_rreg,
 	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
 	    TP_ARGS(did, reg, value),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
index b96d885f6e33..fe61ed5b487e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
@@ -25,6 +25,7 @@
 #include <drm/amdgpu_drm.h>
 #include "amdgpu_cs.h"
 #include "amdgpu.h"
+#include "amdgpu_vm_internal.h"
 
 #define CREATE_TRACE_POINTS
 #include "amdgpu_trace.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 88249aa89ee3..517490946a9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -37,6 +37,7 @@
 #include <drm/drm_exec.h>
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_vm_internal.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gmc.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d32183cd9e0f..ac3b8e8525c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -262,80 +262,6 @@ struct amdgpu_task_info {
 	struct kref	refcount;
 };
 
-/**
- * struct amdgpu_vm_update_params
- *
- * Encapsulate some VM table update parameters to reduce
- * the number of function parameters
- *
- */
-struct amdgpu_vm_update_params {
-
-	/**
-	 * @adev: amdgpu device we do this update for
-	 */
-	struct amdgpu_device *adev;
-
-	/**
-	 * @vm: optional amdgpu_vm we do this update for
-	 */
-	struct amdgpu_vm *vm;
-
-	/**
-	 * @immediate: if changes should be made immediately
-	 */
-	bool immediate;
-
-	/**
-	 * @unlocked: true if the root BO is not locked
-	 */
-	bool unlocked;
-
-	/**
-	 * @pages_addr:
-	 *
-	 * DMA addresses to use for mapping
-	 */
-	dma_addr_t *pages_addr;
-
-	/**
-	 * @job: job to used for hw submission
-	 */
-	struct amdgpu_job *job;
-
-	/**
-	 * @num_dw_left: number of dw left for the IB
-	 */
-	unsigned int num_dw_left;
-
-	/**
-	 * @needs_flush: true whenever we need to invalidate the TLB
-	 */
-	bool needs_flush;
-
-	/**
-	 * @override_pte: true for memory that is not uncached and gmc override function is
-	 * implemented to allow MTYPE to be overridden for NUMA local memory.
-	 */
-	bool override_pte;
-
-	/**
-	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
-	 */
-	struct list_head tlb_flush_waitlist;
-};
-
-struct amdgpu_vm_update_funcs {
-	int (*map_table)(struct amdgpu_bo_vm *bo);
-	int (*prepare)(struct amdgpu_vm_update_params *p,
-		       struct amdgpu_sync *sync, u64 k_job_id);
-	int (*update)(struct amdgpu_vm_update_params *p,
-		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
-		      unsigned count, uint32_t incr, uint64_t flags);
-	int (*commit)(struct amdgpu_vm_update_params *p,
-		      struct dma_fence **fence);
-};
-
 struct amdgpu_vm_fault_info {
 	/* fault address */
 	uint64_t	addr;
@@ -600,22 +526,6 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM]);
 
-int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		       struct amdgpu_bo_vm *vmbo, bool immediate);
-int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
-			int32_t xcp_id);
-void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-
-int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
-			 struct amdgpu_vm_bo_base *entry);
-int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
-			  uint64_t start, uint64_t end,
-			  uint64_t dst, uint64_t flags);
-void amdgpu_vm_pt_free_work(struct work_struct *work);
-void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
-			    struct amdgpu_vm_update_params *params);
-
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
 #endif
@@ -651,32 +561,6 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
 	return atomic64_read(&vm->tlb_seq);
 }
 
-/*
- * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
- * happens while holding this lock anywhere to prevent deadlocks when
- * an MMU notifier runs in reclaim-FS context.
- */
-static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
-{
-	mutex_lock(&vm->eviction_lock);
-	vm->saved_flags = memalloc_noreclaim_save();
-}
-
-static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
-{
-	if (mutex_trylock(&vm->eviction_lock)) {
-		vm->saved_flags = memalloc_noreclaim_save();
-		return true;
-	}
-	return false;
-}
-
-static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
-{
-	memalloc_noreclaim_restore(vm->saved_flags);
-	mutex_unlock(&vm->eviction_lock);
-}
-
 void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  unsigned int pasid,
 				  uint64_t addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index b31ff6f56f0d..d03b9bbe20c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -21,6 +21,7 @@
  */
 
 #include "amdgpu_vm.h"
+#include "amdgpu_vm_internal.h"
 #include "amdgpu.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_object.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
new file mode 100644
index 000000000000..447195cc4593
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -0,0 +1,155 @@
+/*
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Christian König
+ */
+#ifndef __AMDGPU_VM_INTERNAL_H__
+#define __AMDGPU_VM_INTERNAL_H__
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include "amdgpu_vm.h"
+
+struct amdgpu_device;
+struct amdgpu_vm;
+struct amdgpu_job;
+struct amdgpu_sync;
+struct amdgpu_bo_vm;
+struct amdgpu_vm_bo_base;
+struct dma_fence;
+
+/**
+ * struct amdgpu_vm_update_params
+ *
+ * Encapsulate some VM table update parameters to reduce
+ * the number of function parameters
+ *
+ */
+struct amdgpu_vm_update_params {
+
+	/**
+	 * @adev: amdgpu device we do this update for
+	 */
+	struct amdgpu_device *adev;
+
+	/**
+	 * @vm: optional amdgpu_vm we do this update for
+	 */
+	struct amdgpu_vm *vm;
+
+	/**
+	 * @immediate: if changes should be made immediately
+	 */
+	bool immediate;
+
+	/**
+	 * @unlocked: true if the root BO is not locked
+	 */
+	bool unlocked;
+
+	/**
+	 * @pages_addr:
+	 *
+	 * DMA addresses to use for mapping
+	 */
+	dma_addr_t *pages_addr;
+
+	/**
+	 * @job: job to used for hw submission
+	 */
+	struct amdgpu_job *job;
+
+	/**
+	 * @num_dw_left: number of dw left for the IB
+	 */
+	unsigned int num_dw_left;
+
+	/**
+	 * @needs_flush: true whenever we need to invalidate the TLB
+	 */
+	bool needs_flush;
+
+	/**
+	 * @override_pte: true for memory that is not uncached and gmc override function is
+	 * implemented to allow MTYPE to be overridden for NUMA local memory.
+	 */
+	bool override_pte;
+
+	/**
+	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
+	 */
+	struct list_head tlb_flush_waitlist;
+};
+
+struct amdgpu_vm_update_funcs {
+	int (*map_table)(struct amdgpu_bo_vm *bo);
+	int (*prepare)(struct amdgpu_vm_update_params *p,
+		       struct amdgpu_sync *sync, u64 k_job_id);
+	int (*update)(struct amdgpu_vm_update_params *p,
+		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
+		      unsigned count, uint32_t incr, uint64_t flags);
+	int (*commit)(struct amdgpu_vm_update_params *p,
+		      struct dma_fence **fence);
+};
+
+int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		       struct amdgpu_bo_vm *vmbo, bool immediate);
+int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
+			int32_t xcp_id);
+void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
+			 struct amdgpu_vm_bo_base *entry);
+int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
+			  uint64_t start, uint64_t end,
+			  uint64_t dst, uint64_t flags);
+void amdgpu_vm_pt_free_work(struct work_struct *work);
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+			    struct amdgpu_vm_update_params *params);
+int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+
+/*
+ * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
+ * happens while holding this lock anywhere to prevent deadlocks when
+ * an MMU notifier runs in reclaim-FS context.
+ */
+static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
+{
+	mutex_lock(&vm->eviction_lock);
+	vm->saved_flags = memalloc_noreclaim_save();
+}
+
+static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
+{
+	if (mutex_trylock(&vm->eviction_lock)) {
+		vm->saved_flags = memalloc_noreclaim_save();
+		return true;
+	}
+	return false;
+}
+
+static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
+{
+	memalloc_noreclaim_restore(vm->saved_flags);
+	mutex_unlock(&vm->eviction_lock);
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e43a60d09808..0d7fe32d0c7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_vm_internal.h"
 #include "amdgpu_job.h"
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 430274237689..a6ae2f62f80d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -21,6 +21,7 @@
  */
 
 #include "amdgpu_vm.h"
+#include "amdgpu_vm_internal.h"
 #include "amdgpu_job.h"
 #include "amdgpu_object.h"
 #include "amdgpu_trace.h"
-- 
2.53.0

