Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D530BD77881
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA2010EB71;
	Fri, 23 Jan 2026 17:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q22VlJIi";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0C410EB71
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=et0GssCXoQJw5BAAExpnd5vm8g95FID0QMjTAr0CuSaqsrYKG0SM3N5BdDx4pwx1t6EwsHP5fLD/jJxmrS6l1xdyPvQrR5HIfDXQv/+l5/+Sduy90DK8eJR/Gq3DHrq6cswP0kxv32OC+ZhFQthvY7wxWT2kGm8B3Y4mXaUpw+Nbspq1iQMTv6pamfSib3Z7PnZEQFqOABLrP+hceN7HyxlvjST6C7mpPu++KTNVYQZzx2OZVNkf6UlkHD4Tif2e801ItE8Zwk4aCukTZS4b+AgeZQgcNwMlbfM7guKCRzWIb+eqoc1lDceiVoqCt1S90uCgqzhNQF5Yk1mRKsZh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIanSN/Uhj0kCy42bxLoPr3DxCANinMCP5BGubY6Sh8=;
 b=BLsduiFXE7V7DpikO3HKzeSRDqc+S8rNxJ9MXPZKOeJ1DeaPZh8WCExaO9kZkI2g1zl48YKEAdfeXOXKF2RANE0dtdaO5mpc24rZAwyrDKdvyStYNN+IBhDHm1sJ9NvWPD6fc6jTK08QUnvyTF+H/05DyZe8s6MHBbpndGxAs/dF3CwImRvE498mN8iRPuYTpTChTubtvVCHYcF8+rlkYnrAb1g/JowZrgdMKFcxUhulAc6tFrqINo4R67w76Eo+/YwMH2dvAfHuXtzNSB7sIkYH8c/oQW9+MQ0RahQvs2XDb9pg/hNNrtYIAP/mWEcX2VkfpGf7MWl1K7nLufNPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIanSN/Uhj0kCy42bxLoPr3DxCANinMCP5BGubY6Sh8=;
 b=q22VlJIiSObePSY93SuofIZ1dp/HNUR74rGgURkPUGTMRVsW/Uyw+ji0WBqCzCNYTyTpzBOV0OM6MrBwSVZVk1nf+7ejjgDRix9VYDdvMzyceM4S045zoIs15lERAiul9qgkGnLacoveFr1eGP+E5DduGPc209O7CRDrUo/J52k=
Received: from CH2PR11CA0020.namprd11.prod.outlook.com (2603:10b6:610:54::30)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 17:19:55 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::a1) by CH2PR11CA0020.outlook.office365.com
 (2603:10b6:610:54::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 17:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:19:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 23 Jan
 2026 11:19:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Jan
 2026 11:19:50 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 11:19:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 11/11] drm/amdgpu: rework ring reset backup and reemit v6
