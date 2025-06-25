Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D17EC7EE32
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEA610E809;
	Wed, 25 Jun 2025 21:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DsHLzoB0";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE4710E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBl5qVjaC2CP+26b0651sHTaBG7CErjOaajQ88eyo17Yl0olGUBK8/Wcoig6a2JjIe7WSVxD2Z2xi18Va8xPvj7hCKUtltXV/lWKelO9RHI8mE2RsaGfeWPoQvPvWBvj5YpvqzYWv0XClj2rH/JVOuk8x811VXxrK6+tgPZCAiatWhmO//JNELgrdDlzReim+OMdJS3th5xJuWHC0PTPOGd+ZYVPfFgrcRMmdmObM9rQg/oI9DcuSxEhdk+KOBt2QWeSwXUOX1omi7SIi7BDnuDpvV9h8WrzmwUeCyTM4wjK3XzfzGT78rhP1wKDKdq9NjiAKBPxtyIa8mxpA8Slww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuBuNN/AswZAfeNldagaWmWv9fzmZapbnjdjpmXsc44=;
 b=ZqKtsPamLOtzvV4pWhMUdUEqTxiHKI1Ty8QKEZqrQPLMMqqSJ83DKsPu0dtmFNtlLTtGZGYzV2uFIEvaQCCYAHAfMSw5qxdGQMt8mL/O0nOrPpyXHVfCikWK2b3vxCYRPLbipcbzk8Gyp7TfBO5NoI8ffX/aqc1RfFrywhate17bl7c2qQcicJ0/F/PBa0s+YNrQmUpTU7JxvM+RHA/u/ik8XQifXnmzCF1S3FnM9j0TwC3EkRCyf2Yx7YUjc+OEtCPyJsvEoBW1RkAPQG097iGcAiHIxn/llhQD4rGhfp8JkBhhH01fkjFdDImH4+n3O4sfB9sdd+15Jzsg5i3oRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuBuNN/AswZAfeNldagaWmWv9fzmZapbnjdjpmXsc44=;
 b=DsHLzoB03X4zoy5mvGCg8cPhjHy3d/XpQb71MNlYj4MxGZjYrUJyDw35Qmh/5BzKDr49o7I48lkklWCy6Lrk5SW4uFmp5f1tB6P/kCoqfiFq2G+7Bldmp1xZ5riNgQL4eWnf7gJFjOJdkan1aKoVku/pU9C2jKC+WjupHI8Nct8=
Received: from BYAPR01CA0006.prod.exchangelabs.com (2603:10b6:a02:80::19) by
 CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Wed, 25 Jun 2025 21:07:00 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::5a) by BYAPR01CA0006.outlook.office365.com
 (2603:10b6:a02:80::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:06:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/30] drm/amdgpu: track ring state associated with a fence
