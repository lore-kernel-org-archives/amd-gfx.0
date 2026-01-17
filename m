Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DA0C9832A
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Jan 2026 20:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC2410E063;
	Sat, 17 Jan 2026 20:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KSnIE1sH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8B210E063
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Jan 2026 20:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZCYx5Hd0jMeKrVvwy2tex20xtTldUiVEPDRKb5Bu5v4xmobiaTNChWygDgFSOQYVoRRVzvtwp4WXbHbqLFNe7We1ml1R4d94TI23qUDjHxUo4gIl5Yi3Z9OD8luR7FF+YJYcZtI1Fo6rHgueeAzOBnV6Ntr5NrkqyoBZqNF9eBgTxAiIVY11uvWykHAZ2hKqYFr6ooX5mL7WrrBG7nfQ46THN6CdlUDQu8IalCEBXwrUAiI555lBZDRsnwyjtNEjcZ0Su2ttIx8Z3Oq25yHgRgm80IFkktnx1SyFTohMQoPVRaasJ9CnnHkn4AXsJ3M3bhqWS79OM/YiWvXWm8qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y24pGn5WciCqVaTbFqWwRk1DWDTezUnn6V7DlvZC/ao=;
 b=JyuH1Nmbm25aPGj5hz0Wm3qTpf6eqdyNH8PlDs4q2/OHf6S4+Onlq0DVy1rmPX9V2IY1zDvzGOSQ/EidLECZtjKFvX7NswDEWx1bgxiudLQ6T18QVqK3M+VtM+t7JMCs2+jR/EGegmIA3jlt9cBIyTBmGdWf+8EVWqowdrjfUS7frrRJvkEoN4c6FKos1CF1Y/8J/v+4X65fY9Fj+WxJNOJb6cfNstiPJLoJH1f5/90auNeHsr/kwDOx0h4Dc9AZZTzrEMe5xpN0880zRLHO65W7YXiAk5wBJzv9hI8YiEpG3SavkE/ZjohaRoGMyLc+hJGOHgyjx0fttulLlYEQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y24pGn5WciCqVaTbFqWwRk1DWDTezUnn6V7DlvZC/ao=;
 b=KSnIE1sH6MLbWYc2yoNEHon90Bx5OMWoqeC9TcvoscxlpYr6OeGuDPeWnxihVLzQnLEUAbTmt10Y5sDQ12f6mkSj/HgUKaYnxFxXZiAbJSsSBCJXk9+Glq8u2kQLHPDILJKncQvTtluLLFv7lROaYVmLFcNvt44LGCINcyxMupw=
Received: from BN9PR03CA0861.namprd03.prod.outlook.com (2603:10b6:408:13d::26)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Sat, 17 Jan
 2026 20:28:22 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::5) by BN9PR03CA0861.outlook.office365.com
 (2603:10b6:408:13d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Sat,
 17 Jan 2026 20:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Sat, 17 Jan 2026 20:28:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 17 Jan
 2026 14:28:22 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 17 Jan
 2026 14:28:21 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sat, 17 Jan 2026 14:28:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 10/10] drm/amdgpu: rework ring reset backup and reemit v2
