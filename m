Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717DCC83010
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6EF10E947;
	Fri, 27 Jun 2025 03:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LDStqP+S";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2E410E93E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxBjanbj1sDvg/UPx4e/LcHHIrsaI9qjrTIFOGH6Z/WeB0qeUpA5RGHHY6VlDW8z/OzNVVjmUA+NvB/D8RNjq+Dl45RrllzngEbOjcK2OezVqEf0RRK5zqIwI5sGF98wguritCjgyRNHB8ggXdhnPiP0Q99gWb849H76dwAZAJWnDqLrkzM/Te1m8P+ni4n0Ax7mmGUfTC2mclaa2AXOqQiEjFBwne3lvlTTOe61gEkQGcUF522ElXL+IOA3xZFEQKLuZv/7C5DM2Kt8A8q6O3zJoWg+YymS/34dB28nFhEtfrIcoG2RZEl7DKvUz5b3uCqwuzP/HzOqJiBIhjPfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACCxBUFF7uFhFng9EKy+N7oUK1l6uoISlLpsTFjZkl4=;
 b=NYONpjqoDqyp4/SDCBfGoDZqd9qkEEihw2/jOf+CTHQVOPbkUbBysNGWVvhhwaNXeGTLTqAZSMwByC7iaqRLxuWwUujmEROp9miYUKW7F6bs/jvG/sn6t3TMQA+DDqC/fNfQvTgtxkWNMz9IgwxqP3LTMdUxiSa7wyn2JXyysiR2H3jdpQrGpVMjcaD3vvdG35sqBYG6KyzEwe+JplbtJcx1lTwc4szSHLN8U/aKzeEDPtZpWIFgk+Q/fU6unL9AQFv+nPDc+Y4herclZNMoON37n+kjpVHJy6j6j8APwIv5TRcjW9XN/qvPqz+Cl7RHANGaAJa0ZV0fZXEacvoJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACCxBUFF7uFhFng9EKy+N7oUK1l6uoISlLpsTFjZkl4=;
 b=LDStqP+SXmk0RAPKcUkMMcUHGU/kHgCE71Y9tGnmpeYcIhWrEOzNE47FHH6+R8UGC14eEBNPWUxLs4G+is/O0hd+YsV+bUKtc5qQz7AypuoGdEfS8nxcdugIrzCCcGU/FiGRs1IwrNav9nWqEmX9Zuv8darNIdMeNrecZ2AKF9c=
Received: from MN2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:208:239::22)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 03:40:28 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::5c) by MN2PR08CA0017.outlook.office365.com
 (2603:10b6:208:239::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 03:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/33] drm/amdgpu: track ring state associated with a fence
