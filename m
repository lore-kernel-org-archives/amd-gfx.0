Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB9CE83838
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 21:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF5E10E3ED;
	Mon, 16 Feb 2026 21:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vrW8K3xc";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7186110E0E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 21:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsSlZugkAbOaqZ2DOYJJ0iK9oso6ayRlksgmLbdu1wXoFyCEI2E7ZP7PQqDEppjLtImCrUdeOej8GFe3cKKHe6z5z/DA89RRS1WVIEPLg6Fa3WGqw44XBCm345hYsk/MeP4aMN8avSiMFY2p0ppkvvSkcIpnGTMYRREFceNh4Uk5d6Dm+mY79ortaltduEwGHXkWE0t7IZZSZHnx6Ra4g+SOH4Cx1oFhk/uTJ/bmc6wyG1eg9Y4mrC8zDOWi8csmaKKw6JlHP/jR8tsGjWUpZeYKR2mJcgs7QK760Zj4YlrdHblrOjjOvIwv6Gc5xv0AjpPd3Gm4QRqb7sXMsOb3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZttnHCE41ExKo5fgoc4Nho7U+IzKEDIpFuREE/+CUc=;
 b=XfdneTlAryqQr4KbhJ1jKKXNjRf4YjmvnCz3T0c8FdYCboY6hO2J3CDPmd51u7afGagmTg4ibBgY7zFP5iw7mnJ3sEKtStZtk9absEH5F44qpCU1d0O+1NHztYc1BxOV3A3osigttOlFZ+tkmsuxOQuD8rxdEBF9Cw1Z7r95aTLWLCxLOIDY9bLWTbsyyCtq0Bx9RzuZgegLetnOf09r/ODIuuSb563zh1af/yQQTyk136uJkJXiuZcHO3sYXXEsxKraOppZ4CHanitCZyvhpoKfF0esGwGjQN+vnMpOR7S4GajRSnUGH8cLZIh4hvLDo7WJW5QbB/jXAoKEirSXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZttnHCE41ExKo5fgoc4Nho7U+IzKEDIpFuREE/+CUc=;
 b=vrW8K3xcRtST3SY8ZJizgvspmoR98nSsQz5+ljQS1uOXUO5Hv8JxRlWAy1DxYQkdIMxtTLBaWVT4l7FFCJqEr2Pii8W/R6leca5n6HCfLe4bvX2NKEId3cyZdCxoN116Zto2eK98YulJNmalk9mOl0XIuBtCV2p1zAwmd9B7YI8=
