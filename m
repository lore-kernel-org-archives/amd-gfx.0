Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AD9CA1013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 15:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A252D10EBDF;
	Fri,  5 Sep 2025 15:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VSwqCwn5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3A810EBDF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 15:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfSlgZVrUTmJvMFogQ6Wf/QwcVsr4qW1O2Bk9sHnkEyFjYRo0B29ccuXum6W373B+Ctz1q6i2j3FnNarHC+1GDpMtHJx5mHPbYhzX41u1Z642PKR/g0a3KFj7ZuFSx0GnAcOO2GSMVc1ydNESTDfSCbjhJyG6yfga6uB8NUTVxDke19Q6WS7JAZ4AJIGRGsrQY2pIODXDeVI+DRO/VpsyF96rpXxmqoPx0EiAOb6eJrLvVhBY8noUeKf7jHGaWLbG4HHOQW2b/8hcr2nuIICjkEGMagMBFWxhayXm2IVnDwHghG22Ysr0T+/qthYqk7r6zIwVBrBYgse0oFWH86aUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmrvVK6dhquAiEgysUIJ8Bpqf3qKboLJN+SoNDhhqnA=;
 b=bY2ZVB9JGRGOJg2YEfXnfywMjrRRonpDSCgZy4NZW+wRxWM8x+HPoaXuESYqOkL8kDShBNFSqvQjfZgieFYBtfERzmh5QHyDipnnAQLtTYzA25peeVyJmU38Spb/DAOv8PqOS8dYoltL2pzQvMTcNKGpALgMYYCGZNriZJBaVPgOINy6ZD1A71t79jl0z4TtJzLLjGoQzJiD054Un+tpClDfz+A+qzCG7wcp8S4aqVgFJLUGxqZ2Frnadr7YyKYaSl8XyBB4FIhCBkKXul8OzwwErLIXiFUg7Wr5JOPmiKxjIJxeshBygjG2aNe8XYDyWk6e/jKkFwGMrqhHkUgAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmrvVK6dhquAiEgysUIJ8Bpqf3qKboLJN+SoNDhhqnA=;
 b=VSwqCwn5fOf+QiK0pLP7z3gky+S0sTLw79BK24ZCp8fgS3MBURT640hKt6e4AAoonhyS9VsSvMCPeQoktvL8/9zauoGFYQ+xrs/acdigRCbwx3Hgj5moY2xJ8w3nEYu7OAcXwVAgoYQj5EEp+jY7bCOs404pwiyBiu42XymR81A=