Date: Thu, 26 Jun 2025 23:39:37 -0400
Message-ID: <20250627034002.5590-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 902cf555-d0b2-4a28-4f18-08ddb52c5bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5fgQOExtfOfCNkjoWN7X0PnIORtRrI+D0942OqrsK9ew73Quwwvj0tW0Bze6?=
 =?us-ascii?Q?A+WiQogcP4uvARGQgg2S/fs+96An6+SSjsSmyTWnRiuiFN6wlBxmGNCOg97e?=
 =?us-ascii?Q?U4At8R+6jKpNfgjIUxueuQW8sPdN/v4WeU23xyrGkNJ2M/d/jf8g+Vy30qow?=
 =?us-ascii?Q?tmLewhc088xOhoN7cKE2n4PUVCC5dcXuHsWKRJOuIhIheunos0sfuFbHyUps?=
 =?us-ascii?Q?VrCPiQOobHf6T6+b20DSnuZrngiYS+sXWJ0VNs/ayeC7QJlGA9swEWQ1eFMJ?=
 =?us-ascii?Q?uPR2ZrIZFrn65xO7/bAi9YE3LdcqtDCd42XLQCeOy7/jz+CXPYWOnqQdz2GZ?=
 =?us-ascii?Q?VPZyzs0ZI/GIo/Mo6wuZCDezWUdHMsjXdsQslO5BSkSGTcScn4Ism/Co/djg?=
 =?us-ascii?Q?TLolWIvWOg0fcYMox6W10BBvbtmANyRpKBjq7r44NPRF0sc2Nm7rvO35KVPt?=
 =?us-ascii?Q?OJv1ZzcLu34D/fHP/Jg3+ORSzPCHLMBkXiUcc3RT85Rxfp3WqqXxGjd/+Vx8?=
 =?us-ascii?Q?2+61aMcO/07AWgRk9wfPJsjBM9sudL7Y+SJyV7O4Y/6t99Suwhq/ERCcs8z8?=
 =?us-ascii?Q?B8BlgxtapuTQPppCXATNmSCGu4yTcAWgkaR2Lowrwn0BZUvXsfX3J9+mFjBy?=
 =?us-ascii?Q?us/21TMlA2/4F0Sxn/L7aR00E9USDJYQq/Y1JM6ryHkP9hvmKMHKnaneQwS2?=
 =?us-ascii?Q?es1aGQw63WSeLyiEIgZdlrUjQveiLVovYHAdmOHv6c0PUtjvCfPcOTNH+bIA?=
 =?us-ascii?Q?Hez53KDdj7Bu9IorbrjVfEWmkl6kPdUyUecU5WH1EEyd+uJxICky2pLMxzuD?=
 =?us-ascii?Q?bvPWso9Xpq1M0DACNzsBgBgjCDCYNEGJFV307dSFj6Vf8vRmXbuRn2g4hWJK?=
 =?us-ascii?Q?fEnRXk2dUmCeT+LGqxWL6+L5cJpewGxaSUd7t9z5A+UcEeN0GXSE2TE1ZJD1?=
 =?us-ascii?Q?a9Lk7JcV4SPfwKAXRYWh7fD+HA4c1W8uOzuCrv3uc5GhKrXtWzcJsJDfffE2?=
 =?us-ascii?Q?cSQi39vEzJGBJzk17B8hxIn+F+bSXSGudZ3vDznmcH42kUGtcix71iZZJuKH?=
 =?us-ascii?Q?xpkjKuXu2dwsy3MHRKP0AcBr1g7Sc9wN/tTpWglK4zWO3HyzRdPUITlPEPJ7?=
 =?us-ascii?Q?x+RmQ8Q0jKxWFPHeVI/3pAyHymvKDDf1zL08uzHrI4NeTZcYJ04D/HlXyQMI?=
 =?us-ascii?Q?F4FbVuKs9MfjAnK7Dffe+xGpzSGVdpIn4fPbLSbzpPJ+bI6aEFBMjsdflV8g?=
 =?us-ascii?Q?m+08rAzmxUIuXZNpdbApDM/kjZAqVzQtn+/H9/PTtpk51lNK4ZT194yAxsJI?=
 =?us-ascii?Q?ceNIpCF6G8jwW7iPzJWSxkw1TM+PiJDpfRNIUHcQddwzlPq8l+htuKPhHlvT?=
 =?us-ascii?Q?aeudi1GnDlqglArFHoR6edqRb82/JfKTIsUnrdlhbHQ0Xi0bj7FDpTFDN9TG?=
 =?us-ascii?Q?XFt46+z2yaYUBP2ZrdWO6D9Nh2D2+XYlIUw/T9Ulr8IjtxCDmYE/38EHc8xq?=
 =?us-ascii?Q?Wi4DocyPvwPdFIiHVQM3TJsxuXv4LnuCfBPo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:27.7242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 902cf555-d0b2-4a28-4f18-08ddb52c5bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 90 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 15 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 67 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 18 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +
 6 files changed, 195 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2d6b2b486baf7..3f2080aecd5a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -120,6 +120,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
 		if (!am_fence)
 			return -ENOMEM;
+		am_fence->context = 0;
 	} else {
 		am_fence = af;
 	}
@@ -127,6 +128,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	am_fence->ring = ring;
 
 	seq = ++ring->fence_drv.sync_seq;
