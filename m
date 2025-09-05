Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D243CA1010
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 15:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC89110EBCF;
	Fri,  5 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wxqMdr7m";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C230C10EBCF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 15:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVfaVSC9HoHPAitGD+mXWA0ASpQdBZ6vX2I94S89dx9es1GstoyF7M3Spqg4xvPlXcezmDThMLjXhi3fHHTarwuym0FJX1mhGMiavszYQu6wAsI9+0Vcg7cgVMbkSmcb64SR+NykKwJEKcrH8W8XmXbgex/TzyOtLkduJlsS5HbT4j+5Zl0kSq/AwiGmCIuDszVIhIXZA04zacyvEDwVfkpVPlBUeoniXkndAw25Nm4TeRbv5XGx0KJHMxhk79Mm8ECml+ueSKyLVM6jQ/UW6n9JX4FRe4y6hg8ezx5qnGP8EHBIw6TEmlXkIdT3vwN+7FC2BlZzAhcObw6+JC4j5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKD70MJu7dvdaaaLCMfEWeu9eDxPrjgevn3q6nQnGdw=;
 b=yJYEaHVguGiD5kBt+l6Nox3rjnLQd3qFVdK9LU5t2XhRVqcRde6chQHaZkfIWHhkhBeN+BuOaLiC/VHaG7rm7iiC2JOfAYK8g/5/G/5D/D0KTbMOJJEaHFIsb3HbKJaJ0bRft9ntZftCljsdOw5AjB4wON3M+gBXdQKfuAoxZ/6mHBqqmljPe/izl2XzwUirr2iCuKQqtptf2AseUnyzsYwkLK0WVmaOuX+4AB2qLxeokUYGnorhMfiPzGvYj9h8GXRzHI/ynYzE1qsHUebLUW7jITv1QTK9T4q2hHJx8LbrPldr8YQG9/piUySjYNm2zOhtnWa48zpxfmOMFfHwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKD70MJu7dvdaaaLCMfEWeu9eDxPrjgevn3q6nQnGdw=;
 b=wxqMdr7m682Cyagh12b1d+KYAIkY4qDVxJuzH+12HzYyKrN02tsUYXJlres06vlWTrhmmGlOnAYjhH04k+Dv/uOVxnKGG/QGSPe3USwRiXxQ7FSgH3OmdKA14/qcFXDBatUiASYVBcEGjxW2SM2ggbzzQwB1ohViv0Nm8Gnb+gw=
