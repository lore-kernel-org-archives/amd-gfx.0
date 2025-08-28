Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8508DCA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9DE10EA03;
	Thu, 28 Aug 2025 15:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EePiNFzZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3248510EA03
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYFOI8k3EYPnIvKEVm961mWQwrWVVKz3+7ULkeNSXqcBlidW3q8JEGsP/1vyZHSOf0Fg69S8sF0yvhW27pKfYFDTf+aQrJdQSLZiwnxmNVb/0GdmIrKb5THBUaVLVSCDupvSoewV8uZX384JDivnyge1go18oAWfsLHS7SXVymh0tjagRrNfXKh73u3dagTimloTI54svCAOngtNjF7yVh4tQ4IbVR7xl5277goiNoJqMpxGqCBtjxvxpoIL4RQ4mgS0dIGJDwV3Syh5OQOOlvnnFAfpDCVpN7Hqn9HC/MOyVbGSdsDmPp0+GFw7jMOuS14YBk2fx47J75UAW2RrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iphdmpZ+/rXp/t16mjBR1YHZ5yGYlFlnRg3kP2rFCBo=;
 b=xVbP1FaWH+62WtaS8DOFx92fQAFj302LLol6Q7tHAD7WXr3vA1+VE2k20XTYLeh1uS+cCkHbLpKLcpNT8It3PMj0NXrJOu6RMdkqgxDcnTG8M4IXj4yGVlvSFOntWYxGzcHFkpoNL8e5xqqzioMfB5EG7RQ1w2pJbDdg3+LxFfqSS6hIRLyY0+HDZqqmQq1lkS061zmvjnudhqabwFWQ0hZ5y5agfSQ8kJIQnJbi3kS4nommY4VoiF0vNqRijUfG8Yxm2Dpyt6Ph91gMSMbG+fMiVTQ7L7bbAPKdaV2U25AjOG0D9YAUBHqf7m38CpPPwQuqljVzuQMg7H4+GjCFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iphdmpZ+/rXp/t16mjBR1YHZ5yGYlFlnRg3kP2rFCBo=;
 b=EePiNFzZPr+l1pxYAtLcza5UooTla8GmNLZ//49zYY4oGuRZ8Bl2iTdFPh4cH/Wq0z+zji2jId+UdYn8xm/kNoj8ihdlS3pmXmMmRuMHfmMJdG9fcs1ZUcH8TE+ac0T+F1Y1qjW8K9hPQGw77Vn4CYjdjPySVqy1oIlb8KS3bCs=
