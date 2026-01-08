Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5BDD1D467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C174010E77F;
	Thu,  8 Jan 2026 14:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z+L27abE";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A3E410E782
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKkbCl5NMluH0ZlM/IsbsKD+yMzzaIKmRj4RuMIpebEfW6MCyIQfv4QPQv66wGZES+KcmU00lkcMeGYS4y2HU7jyvIRM2iTZvHGaGG1CCFXNpMBlwnXCs6YsyVVcN+rLcR5EoIYtDnvZMXz8AicPnDvzPMA6aifeQdpj7UiwSfVGzWJ/hgOMkffcrById0BI4jiEi+LuGMLEQq2Z72TCdA6o4Yl6BurVomJu7ZXp2Rgfx4iNLcFDbzCCtF7FS3xVOt/gisllFbvlmtQIFr3EcUae9TisrXqIra0xrbtbLe8lDwam1A3kfoQMFtZfq3UY4FVnDB0MeN7Xa5d74cyxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6Z6ua5I29Reh7DRboEEGaxiLaAWWX1UvVCTkrF0LF4=;
 b=PM5A9bbZvHIZQOlVJvhmdJbIDu2SYK0M62dcb3zKVa8wn6pKNJl6ZVDMW7tVSSkPhMrxfdM5l7bbJOjLOE1VD2mEWqdHe4atGHg/ahK/CPQRNrJc6vrJjDg+m2SuE4XaiASeOAsb4ZB9YH8/jclWVwtGFuM6oozXkx2Kvu5OGXbl+CqT/VmZbmUzA5UeIl1X9gqpzRKBnZc+TFETs67It9zUmL45+mYhqx3unOZe3Wa3fmjRm9/T4y6k9nNDrMSA4jl/D3nB4TcXU0MfzsaVQ9ybXz6QBE6jneOljsoF7COTKM1U6JikEu4gQeg5UzhAR99/Bz+UyrGu33urfSLgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6Z6ua5I29Reh7DRboEEGaxiLaAWWX1UvVCTkrF0LF4=;
 b=z+L27abE+fOEvgnXzay59GtIboD4hzqUtEw48nR3JdYY2UzlW2FMilOFn69Ft/28EkjWVs2BM8x1uJCQNwoX1NpXawjiqXVibgpOuKRPOGUUkxopZ+U42uuQZ6m9WIWav33sjHd+u7rxCowmYDLPIUvTH1j3iIEMmhEcQiAIfy0=
Received: from BYAPR02CA0063.namprd02.prod.outlook.com (2603:10b6:a03:54::40)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:19 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:54:cafe::25) by BYAPR02CA0063.outlook.office365.com
 (2603:10b6:a03:54::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:49:08 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 41/42] drm/amdgpu: rework reset reemit handling
