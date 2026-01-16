Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0CAC982D8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F16710E8DD;
	Fri, 16 Jan 2026 16:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zpkWf2i3";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D71410E8DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTplB/Z/SKFo4XHYWbImCZcsg4DSKkyjXbETzIqbfj+WInuIrXDMLU8nDdYoLE/kDRCPW9fJkThqLjIudQLwTbUhTPWPadMEDS3WDDbySxFdvKFoZjwkkfKfLoLPg/io8an52V+M+JI+hci74dvBLC+BondyoEOS8+piWrNT9QgG9isY4CsqmZMNMlvFOOicuauJhhM1QbbCBuzMUWx7r9dFBq1idMcqyPdgtq5OOxN3WY7acJUEZXO2jC+U1/8gWuhqcQOG8K/d5Ebd2QdFIOK42AoN7gsV3SCUGuEMCHE8HUQA2MoQHEu5byKGXvgW2H4xTYis2RIxOLYqSV6pDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26kqYDbfp7jWij+ZrCfFuIrMMHQM8v47TLg14jZWzh8=;
 b=W2I4zlbX3NGphFA4D9qNjg+tw4UZOfUeUCDj0HKY29txBVyvKVhU2TDfz1u+RSUV+UmLVT8XQqQNOr/XOuxton4T4wOCT7Mnn0TGH+1o6QXFLyMy15q7OqDp70ULKe4aKRYd8HtexQus7dX5i+8SLxxUZkyLPaBivd57SksGIUiH5jV7FqK8EkX7/QBlf0HxLJ/8cBRV9b58vaMnaLm/+mkwP3Uq9CYNH8T9UDhvzBudIwHqDH+PW04Dtav99Hy1eGgUozZW8YSZGMmKES90Pd5hl1rKVsGb2bEtpTuL45aJrXDs8UyWb1D28JJS4KSDNK21HXkQHS7NBDGoC1KZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26kqYDbfp7jWij+ZrCfFuIrMMHQM8v47TLg14jZWzh8=;
 b=zpkWf2i3bSxV1CVNJimtqzIHyjBybtOXsoW6lQdPLdln3GiFY7sgeyxuRhK016HNIdF8ZiAnn4D6lyKGOVAoRqEA2gZXcZWo5V2YpT3cwqvzW3TtCCFq0PIVJpJmAMQGoBfzUmb397Fuw0jXf9ZA/ShO7Z8qniIoJTaQoFAVm2w=
Received: from BL1PR13CA0332.namprd13.prod.outlook.com (2603:10b6:208:2c6::7)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 16:20:52 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::5) by BL1PR13CA0332.outlook.office365.com
 (2603:10b6:208:2c6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.2 via Frontend Transport; Fri,
 16 Jan 2026 16:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 16:20:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:45 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 10:20:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/10] drm/amdgpu: rework ring reset backup and reemit