Date: Fri, 23 Jan 2026 12:19:37 -0500
Message-ID: <20260123171938.16814-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123171938.16814-1-alexander.deucher@amd.com>
References: <20260123171938.16814-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f6fe48-2616-4936-8ec8-08de5aa3a06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hQ2979N54Ayp6WzkrSuwPRGF3b8XAAynwHOXj2JmvJMs86lo1krZ1dYpzrhF?=
 =?us-ascii?Q?pV/ZjHiRR7ppaGaf8ukY2SfXK/+BkhVjU/LpBwQjK7SWENHLkKX9lnKQmXy2?=
 =?us-ascii?Q?mX04QbO32nXj5JZN/xAd1VqTsp7Thbe+Lql3KfMztuh39yqJIMoPt33/EHEl?=
 =?us-ascii?Q?mnnoM1CeGxg6UXvE230N3jEG3DiprwqkyzWxlmv3X+MdH+PFkoqHC2xglxIO?=
 =?us-ascii?Q?2NXb8yBFkHBM/2AIlR0mlsSBfN22Eb1BzX0yhDkuB17k3CjdghnwL/Tl1REH?=
 =?us-ascii?Q?vxw8Y8Q6oRHqrxtqgLllhqpotnTTUYx/k9vrDLkyAdZww9xWcijfMKY2JVrC?=
 =?us-ascii?Q?ed1WfqksLl7DRiy5vGjD+o0t/7LI1W0ZI6udE0+8ndOL6SnFdOdJREb2yy3W?=
 =?us-ascii?Q?UyTT9w1RNJZySh7LXwJJX19PWW/3ybGh/G1xmzoNqvvYwy9aHO6jRuWfN4zn?=
 =?us-ascii?Q?XcXcWlOsNyQvZEDBI63EaHqQq09F5Qg29OFe9yygBp01HKj0lCLOrXtAT5u0?=
 =?us-ascii?Q?AlGiZvRMv3gVJRSacyRAHhUqNTJtilAoRGz7X+qhN8JlDQESXEu/sWHp8Hem?=
 =?us-ascii?Q?GmAiYa5dt0H/iZ7A2hFpOi7TfwOkMGCr3Uy8ekYp25toII7i7om/JnNe8HFP?=
 =?us-ascii?Q?lk2/0YeTWgrbSuczG1Fr9E2OCOKaT/DZ/o1EGK7Q+Tmki22QRuT0jrZVVTqj?=
 =?us-ascii?Q?WM0QLlrpOYpPuqyetWs47wKVHQdICrqWmrg2kudtQ/rSfAe+F/m9vGpBmma/?=
 =?us-ascii?Q?FWmDGMKhqLs3RZBiCKrU2B0adf0MLZJXAD8sGmp6ryymibCo4Sj9wctQPSaY?=
 =?us-ascii?Q?gp/bSNOKVl/dL+ap3VNrquWTIQ94IzsfW+95fxL8VV5shH8X3Fp3PHq2lpGE?=
 =?us-ascii?Q?CQCDBXbW/nStBi6qq3v1l6a7bUssI+FFTgE6FSgi9+ue/Rb9mYVDc3hHARsv?=
 =?us-ascii?Q?jqQk4+C+wF7xrkOVUG/AqYRs1GlI1zrlynyPoEzBTnvzwkQbmT1AVZ+G8axv?=
 =?us-ascii?Q?Q7LGBownHNDiZce/DpUXC37iyh7bB1yZKsl/SK9nXJPOBy9/YIkbhsjFiWQ/?=
 =?us-ascii?Q?wARMUvifpCKcF99aFZoZEAQiDyqUI1AqAgU8wcBSj57KLqNCwVRbSDxzF0+H?=
 =?us-ascii?Q?I38O0qvXmhDrgxJ3FBID2DXKS5f8sRmYzRgvOqx6kSQ52yR0K1p+0BjIaQXK?=
 =?us-ascii?Q?4HtnSUK3lXEo6RcPEOXivq3iFax0aQWKSWVGHXvw00Ct48i/bKvf9hmsg6rH?=
 =?us-ascii?Q?+t6gLtKz3xhQY1/HHZLPY3DB26wUYcvPW794GrpZHYoZhktnoB0e+pQPOUzL?=
 =?us-ascii?Q?22SpwQFSfpvq2m95KyqtBan2nSRQLuIgeI8Gju2tO/xwNPtPT6n/wKstFqJi?=
 =?us-ascii?Q?GNDzGzdh6GzECM9fJoRDk4VsmHgQ+0s+MYsfg79OTAt+eMfsrynBuiW41EFN?=
 =?us-ascii?Q?pZj4NG0RIfFgl1hytyk97cNQyQQdY3vx8+iGsUQbGyW5b2Cbc5kO95jIaDas?=
 =?us-ascii?Q?1w0AjtCKTZ7ocmA7lryLLxwTZUKbfqAI6kOP+qWZLSUf5gSAIP2AkNTs5lFf?=
 =?us-ascii?Q?3mV9jtvQNwc8dQQ15aq8lO5M0dhIBTJVbHZzj6Q8s+LYse8abhACnCIt1RXG?=
 =?us-ascii?Q?eRMv3yyq7PwI/bIwyxTB41/lSTtAoD7W82kebCICIbjMss7Bz/2+I8KoZIPb?=
 =?us-ascii?Q?wRL8Ig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:19:55.0476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f6fe48-2616-4936-8ec8-08de5aa3a06f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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
For guilty contexts, replace the IB submission with nops, but reemit
the rest.  Special handling is required for the vm fence as that
likely signalled before the job fence even if the job ultimately
hung.  Skip the vm state if the vm fence signalled.  Split the reemit
per fence and when we reemit, update the wptr with the new values
from reemit.  This allows us to reemit jobs repeatedly as the wptrs get
properly updated each time.

v2: further simplify the logic
v3: reemit vm state, not just vm fence
v4: just nop the IB and possibly the VM portion of the submission
v5: simplify the vm fence check
v6: split the vm and ib fences

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 98 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 27 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 46 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 20 ++---
 4 files changed, 73 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d48f61076c06a..dcd313e09f379 100644
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
@@ -126,11 +116,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		       &ring->fence_drv.lock,
 		       adev->fence_context + ring->idx, seq);
 