Received: from SN1PR12CA0083.namprd12.prod.outlook.com (2603:10b6:802:21::18)
 by LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 15:26:08 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::29) by SN1PR12CA0083.outlook.office365.com
 (2603:10b6:802:21::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 15:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 15:26:08 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 10:26:06 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 5 Sep
 2025 08:26:06 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <David.Wu3@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: clean up and unify hw fence handling
Date: Fri, 5 Sep 2025 11:25:52 -0400
Message-ID: <20250905152552.5558-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905152552.5558-1-alexander.deucher@amd.com>
References: <20250905152552.5558-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|LV8PR12MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e34c76-0c6e-4a79-6a56-08ddec90899d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M51e9fc9YV45nnSroK7ubtwUp1F/eDlb7oJhcwrI7rEaGb2Gnn+amqWpmm2D?=
 =?us-ascii?Q?z84aTt7b4fh/2K+9OReDSA+h7aHHIrn07slAwa/wz2tRtwXH00S02XImv/JW?=
 =?us-ascii?Q?CQi45DpuAIOqzvZLWdXX5yEorwLifVuNZvbq5BJCuEkualurQmepLXYauP7+?=
 =?us-ascii?Q?BK6Hjzf+Y4mlABBu7mDDrNhl+JgpP5HUnEdwDdkrIMFTNRjnssB2dYmigFik?=
 =?us-ascii?Q?YGEAiMOecn4cH+9PntswcffmDSgN8+fVWlTEolqmepudF50jJPCl5EhkFWVc?=
 =?us-ascii?Q?0DO/tnERYhEXrd4iOVfISpqtacpmaYAoGiuMW/nIM7LZzMaVBBx6QvcVD4NK?=
 =?us-ascii?Q?Uk1FGB0ymhnzRVDfuPp/VRQQmedCn0KAi3djnJZX0GbeGBDNazKwQOSO6Q+C?=
 =?us-ascii?Q?hEKCCEOluqs2XxP7EmxfWvSk3oCXMgN2S2+Z1Wb+zQRiHhgKTa6C8x99//OP?=
 =?us-ascii?Q?i+2dZqSYBHunXC0ruffv/6DFFrybG60hWiM45b6WeR8AfYImGKUuMclKFbrW?=
 =?us-ascii?Q?4uMgTgo/GNZKC9qj5tOnoYQF1POEOVIlxcRiRT+XUMjfE/eosRpicZMODAsX?=
 =?us-ascii?Q?nVEd8EOa6fSBfHA1BsKJV7g2VkjAaFLiqoVKnLlMiEwirs6e/4YFN9KTwJ5f?=
 =?us-ascii?Q?sNv+BfakvZwfz6MWg5EDxJ7I2OMp1anPyTA0bWOlvgWSYsAQNKVk2x75PpF1?=
 =?us-ascii?Q?uWYdvJmwKFADysE1dkjBCYpWcR5Dt9m2LeZKbQ6YgwnYIkAY8Mu8JbcZbnqo?=
 =?us-ascii?Q?g+pi+giTeMWT81XPn087WXrJ0gipN4IhJ6TGVDBb1mxaLXLxrrEbhqxY4K3L?=
 =?us-ascii?Q?7SR6JXOo/Apm15fdCdcFjpSfEhi9TxpFGqVCQpZ3k/gynQ1UwHz7OwWu1GUj?=
 =?us-ascii?Q?IAp4pqpk0eVwVYsL21PONS/BYcVmj7Wm3eqrG0fdjn+mYX1+oksoBXXyw7cm?=
 =?us-ascii?Q?YGiawyOiPecgFEjTvZD95ehEPZbh5cQ6NRPhyzPnFN9G07jDvQOHtg1fvAHN?=
 =?us-ascii?Q?2ftaAaDG9cmBVbcfN3yXMgDF8x0ewFPf3R3j3IbsZvd/zc6DXXO+f+s8XesB?=
 =?us-ascii?Q?+EJ4oenP5Re6wRvH8p4Wh9s9LV12q6X+VYL1cL2/IirdhekU6Wv520DQGl5+?=
 =?us-ascii?Q?ibGuyS0HGMnpZCKrKdGNBq+UBcY83fwibeQFBzQIptlQ98PstecV1O76HO3F?=
 =?us-ascii?Q?yTnar/jACZLjvbLaCUeeQ7HaS3iC603GUcvhbWsIahAjpsKDVfLtZkCl/3hU?=
 =?us-ascii?Q?nb+O8YkzN16OCoGSRYD5NPL85MDAGaxytIIqLBGXLG5ZRBt0CKqM0wlcN9MC?=
 =?us-ascii?Q?qSyctQ38T2pn1TeOkTaXN86Up3/EDSG7SpjowvCqozfqNDTAR4aZaGvl6jf1?=
 =?us-ascii?Q?0j0UJLvz34x0+yORQI7lyL8c3KA0ugLyGDk0li8t9qeN+dH48WMDv+BBCD46?=
 =?us-ascii?Q?P4u4guK7AAQHLH1s3Zml7Jm9QoP57ILMv6IYaWWvg+VuVM1At3Y22ilugkPw?=
 =?us-ascii?Q?NquB4aakxXnO3u5shMzegxLTX5Msh4JIN/PB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:26:08.4063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e34c76-0c6e-4a79-6a56-08ddec90899d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643
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

Decouple the amdgpu fence from the amdgpu_job structure.
This lets us clean up the separate fence ops for the embedded
fence and other fences.  This also allows us to allocate the
vm fence up front when we allocate the job.

v2: Additional cleanup suggested by Christian
v3: Additional cleanups suggested by Christian
v4: Additional cleanups suggested by David and
    vm fence fix
v5: cast seqno (David)

Cc: David.Wu3@amd.com
Cc: christian.koenig@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 143 ++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  17 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  43 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
 8 files changed, 63 insertions(+), 167 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a70651050acff..0a62727e74f0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
 			continue;
 		}
 		job = to_amdgpu_job(s_job);
