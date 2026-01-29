Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1858CD73E88
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F3010E2B5;
	Thu, 29 Jan 2026 20:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vnmzJqQ3";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57E910E2B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb9rimXoJc7dGpY5pagG8v8A1nE8gnlgoCzumH69recFWf1UvU07+JcZXVC+mADujvy+J3YNRESd+FQo8iNWfdYZKmTqMIDo7KBpd+yG26jyA4hYdstrIVvw6wFHl3omEA/ZHOMyXu4P8xx68lkdGlnGkPHjjH/bnbmZpHfFSQ/BqM+zk7kDR/y/wbP3ayXe/XWezvQomPRblq+MG7crT5+Lz7KOcTLxgNEzkWkvGmhBRB/dsuwR3a9Xc+/E4q/dzV9W88v3DtqJBnz3o2bgiLnbxD+5nQ+60dFecBgOQA/VPXPEe/RCSwjRG05ORJ+Q21AGVwWOAb8u4aQL9/Pkfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0vvx4zUz0eItI3xwIgrJlHz6gFXjWVXygrsuMQmvHM=;
 b=Yt/xtNa9qLJNGoxx2ichs9iS1xMejJqqlMvoYDrJJYEHunRxiqsBXZ6g83iJQtMkn+i356kXpXkNU9VKDH3bbCBiPIT/HrRu6BQYW2SXrj5MYn1k+3HJ1/8/tLcwte5R64ddK3QXUHx+lxaxHmM3BSSAen12m0mksoxEciOZtzXeUqiWrsgMgcvdDV0NKMyBMwBBwMmlk0FEitqqNkBzJRHqtWbU1nJQjf8/GeqYmCuovbgCBgCO0jzXVNDlN1iDf8LbuJ3bs/zi9SrprMiuLTtYAuTBZU4VEB0kwrS9jnNrCkKYa1GXTDNBJ3ohE3f6LxWGJBtNh1JliUMnfnx6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0vvx4zUz0eItI3xwIgrJlHz6gFXjWVXygrsuMQmvHM=;
 b=vnmzJqQ3MGPnLtjitkiKwvL/QIswYSsCMdDqNBF5umD1ti5rwt+G/fdpNpI8ewHMhtDg5EwUB+2kXvpy1pyxLVG1bDlY2ZrPGLUmGpus4wt3NsCWfJiufXBShrwUqfuBFcmH/bgBb16NBD/ijwBiVJZuALAC04YCkpqtrEhKKUw=
Received: from SA1P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::6)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 20:37:57 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::b) by SA1P222CA0030.outlook.office365.com
 (2603:10b6:806:22c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 20:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 20:37:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:56 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:56 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 12/12] drm/amdgpu: rework ring reset backup and reemit v8