Date: Sat, 17 Jan 2026 15:28:07 -0500
Message-ID: <20260117202807.15055-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfd3169-4c09-4ef7-3bc1-08de5606f5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XHTBcOVKK5KLbVGz7Jm0PmYSCPsohjdKsbsW89DQ1mHY+DpR2XhxPj5nK3iB?=
 =?us-ascii?Q?KEMZIVbDN7xqSrydLGVzPcilHbHWTyvRpYbZaapLfryEAr3R0u915iqmfi8H?=
 =?us-ascii?Q?FHxJIKfHq3eKjWp5IHWK+UKGalKGqX72JoOaFuG5fDYk8Fdark2ZeMpIEDuF?=
 =?us-ascii?Q?eQop1AKYSfqVMNW2n4eQ+Qsaa64eKWAlLJp3zgE3WHXtvCsObT1mpXJP4KfJ?=
 =?us-ascii?Q?52W3TWMNs+e2vbeB/JrhM/iiAuaBgO1HCPLeF9NUlEkeRBz01fKckM7h34y/?=
 =?us-ascii?Q?oJUlL9ZjGqNMcN077tTOrzInPNaKeMhkF88vEDchWpQse33iJl9xa/Yke9BI?=
 =?us-ascii?Q?ybXPYLtzHQjNH2cl0j2frJLFB8bolm6TGlk/MHVcaCa2lG6oD1d3m2TKMOzj?=
 =?us-ascii?Q?A68ULwi/Zty+yqNmi6NOdNHFlEXLOSM5m1AsgVdBzKPlACSm4XN1fmTSM591?=
 =?us-ascii?Q?LSeXUmdsYHNf8kFoQ+2mobpR/HD8khNDFiATybmyJWomupBIzRUavSrheUKv?=
 =?us-ascii?Q?/Hl7DzBZfMlKQEXduUrWzGE3zkNxd66JO0goOHsAom/ops060OcmShBSPkcw?=
 =?us-ascii?Q?iLJmdNkAZrFAxyXDDv2nwGOfPaftW7UHlOyWQcMM6GdvzF2+ihQRWEOpyurb?=
 =?us-ascii?Q?XBESI2kaEb+EABmcfjlSK2CCIUYFCSJw2IZ9U9tCFPqIZLSzv8qQCTgIH/9D?=
 =?us-ascii?Q?HwMh6dyk8Mr7SCFVdys943mkl8c5tZwP0pnoUw11A2uBdQ51uk15Np0f2zb3?=
 =?us-ascii?Q?A4JjNilYxmXzzGB9fvCeKLyCDWvGLPA/lQDrefTS6gpfWy0U7l4kQkPDk5FV?=
 =?us-ascii?Q?/qzdEepboFfIDmpzxYzHEQ4ebhLITptif1ipJV4ZookjHSf/jcqwoJcwSxAt?=
 =?us-ascii?Q?k9jphUV9Vh8tsPNuvcPDRgkyb7Gu1V3ButoB6/CFRGyb3Qtq4ZIezZtQc8xh?=
 =?us-ascii?Q?D1juEUKeVCSUhebsKsJafTr0vTPhFOOiAdbcfYYp3GgmVfpWOsEVsVgbfDIj?=
 =?us-ascii?Q?i7+xw6yUzdCKF/BTNrLVrrdO/Ev6RGbGbZ+SIMUVGXO9Xvr8or0bblL78+2m?=
 =?us-ascii?Q?267V5o5dLfUSMw54Rb2qlLAvmblDF4b4zATSvrxhSV+PgGdeLHLyEZ/WzWvD?=
 =?us-ascii?Q?3TkcHFN03v0RgAOzbD4ZJVSG8jtjy5+c+Z6XVenlGOn1o4r5xPpK6XBTlfiW?=
 =?us-ascii?Q?MpmNbdUwjB/+Jw/1No9U+6pz6jke4tdSkjqVll3gTslH5SxA1/NOQUxh7QZR?=
 =?us-ascii?Q?PydU2MFmQnayQvhYgX71rRjj9xrX6a65U2s5S2h/0X61irEGImo2VCWY9NcC?=
 =?us-ascii?Q?ixy0WWTRXuoWxwQOP58TqXxpmRe1qsOYEH2eQDN128h937BEbHGz6A01vpYy?=
 =?us-ascii?Q?4eBz5EJG5a0fVgjHAwJXivUgwGDgyztnOgQ9+1Ka3YseQ1Ins5ZtG2EqDu+J?=
 =?us-ascii?Q?GgmvRgLoyWFBCMQkNyzHRPR4fuPx88/9MFCA8aW2Q80ObFDKVq4zBGgJXsxi?=
 =?us-ascii?Q?uMdKrhV/OMaRv4yv9Ksb5edbzd2Mf3UeZYKXZrzuBKiO3w2K4bQ3xXrRWLZp?=
 =?us-ascii?Q?nTGMKEKVY1SS6PE0171Ah58qBbm6V8DUJph4N1/39UTpFbbFJZYTu3pHUMlz?=
 =?us-ascii?Q?Tr1wi7pC94YGZCBXOe7qhnI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 20:28:22.4981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfd3169-4c09-4ef7-3bc1-08de5606f5b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709
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