Date: Thu, 8 Jan 2026 09:48:42 -0500
Message-ID: <20260108144843.493816-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 070ad4ac-a8ec-44bc-8db0-08de4ec51ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o5XiGFcWEvTBifPvdM0xQyWVw1VNu0pF5Qldh5UV2PS+Wz6jNKZdO9AIccCH?=
 =?us-ascii?Q?hygXfo1R50suuWDbDSd5fXjrmM0KU1OsZi3D4Rv2jvCYenCnYqKmP4o+a063?=
 =?us-ascii?Q?vQ2U8f5DBDRv+9D0PXkp+JCHwLyt5TsPwNszKzVcqpvdbHGWmWDj14HF4AkA?=
 =?us-ascii?Q?LO4ZlaJxFtXzjJueZ9kmhvXkpPpio3c6FyxnFGaQQ1zR9z2SLcVBI5CZptOw?=
 =?us-ascii?Q?rEbGMSzDgjDI7Bi2E0WjPUiEgoMLhcv72jSCKbNGJNZTO2KZbqVfaNDRUKIe?=
 =?us-ascii?Q?0bP/U6sPnuH/yX/YlaOQD0B/TYyZglWpHgN6IF+MOu+ru/APg57HhgDMIPXI?=
 =?us-ascii?Q?bzz+uJHdeL9pGqVYaFN8lZVjsz/OcUg+vO5cWK1j9K2KgBFbaXSBFfTC4d5t?=
 =?us-ascii?Q?0h6tClr1uDJ0rTpx6Bcl7kyNqlozGlwpVSm7QL37C/Gve2ukhwLnnGmk1yqx?=
 =?us-ascii?Q?EII/iP9PbLrBVNlp6lR5kKabTs3VLmcrFGx7sUm6CulZzSllxA/CCM1gPA1J?=
 =?us-ascii?Q?EOeuWS4Q38CkLHUpEGDkIMEPPRiNIJPIOLHcKPbeXoP6N/jOkykeuhyMY9lS?=
 =?us-ascii?Q?4Oly0KgEnXtwSoGdfwPEB5269WqJ3bAfT7JV4njX5iOOH/YKi1Hz5zCs73Dy?=
 =?us-ascii?Q?xIWN22aE+o35J8K4UClICGxnjHp0YvHjWYV148j4o/3XXk8Xc84i5RSEx6PR?=
 =?us-ascii?Q?CZ/06YeBpHSpgQZsaDtNDj2D/3Xcrp2Ef3Cxxe0PuqHHEEpSoAI2+IdARURi?=
 =?us-ascii?Q?FwR7wGNI3c+QdlpFnhSnaHtvDpef/IRPAKFuwgohmBlqiRF3VpFLnb/hnJs1?=
 =?us-ascii?Q?Z+RnJ0hOojjmDBl3+PXohI5JXRAAxL14K+TVMTQqq18J7dqeA4ZDpfJWR5Bo?=
 =?us-ascii?Q?3k8VouIV/zQcR5MY+mIDeO8tGOy2T/f0fCZUr6EJXZehWalcO/YMFvecTN2y?=
 =?us-ascii?Q?4DSzT+avA2VHUnIhcK0sI+xoeaEE9fnYwYx7WFBEG/NBEf71DrHj2rWNADFB?=
 =?us-ascii?Q?0G4mmc/jh/XlV9WUYzU2Br5WEtiGmr6YBj4iN0tpJTqcDHelytqtJmaBoqSK?=
 =?us-ascii?Q?LpOOzm8sI/FG5qNgexmFLlJVWVeUZoRJJ5kPxGgJbKJuq5ZVRSxPlOTe47mo?=
 =?us-ascii?Q?Z+5LgrNj8pf/W8tHqxR5rIHabuoxc4K2mLrXbz4obRv0nd8jA2Jw9ZVC57n3?=
 =?us-ascii?Q?uuXihzrgLawW0xnhcd+MXf8JA2QCUTvGCfMAgONHyOBPSHpzALF5ov4/YRlB?=
 =?us-ascii?Q?zteenr1jy9Bwe3y+5XzxO/F+iEh+j1L3IdKQMvmGkF4DoI+f9jSJOreko69+?=
 =?us-ascii?Q?asHW0lOHLWa/bX+mcpbuzA7UshkmH06GLrwUkh6BdRL/UjG5mnb64G00ilfB?=
 =?us-ascii?Q?DFgar2Zd+kybN3TrrLCkxMIbc5WPgsKrevqPFx4lxzIEIXrO60Zxhr7mI27y?=
 =?us-ascii?Q?NBaUp5p0rhtD7CkOri5nmLIS8FI4ClzuXs8K3vvZAnM04W5Io8f1HVAQTYkW?=
 =?us-ascii?Q?y+D1kBtBWGuqTZg+E1JdhVx36RU3biJuVE+sCRDWbi3P3qKlLddYLrEYXukJ?=
 =?us-ascii?Q?rD/Gh6TcoJ/SmgwUpLU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:19.6699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070ad4ac-a8ec-44bc-8db0-08de4ec51ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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

Rather than saving and reemitting the ring's contents,
use the state stored in the job and fence to reemit
the state explicitly.  This greatly simplifies reemitting
the ring state and allows it to be reemitted over and
over if there are multiple ring resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 91 ++---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 35 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   | 29 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 50 +------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 15 +---
 5 files changed, 65 insertions(+), 155 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c1cb47e92d08c..28691f9b6e32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -89,16 +89,6 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
 	return seq;
 }
 