Date: Fri, 16 Jan 2026 11:20:27 -0500
Message-ID: <20260116162027.21550-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116162027.21550-1-alexander.deucher@amd.com>
References: <20260116162027.21550-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8243a7-830e-4a77-1ca9-08de551b3594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nyjSKqh0ktM8ShycUE0aYJ9NMQlCD4DfFDD/i7rJQ/b1IMjtEpuiil8qFPsz?=
 =?us-ascii?Q?TJiBIr+cWY9ACCsEurhBanq5xqH55OvFzQkBFaUwiXq2S1jFLhF/rzJ1YeET?=
 =?us-ascii?Q?mp3pGraMG1+ruiaFBMQQbjyxhK02TFag4OR5dOZzccwdztNYWvhEz6kN5YcS?=
 =?us-ascii?Q?Xq3jhWARv5rQifKIsZzRN54iQF6y+ju3AmCLRlZgtpdhKW+3zqcbve9FMtTi?=
 =?us-ascii?Q?Sayuu7DjKtmT0sti0Llnrucfew3nUKE9RFDM7fDWiOI0cutpZRTDxPIPg681?=
 =?us-ascii?Q?BfluN+ZVg7yzwWMyHdiyOnBvirVKJgCZZyrrT3JwL52wS6gH1mglax2M6/EG?=
 =?us-ascii?Q?Wd7kmmcadLsEo8R/DqhLYJJ0yWCjr9BkVVtqKwf+4UDAfBRbQZfQ6qKDJgW6?=
 =?us-ascii?Q?tHfjOp5RufRs5DIiAiLRRk4zrdVr7YQWv/EfCJwbMsnJsdAYaR7qvVxdGM71?=
 =?us-ascii?Q?B7ZJgylS6aHW7CQV23iFRkuvtbIPs0oAICU+HbDGywBdRf5Q9XqfLCFyro5e?=
 =?us-ascii?Q?1o0LaA2Wz4LvMtis1p8vex3N8CG47F4lZGdTDZ7IcoelB8rNZYV+dfg83iv7?=
 =?us-ascii?Q?qzS9Nr6xDe2CROeUVmio8dsC9CVxPmplrGofTGmzTyzMguLAOWFckgxJmoBc?=
 =?us-ascii?Q?si0kbAPSztRGL5d5KSs22kmOZrh7HQ7gqgnrPRzHRRV8i9Ob+NHxLxegxYzQ?=
 =?us-ascii?Q?D5j7HzNxdzTm2PEPvb+LVr9Q9xgOXaG5sr6+MBmky0fHQBnaT8db7J7nQAfr?=
 =?us-ascii?Q?apMpuh92S3lpluC4rpfRkqbVHJHan0t/J/34JmDIVp69q1nODGWob4jw2XKa?=
 =?us-ascii?Q?7t2xckvmLZVPNb7kBwXkA0fDrMafCTEO9hYLlCuyWpe+Tl8B4B8s2dSLqCHk?=
 =?us-ascii?Q?gCgIMauI/qsjTF7SD/yNu+aLBccFkCviti9cPU00OhLFI2xyzuvelag3an4h?=
 =?us-ascii?Q?KbWAI7+tO1tIx/INFxcy3Wq1gqBgr/Nv5G++WDv9qSxs9Puy0tJ5ZzB4DPmE?=
 =?us-ascii?Q?bzgB0PHNQrUg9RfP1PwelcZQejokDKF1L0gTqOkETyeqjS0wNOnTGS5tu7Ii?=
 =?us-ascii?Q?nr7xhwCD4AtTpmwLCeQ5SXybSAXJ5ipvNsTt1TM0Km8QPb8oGTIHcoaXgBaL?=
 =?us-ascii?Q?nnN6IapsLo/Zhvt3qvSca92f+fCIffJlJF2JgsXUqp7x4FhZQDuF5EPa7W31?=
 =?us-ascii?Q?hZf7akA7SBhxZkWa7Y6cWDw/VCG6eyqcKkcF3liY5zh2J1pINs7o/hKg9Q6N?=
 =?us-ascii?Q?seUcUIBoOfJdzxk/NSRgRCyJU/t7UP/QR50fLIrnWk5G9gPoFCExTS30+fkV?=
 =?us-ascii?Q?dhhS7jGjkavAiZPjdvL4exHzu2/VcS5tfxxssqg+L3Rh1Q1TKRQeWx2IjgoQ?=
 =?us-ascii?Q?qnOS1OfRisEMmyEYj8Pjl2RjoWbm4hIYWqVv70cqdGQ1x1ZyEw4YuhUgUlXM?=
 =?us-ascii?Q?m3lqk/29LcNZpHQ8UTRyLHu3B++wqg10NxbXTYVXJsPL/o9UuZPCVxT8nyqN?=
 =?us-ascii?Q?v4zYri+JV/MRVUrEDYgEC3V1eJAcHogBwCdPzyHmQU3FWLObIEqyzcsWh2LG?=
 =?us-ascii?Q?dk8ALod1RLohS85hFS6djWyLJPyTrzzUIR75vXqOPABHfmzEpR3yLqab1xiY?=
 =?us-ascii?Q?iqRpZOHiM70rFFdvXGOAsYoDHhZy5sx/whxJxW0hSqEWq4CaQibv+4DJfeML?=
 =?us-ascii?Q?NMqTjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:20:48.4114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8243a7-830e-4a77-1ca9-08de551b3594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