-		if (preempted && (&job->hw_fence.base) == fence)
+		if (preempted && (&job->hw_fence->base) == fence)
 			/* mark the job as preempted */
 			job->preemption_status |= AMDGPU_IB_PREEMPTED;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bdfb80377e6a8..dded88bc374c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5802,11 +5802,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		if (!amdgpu_ring_sched_ready(ring))
 			continue;
 
-		/* Clear job fence from fence drv to avoid force_completion
-		 * leave NULL and vm flush fence in fence drv
-		 */
-		amdgpu_fence_driver_clear_job_fences(ring);
-
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
 		amdgpu_fence_driver_force_completion(ring);
 	}
@@ -6530,7 +6525,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
+	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 72f0f16924476..e9586aab2c474 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -45,16 +45,11 @@
  * Cast helper
  */
 static const struct dma_fence_ops amdgpu_fence_ops;
-static const struct dma_fence_ops amdgpu_job_fence_ops;
 static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
 {
 	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
 
-	if (__f->base.ops == &amdgpu_fence_ops ||
-	    __f->base.ops == &amdgpu_job_fence_ops)
-		return __f;
-
-	return NULL;
+	return __f;
 }
 
 /**
@@ -98,51 +93,32 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  * amdgpu_fence_emit - emit a fence on the requested ring
  *
  * @ring: ring the fence is associated with
- * @f: resulting fence object
  * @af: amdgpu fence input
  * @flags: flags to pass into the subordinate .emit_fence() call
  *
  * Emits a fence command on the requested ring (all asics).
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
-		      struct amdgpu_fence *af, unsigned int flags)
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		      unsigned int flags)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence;
-	struct amdgpu_fence *am_fence;
 	struct dma_fence __rcu **ptr;
 	uint32_t seq;
 	int r;
 
-	if (!af) {
-		/* create a separate hw fence */
-		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
-		if (!am_fence)
-			return -ENOMEM;
-	} else {
-		am_fence = af;
-	}
-	fence = &am_fence->base;
-	am_fence->ring = ring;
+	fence = &af->base;
+	af->ring = ring;
 
 	seq = ++ring->fence_drv.sync_seq;
-	am_fence->seq = seq;
-	if (af) {
-		dma_fence_init(fence, &amdgpu_job_fence_ops,
-			       &ring->fence_drv.lock,
-			       adev->fence_context + ring->idx, seq);
-		/* Against remove in amdgpu_job_{free, free_cb} */
-		dma_fence_get(fence);
-	} else {
-		dma_fence_init(fence, &amdgpu_fence_ops,
-			       &ring->fence_drv.lock,
-			       adev->fence_context + ring->idx, seq);
-	}
+	dma_fence_init(fence, &amdgpu_fence_ops,
+		       &ring->fence_drv.lock,
+		       adev->fence_context + ring->idx, seq);
 
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
-	amdgpu_fence_save_wptr(fence);
+	amdgpu_fence_save_wptr(af);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
@@ -167,8 +143,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	 */
 	rcu_assign_pointer(*ptr, dma_fence_get(fence));
 
-	*f = fence;
-
 	return 0;
 }
 
@@ -669,36 +643,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
- *
- * @ring: fence of the ring to be cleared
- *
- */
-void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
-{
-	int i;
-	struct dma_fence *old, **ptr;
-
-	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
-		ptr = &ring->fence_drv.fences[i];
-		old = rcu_dereference_protected(*ptr, 1);
-		if (old && old->ops == &amdgpu_job_fence_ops) {
-			struct amdgpu_job *job;
-
-			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
-			 * it right here or we won't be able to track them in fence_drv
-			 * and they will remain unsignaled during sa_bo free.
-			 */
-			job = container_of(old, struct amdgpu_job, hw_fence.base);
-			if (!job->base.s_fence && !dma_fence_is_signaled(old))
-				dma_fence_signal(old);
-			RCU_INIT_POINTER(*ptr, NULL);
-			dma_fence_put(old);
-		}
-	}
-}
-
 /**
  * amdgpu_fence_driver_set_error - set error code on fences
  * @ring: the ring which contains the fences
@@ -755,7 +699,7 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 /**
  * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
  *
- * @fence: fence of the ring to signal
+ * @af: fence of the ring to signal
  *
  */
 void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
