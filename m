Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71B8D2ECFE
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 01:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB5710E550;
	Tue, 20 Jan 2026 01:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gt8klknE";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B7710E54A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 01:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xItFZcrAI/bP5sLZc3iUSgKg7LBa44UDXkdKN+wY/x9JkwlIGgvoIJTdu2f7HmbalZ4OB00sVi1cTwdza8xsS3MDgmcSF+sPCf74Wv8L0R7fgKQcQCYu2qTdYnLaFvx/BQmkFytcaiGM+gucM+4Y1yD0shT0PtFWQBt8Rq92CHSSR3n9y+JCrmWJ7uEErrZHhuCCvz6E8b4HouUR3/amBKxrD//3BCYQkDy1QtFYQlQXlLGrSuyDcGQ1g0nGQgXehEwZgQTSqxlc1/UPurY+1iTpsPHLCP6BAtG2bsTqaUlBO5QxfMZwmKhOIQOVQSG+3/OzI8oh0ZXG+Z7FTKjFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=336PKe5QtLP8g9eNUedDn6klHIgY1MvAON3unZ3HXuE=;
 b=jFRjnUUtw+cm+MEOj/jiHQ3sf8bgqod4bJElTIPHZZW8xWf2tmVfbXc6vfbq6NOLjd2sjwopG1nj1rAxOIAmwpeSfoThd1IJX+qtw9rWtNLe/hnvhxJjIh6tNhVcGI0s78C9BxASgEzK1MNcYV3dlrAVMIVUmunkMx1KFPwrDb2WIzFtQAuYWTP0Spa3DdlM4ID6eVt8QeLgB0DWsZU4fpPWQdOMnBTyVD0xXAAEgOPRxpMyLxzopohr2hvAw2Pb9l6Ho1nN2xoGkKeC7noB5QgmfKlaeNa+rlWqLDJz5dYt9Gmz772TWo1MxkY0T4ry3u+xBLAHvRD/Mx/Wvm0vcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=336PKe5QtLP8g9eNUedDn6klHIgY1MvAON3unZ3HXuE=;
 b=gt8klknE5PSPBhclpj8UnvPd3fMWM9yuqxXDfg3cK/4FPlve/aNC9oQIu99HGJK7fEPchaQHFf/FK3XwZYnacHZeYNCApjcuhS33aEv1v4eIju04fK7sG2OEK0F6Dk+KULir73Q+kEfRxdWS/vj3RX/vDb+mdSzZJ1XmC98PPg0=
Received: from BY3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:254::16)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 01:34:28 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::61) by BY3PR05CA0011.outlook.office365.com
 (2603:10b6:a03:254::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 01:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 01:34:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 19:34:23 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 17:34:23 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/10] drm/amdgpu: rework ring reset backup and reemit v3
Date: Mon, 19 Jan 2026 20:34:11 -0500
Message-ID: <20260120013411.15659-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013411.15659-1-alexander.deucher@amd.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a812fbf-f703-4a57-25be-08de57c40d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sQ2I7swMTtY5ps2Ofpkqs+5nmKP5U69r6TxK7DXbY5t3R844lqo0OKVfYJ5m?=
 =?us-ascii?Q?O6NwjNegd/hH0yYrkky11dni54b+IOTIPNMZKReGVf+e2wZw+enxfhQygl26?=
 =?us-ascii?Q?gHDCv+ulSPD/vlvb2awDvGtVY1vo33+BDVCEg33VYTYXZbPXRwfUgem95Saz?=
 =?us-ascii?Q?X0uZsrz6GBi7PGH0f8wVW4tUkieeZSI8/VMc08FD8PqrwYZTA7q2nrLmR81M?=
 =?us-ascii?Q?eKCOFwQPtphOESky8t848+VEZYwquW4a8nbqc5T9cTuoZipU3mOEvT3J6ilD?=
 =?us-ascii?Q?HHOPFJ9mxTzv5iUXXyss5wG8VFEY0jcDKLdY52rpamM7kkTgtED6KQozr5Gr?=
 =?us-ascii?Q?/WB/TpsXusRo05I1xHZUzZ3nYzRPuOxFfR3vI+Lvcd2wtDwuA7XGv4bevx7H?=
 =?us-ascii?Q?5FdtKHty4BClcIKjawrlXYhx5ImT0udHroe9q02B3SGHSvt9BQXaNeE3ZGfH?=
 =?us-ascii?Q?+Psx+KLLhnWmFRmj1moVP4lnB2a/p7y2rmxoLSVGRmRGN5/R4XPqnhdIgXx7?=
 =?us-ascii?Q?CZQAAXOTc6UCt2aHgyLNlwedUIfktg1po2/sXdq3SRMiOdQlE9BlFv7CjLLj?=
 =?us-ascii?Q?ZNUzQ79iSCulNX8PXvMrWuTkvvcSjXPb2IF9MB2aFSC3vfz1c3vGAG4FDfZ/?=
 =?us-ascii?Q?ftPitp7Tbs2/6U8iZPrer7jpgCTvmAR6+vERH0mgQaecEKkErkvu227vuna6?=
 =?us-ascii?Q?JWXreHxX1ADneR4aHTWcwVd8A26i+rnvF8jymCMcL5jv+BkL8BkDmCw3GxRC?=
 =?us-ascii?Q?YxMwBItIBgJXOfqKw6druQbLHR5QHb0iZNnOawvZ/qX3xebT6U1Ga0Qc8+E+?=
 =?us-ascii?Q?/NMe4gURPSNH1N97yZjktcFsdsdwqt4GOxuKNqGxbswaUsfv8w48WcY8H/z2?=
 =?us-ascii?Q?oWhXU9YOrNLVx0+1IQpFaTjdJSHAoV7NTO1/h03JvF+Fv8HsJCTjXVO8qu3K?=
 =?us-ascii?Q?KRMIC05oopKvVZJDAEylBCSLPxYUjR0cPVqc3vzXXtkVBozr67Sc6MvwjFq/?=
 =?us-ascii?Q?6HIJ++qjhzLDYW5Iac3fcqV5I2kJB1/pnu2G1wnz3wHCJYkbdedjg1AMjCuv?=
 =?us-ascii?Q?PzTFH2Xua7MSJ5eEl2Q8HlArhZ0FHeLVnNlyOVqVNTOFrbaO+BjiVA5O/8NU?=
 =?us-ascii?Q?FQF6NP50Setmi+4AfuR92OaI175rl4lFPeC+KgMRNoEHCF/14eJyjNeRZzzq?=
 =?us-ascii?Q?hFf93UgGQCnmudvwn40ewec1VynuMWR5KFoOQ0WXEze/Bu+sEl2jzNKR9T/y?=
 =?us-ascii?Q?IM6ygbjBuH4Z9KHZxCiipB1wX5THsWOGwAAQbeLLWW/myQJvYy7bNB0nClZ0?=
 =?us-ascii?Q?Y87TFpJJMoAgcgoXfFMmDseltUIV9gWa5Oq5NS5qkazx+G9Tfwf6pWbYtiQG?=
 =?us-ascii?Q?O20SAS3LvGH5siEs/9GDrpgcbr5NEG1HEyFF/CfWN06izhB8aomPUNz6Qzr1?=
 =?us-ascii?Q?4Co5BlOdStmlqWdk3oapWxCMKNpJ20pK8u4flHq0pyYVxYf6DP+y7YfOZ6TI?=
 =?us-ascii?Q?lGwiLG3g3yBaBR3iA9K1Y/CxnzMNPxRSDsO+hx5g2yD5hW1sKqGjqzM1asEJ?=
 =?us-ascii?Q?fbsJADFpng43bBozfgE46WZVbxtGi1SQxPQLu7CCpP9VQOzcQgissMMLk/F9?=
 =?us-ascii?Q?EVnV/Yc9T5E91FB9Fj1NRBPQd6TEJuDjDfzg4vee7+QVHExo7Jkluskp37xI?=
 =?us-ascii?Q?uBQ1xw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:34:27.8444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a812fbf-f703-4a57-25be-08de57c40d32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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