Date: Wed, 25 Jun 2025 17:06:15 -0400
Message-ID: <20250625210638.422479-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: c751e4f9-63b7-41b5-b44c-08ddb42c39d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ucObbS/JrTb5z0nRY8jLPlb3IwqDoe5we6qUth1g1TTcYrqU3OfoXelSwvbp?=
 =?us-ascii?Q?lujBnQE7N/aA7RU5ys+p+FtbSpbCyM0eNQ9FwLMnh2ZExBLsJvT3ECxHJYk5?=
 =?us-ascii?Q?0ia/5SUYJpEB4NzSFEcXSBiZyXaSMxfH+17xE8g10yX2vDlHlm/ooNSApD3A?=
 =?us-ascii?Q?bTa7N7izMegak302b1Up5ECnS7lz1vmJyFG6WEUMmMnjA6Nk6eZNyKEoJtIS?=
 =?us-ascii?Q?2wSDb8huN7U/E5eL+FEQV+e476gYrKOQHrv9W4zCL5YaadOnzoW8As6kE3FV?=
 =?us-ascii?Q?RfYRJB9wdSR9jYwFBsiv35HqBzrZEMqgg0QkrsmATnv/fSiQ0fOI7pOC34qC?=
 =?us-ascii?Q?UGF3BrKr2uGxGQV1sNGlPwhvSkQXMopyR5doL/gjR6ICWghm+iz3J9+zuRVM?=
 =?us-ascii?Q?z+kwjxUkGa2AazcK1dKeuUIIp19dxNxOlOpmQWCfC1DBFMKIdTax40tivEvl?=
 =?us-ascii?Q?SOXQ9J2XBXvBcbh/IQKmyoJUaSx0YQMR4rUC+ijMpR5Rth1tweslEUFOLbXx?=
 =?us-ascii?Q?hJWzYmd1SDwF4laEsM8/blATVhYOfITjhcytrdhjn/wBBCoT2B0FUc8MTNHh?=
 =?us-ascii?Q?m8FpvvmvpD131vrHsRm/cSG370hZWxdFVMyb1K24le9tAwh5FP8lERvrBDO7?=
 =?us-ascii?Q?yIfgKYF1QPVoAXXMw0CDjz2SF4yf1cD98WsFJkYME5V9AkUrDpudFeTCqUid?=
 =?us-ascii?Q?5s/A4VkWQwQievOFt5m+SNUl9MfRIdLXpVwF0s67fh27uwambtLYebz9arMq?=
 =?us-ascii?Q?2VijYC4a0IrhBPvLoERZQAq70bi+wOan7VNMncFpQ/i+/J81humsvcp99ndW?=
 =?us-ascii?Q?8JfaUOYmjZ0qhtqxkaV7FjX3SoDb+DCfvnydGGymQXTkE1dlSQl10BVix1ts?=
 =?us-ascii?Q?kHMw/xx96m5uaaixrdfXW7aXx5l18EoDadskqRK3VMZWAajAa0Ztvmj7G0h/?=
 =?us-ascii?Q?wmpmJBqeaagQQ9KvY9fTaCHhy09FVY/W9zKVL/GgwZA1EvCuB5Sa1pMINdP1?=
 =?us-ascii?Q?dc6RdsPanaY9NI8ksLqMkTguh3qjynGxTOeqX0AuuJz5/iL/+WatAnwQyh/F?=
 =?us-ascii?Q?MKSTur0v7m8HMg18YYY5FBoucjMIhZKGMu7cmRKIjNhwC9O0d0J7vKxtrgs0?=
 =?us-ascii?Q?ONz2wuLKe4ZRF47cpvJhqkyGtl6aWfKb5Jxie2k48qTF5ert1dcw0BWVQczw?=
 =?us-ascii?Q?oBcqpJ6qZQEB7XnRntHswhkCseSYYtmnBdW4Xmh0XQqJLtj1yyl1R2/Xsm7Z?=
 =?us-ascii?Q?S55EHHoFeDqU5QR9m3kNqY/KTaU+BzFOtXdx4dNmC3kT5xkaMcbXcGkLOKrF?=
 =?us-ascii?Q?26y7Geu1ARcCrg6mbcBUPklJ5/k+lBLl7lM6wrKm/9wY3nr4gVlM7cHl5uKM?=
 =?us-ascii?Q?lTwL3SdPvtigHni7OHAo637Ij0dRFxjsv7CX/FroG62+mo36X2DOsddIicV1?=
 =?us-ascii?Q?6LIef/QyZFvwczz+KWOUHBohEr+Vvx3pV0GjPhiLrA7mONeNwUykh6WizWJK?=
 =?us-ascii?Q?ef1tsEAcR6JYGbHgN7XTSc6CUX911c++l4kd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:06:59.7272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c751e4f9-63b7-41b5-b44c-08ddb42c39d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396
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

We need to know the wptr and sequence number associated
with a fence so that we can re-emit the unprocessed state
after a ring reset.  Pre-allocate storage space for
the ring buffer contents and add helpers to save off
and re-emit the unprocessed state so that it can be
re-emitted after the queue is reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 99 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 15 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 59 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 17 ++++
 5 files changed, 191 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2d6b2b486baf7..db14bdc7053ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -120,11 +120,13 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
 		if (!am_fence)
 			return -ENOMEM;