@@ -786,15 +730,13 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 		rcu_read_unlock();
 	}
 	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
-	amdgpu_fence_write(ring, af->seq);
+	amdgpu_fence_write(ring, (u32)af->base.seqno);
 	amdgpu_fence_process(ring);
 }
 
-void amdgpu_fence_save_wptr(struct dma_fence *fence)
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
 {
-	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
-
-	am_fence->wptr = am_fence->ring->wptr;
+	af->wptr = af->ring->wptr;
 }
 
 static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
@@ -855,13 +797,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
 	return (const char *)to_amdgpu_fence(f)->ring->name;
 }
 
-static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
-{
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
-
-	return (const char *)to_amdgpu_ring(job->base.sched)->name;
-}
-
 /**
  * amdgpu_fence_enable_signaling - enable signalling on fence
  * @f: fence
@@ -878,23 +813,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 	return true;
 }
 
-/**
- * amdgpu_job_fence_enable_signaling - enable signalling on job fence
- * @f: fence
- *
- * This is the simliar function with amdgpu_fence_enable_signaling above, it
- * only handles the job embedded fence.
- */
-static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
-{
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
-
-	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
-		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
-
-	return true;
-}
-
 /**
  * amdgpu_fence_free - free up the fence memory
  *
@@ -910,21 +828,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
 	kfree(to_amdgpu_fence(f));
 }
 
-/**
- * amdgpu_job_fence_free - free up the job with embedded fence
- *
- * @rcu: RCU callback head
- *
- * Free up the job with embedded fence after the RCU grace period.
- */
-static void amdgpu_job_fence_free(struct rcu_head *rcu)
-{
-	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-
-	/* free job if fence has a parent job */
-	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
-}
-
 /**
  * amdgpu_fence_release - callback that fence can be freed
  *
@@ -938,19 +841,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
 	call_rcu(&f->rcu, amdgpu_fence_free);
 }
 
-/**
- * amdgpu_job_fence_release - callback that job embedded fence can be freed
- *
- * @f: fence
- *
- * This is the simliar function with amdgpu_fence_release above, it
- * only handles the job embedded fence.
- */
-static void amdgpu_job_fence_release(struct dma_fence *f)
-{
-	call_rcu(&f->rcu, amdgpu_job_fence_free);
-}
-
 static const struct dma_fence_ops amdgpu_fence_ops = {
 	.get_driver_name = amdgpu_fence_get_driver_name,
 	.get_timeline_name = amdgpu_fence_get_timeline_name,
@@ -958,13 +848,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
 	.release = amdgpu_fence_release,
 };
 
-static const struct dma_fence_ops amdgpu_job_fence_ops = {
-	.get_driver_name = amdgpu_fence_get_driver_name,
-	.get_timeline_name = amdgpu_job_fence_get_timeline_name,
-	.enable_signaling = amdgpu_job_fence_enable_signaling,
-	.release = amdgpu_job_fence_release,
-};
-
 /*
  * Fence debugfs
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 7d9bcb72e8dd3..39229ece83f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -149,17 +149,19 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (job) {
 		vm = job->vm;
 		fence_ctx = job->base.s_fence ?
-			job->base.s_fence->scheduled.context : 0;
+			job->base.s_fence->finished.context : 0;
 		shadow_va = job->shadow_va;
 		csa_va = job->csa_va;
 		gds_va = job->gds_va;
 		init_shadow = job->init_shadow;
-		af = &job->hw_fence;
+		af = job->hw_fence;
 		/* Save the context of the job for reset handling.
 		 * The driver needs this so it can skip the ring
 		 * contents for guilty contexts.
 		 */