Store the start wptr and ib size in the IB fence. On queue
reset, save the ring contents of all IBs. Since the VM fence
is a sub-fence of the the IB fence, the IB fence stores the
state for both fences as the IB state encapsulates the VM fence
state.

For reemit, reemit the entire IB state for non-guilty contexts.
For guilty contexts, replace all of the IB state except the
fences with NOPs.  Split the reemit per non-vm fence annd when
we reemit, update the wptr with the new values from reemit.
This allows us to reemit jobs repeatedly as the wptrs get
properly updated each time.

v2: further simplify the logic

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

I've reworked patch 10 of this series to further simplify things.
The rest are the same.

Git tree available as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/ib_improvements3?ref_type=heads

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 111 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  46 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  24 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |   3 +
 5 files changed, 84 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d48f61076c06a..75b3acabedfd5 100644
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
@@ -727,25 +709,26 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
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
 
-	/* mark all fences from the guilty context with an error */
+	ring->reemit = true;
+	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
 	do {
 		last_seq++;
@@ -758,38 +741,54 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
-			if (fence->reemitted > 1)
-				reemitted = true;
-			else if (fence == af)
+			/* mark all fences from the guilty context with an error */
+			if (fence == guilty_fence)
 				dma_fence_set_error(&fence->base, -ETIME);
-			else if (fence->context == af->context)
+			else if (fence->context == guilty_fence->context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
+
+			/* Non-vm fence has all the state. */
+			if (!fence->is_vm_fence) {
+				/* reemit the packet stream and update wptrs */
+				fence->ib_wptr = ring->wptr;
+				for (i = 0; i < fence->ib_dw_size; i++) {
+					if (fence->context == guilty_fence->context) {
+						/* just emit the fences if guilty context */
+						if (fence->vm_fence_dw_start_offset &&
+						    i >= fence->vm_fence_dw_start_offset &&
+						    i < fence->vm_fence_dw_end_offset)
+							amdgpu_ring_write(ring,
+									  ring->ring_backup[fence->backup_idx + i]);
+						else if (i >= fence->fence_dw_start_offset &&
+							 i < fence->fence_dw_end_offset)
+							amdgpu_ring_write(ring,
+									  ring->ring_backup[fence->backup_idx + i]);
+						else
+							amdgpu_ring_write(ring, ring->funcs->nop);
+					} else {
+						/* emit the whole IB */
+						amdgpu_ring_write(ring, ring->ring_backup[fence->backup_idx + i]);
+					}
+				}
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
+	ring->reemit = false;
 }
 
 static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
-						   u64 start_wptr, u64 end_wptr)
+						   struct amdgpu_fence *af)
 {
-	unsigned int first_idx = start_wptr & ring->buf_mask;
-	unsigned int last_idx = end_wptr & ring->buf_mask;
+	unsigned int first_idx = af->ib_wptr & ring->buf_mask;
+	unsigned int dw_size = af->ib_dw_size;
 	unsigned int i;
 
+	af->backup_idx = ring->ring_backup_entries_to_copy;
 	/* Backup the contents of the ring buffer. */
-	for (i = first_idx; i != last_idx; ++i, i &= ring->buf_mask)
+	for (i = first_idx; dw_size > 0; ++i, i &= ring->buf_mask, --dw_size)
 		ring->ring_backup[ring->ring_backup_entries_to_copy++] = ring->ring[i];
 }
 
@@ -799,12 +798,10 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
-	u64 wptr;
 	u32 seq, last_seq;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