Received: from CH5PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:1f4::28)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Fri, 5 Sep
 2025 15:26:09 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::3d) by CH5PR04CA0012.outlook.office365.com
 (2603:10b6:610:1f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Fri,
 5 Sep 2025 15:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 15:26:08 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 10:26:06 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 5 Sep
 2025 08:26:05 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: set an error on all fences from a bad context
Date: Fri, 5 Sep 2025 11:25:51 -0400
Message-ID: <20250905152552.5558-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b5eb03-a03d-4abd-88f2-08ddec9089db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P4Q95aRGvaa5EHO+0V7x0Duvi1IvkmGFsipTNBTHEhqWO2X+Fskmqzh4mlg9?=
 =?us-ascii?Q?pLB74XhUYRVNY5RNGQ03rtW13UHrZfUvtbQUjFBv+/NIdMShkAd1DTDDkcZI?=
 =?us-ascii?Q?Im8H0OqvI2Bq+jNS00n+bvS4q3kE/kuEwD6J2y8WpW3duLFP6VXbLibXsv8G?=
 =?us-ascii?Q?zLoEfpvkEwSWPW1JeIyuK4ltFTFro6fvH+TnV0nN20x+Lk1hQuPGOAmM1dJC?=
 =?us-ascii?Q?wJ8P2MQboeJf1706ATVteXz1YEi1h+oEuitvxLGEUHqifmccUMPfh+AAqyxc?=
 =?us-ascii?Q?3epXQdcrQSZ4qvaR+1NYeiKaGD6rRsRgHRtea300nt5qqAM/LaRTwBi8OFL1?=
 =?us-ascii?Q?vKNVxyWT/7NjUph5KXfvf+yeH8a4zlUzjX29mmQoXXWY9oFia4fnzgHMgIML?=
 =?us-ascii?Q?xge6yeOB5DX3Hy8GbulT2I93iqt/Q9r0z//YrRQKxHriVcKmYkebZfAmJNo4?=
 =?us-ascii?Q?XnHr8vxnLkUNtDjpYBg/XAHCDniyJVGuDXG59FMBtV3+2GozAHUHujTVsqFB?=
 =?us-ascii?Q?rocYOaOPD8Jve0OpMKVXexRXt/RCesnTsy0KDm0vWSW/Fyb7i3i2n0bkP+QI?=
 =?us-ascii?Q?xy1CwJ1Ai8vt6ABzh8i0LLsahf51XZ4eSkAL9YbHDBvrUOn4fzoV2jO6W5ET?=
 =?us-ascii?Q?zvKUCjRIMbM6veNdPCYiJtXyUMzzr2JOL5e8cu5P+37hyA9MduVZAvP9KRKr?=
 =?us-ascii?Q?tl9uuDLYPobo2OOuyb98Mmdb2ryuPlabNW9KNkIUqNNBmIJNNByOLzdAHo5W?=
 =?us-ascii?Q?zM+Kt2WSGxrA0RioHk+TyAdqJHX2oEmb6It4qVZbkU3/Pd5YwcqY1wjBiYj7?=
 =?us-ascii?Q?PUUEsSm3cO3J/6BILSU31vd8kmd58TPNTvDc/arkfziIICNZ+Y9FnesWszZf?=
 =?us-ascii?Q?9CegO5oJbzocMzT+S0CHixjnPzTOG+hstYO+0dh+hLql2bcnGDrYgmfsXB8P?=
 =?us-ascii?Q?bMh7aTfKKkAPj5UKQNSGsTA1WMD1y4b5QrRkplfwgm6y+OuWnA84OGNQMVXq?=
 =?us-ascii?Q?U7UfJaDFGX+MdgVLkYaScu+asRr5PaHljzk4ZcmnATBZYKhkwI8nNsUe1gLH?=
 =?us-ascii?Q?ZB4UszwmnHnJ7ohZ3FEknKRgzX7t7lbNDPhauxhip7IC1NIcfM8sJz8engY4?=
 =?us-ascii?Q?tqPLmgqQTXVEcECHxR/DUbZCkMnnpQ9Dc+IdByzi1VvSF2UPZVU9pWZXM1jF?=
 =?us-ascii?Q?T08m9ZG+fcYyMG7x5twnV6QaIk+n/TviWVt8Ge8y1DYu0iurP5waugKj3flO?=
 =?us-ascii?Q?oTFYg5XPdgRmpFYG2f8KIKBAtE4tnfpbucFYwP7rWfn+hnAakbfaOqUmKLBE?=
 =?us-ascii?Q?rVEgjB3Lu2mU/ky0OdNmbi8VEeYDagFl1nJCo//882CzGXQ+DBCG1DMCLPrn?=
 =?us-ascii?Q?oxx0l2fBCUqCuGZO7mQS7twZgMH4Q7BsnqNbDReucYh4W6ArC5oG91akv9Mf?=
 =?us-ascii?Q?CWxlEagerqra5zwXqoaaPTxscreWunCE3KxrmXez3YPy4BIK0zjRq/aX0PSp?=
 =?us-ascii?Q?PNSRFEJMp0K4u7eXIQgGO/0tpIIBdfxMvFmm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:26:08.8220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b5eb03-a03d-4abd-88f2-08ddec9089db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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

When we backup ring contents to reemit after a queue reset,
we don't backup ring contents from the bad context.  When
we signal the fences, we should set an error on those
fences as well.

v2: misc cleanups
v3: add locking for fence error, fix comment (Christian)

Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 33 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index fd8cca241da62..72f0f16924476 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -758,11 +758,36 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
  * @fence: fence of the ring to signal
  *
  */
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 {
-	dma_fence_set_error(&fence->base, -ETIME);
-	amdgpu_fence_write(fence->ring, fence->seq);
-	amdgpu_fence_process(fence->ring);
+	struct dma_fence *unprocessed;
+	struct dma_fence __rcu **ptr;
+	struct amdgpu_fence *fence;
+	struct amdgpu_ring *ring = af->ring;
+	unsigned long flags;
+	u64 i, seqno;
+
+	seqno = amdgpu_fence_read(ring);
+
+	spin_lock_irqsave(&ring->fence_drv.lock, flags);
+	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
+		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+
+			if (fence == af)
+				dma_fence_set_error(&fence->base, -ETIME);
+			else if (fence->context == af->context)
+				dma_fence_set_error(&fence->base, -ECANCELED);
+		}
+		rcu_read_unlock();
+	}
+	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
+	amdgpu_fence_write(ring, af->seq);
+	amdgpu_fence_process(ring);
 }
 
 void amdgpu_fence_save_wptr(struct dma_fence *fence)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5ce..f6c9decedbd51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -812,7 +812,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the fence of the bad job */
+	/* signal the guilty fence and set an error on all fences from the context */
 	if (guilty_fence)
 		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	/* Re-emit the non-guilty commands */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7670f5d82b9e4..0704fd9b85fdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -155,7 +155,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct dma_fence *fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
-- 
2.51.0