+	am_fence->seq = seq;
 	if (af) {
 		dma_fence_init(fence, &amdgpu_job_fence_ops,
 			       &ring->fence_drv.lock,
@@ -141,6 +143,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
+	amdgpu_fence_save_wptr(fence);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
@@ -253,6 +256,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 
 	do {
 		struct dma_fence *fence, **ptr;
+		struct amdgpu_fence *am_fence;
 
 		++last_seq;
 		last_seq &= drv->num_fences_mask;
@@ -265,6 +269,12 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 		if (!fence)
 			continue;
 
+		/* Save the wptr in the fence driver so we know what the last processed
+		 * wptr was.  This is required for re-emitting the ring state for
+		 * queues that are reset but are not guilty and thus have no guilty fence.
+		 */
+		am_fence = container_of(fence, struct amdgpu_fence, base);
+		drv->signalled_wptr = am_fence->wptr;
 		dma_fence_signal(fence);
 		dma_fence_put(fence);
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -727,6 +737,86 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 	amdgpu_fence_process(ring);
 }
 
+
+/**
+ * Kernel queue reset handling
+ *
+ * The driver can reset individual queues for most engines, but those queues
+ * may contain work from multiple contexts.  Resetting the queue will reset
+ * lose all of that state.  In order to minimize the collateral damage, the
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
+	amdgpu_fence_write(fence->ring, fence->seq);
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
+						   u64 start_wptr, u32 end_wptr)
+{
+	unsigned int first_idx = start_wptr & ring->buf_mask;
+	unsigned int last_idx = end_wptr & ring->buf_mask;
+	unsigned int i;
+
+	/* Backup the contents of the ring buffer. */
+	for (i = first_idx; i != last_idx; ++i, i &= ring->buf_mask)
+		ring->ring_backup[ring->ring_backup_entries_to_copy++] = ring->ring[i];
+}
+
+void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence)
+{
+	struct dma_fence *unprocessed;
+	struct dma_fence __rcu **ptr;
+	struct amdgpu_fence *fence;
+	u64 wptr, i, seqno;
+
+	seqno = amdgpu_fence_read(ring);
+	wptr = ring->fence_drv.signalled_wptr;
+	ring->ring_backup_entries_to_copy = 0;
+
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
+			if (!guilty_fence || (fence->context != guilty_fence->context))
+				amdgpu_ring_backup_unprocessed_command(ring, wptr,
+								       fence->wptr);
+			wptr = fence->wptr;
+		}
+		rcu_read_unlock();
+	}
+}
+
 /*
  * Common fence implementation
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 206b70acb29a0..7d9bcb72e8dd3 100644
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
@@ -307,8 +311,17 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
+	/* Save the wptr associated with this fence.
+	 * This must be last for resets to work properly
+	 * as we need to save the wptr associated with this
+	 * fence so we know what rings contents to backup
+	 * after we reset the queue.
+	 */
+	amdgpu_fence_save_wptr(*f);
+
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
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
index 426834806fbf2..09d7681b7a754 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -99,6 +99,29 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 	return 0;
 }
 
+/**
+ * amdgpu_ring_alloc_reemit - allocate space on the ring buffer for reemit
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ndw: number of dwords to allocate in the ring buffer
+ *
+ * Allocate @ndw dwords in the ring buffer (all asics).
+ * doesn't check the max_dw limit as we may be reemitting
+ * several submissions.
+ */
+static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
+{
+	/* Align requested size with padding so unlock_commit can
+	 * pad safely */
+	ndw = (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
+
+	ring->count_dw = ndw;
+	ring->wptr_old = ring->wptr;
+
+	if (ring->funcs->begin_use)
+		ring->funcs->begin_use(ring);
+}
+
 /** amdgpu_ring_insert_nop - insert NOP packets
  *
  * @ring: amdgpu_ring structure holding ring information
@@ -333,6 +356,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
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
@@ -342,6 +371,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 					    (void **)&ring->ring);
 		if (r) {
 			dev_err(adev->dev, "(%d) ring create failed\n", r);
+			kvfree(ring->ring_backup);
 			return r;
 		}
 		amdgpu_ring_clear_ring(ring);
@@ -385,6 +415,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	amdgpu_bo_free_kernel(&ring->ring_obj,
 			      &ring->gpu_addr,
 			      (void **)&ring->ring);
+	kvfree(ring->ring_backup);
+	ring->ring_backup = NULL;
 
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
@@ -753,3 +785,38 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 
 	return true;
 }
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
+	unsigned int i;
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
+	if (ring->ring_backup_entries_to_copy) {
+		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
+		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+			amdgpu_ring_write(ring, ring->ring_backup[i]);
+		amdgpu_ring_commit(ring);
+	}
+	/* Start the scheduler again */
+	drm_sched_wqueue_start(&ring->sched);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 784ba2ec354c7..309e7bb6001bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
 	/* sync_seq is protected by ring emission lock */
 	uint32_t			sync_seq;
 	atomic_t			last_seq;
+	u64				signalled_wptr;
 	bool				initialized;
 	struct amdgpu_irq_src		*irq_src;
 	unsigned			irq_type;
@@ -141,6 +142,12 @@ struct amdgpu_fence {
 	/* RB, DMA, etc. */
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
+
+	/* wptr for the fence for resets */
+	u64				wptr;
+	/* fence context for resets */
+	u64				context;
+	uint32_t			seq;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -148,6 +155,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
+void amdgpu_fence_save_wptr(struct dma_fence *fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -284,6 +293,9 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
+	/* backups for resets */
+	uint32_t		*ring_backup;
+	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -550,4 +562,10 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f042372d9f2e6..ea9b0f050f799 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -765,6 +765,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
+	struct amdgpu_fence *af;
 	unsigned int patch;
 	int r;
 
@@ -830,6 +831,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
 		if (r)
 			return r;
+		/* this is part of the job's context */
+		af = container_of(fence, struct amdgpu_fence, base);
+		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
 	}
 
 	if (vm_flush_needed) {
-- 
2.50.0