-	amdgpu_fence_save_fence_wptr_start(af);
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
-	amdgpu_fence_save_fence_wptr_end(af);
-	amdgpu_fence_save_wptr(af);
+
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
@@ -241,7 +229,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 
 	do {
 		struct dma_fence *fence, **ptr;
-		struct amdgpu_fence *am_fence;
 
 		++last_seq;
 		last_seq &= drv->num_fences_mask;
@@ -254,12 +241,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
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
@@ -727,25 +708,28 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
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
+	bool is_guilty_fence;
+	bool is_guilty_context;
 
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 
-	/* mark all fences from the guilty context with an error */
+	ring->reemit = true;
+	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
 	do {
 		last_seq++;
@@ -757,39 +741,45 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
+			is_guilty_fence = fence == guilty_fence;
+			is_guilty_context = fence->context == guilty_fence->context;
 
-			if (fence->reemitted > 1)
-				reemitted = true;
-			else if (fence == af)
+			/* mark all fences from the guilty context with an error */
+			if (is_guilty_fence)
 				dma_fence_set_error(&fence->base, -ETIME);
-			else if (fence->context == af->context)
+			else if (is_guilty_context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
+
+			/* reemit the packet stream and update wptrs */
+			fence->ib_wptr = ring->wptr;
+			for (i = 0; i < fence->ib_dw_size; i++) {
+				/* Skip the IB(s) for the guilty context. */
+				if (is_guilty_context &&
+				    i >= fence->skip_ib_dw_start_offset &&
+				    i < fence->skip_ib_dw_end_offset)
+					amdgpu_ring_write(ring, ring->funcs->nop);
+				else
+					amdgpu_ring_write(ring,
+							  ring->ring_backup[fence->backup_idx + i]);
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
 
@@ -799,12 +789,10 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
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
@@ -818,21 +806,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
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
+			amdgpu_ring_backup_unprocessed_command(ring, fence);
 		}
 		rcu_read_unlock();
 	} while (last_seq != seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index fc02756673860..2ff22a8bd7b07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -126,6 +126,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
+	struct amdgpu_fence *vm_af;
 	bool need_ctx_switch;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
@@ -135,7 +136,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool need_pipe_sync = false;
 	unsigned int cond_exec;
 	unsigned int i;
-	int r = 0;
+	int r = 0, count_dw;
 
 	if (!job)
 		return -EINVAL;
@@ -146,13 +147,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	fence_ctx = job->base.s_fence ?
 		job->base.s_fence->finished.context : 0;
 	af = job->hw_fence;
+	vm_af = job->hw_vm_fence;
 	/* Save the context of the job for reset handling.
 	 * The driver needs this so it can skip the ring
 	 * contents for guilty contexts.
 	 */
 	af->context = fence_ctx;
 	/* the vm fence is also part of the job's context */
-	job->hw_vm_fence->context = fence_ctx;
+	vm_af->context = fence_ctx;
 
 	if (!ring->sched.ready) {
 		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
@@ -192,11 +194,19 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		dma_fence_put(tmp);
 	}
 
+	/* VM sequence */
+	vm_af->ib_wptr = ring->wptr;
+	count_dw = ring->count_dw;
 	r = amdgpu_vm_flush(ring, job, need_pipe_sync);
 	if (r) {
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	vm_af->ib_dw_size = count_dw - ring->count_dw;
+
+	/* IB sequence */
+	af->ib_wptr = ring->wptr;
+	count_dw = ring->count_dw;
 
 	amdgpu_ring_ib_begin(ring);
 
@@ -218,6 +228,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		cond_exec = amdgpu_ring_init_cond_exec(ring,
 						       ring->cond_exe_gpu_addr);
 
+	/* Skip the IB for guilty contexts */
+	af->skip_ib_dw_start_offset = count_dw - ring->count_dw;
 	amdgpu_device_flush_hdp(adev, ring);
 
 	if (need_ctx_switch)
@@ -256,6 +268,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
 	amdgpu_device_invalidate_hdp(adev, ring);
+	/* Skip the IB for guilty contexts */
+	af->skip_ib_dw_end_offset = count_dw - ring->count_dw;
 
 	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
@@ -297,13 +311,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		ring->funcs->emit_wave_limit(ring, false);
 
 	amdgpu_ring_ib_end(ring);
-	/* Save the wptr associated with this fence.
-	 * This must be last for resets to work properly
-	 * as we need to save the wptr associated with this
-	 * fence so we know what rings contents to backup
-	 * after we reset the queue.
-	 */
-	amdgpu_fence_save_wptr(af);
+
+	af->ib_dw_size = count_dw - ring->count_dw;
 
 	amdgpu_ring_commit(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 129ad51386535..83750ab4e81b5 100644
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
@@ -875,7 +855,6 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *guilty_fence)
 {
-	unsigned int i;
 	int r;
 
 	/* verify that the ring is functional */
@@ -883,16 +862,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
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
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ce095427611fb..9231896d603d8 100644
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
@@ -146,15 +145,15 @@ struct amdgpu_fence {
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
 
-	/* wptr for the total submission for resets */
-	u64				wptr;
+	/* location and size of the IB */
+	u64				ib_wptr;
+	unsigned int			ib_dw_size;
+	unsigned int			skip_ib_dw_start_offset;
+	unsigned int			skip_ib_dw_end_offset;
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
@@ -162,8 +161,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
 					  struct dma_fence *timedout_fence);
-void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
-void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
+void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -314,6 +313,7 @@ struct amdgpu_ring {
 	/* backups for resets */
 	uint32_t		*ring_backup;
 	unsigned int		ring_backup_entries_to_copy;
+	bool			reemit;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	u32			*rptr_cpu_addr;
-- 
2.52.0