-	wptr = ring->fence_drv.signalled_wptr;
 	ring->ring_backup_entries_to_copy = 0;
 
 	do {
@@ -818,21 +815,9 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
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
+			/* Non-vm fence has all the state. */
+			if (!fence->is_vm_fence)
+				amdgpu_ring_backup_unprocessed_command(ring, fence);
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index fb58637ed1507..89c2673f91f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -137,7 +137,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool need_pipe_sync = false;
 	unsigned int cond_exec;
 	unsigned int i;
-	int r = 0;
+	int r = 0, count_dw;
 
 	if (!job)
 		return -EINVAL;
@@ -185,6 +185,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
 		return r;
 	}
+	af->ib_wptr = ring->wptr;
+	count_dw = ring->count_dw;
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
@@ -278,6 +280,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
+	af->fence_dw_start_offset = count_dw - ring->count_dw;
 	r = amdgpu_fence_emit(ring, af, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
@@ -286,6 +289,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	af->fence_dw_end_offset = count_dw - ring->count_dw;
 	*f = &af->base;
 	/* get a ref for the job */
 	dma_fence_get(*f);
@@ -303,13 +307,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
-	/* Save the wptr associated with this fence.
-	 * This must be last for resets to work properly
-	 * as we need to save the wptr associated with this
-	 * fence so we know what rings contents to backup
-	 * after we reset the queue.
-	 */
-	amdgpu_fence_save_wptr(af);
+	af->ib_dw_size = count_dw - ring->count_dw;
+	if (af->vm_fence_dw_start_offset) {
+		af->vm_fence_dw_start_offset = count_dw - af->vm_fence_dw_start_offset;
+		af->vm_fence_dw_end_offset = count_dw - af->vm_fence_dw_end_offset;
+	}
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index b82357c657237..5862e05cc26b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -90,10 +90,13 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 	ndw = (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
 
 	/* Make sure we aren't trying to allocate more space
-	 * than the maximum for one submission
+	 * than the maximum for one submission.  Skip for reemit
+	 * since we may be reemitting several submissions.
 	 */
-	if (WARN_ON_ONCE(ndw > ring->max_dw))
-		return -ENOMEM;
+	if (!ring->reemit) {
+		if (WARN_ON_ONCE(ndw > ring->max_dw))
+			return -ENOMEM;
+	}
 
 	ring->count_dw = ndw;
 	ring->wptr_old = ring->wptr;
@@ -104,29 +107,6 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
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
@@ -877,7 +857,6 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence)
 {
-	unsigned int i;
 	int r;
 
 	/* verify that the ring is functional */
@@ -885,16 +864,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
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
index ce095427611fb..88e0db27be55f 100644
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
@@ -146,15 +145,19 @@ struct amdgpu_fence {
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
 
-	/* wptr for the total submission for resets */
-	u64				wptr;
+	bool				is_vm_fence;
+	unsigned int			flags;
+	/* location and size of the IB */
+	u64				ib_wptr;
+	unsigned int			ib_dw_size;
+	unsigned int			vm_fence_dw_start_offset;
+	unsigned int			vm_fence_dw_end_offset;
+	unsigned int			fence_dw_start_offset;
+	unsigned int			fence_dw_end_offset;
 	/* fence context for resets */
 	u64				context;
-	/* has this fence been reemitted */
-	unsigned int			reemitted;
-	/* wptr for the fence for the submission */
-	u64				fence_wptr_start;
-	u64				fence_wptr_end;
+	/* idx for ring backups */
+	unsigned int			backup_idx;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -162,8 +165,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
 					  struct dma_fence *timedout_fence);
-void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
-void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
+void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -314,6 +317,7 @@ struct amdgpu_ring {
 	/* backups for resets */
 	uint32_t		*ring_backup;
 	unsigned int		ring_backup_entries_to_copy;
+	bool			reemit;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	u32			*rptr_cpu_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a2ea200d90c8..bd4021bb18ae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -845,9 +845,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
+		job->hw_fence->vm_fence_dw_start_offset = ring->count_dw;
 		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
 		if (r)
 			return r;
+		job->hw_vm_fence->is_vm_fence = true;
+		job->hw_fence->vm_fence_dw_end_offset = ring->count_dw;
 		fence = &job->hw_vm_fence->base;
 		/* get a ref for the job */
 		dma_fence_get(fence);
-- 
2.52.0