Received: from BN0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:408:ea::17)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 21:13:50 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::da) by BN0PR04CA0072.outlook.office365.com
 (2603:10b6:408:ea::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 21:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 16 Feb 2026 21:13:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 15:13:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 15:13:49 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 15:13:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: rework ring reset backup and reemit v9
Date: Mon, 16 Feb 2026 16:13:33 -0500
Message-ID: <20260216211340.16364-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216211340.16364-1-alexander.deucher@amd.com>
References: <20260216211340.16364-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d2bd9e-80ab-4b3f-e3da-08de6da047b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yHErAVqZR/UF4G7cFyvx0YVU40N/M+h5hkai7CoN6Eo/tPAQVCZLvXHsZdbc?=
 =?us-ascii?Q?XvUhwwBOFI0G1wJDy6tOexvpumVy4LzdtFwehdcGRi0IAyOiJWN0sLBeyL9+?=
 =?us-ascii?Q?ReYGc/7Xpkkc0g9tm3ZU68+8Qsu6fEWcbCWnNH54I8Dhdhqh/55UwW1Uk/oV?=
 =?us-ascii?Q?sgB9CMUGN7un6Wn6P3mfXXs5inJrkhie4+jheXXHV1Q4CA+c8J8aMeY7sCCb?=
 =?us-ascii?Q?QLFK9HJjKBAKXrtneNC2xl6JXdpsSJAVYtAgdIpoLWkGb8SfE8oxzXSCfa3n?=
 =?us-ascii?Q?fmc43bsZz6pl/N+QRFfGpLpS4EfI4W/QMsbykcgnapFTA4i0KAkllfTXeQnu?=
 =?us-ascii?Q?m7DPSJTexeUWKZFMLjHk4zS78s0fm2ZDBC3c3GJdM6UzHb2rFw3jxLQYt9+1?=
 =?us-ascii?Q?T28w3SUPTHwKUPvjfxzPk0gdgT6B7UKzWyd3RnCrgHz7HcmsDRPI/yVoSdnd?=
 =?us-ascii?Q?EOTzYz2xtUB48K9KM7PNh8eQGRyzipqz3hDMca+TxbVUbcieYEAs0qa/kRDk?=
 =?us-ascii?Q?fxsTrqTgf42nZI8aHdz9aIEqUFryGZBzCoBtwczqWtKNDNJTy9O9VdX5TjLA?=
 =?us-ascii?Q?kFBJq107bqxZ9937nKZR2ydWOMc//RAt0WBD8NtHZbw4PZjP06UN3wEJlJKi?=
 =?us-ascii?Q?OqCSpl8nWBEX86ER3f8sU54LR/QfrBG0vzah2XLnVoAm8q4+O7d+i0Sk1XZo?=
 =?us-ascii?Q?nXDMn7BpKtlGmLb5gGnm7aj/tx6Fp/thf43siIv3F6GUymLHJLnWqrWzeLtW?=
 =?us-ascii?Q?fvJnaqO2sx++18lFcYeDax1q4ILwWjSC6VZfwCeSD5tQl4hxZdOAqrkdpgD3?=
 =?us-ascii?Q?1UbnEVwTx4sRZkqcH9bRRAH02eonfAsptukeARHPWVM6+vLeXwht1rPqstUu?=
 =?us-ascii?Q?mb8LYD0q6bqabwo4DlKaTfBCPMHPYSXHUTLkc4XD08xm77UrXhUTGEEOJRAO?=
 =?us-ascii?Q?vzaL/xX47+ITsxyLmTIIK4EJLcbE324ZBAJG73RLgUGFrYm0I2+2VG0Ce3MS?=
 =?us-ascii?Q?lgzjLFigQgHF61z4dCIY0T6O+/oQAVU7LFkWGH+txL/cibeaUYE4GEdXrF8o?=
 =?us-ascii?Q?R7hG7GwVlsRqt/k2LX4lX35DuiZL5lZc72fyDMOPUO0nSZM7eiUEO1nkeWTq?=
 =?us-ascii?Q?CkwwnU6qjVP6UCzJnOsAC7mQDvqH4Qdld8djQKtMcHvS5ifM1AxBHgCib45k?=
 =?us-ascii?Q?rcDiI42fh9ZLNtNIyn61t306dqRNhE8j8ZT+ZXUpVb39NyeESIGrKijqzXBR?=
 =?us-ascii?Q?KP860qDpzGoJocLtleTMz/AE8CiXwK/iMY1Yw4E3RbbT0tKTAASo99FooZ80?=
 =?us-ascii?Q?AiHFhFtszvo4l6NceklXV5Hvjh468AHCphSjHSbu1i5IvV2zg08xSnAg4JgE?=
 =?us-ascii?Q?Z2dezMonW10dya8Hw96UHYIuSfgwnpOeXXQoAv3Ej1nMYbxIpEUHHZOLTrDi?=
 =?us-ascii?Q?iGGFsDVMHnzDFOAnuhlDWOOoowYFLIOp9DesDc64KzFxDi4zHAJ6v2SAQ6EU?=
 =?us-ascii?Q?m6jd0oksahhIX+lBJk561nO1H3rnRdJzxpq4e83SU9VRFQmd1MukXXs4QKJC?=
 =?us-ascii?Q?5j+Rx22r6giLJTpGxxMuEA7Yxgxs2bOOCQ63xikDIOGrlCG2i09C5fWZ8Z1L?=
 =?us-ascii?Q?IZCiPq6An5/j0SnlEdoydVM1rw/FYbr44Kf7GI3UVDTbnIDB2HdNT/rVq379?=
 =?us-ascii?Q?8nJOBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QsDxZi/7MPULRUSd+Xtl2ZLfA+5BSWBfjRZUNE9Fa2/7oaAdnqgcrtJEgVYewor3f5nLc52Oc2KiMqwQZR4w1gfZfdWiA6CqhcVIFVss4k3D/498DX7p38XcPgdgayQDUFecPRhFXg1SUKA4JqJ2SJ2oAKufxFibFMjnVljkUMiF+FgfS/MLVoZPVHSJBDFd28wzkZNwUkyKosK58kQNNQMth0MosMEbpGEBat9/2sR0Mtx2hhLGEPJYDupK1uVdX5KemTihEqRfzVZz5Baefj/NEAH1HXlJUZA2Yoj61aI6gkxP7c0aC3OjeoMKPj62mBfueFYNBdLKeFV5rA5W6OGyKCnOVwZN/IjmzwPyH2eqScRvFstXrpUV+H+5PssaBLTIup/vCqXujl1m73ThqdhYHMYCPFomLg0H9ccuiUtF89MDBsP0EfpbzXOG204e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 21:13:49.7850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d2bd9e-80ab-4b3f-e3da-08de6da047b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044
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
reset, save the ring contents of all IBs.

For reemit, reemit the entire IB state for non-guilty contexts.
For guilty contexts, replace the IB submission with nops, but reemit
the rest.  Split the reemit per fence and when we reemit, update the
wptr with the new values from reemit.  This allows us to reemit jobs
repeatedly as the wptrs get properly updated each time.

v2: further simplify the logic
v3: reemit vm state, not just vm fence
v4: just nop the IB and possibly the VM portion of the submission
v5: simplify the vm fence check
v6: split the vm and ib fences
v7: fix commit message
v8: use wptr rather than count_dw to calculate offsets
v9: fix missing documenation update spotted by the kernel test robot

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 99 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 26 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 46 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 20 ++---
 4 files changed, 74 insertions(+), 117 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 07568516c5066..d209591e3710a 100644
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
@@ -124,11 +114,9 @@ void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
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
@@ -240,7 +228,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 
 	do {
 		struct dma_fence *fence, **ptr;
-		struct amdgpu_fence *am_fence;
 
 		++last_seq;
 		last_seq &= drv->num_fences_mask;
@@ -253,12 +240,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
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
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -707,25 +688,29 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
  */
 
 /**
- * amdgpu_fence_driver_update_timedout_fence_state - Update fence state and set errors
+ * amdgpu_ring_set_fence_errors_and_reemit - Set dma_fence errors and reemit
  *
- * @af: fence of the ring to update
+ * @ring: the ring to operate on
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
@@ -737,39 +722,45 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 
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
-		amdgpu_fence_driver_force_completion(af->ring);
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
 
@@ -779,12 +770,10 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
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
@@ -798,21 +787,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
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
index eb92c96d290b6..f1ed4a436f5b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -129,6 +129,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
+	struct amdgpu_fence *vm_af;
 	bool need_ctx_switch;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
@@ -215,9 +216,17 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		dma_fence_put(tmp);
 	}
 
-	if (job)
+	if (job) {
+		vm_af = job->hw_vm_fence;
+		/* VM sequence */
+		vm_af->ib_wptr = ring->wptr;
 		amdgpu_vm_flush(ring, job, need_pipe_sync);
+		vm_af->ib_dw_size =
+			amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
+	}
 
+	/* IB sequence */
+	af->ib_wptr = ring->wptr;
 	amdgpu_ring_ib_begin(ring);
 
 	if (ring->funcs->insert_start)
@@ -238,6 +247,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		cond_exec = amdgpu_ring_init_cond_exec(ring,
 						       ring->cond_exe_gpu_addr);
 
+	/* Skip the IB for guilty contexts */
+	af->skip_ib_dw_start_offset =
+		amdgpu_ring_get_dw_distance(ring, af->ib_wptr, ring->wptr);
 	amdgpu_device_flush_hdp(adev, ring);
 
 	if (need_ctx_switch)
@@ -276,6 +288,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
 	amdgpu_device_invalidate_hdp(adev, ring);
+	/* Skip the IB for guilty contexts */
+	af->skip_ib_dw_end_offset =
+		amdgpu_ring_get_dw_distance(ring, af->ib_wptr, ring->wptr);
 
 	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
@@ -312,13 +327,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
+	af->ib_dw_size = amdgpu_ring_get_dw_distance(ring, af->ib_wptr, ring->wptr);
 
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
index 5a82db0888f0a..ce5af137ee400 100644
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
@@ -146,23 +145,23 @@ struct amdgpu_fence {
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
 
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
-void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
-void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
+void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -313,6 +312,7 @@ struct amdgpu_ring {
 	/* backups for resets */
 	uint32_t		*ring_backup;
 	unsigned int		ring_backup_entries_to_copy;
+	bool			reemit;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	u32			*rptr_cpu_addr;
-- 
2.53.0