+		am_fence->context = 0;
 	} else {
 		am_fence = af;
 	}
 	fence = &am_fence->base;
 	am_fence->ring = ring;
+	am_fence->wptr = 0;
 
 	seq = ++ring->fence_drv.sync_seq;
 	if (af) {
@@ -253,6 +255,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 
 	do {
 		struct dma_fence *fence, **ptr;
+		struct amdgpu_fence *am_fence;
 
 		++last_seq;
 		last_seq &= drv->num_fences_mask;
@@ -265,6 +268,13 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 		if (!fence)
 			continue;
 
+		/* Save the wptr in the fence driver so we know what the last processed
+		 * wptr was.  This is required for re-emitting the ring state for
+		 * queues that are reset but are not guilty and thus have no guilty fence.
+		 */
+		am_fence = container_of(fence, struct amdgpu_fence, base);
+		if (am_fence->wptr)
+			drv->last_wptr = am_fence->wptr;
 		dma_fence_signal(fence);
 		dma_fence_put(fence);
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -727,6 +737,95 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 	amdgpu_fence_process(ring);
 }
 
+
+/**
+ * Kernel queue reset handling
+ *
+ * The driver can reset individual queues for most engines, but those queues
+ * may contain work from multiple contexts.  Resetting the queue will reset
+ * lose all of that state.  In order to minimize the collatoral damage, the
+ * driver will save the ring contents which are not associated with the guilty
+ * context prior to resetting the queue.  After resetting the queue the queue
+ * contents from the other contexts is re-emitted to the rings so that it can
+ * be processed by the engine.  To handle this, we save the queue's write
+ * pointer (wptr) in the fences associated with each context.  If we get a
+ * queue timeout, we can then use the wptrs from the fences to determine
+ * which data needs to be saved out of the queue's ring buffer.
+ */
+
+/**
+ * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
+ *
+ * @fence: fence of the ring to signal
+ *
+ */
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
+{
+	dma_fence_set_error(&fence->base, -ETIME);
+	amdgpu_fence_write(fence->ring, fence->base.seqno);
+	amdgpu_fence_process(fence->ring);
+}
+
+void amdgpu_fence_save_wptr(struct dma_fence *fence)
+{
+	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
+
+	am_fence->wptr = am_fence->ring->wptr;
+}
+
+static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
+						   unsigned int idx,
+						   u64 start_wptr, u32 end_wptr)
+{
+	unsigned int first_idx = start_wptr & ring->buf_mask;
+	unsigned int last_idx = end_wptr & ring->buf_mask;
+	unsigned int i, count;
+
+	/* Backup the contents of the ring buffer. */
+	for (i = first_idx, count = 0; i != last_idx; ++i, i &= ring->buf_mask, ++count)
+		ring->ring_backup[count] = ring->ring[i];
+	ring->ring_backup_entries_to_copy = count;
+}
+
+void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence)
+{
+	struct amdgpu_fence *fence;
+	struct dma_fence *unprocessed, **ptr;
+	u64 wptr, i, seqno;
+
+	if (guilty_fence) {
+		seqno = guilty_fence->base.seqno;
+		wptr = guilty_fence->wptr;
+	} else {
+		seqno = amdgpu_fence_read(ring);
+		wptr = ring->fence_drv.last_wptr;
+	}
+	ring->ring_backup_entries_to_copy = 0;
+	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
+		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+
+			/* save everything if the ring is not guilty, otherwise
+			 * just save the content from other contexts.
+			 */
+			if (fence->wptr &&
+			    (!guilty_fence || (fence->context != guilty_fence->context))) {
+				amdgpu_ring_backup_unprocessed_command(ring,
+								       ring->ring_backup_entries_to_copy,
+								       wptr,
+								       fence->wptr);
+				wptr = fence->wptr;
+			}
+		}
+		rcu_read_unlock();
+	}
+}
+
 /*
  * Common fence implementation
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 206b70acb29a0..d0f838fde2ae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -139,7 +139,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	int vmid = AMDGPU_JOB_GET_VMID(job);
 	bool need_pipe_sync = false;
 	unsigned int cond_exec;
-
 	unsigned int i;
 	int r = 0;
 
@@ -156,6 +155,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		gds_va = job->gds_va;
 		init_shadow = job->init_shadow;
 		af = &job->hw_fence;
+		/* Save the context of the job for reset handling.
+		 * The driver needs this so it can skip the ring
+		 * contents for guilty contexts.
+		 */
+		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -309,6 +313,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
+
+	/* Save the wptr associated with this fence.
+	 * This must be last for resets to work properly
+	 * as we need to save the wptr associated with this
+	 * fence so we know what rings contents to backup
+	 * after we reset the queue.
+	 */
+	amdgpu_fence_save_wptr(*f);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index f0b7080dccb8d..45febdc2f3493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -89,8 +89,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
-	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_task_info *ti;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -135,7 +135,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
-		r = amdgpu_ring_reset(ring, job->vmid, NULL);
+		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
 		if (!r) {
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf2..0985eba010e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	/*  Initialize cached_rptr to 0 */
 	ring->cached_rptr = 0;
 
+	if (!ring->ring_backup) {
+		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
+		if (!ring->ring_backup)
+			return -ENOMEM;
+	}
+
 	/* Allocate ring buffer */
 	if (ring->ring_obj == NULL) {
 		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
@@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 					    (void **)&ring->ring);
 		if (r) {
 			dev_err(adev->dev, "(%d) ring create failed\n", r);
+			kvfree(ring->ring_backup);
 			return r;
 		}
 		amdgpu_ring_clear_ring(ring);
@@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	amdgpu_bo_free_kernel(&ring->ring_obj,
 			      &ring->gpu_addr,
 			      (void **)&ring->ring);
+	kvfree(ring->ring_backup);
+	ring->ring_backup = NULL;
 
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
@@ -753,3 +762,53 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 
 	return true;
 }