Received: from SA1PR04CA0020.namprd04.prod.outlook.com (2603:10b6:806:2ce::29)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 15:00:23 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::56) by SA1PR04CA0020.outlook.office365.com
 (2603:10b6:806:2ce::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Thu,
 28 Aug 2025 15:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 15:00:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 10:00:19 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 08:00:18 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <David.Wu3@amd.com>,
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: clean up and unify hw fence handling
Date: Thu, 28 Aug 2025 11:00:04 -0400
Message-ID: <20250828150004.5362-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 21119eec-e25a-458c-ce67-08dde6439cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KvoZBcVIfPJcfq4gx3xcY2PnNMisoeHqczLhtS/ZGoxQbIAoa+dce9N8o2aA?=
 =?us-ascii?Q?zhcXhcjadn2v9cJwRdKj6G0QDQyPRT++q5RtygZ+4DBdA0hNR10ly1XPZmlq?=
 =?us-ascii?Q?e+ogp+SHgWsMF7KFlcWKZx0ze7ZQLNE8VvfuOWeY+mPCRq2erwZNXuA8awLp?=
 =?us-ascii?Q?kY6vRjSOqvYYBs9T5aG0oERwCbTXH+ppPXCl64AzgC+HM755yP02j3CYIEjX?=
 =?us-ascii?Q?3YHpZNyiOkFOwvvEu55MzZ2izKBJHBLF7qmRc8/ZbVfE+oeY6HIzlV/jaYtz?=
 =?us-ascii?Q?DGo3V7O6WS1IxPFVUfOSPs0dGa8Sv5dTF50G0jKmcnv07ykClIe0aWQW9HTn?=
 =?us-ascii?Q?mTwo0OD5xfCj18+HPwaCVnYDxZtHV5P/SebEWxT27DbxwD/txuBYBCmOhVe5?=
 =?us-ascii?Q?xYPmFqwOWSxSu/nq7ewvrQrdbNiDm1K/RXQp4AEkQ9wXADTlYcVyiZZ9Jijb?=
 =?us-ascii?Q?A2c7xQuH9gJzkjTuupbOz8I/fKudLcXHkoFtnmnfyX6tkALP4dFFj/yds/op?=
 =?us-ascii?Q?iLFO12TkZd5NI2fY4VZffRnZ1YO71d3yHP7nUqBRDp7s0d/+KOvDVuC1zTyZ?=
 =?us-ascii?Q?ioaWXlUQ1532P1T2ljwXEjiTLAkXpNyzLhCTj/kcQo+Gs6MduL0mSOpd2HRi?=
 =?us-ascii?Q?wdjD+4mNsnjFJkVIVmpcGNEhx/ZD36CkSqtuXli3NjQZg/fcTvAjlaWd8Vw2?=
 =?us-ascii?Q?MAKL0HjKqOqF+0D3jIek2oyXNWGXr/eHZRVg6Dx9bamBHvrgaXqM60fypCp3?=
 =?us-ascii?Q?T+j94u7QnlYKgwgcJxFk7QyrpZTgkmxJbak7d2OSTGbYaRiRrTOyeZPEH2Zd?=
 =?us-ascii?Q?HE1coWhbYKT8f9p3snMXCOFQFEXlDWsEbiL1nciBUJgBDDtMxqn9mqBKKBmk?=
 =?us-ascii?Q?IHh/yR1hoRDHXUMBL56xTJNCiRgjtAhRHFMI1o/rrNRg+60VDA9vCdArUdCN?=
 =?us-ascii?Q?FkDLggEZVA76Ae7D/9xT5gmM1A/Kq7zkURvCHaIb2+Bx6ezFrcczjE/lmexl?=
 =?us-ascii?Q?q66HYuXNwpddtDd4XIl5QAy3h9/GLc3aaS8w+bAebeo8XptEYwSwQ1HiaFdn?=
 =?us-ascii?Q?Fb0Xbe2wzG8PCBHwkw71QGKFUGtdX/QTyYRPPnm434VHE/fBisuG7DelfKbR?=
 =?us-ascii?Q?BsX3IP1cezPXzBTG9GlykaD8q5iFU5JsC6YAuQNc4UgLbR9N2xHtkWMiTZ1x?=
 =?us-ascii?Q?B7z52rQRPHo6e8r9/hAQsIxiPyAAwkXnsoarGARw/eA5xRhahBY/4GPKAOnU?=
 =?us-ascii?Q?nfAMGG3RgPmvYfImjIFjD9SoRY/Yi12zZ6nMYPM2T9nJoQEq0TbZdOjXria9?=
 =?us-ascii?Q?/KamUqZbCnNNZscsgpO8oLDGqjEkXtf0GvFNHj9mnd6YNgtafGEb4cVrf76O?=
 =?us-ascii?Q?vPIl3T73YUBgPCjqu3clYjyOItjGLUgXDkuSwx/SNqL7mLhx5uVPBJNospIi?=
 =?us-ascii?Q?5wbfUX7usveqx8Sh7zZ6gG0wS7SOHEG5vzlvbFv1AczfR5UUSXarSKQIkdN5?=
 =?us-ascii?Q?OHHgZbf0LAhLAzZZ9Nr2HUJZ4MEWYlDvYf+W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:00:22.6635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21119eec-e25a-458c-ce67-08dde6439cfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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
v3: Additional cleaups suggested by Christian

Cc: David.Wu3@amd.com
Cc: christian.koenig@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 149 +++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  21 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  41 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
 8 files changed, 68 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f81608330a3d0..7ea3cb6491b1b 100644
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
index 7783272a79302..add272fa31288 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
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
@@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
+	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2d58aefbd68a7..00ae1ef540815 100644
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
@@ -755,21 +699,19 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 /**
  * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
  *
- * @fence: fence of the ring to signal
+ * @af: fence of the ring to signal
  *
  */
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 {
-	dma_fence_set_error(&fence->base, -ETIME);
-	amdgpu_fence_write(fence->ring, fence->seq);
-	amdgpu_fence_process(fence->ring);
+	dma_fence_set_error(&af->base, -ETIME);
+	amdgpu_fence_write(af->ring, af->base.seqno);
+	amdgpu_fence_process(af->ring);
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
@@ -830,13 +772,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
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
@@ -853,23 +788,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
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
@@ -885,21 +803,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
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
@@ -913,19 +816,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
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
@@ -933,13 +823,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
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
index 7d9bcb72e8dd3..0a542a325ddb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -128,7 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
-	struct amdgpu_fence *af;
+	struct amdgpu_fence *af, *vm_af;
 	bool need_ctx_switch;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
@@ -149,17 +149,20 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
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
+		vm_af = job->hw_vm_fence;
+		/* the vm fence is also part of the job's context */
+		vm_af->context = fence_ctx;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -167,7 +170,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = 0;
 		gds_va = 0;
 		init_shadow = false;
-		af = NULL;
+		af = kzalloc(sizeof(*af), GFP_ATOMIC);
+		if (!af)
+			return -ENOMEM;
+		vm_af = NULL;
 	}
 
 	if (!ring->sched.ready) {
@@ -289,7 +295,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_emit(ring, f, af, fence_flags);
+	r = amdgpu_fence_emit(ring, af, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
@@ -297,6 +303,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	*f = &af->base;
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
@@ -317,7 +324,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	 * fence so we know what rings contents to backup
 	 * after we reset the queue.
 	 */
-	amdgpu_fence_save_wptr(*f);
+	amdgpu_fence_save_wptr(af);
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 311e97c96c4e0..9a78fe01efa3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -138,7 +138,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		   ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
-		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
+		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
@@ -185,6 +185,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct drm_sched_entity *entity, void *owner,
 		     unsigned int num_ibs, struct amdgpu_job **job)
 {
+	struct amdgpu_fence *af;
+	int r;
+
 	if (num_ibs == 0)
 		return -EINVAL;
 
@@ -192,6 +195,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -202,6 +219,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return 0;
 
 	return drm_sched_job_init(&(*job)->base, entity, 1, owner);
+
+err_fence:
+	kfree((*job)->hw_fence);
+err_job:
+	kfree(*job);
+
+	return r;
 }
 
 int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
@@ -251,8 +275,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	/* Check if any fences where initialized */
 	if (job->base.s_fence && job->base.s_fence->finished.ops)
 		f = &job->base.s_fence->finished;
-	else if (job->hw_fence.base.ops)
-		f = &job->hw_fence.base;
+	else if (job->hw_fence)
+		f = &job->hw_fence->base;
 	else
 		f = NULL;
 
@@ -268,11 +292,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	amdgpu_sync_free(&job->explicit_sync);
 
-	/* only put the hw fence if has embedded fence */
-	if (!job->hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&job->hw_fence.base);
+	kfree(job);
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -301,10 +321,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
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
index 931fed8892cc1..077b2414a24b7 100644
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
index 7670f5d82b9e4..77ddddadc25fe 100644
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
 void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
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
index bf42246a3db2f..7d1a363ad6878 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
-	struct amdgpu_fence *af;
 	unsigned int patch;
 	int r;
 
@@ -835,13 +834,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
-		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
+		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
 		if (r)
 			return r;
-		/* this is part of the job's context */
-		af = container_of(fence, struct amdgpu_fence, base);
-		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
 	}
+	fence = &job->hw_vm_fence->base;
 
 	if (vm_flush_needed) {
 		mutex_lock(&id_mgr->lock);
-- 
2.51.0