fences and vm state with NOPs.  Split the reemit per non-vm fence
and when we reemit, update the wptr with the new values from reemit.
This allows us to reemit jobs repeatedly as the wptrs get
properly updated each time.

v2: further simplify the logic
v3: reemit vm state, not just vm fence

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 110 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  46 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  24 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |   6 ++
 5 files changed, 86 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d48f61076c06a..b123343cbfe7e 100644
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
@@ -758,38 +741,53 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
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
+						/* just emit the vm state and fences if guilty context */
+						if (i >= fence->vm_state_dw_start_offset &&
+						    i < fence->vm_state_dw_end_offset)
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
 
@@ -799,12 +797,10 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
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
@@ -818,21 +814,9 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
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
index 78987ecdfe03a..8c3610dd757e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -135,7 +135,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool need_pipe_sync = false;
 	unsigned int cond_exec;
 	unsigned int i;
-	int r = 0;
+	int r = 0, count_dw;
 
 	if (!job)
 		return -EINVAL;
@@ -178,6 +178,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
 		return r;
 	}
+	af->ib_wptr = ring->wptr;
+	count_dw = ring->count_dw;
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
@@ -271,6 +273,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
+	af->fence_dw_start_offset = count_dw - ring->count_dw;
 	r = amdgpu_fence_emit(ring, af, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
@@ -279,6 +282,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	af->fence_dw_end_offset = count_dw - ring->count_dw;
 	*f = &af->base;
 	/* get a ref for the job */
 	dma_fence_get(*f);
@@ -296,13 +300,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
+	if (af->vm_state_dw_start_offset) {
+		af->vm_state_dw_start_offset = count_dw - af->vm_state_dw_start_offset;
+		af->vm_state_dw_end_offset = count_dw - af->vm_state_dw_end_offset;
+	}
 
 	amdgpu_ring_ib_end(ring);
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
index ce095427611fb..69c4224da88ad 100644
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
+	unsigned int			vm_state_dw_start_offset;
+	unsigned int			vm_state_dw_end_offset;
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
index 6a2ea200d90c8..d217f2044c83a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -825,6 +825,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (cleaner_shader_needed)
 		ring->funcs->emit_cleaner_shader(ring);
 
+	/* mark the start of the vm state */
+	job->hw_fence->vm_state_dw_start_offset = ring->count_dw;
+
 	if (vm_flush_needed) {
 		trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
 		amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_addr);
@@ -848,10 +851,13 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
 		if (r)
 			return r;
+		job->hw_vm_fence->is_vm_fence = true;
 		fence = &job->hw_vm_fence->base;
 		/* get a ref for the job */
 		dma_fence_get(fence);
 	}
+	/* mark the end of the vm state */
+	job->hw_fence->vm_state_dw_end_offset = ring->count_dw;
 
 	if (vm_flush_needed) {
 		mutex_lock(&id_mgr->lock);
-- 
2.52.0