-static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
-{
-	af->fence_wptr_start = af->ring->wptr;
-}
-
-static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
-{
-	af->fence_wptr_end = af->ring->wptr;
-}
-
 /**
  * amdgpu_fence_emit - emit a fence on the requested ring
  *
@@ -154,11 +144,8 @@ int amdgpu_fence_init(struct amdgpu_ring *ring, struct amdgpu_fence *af)
 void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		       unsigned int flags)
 {
-	amdgpu_fence_save_fence_wptr_start(af);
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       af->base.seqno, flags | AMDGPU_FENCE_FLAG_INT);
-	amdgpu_fence_save_fence_wptr_end(af);
-	amdgpu_fence_save_wptr(af);
 }
 
 /**
@@ -743,7 +730,6 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 	struct amdgpu_ring *ring = af->ring;
 	unsigned long flags;
 	u32 seq, last_seq;
-	bool reemitted = false;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
@@ -761,84 +747,17 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
-			if (fence->reemitted > 1)
-				reemitted = true;
-			else if (fence == af)
+			if (fence == af) {
 				dma_fence_set_error(&fence->base, -ETIME);
-			else if (fence->context == af->context)
+				fence->skip_ib = true;
+			} else if (fence->context == af->context) {
 				dma_fence_set_error(&fence->base, -ECANCELED);
-		}
-		rcu_read_unlock();
-	} while (last_seq != seq);
-	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
-
-	if (reemitted) {
-		/* if we've already reemitted once then just cancel everything */
-		amdgpu_fence_driver_force_completion(af->ring, &af->base);
-		af->ring->ring_backup_entries_to_copy = 0;
-	}
-}
-
-void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
-{
-	af->wptr = af->ring->wptr;
-}
-
-static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
-						   u64 start_wptr, u32 end_wptr)
-{
-	unsigned int first_idx = start_wptr & ring->buf_mask;
-	unsigned int last_idx = end_wptr & ring->buf_mask;
-	unsigned int i;
-
-	/* Backup the contents of the ring buffer. */
-	for (i = first_idx; i != last_idx; ++i, i &= ring->buf_mask)
-		ring->ring_backup[ring->ring_backup_entries_to_copy++] = ring->ring[i];
-}
-
-void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
-					     struct amdgpu_fence *guilty_fence)
-{
-	struct dma_fence *unprocessed;
-	struct dma_fence __rcu **ptr;
-	struct amdgpu_fence *fence;
-	u64 wptr;
-	u32 seq, last_seq;
-
-	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
-	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
-	wptr = ring->fence_drv.signalled_wptr;
-	ring->ring_backup_entries_to_copy = 0;
-
-	do {
-		last_seq++;
-		last_seq &= ring->fence_drv.num_fences_mask;
-
-		ptr = &ring->fence_drv.fences[last_seq];
-		rcu_read_lock();
-		unprocessed = rcu_dereference(*ptr);
-
-		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
-			fence = container_of(unprocessed, struct amdgpu_fence, base);
-
-			/* save everything if the ring is not guilty, otherwise
-			 * just save the content from other contexts.
-			 */
-			if (!fence->reemitted &&
-			    (!guilty_fence || (fence->context != guilty_fence->context))) {
-				amdgpu_ring_backup_unprocessed_command(ring, wptr,
-								       fence->wptr);
-			} else if (!fence->reemitted) {
-				/* always save the fence */
-				amdgpu_ring_backup_unprocessed_command(ring,
-								       fence->fence_wptr_start,
-								       fence->fence_wptr_end);
+				fence->skip_ib = true;
 			}
-			wptr = fence->wptr;
-			fence->reemitted++;
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
+	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 0e648fbe0980f..15a7daf5b9fa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -99,7 +99,7 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
 	amdgpu_sa_bo_free(&ib->sa_bo, f);
 }
 
-static int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job)
+int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int vmid = AMDGPU_JOB_GET_VMID(job);
@@ -135,6 +135,31 @@ static int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job)
 		return r;
 	}
 
+	if (job->hw_fence->skip_ib) {
+		if (ring->funcs->insert_start)
+			ring->funcs->insert_start(ring);
+		if (job->emit_vm_fence) {
+			amdgpu_ring_ib_begin(ring);
+			if (ring->funcs->init_cond_exec)
+				cond_exec = amdgpu_ring_init_cond_exec(ring,
+								       ring->cond_exe_gpu_addr);
+			amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
+			amdgpu_ring_ib_end(ring);
+			amdgpu_ring_patch_cond_exec(ring, cond_exec);
+		}
+		amdgpu_ring_ib_begin(ring);
+		if (ring->funcs->init_cond_exec)
+			cond_exec = amdgpu_ring_init_cond_exec(ring,
+							       ring->cond_exe_gpu_addr);
+		amdgpu_fence_emit(ring, job->hw_fence, fence_flags);
+		if (ring->funcs->insert_end)
+			ring->funcs->insert_end(ring);
+		amdgpu_ring_patch_cond_exec(ring, cond_exec);
+		amdgpu_ring_ib_end(ring);
+		amdgpu_ring_commit(ring);
+		return 0;
+	}
+
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);
 
@@ -221,14 +246,6 @@ static int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job)
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
-	/* Save the wptr associated with this fence.
-	 * This must be last for resets to work properly
-	 * as we need to save the wptr associated with this
-	 * fence so we know what rings contents to backup
-	 * after we reset the queue.
-	 */
-	amdgpu_fence_save_wptr(job->hw_fence);
-
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3834c1b288eab..91821207636ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -85,6 +85,33 @@ static void amdgpu_job_core_dump(struct amdgpu_device *adev,
 	}
 }
 