+
+static int amdgpu_ring_reemit_unprocessed_commands(struct amdgpu_ring *ring)
+{
+	unsigned int i;
+	int r;
+
+	/* re-emit the unprocessed ring contents */
+	if (ring->ring_backup_entries_to_copy) {
+		r = amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
+		if (r)
+			return r;
+		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+			amdgpu_ring_write(ring, ring->ring_backup[i]);
+		amdgpu_ring_commit(ring);
+	}
+
+	return 0;
+}
+
+void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
+				    struct amdgpu_fence *guilty_fence)
+{
+	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
+	drm_sched_wqueue_stop(&ring->sched);
+	/* back up the non-guilty commands */
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+}
+
+int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
+				 struct amdgpu_fence *guilty_fence)
+{
+	int r;
+
+	/* verify that the ring is functional */
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+
+	/* signal the fence of the bad job */
+	if (guilty_fence)
+		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+	/* Re-emit the non-guilty commands */
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+	/* Start the scheduler again */
+	drm_sched_wqueue_start(&ring->sched);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 784ba2ec354c7..2b5546d15a6be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
 	/* sync_seq is protected by ring emission lock */
 	uint32_t			sync_seq;
 	atomic_t			last_seq;
+	u64				last_wptr;
 	bool				initialized;
 	struct amdgpu_irq_src		*irq_src;
 	unsigned			irq_type;
@@ -141,6 +142,11 @@ struct amdgpu_fence {
 	/* RB, DMA, etc. */
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
+
+	/* wptr for the fence for resets */
+	u64				wptr;
+	/* fence context for resets */
+	u64				context;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -148,6 +154,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
+void amdgpu_fence_save_wptr(struct dma_fence *fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -284,6 +292,9 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
+	/* backups for resets */
+	uint32_t		*ring_backup;
+	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -550,4 +561,10 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
+void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence);
+void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
+				    struct amdgpu_fence *guilty_fence);
+int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
+				 struct amdgpu_fence *guilty_fence);
 #endif
-- 
2.50.0