Date: Thu, 29 Jan 2026 15:37:31 -0500
Message-ID: <20260129203731.21506-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: a41c34a0-4b8a-4cc3-87a7-08de5f764974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?THtMjaQr5ojqbhc4LCxKoXoWfqksXRXEaYQo+CRA+zZ2iNZ6sm94xj60o6W0?=
 =?us-ascii?Q?q+ZquLWHwiHWMeG0kIjhk0++DFz8FDfaM4iemUl1gRtdCkjfXDSJdSexw/RP?=
 =?us-ascii?Q?9nS12JMQCId2afLzaGivmEwiqUgIZWjdLdYqfHB0dfcoVonxqBYdn7JPZ65c?=
 =?us-ascii?Q?n8TGPaYWoSz81jBE1/E0Fl6CtjgbBgw2mNmcOASptqhwXOghZfSuJlDrtD8j?=
 =?us-ascii?Q?ec7MZXGwfyG+kT1mo0HBXrHW0ZE/yFo+qM9y+SEOQEhKICgt8UwFKtEMUA0L?=
 =?us-ascii?Q?iDWVHS86yvKYFLayH3XnMtSInkjmgssNZYpphOdBuBsVBw20sJFs0c3+zxP7?=
 =?us-ascii?Q?xBl0YaOSP6QUDd3B8TA5oXBaabKPvYY9ZH6YMzqPSQK6X0Jtc/cA1eH5i/Rj?=
 =?us-ascii?Q?BaQupA41BNEUhCqeW89zoR34ck595jGZuzxmsayXHZ45Ki6GmXPqKKEPENau?=
 =?us-ascii?Q?HyqqHO/eT/fymWP19dBVnit7jmcgEwLq0gxJ8lccNE4SSdulGvlOJ9+yIIfR?=
 =?us-ascii?Q?4rn29sUagjZaa6WSXBX3V+itM/JqxohMm8uDRGiDnGuPIP7xVLRKq7eJGaHp?=
 =?us-ascii?Q?N/hqycF309wLVGfBRX3uRk3N6KZ8yaTOOnN18YeLCzxSuSWH2AbOKQEhK+66?=
 =?us-ascii?Q?OtPUK3B9Xa9uObuP58cuZHxHjuxSM/YPQvSeB+gavujC53IkaScYmCRRIuj6?=
 =?us-ascii?Q?6baUlAaQfILyEEAE86beGdbsFmhiEac1Lb896I+d74ylquTzPyjAdOJgNDAk?=
 =?us-ascii?Q?QzKrEZb1GQ2xF5RUTXdly+2jAMEwJTwbnKjmigbguuZSgZV9AsRIxy2TLON7?=
 =?us-ascii?Q?/yyxGyYs7UK96MGo97uoj/STjUxruC0+vbnjm149ZdAR493cGZEFVRCVg0IM?=
 =?us-ascii?Q?NljSzoNRQQwPw9X5EdZgEPse2miMyLtJ0dXyGXLkw9hibYCq0hEYPZOD8BGX?=
 =?us-ascii?Q?vfwkBvvOPMQnSe1aCnkbQH+0Q3wEZvCw5BGYMPrr3SerBEaxtPc2zLLY/YrK?=
 =?us-ascii?Q?MWsiCKJY4tXdEAD3dYdI6v65Bmct5Whzi4c9MwgIRetndHCmejo6dLb62ioY?=
 =?us-ascii?Q?+R0TIuUDigir0toXsStJeQI14BZubWTOSIkl9dDsIud/yqyDiWkqdJSYWMY5?=
 =?us-ascii?Q?pTv/5j/Ki1CCaNKUJ8AKN4CZ5P+xm8pn5HLc5NQfp3eifFyP30Rl+03rMnf6?=
 =?us-ascii?Q?yWt2Qll299DhpfGuovXI7gaBb6xt13jR3Hg6QM6H1dv6ajKbQx0T3ZTssxxc?=
 =?us-ascii?Q?QMPO2NRGzcTTqKGyw6cW1FjnxQ4jyxlQlMOeis+wC8kVlvFvfqXD0gcryqx6?=
 =?us-ascii?Q?YUjE0hJ32z8QCu49avAuNJ4reIEl/KQQfZNMepD6+EkyIavOPdG3at4mcusz?=
 =?us-ascii?Q?AmP4ygobSRB8SHEpVcyIhBxbUcUwxwO4hdf9l9FnJzaVTLi1SJI9rvYqwd3k?=
 =?us-ascii?Q?HNIyeIzxo1SXEoBqMeL9Zn6GliXBLyWA/JdxGMleub5y2DJqnVUh5vyUFtsF?=
 =?us-ascii?Q?HedAtMWVGgpX0ZAYaEkhWY9YCpEMr4hX7yYt+uJiCUDmz8KTsi6T8BVTIOsd?=
 =?us-ascii?Q?WdCPBp8J9/qRYyg1Mj7w9Ocxux5GPysjva61es6CHeqIztXrKVqIN8Nei0uV?=
 =?us-ascii?Q?LvaffBhiZwCYYFuKk0GSYWGImcGwEqGhmlQTads1KseJFdTCQmS23Q2liHq/?=
 =?us-ascii?Q?RoboRw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xYEWnmUFSRy4dwvNGetrBLyPMZ0LKzFLUsxzNF7gmZbHAf4t/Bmi1Cktzm6IOi6vgJb2su9GuGjqgsfQiCIDFrQ5EBVhNTvIL2SpRkk++v/VwvM4ttzfmBUN/MYpvSc1lqAv1EymsYTBN29jMzihw8NroEYCPz0P14erVg9bcpfDkvdylqVQj4Y5ZzRkqJ+ocDfmes7WbU9E48n55iyq+NmX/lbYAALxCqxeMnkIW4fvOoSzln7XgF3hC0nNuL+oTwGspvqIx4nqx/eNh/yr19p7xNrYseDDneGv2Squ0CjT+aWx4lUB5OAfoiq69wpL4pv0GBw6iQbCagqAJPfDkw8sBl4e1R3w3g6N5tTnvTpDkIwP641WU1BMoqxU7xIwioOyXDIj8XPz6opOPkl3AW6gAYzh3HwNJNzkgklpKzizInMAoEJdxcFE/y9kiKAn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:57.5684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41c34a0-4b8a-4cc3-87a7-08de5f764974
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 98 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 25 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 46 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 20 ++---
 4 files changed, 72 insertions(+), 117 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3c38bf58fd3f2..941aa442fa133 100644
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
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -726,25 +707,28 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
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
@@ -756,39 +740,45 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 
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
 
@@ -798,12 +788,10 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
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
@@ -817,21 +805,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
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
index 0932a093dee3d..f4d090bc4784c 100644
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
@@ -192,12 +194,18 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		dma_fence_put(tmp);
 	}
 
+	/* VM sequence */
+	vm_af->ib_wptr = ring->wptr;
 	r = amdgpu_vm_flush(ring, job, need_pipe_sync);
 	if (r) {
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	vm_af->ib_dw_size =
+		amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
 
+	/* IB sequence */
+	af->ib_wptr = ring->wptr;
 	amdgpu_ring_ib_begin(ring);
 
 	if (ring->funcs->insert_start)
@@ -218,6 +226,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		cond_exec = amdgpu_ring_init_cond_exec(ring,
 						       ring->cond_exe_gpu_addr);
 
+	/* Skip the IB for guilty contexts */
+	af->skip_ib_dw_start_offset =
+		amdgpu_ring_get_dw_distance(ring, af->ib_wptr, ring->wptr);
 	amdgpu_device_flush_hdp(adev, ring);
 
 	if (need_ctx_switch)
@@ -256,6 +267,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
 	amdgpu_device_invalidate_hdp(adev, ring);
+	/* Skip the IB for guilty contexts */
+	af->skip_ib_dw_end_offset =
+		amdgpu_ring_get_dw_distance(ring, af->ib_wptr, ring->wptr);
 
 	if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
@@ -298,13 +312,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
index e196ffbdd1f3a..6da7eb49d30a2 100644
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