+static int amdgpu_job_reemit_jobs(struct drm_sched_job *timedout_s_job)
+{
+	struct amdgpu_job *timedout_job = to_amdgpu_job(timedout_s_job);
+	struct amdgpu_ring *ring = to_amdgpu_ring(timedout_s_job->sched);
+	struct drm_gpu_scheduler *sched = &ring->sched;
+	struct drm_sched_job *s_job, *tmp;
+	int r;
+
+	/* skip reemit if we reset all the rings on an instance */
+	if (ring->all_instance_rings_reset)
+		return 0;
+
+	r = amdgpu_ib_emit(ring, timedout_job);
+	if (r)
+		return r;
+	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
+		struct amdgpu_job *job = to_amdgpu_job(s_job);
+
+		r = amdgpu_ib_emit(ring, job);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+
 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
@@ -138,6 +165,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
 		drm_sched_wqueue_stop(&ring->sched);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
+		if (!r)
+			r = amdgpu_job_reemit_jobs(s_job);
 		if (!r) {
 			/* Start the scheduler again */
 			drm_sched_wqueue_start(&ring->sched);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 8cb10d71ee733..1d94707fc86d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -104,29 +104,6 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 	return 0;
 }
 
-/**
- * amdgpu_ring_alloc_reemit - allocate space on the ring buffer for reemit
- *
- * @ring: amdgpu_ring structure holding ring information
- * @ndw: number of dwords to allocate in the ring buffer
- *
- * Allocate @ndw dwords in the ring buffer (all asics).
- * doesn't check the max_dw limit as we may be reemitting
- * several submissions.
- */
-static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
-{
-	/* Align requested size with padding so unlock_commit can
-	 * pad safely */
-	ndw = (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
-
-	ring->count_dw = ndw;
-	ring->wptr_old = ring->wptr;
-
-	if (ring->funcs->begin_use)
-		ring->funcs->begin_use(ring);
-}
-
 /**
  * amdgpu_ring_insert_nop - insert NOP packets
  *
@@ -370,12 +347,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	/*  Initialize cached_rptr to 0 */
 	ring->cached_rptr = 0;
 
-	if (!ring->ring_backup) {
-		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
-		if (!ring->ring_backup)
-			return -ENOMEM;
-	}
-
 	/* Allocate ring buffer */
 	if (ring->ring_obj == NULL) {
 		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_bytes,
@@ -386,7 +357,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 					    (void **)&ring->ring);
 		if (r) {
 			dev_err(adev->dev, "(%d) ring create failed\n", r);
-			kvfree(ring->ring_backup);
 			return r;
 		}
 		amdgpu_ring_clear_ring(ring);
@@ -430,8 +400,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	amdgpu_bo_free_kernel(&ring->ring_obj,
 			      &ring->gpu_addr,
 			      (void **)&ring->ring);
-	kvfree(ring->ring_backup);
-	ring->ring_backup = NULL;
 
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
@@ -868,8 +836,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence)
 {
-	/* back up the non-guilty commands */
-	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	/* signal the guilty fence and set an error on all fences from the context */
 	if (guilty_fence)
 		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
@@ -879,22 +845,8 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence)
 {
-	unsigned int i;
-	int r;
-
 	/* verify that the ring is functional */
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-
-	/* Re-emit the non-guilty commands */
-	if (ring->ring_backup_entries_to_copy) {
-		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
-		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
-			amdgpu_ring_write(ring, ring->ring_backup[i]);
-		amdgpu_ring_commit(ring);
-	}
-	return 0;
+	return amdgpu_ring_test_ring(ring);
 }
 
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 63272425a12f6..eae82b802399f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -150,11 +150,8 @@ struct amdgpu_fence {
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
-	/* has this fence been reemitted */
-	unsigned int			reemitted;
-	/* wptr for the fence for the submission */
-	u64				fence_wptr_start;
-	u64				fence_wptr_end;
+	/*  fence state */
+	bool				skip_ib;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -163,7 +160,6 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
 					  struct dma_fence *timedout_fence);
 void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
-void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -312,9 +308,6 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
-	/* backups for resets */
-	uint32_t		*ring_backup;
-	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	u32			*rptr_cpu_addr;
@@ -572,14 +565,14 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		  enum amdgpu_ib_pool_type pool,
 		  struct amdgpu_ib *ib);
 void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f);
+int amdgpu_ib_emit(struct amdgpu_ring *ring, struct amdgpu_job *job);
 int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f);
+
 int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
-void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
-					     struct amdgpu_fence *guilty_fence);
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence);
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
-- 
2.52.0