Store the start and end wptrs in the IB fence. On queue
reset, only save the ring contents of the non-guilty contexts.
Since the VM fence is a sub-fence of the the IB fence, the IB
fence stores the start and end wptrs for both fences as the IB
state encapsulates the VM fence state.

For reemit, only reemit the state for non-guilty contexts; for
guilty contexts, just emit the fences.  Split the reemit per
fence when when we reemit, update the start and end wptrs
with the new values from reemit.  This allows us to
reemit jobs repeatedly as the wptrs get properly updated
each time.  Submitting the fence directly also simplifies
the logic as we no longer need to store additional wptrs for
each fence within the IB ring sequence.  If the context is
guilty, we emit the fence(s) and if not, we reemit the
whole IB ring sequence for that IB.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 98 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  9 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 37 +--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 20 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  1 +
 5 files changed, 54 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d48f61076c06a..541cdbe1e28bf 100644
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
@@ -126,11 +116,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		       &ring->fence_drv.lock,
 		       adev->fence_context + ring->idx, seq);
 
-	amdgpu_fence_save_fence_wptr_start(af);
+	af->flags = flags | AMDGPU_FENCE_FLAG_INT;
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
-			       seq, flags | AMDGPU_FENCE_FLAG_INT);
-	amdgpu_fence_save_fence_wptr_end(af);
-	amdgpu_fence_save_wptr(af);
+			       seq, af->flags);
+
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
@@ -241,7 +230,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 
 	do {
 		struct dma_fence *fence, **ptr;
-		struct amdgpu_fence *am_fence;
 
 		++last_seq;
 		last_seq &= drv->num_fences_mask;
@@ -254,12 +242,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 		if (!fence)
 			continue;
 
-		/* Save the wptr in the fence driver so we know what the last processed
-		 * wptr was.  This is required for re-emitting the ring state for
-		 * queues that are reset but are not guilty and thus have no guilty fence.
-		 */
-		am_fence = container_of(fence, struct amdgpu_fence, base);
-		drv->signalled_wptr = am_fence->wptr;
 		dma_fence_signal(fence);
 		dma_fence_put(fence);
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -727,25 +709,27 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
  */
 
 /**
- * amdgpu_fence_driver_update_timedout_fence_state - Update fence state and set errors
+ * amdgpu_ring_set_fence_errors_and_reemit - Set dma_fence errors and reemit
  *
- * @af: fence of the ring to update
+ * @guilty_fence: fence of the ring to update
  *
  */
-void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
+void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence)
 {
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
-	struct amdgpu_ring *ring = af->ring;
 	unsigned long flags;
 	u32 seq, last_seq;
-	bool reemitted = false;
+	unsigned int i;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 
 	/* mark all fences from the guilty context with an error */
+	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy +
+			  20 * ring->guilty_fence_count);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
 	do {
 		last_seq++;
@@ -758,39 +742,41 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
-			if (fence->reemitted > 1)
-				reemitted = true;
-			else if (fence == af)
+			if (fence == guilty_fence)
 				dma_fence_set_error(&fence->base, -ETIME);
-			else if (fence->context == af->context)
+			else if (fence->context == guilty_fence->context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
+
+			if (fence->context == guilty_fence->context) {
+				/* just emit the fence for the guilty context */
+				amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+						       fence->base.seqno, fence->flags);
+			} else {
+				/* reemit the packet stream and update wptrs */
+				fence->wptr_start = ring->wptr;
+				for (i = 0; i < fence->backup_size; i++)
+					amdgpu_ring_write(ring, ring->ring_backup[fence->backup_idx + i]);
+				fence->wptr_end = ring->wptr;
+			}
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
 	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
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
+	amdgpu_ring_commit(ring);
 }
 
 static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
-						   u64 start_wptr, u64 end_wptr)
+						   struct amdgpu_fence *af)
 {
-	unsigned int first_idx = start_wptr & ring->buf_mask;
-	unsigned int last_idx = end_wptr & ring->buf_mask;
+	unsigned int first_idx = af->wptr_start & ring->buf_mask;
+	unsigned int last_idx = af->wptr_end & ring->buf_mask;
 	unsigned int i;
 
 	/* Backup the contents of the ring buffer. */
+	af->backup_idx = ring->ring_backup_entries_to_copy;
 	for (i = first_idx; i != last_idx; ++i, i &= ring->buf_mask)
 		ring->ring_backup[ring->ring_backup_entries_to_copy++] = ring->ring[i];
+	af->backup_size = ring->ring_backup_entries_to_copy - af->backup_idx;
 }
 
 void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