-		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
+		af->context = fence_ctx;
+		/* the vm fence is also part of the job's context */
+		job->hw_vm_fence->context = fence_ctx;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -167,7 +169,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = 0;
 		gds_va = 0;
 		init_shadow = false;
-		af = NULL;
+		af = kzalloc(sizeof(*af), GFP_ATOMIC);
+		if (!af)
+			return -ENOMEM;
 	}
 
 	if (!ring->sched.ready) {
@@ -289,7 +293,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_emit(ring, f, af, fence_flags);
+	r = amdgpu_fence_emit(ring, af, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
@@ -297,6 +301,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	*f = &af->base;
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
@@ -317,7 +322,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	 * fence so we know what rings contents to backup
 	 * after we reset the queue.
 	 */
-	amdgpu_fence_save_wptr(*f);
+	amdgpu_fence_save_wptr(af);
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 172620880cada..55c7e104d5ca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,7 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		   ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
-		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
+		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
@@ -187,6 +187,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     unsigned int num_ibs, struct amdgpu_job **job,
 		     u64 drm_client_id)
 {
+	struct amdgpu_fence *af;
+	int r;
+
 	if (num_ibs == 0)
 		return -EINVAL;
 
@@ -194,6 +197,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!*job)
 		return -ENOMEM;
 
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		r = -ENOMEM;
+		goto err_job;
+	}
+	(*job)->hw_fence = af;
+
+	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	if (!af) {
+		r = -ENOMEM;
+		goto err_fence;
+	}
+	(*job)->hw_vm_fence = af;
+
 	(*job)->vm = vm;
 
 	amdgpu_sync_create(&(*job)->explicit_sync);
@@ -205,6 +222,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	return drm_sched_job_init(&(*job)->base, entity, 1, owner,
 				  drm_client_id);
+
+err_fence:
+	kfree((*job)->hw_fence);
+err_job:
+	kfree(*job);
+
+	return r;
 }
 
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
@@ -251,11 +275,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	struct dma_fence *f;
 	unsigned i;
 
-	/* Check if any fences where initialized */
+	/* Check if any fences were initialized */
 	if (job->base.s_fence && job->base.s_fence->finished.ops)
 		f = &job->base.s_fence->finished;
-	else if (job->hw_fence.base.ops)
-		f = &job->hw_fence.base;
+	else if (job->hw_fence && job->hw_fence->base.ops)
+		f = &job->hw_fence->base;
 	else
 		f = NULL;
 
@@ -271,11 +295,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	amdgpu_sync_free(&job->explicit_sync);
 
-	/* only put the hw fence if has embedded fence */
-	if (!job->hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&job->hw_fence.base);
+	kfree(job);
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -304,10 +324,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	if (job->gang_submit != &job->base.s_fence->scheduled)
 		dma_fence_put(job->gang_submit);
 
-	if (!job->hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&job->hw_fence.base);
+	kfree(job);
 }
 
 struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 2f302266662bc..d25f1fcf0242e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -48,7 +48,8 @@ struct amdgpu_job {
 	struct drm_sched_job    base;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_sync	explicit_sync;
-	struct amdgpu_fence	hw_fence;
+	struct amdgpu_fence	*hw_fence;
+	struct amdgpu_fence	*hw_vm_fence;
 	struct dma_fence	*gang_submit;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 0704fd9b85fdb..5d44f1354c8d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -147,16 +147,14 @@ struct amdgpu_fence {
 	u64				wptr;
 	/* fence context for resets */
 	u64				context;
-	uint32_t			seq;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
-void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
-void amdgpu_fence_save_wptr(struct dma_fence *fence);
+void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -166,8 +164,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
 int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
-		      struct amdgpu_fence *af, unsigned int flags);
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		      unsigned int flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
 bool amdgpu_fence_process(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bd12d8ff15a42..76bae546df11c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
-	struct amdgpu_fence *af;
 	unsigned int patch;
 	int r;
 
@@ -835,12 +834,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
+		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
 		if (r)
 			return r;
-		/* this is part of the job's context */
-		af = container_of(fence, struct amdgpu_fence, base);
-		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
+		fence = &job->hw_vm_fence->base;
 	}
 
 	if (vm_flush_needed) {
-- 
2.51.0