@@ -799,13 +785,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
-	u64 wptr;
 	u32 seq, last_seq;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
-	wptr = ring->fence_drv.signalled_wptr;
 	ring->ring_backup_entries_to_copy = 0;
+	ring->guilty_fence_count = 0;
 
 	do {
 		last_seq++;
@@ -818,21 +803,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
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
-			}
-			wptr = fence->wptr;
-			fence->reemitted++;
+			/* keep track of the guilty fences for reemit */
+			if (fence->context == guilty_fence->context)
+				ring->guilty_fence_count++;
+			/* Non-vm fence has all the state.  Backup the non-guilty contexts */
+			if (!fence->is_vm_fence && (fence->context != guilty_fence->context))
+				amdgpu_ring_backup_unprocessed_command(ring, fence);
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index fb58637ed1507..865a803026c3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -185,6 +185,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
 		return r;
 	}
+	af->wptr_start = ring->wptr;
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
@@ -303,13 +304,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
-	/* Save the wptr associated with this fence.
-	 * This must be last for resets to work properly
-	 * as we need to save the wptr associated with this
-	 * fence so we know what rings contents to backup
-	 * after we reset the queue.
-	 */
-	amdgpu_fence_save_wptr(af);
+	af->wptr_end = ring->wptr;
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index b82357c657237..df37335127979 100644
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
@@ -877,7 +854,6 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence)
 {
-	unsigned int i;
 	int r;
 
 	/* verify that the ring is functional */
@@ -885,16 +861,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* set an error on all fences from the context */
-	if (guilty_fence)
-		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
-	/* Re-emit the non-guilty commands */
-	if (ring->ring_backup_entries_to_copy) {
-		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
-		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
-			amdgpu_ring_write(ring, ring->ring_backup[i]);
-		amdgpu_ring_commit(ring);
-	}
+	/* set an error on all fences from the context and reemit */
+	amdgpu_ring_set_fence_errors_and_reemit(ring, guilty_fence);
+
 	/* Start the scheduler again */
 	drm_sched_wqueue_start(&ring->sched);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ce095427611fb..6dca1ccd2fc2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -121,7 +121,6 @@ struct amdgpu_fence_driver {
 	/* sync_seq is protected by ring emission lock */
 	uint32_t			sync_seq;
 	atomic_t			last_seq;
-	u64				signalled_wptr;
 	bool				initialized;
 	struct amdgpu_irq_src		*irq_src;
 	unsigned			irq_type;
@@ -146,15 +145,17 @@ struct amdgpu_fence {
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
 
+	bool				is_vm_fence;
+	unsigned int			flags;
 	/* wptr for the total submission for resets */
-	u64				wptr;
+	u64				wptr_start;
+	u64				wptr_end;
 	/* fence context for resets */
 	u64				context;
-	/* has this fence been reemitted */
-	unsigned int			reemitted;
-	/* wptr for the fence for the submission */
-	u64				fence_wptr_start;
-	u64				fence_wptr_end;
+	/* idx into the ring backup */
+	unsigned int			backup_idx;
+	unsigned int			backup_size;
+
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -162,8 +163,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
 					  struct dma_fence *timedout_fence);
-void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
-void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
+void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -314,6 +315,7 @@ struct amdgpu_ring {
 	/* backups for resets */
 	uint32_t		*ring_backup;
 	unsigned int		ring_backup_entries_to_copy;
+	unsigned int		guilty_fence_count;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	u32			*rptr_cpu_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a2ea200d90c8..bd2c01b1ef18f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -848,6 +848,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
 		if (r)
 			return r;
+		job->hw_vm_fence->is_vm_fence = true;
 		fence = &job->hw_vm_fence->base;
 		/* get a ref for the job */
 		dma_fence_get(fence);
-- 
2.52.0

