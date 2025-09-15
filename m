Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B5CAC592
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 17:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC5210E51B;
	Mon, 15 Sep 2025 17:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QFYif35J";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6825810E51C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 17:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLLoQbchnfHRTP+K63FyzsEVZjkz2V7i8GghMNkZLT+jq8ISUh4M15b6KNQ1qpQqGIfyg7JF0H9SZnJ/ckxZrqdzbtGB0l/VH8SYF4Bx5VoUh73qvyWEXXHwUUqUIPN3J9L7G0JMRbtmwSSgW5KXJy67psCjfCEG2gjyZCngNXLSv7S79qLOUlBYm3dogxbVMFxWR+b07zbLcZLGktG9j+za3sMpcgdg4i2YUQceo8ec2hP63B/JBLfY1PAg6290oounNOSZ2FlUwBTZLA82wVb2FhBhVNE1lQd8+nhJyblMlFrrOrNStUXvHYnrlHe9H7/SO+MzOomdLppcOWUm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0xO2eJkLnacc0cok6Pjxh5tn4piSfBbwjqajGw/u60=;
 b=OO9wiUlAN744iAD3N8+kLfBGPIpxNEHLt4lUCl6hCRcNvsQ9GirEHp8nWtb92gv9f0EvVhjIFoIItEAF4zdppbcxJTcrPwVMNLclCkQqGRdEEQlgqGZkqy8oTqto5in17U664MGaM+LSw0cf1WBU6AUxnaVViiY5KV8vUKaKIlSEBPMHHGve/iAlvoWuAmyFbtb17s3ZQCV17k7D1gtNqP5bJ53rX9tQDIEOBIgtMEP3QP2WQCB41ihfrlu413RoJmPF0Nvmxydl2hrxACHbxuLpmQwmjuSmlKWW6jI87pt33pPWuHkYA3Bc+CE6lTAMtFntatuJVifSVuy7qrq34w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0xO2eJkLnacc0cok6Pjxh5tn4piSfBbwjqajGw/u60=;
 b=QFYif35J9h24uV2PGzjerZXPLrLC9yADc1AIZbaahgxM8CmllEab6wbQPLd5aE8G/RKZQUoudJBSAWD2V1UPWpYqDZWLrc5kNjpFHVcNV22xPnE3y+jMJQrqV6gkL+lFpIuG73Zsujw3NLcyFkRAj3KEBWHlhbbKC8C7dADx+Xk=
Received: from MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 17:22:37 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::68) by MN2PR05CA0060.outlook.office365.com
 (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Mon,
 15 Sep 2025 17:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 17:22:36 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 10:22:34 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: set an error on all fences from a bad context
Date: Mon, 15 Sep 2025 13:22:14 -0400
Message-ID: <20250915172215.6872-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915172215.6872-1-alexander.deucher@amd.com>
References: <20250915172215.6872-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: d623bfb1-d550-41ed-2b48-08ddf47c7732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YBE+2zKnt1ErRmea/FQ4tm8UYTPjeZV4/f41Md91NuD7NuzfV9PQWU9sajt6?=
 =?us-ascii?Q?mKTShKASgffy1Y0LMHKXrBg1NLLG0+VWcriHD/99QV0x2zew539o9hxOWWI0?=
 =?us-ascii?Q?ytJP4C8y8Bta1l/h+MUzBfW38faX91os8H6m7eCcnKdqBFN53YxzZLcd/Iqf?=
 =?us-ascii?Q?1hYGzy77PPtXMR3U3Tb7qPIP5qEGv6nojVVW3YSQ+dKf7pJiIAejJafVSSB+?=
 =?us-ascii?Q?4aFfEaF8PzLP4dTFDAze19vOzbSblv+6KKLrBjwQYOiNhPOf55gIka1dbB8b?=
 =?us-ascii?Q?tdd9jjOQ1RFQysqbo47EkOe9rAxgB973PeOhh/rx8uOO4sb2ShYLqKMPR134?=
 =?us-ascii?Q?a7njqHysZ7M7hyH7kFW6YHqsR2eXBKT5s0+lMRV9xKyIBlN7bIadexvqEvb+?=
 =?us-ascii?Q?+4NUqdPXmkIvl5+4W3edhEMiIW28uUCmpGnVSvmnUefKscT1iHz8iDmAqhjB?=
 =?us-ascii?Q?RfZ+FYzaxm6ZAuZx4JzX62k5WJQknVbG69W0ye2Zd7/0nZc/OwT3VtCEeeKm?=
 =?us-ascii?Q?GKsgP1K0V+N640HyavwL8UtNECHaAmCZjKGySdOV3wXJProbqt4wsy15liZl?=
 =?us-ascii?Q?KtCXXrK+RrawkDOTeGKD98iXDd9xD5z9WNOHx0cbJrrl5aQ6sDcuisI6bQWG?=
 =?us-ascii?Q?FrbkErheKrRzrtq35pssB49xMcBrQWCwZvIUM9XMjiNAIjm2zRNkSPfrbSxc?=
 =?us-ascii?Q?Gfs4TMYnPHuTf4rClOWulUMwJscVyTaioKzgtILOQ4k3sLdK6WtXi4WBZvfF?=
 =?us-ascii?Q?d+guHI/7eR4lv3sLFQD7bs7JcIuJxxNMZQLnf1IfCOjZsWrTqycVzK79LFfA?=
 =?us-ascii?Q?4noMGzB49gtVepsnJVXTPnvnSc6R9ws2eyC5OabAll0krhPNqHlXPHlLCFSV?=
 =?us-ascii?Q?el6zNHTEUDiai843sVauhJYFY+PldnlRwamJPSq+Qa3TA0gGubulOWI+BMdP?=
 =?us-ascii?Q?tBJphredT0tJINc8rxku6wUcU3jGxPJ3jVMUpbz1DCRthwkU5bvoZKcySFPN?=
 =?us-ascii?Q?QfrSpYI8vhQ5BxWfzSWerhD0GXlY70lkE6Vi9TGUgNg6pJ9qT6YhPBLBQu64?=
 =?us-ascii?Q?0o4AJhtoJbNs4aiqkzgmHtS7fhGHTi0WSeUA1JE9jPeRjkB2Q5Fty353AXc8?=
 =?us-ascii?Q?GAXyfT2ZUhYhe/negiMqpIKwOxjJl2ysj6bjLtJ9yv97VOcv/jpdcBD/K4N/?=
 =?us-ascii?Q?yvWbpYe+gQ8lm1KPq/IA/1FOlRxq6JiHkciBmaCrD9sEoR4C3tmANK74UlHE?=
 =?us-ascii?Q?q9rl42zcfJVYi8nIb3Oav/G3iJdanMa2v1PY4iRdqFe+zkbj4K8NVDSbmoTA?=
 =?us-ascii?Q?3FOHmGLv7aP5L+8nq1rObi6wOWi6P3FvDiRClXojsuHJoetId9SLfo/yFXWI?=
 =?us-ascii?Q?1a4JnuFEp0Hghw298flAhuKwan66gbpUB4mY3BZB8c6QoZd+U5TuHOPrYWAX?=
 =?us-ascii?Q?yZYG3a50I6lIr1b3sU8uvcb1+sk66XnV2iN3d/rD6N2NXPl0fG4jokgj/Ymx?=
 =?us-ascii?Q?wf6HNBr17BcxB+QLZoucQZQl0GuPZq+7HSH6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 17:22:36.8951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d623bfb1-d550-41ed-2b48-08ddf47c7732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461
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
v4: fix wrap around, locking (Christian)

Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 39 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index e270df30c2790..18a7829122d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -758,11 +758,42 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
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
+	u32 seq, last_seq;
+
+	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
+	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
+
+	/* mark all fences from the guilty context with an error */
+	spin_lock_irqsave(&ring->fence_drv.lock, flags);
+	do {
+		last_seq++;
+		last_seq &= ring->fence_drv.num_fences_mask;
+
+		ptr = &ring->fence_drv.fences[last_seq];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+
+			if (fence == af)
+				dma_fence_set_error(&fence->base, -ETIME);
+			else if (fence->context == af->context)
+				dma_fence_set_error(&fence->base, -ECANCELED);
+		}
+		rcu_read_unlock();
+	} while (last_seq != seq);
+	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
+	/* signal the guilty fence */
+	amdgpu_fence_write(ring, af->seq);
+	amdgpu_fence_process(ring);
 }
 
 void amdgpu_fence_save_wptr(struct dma_fence *fence)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 8f6ce948c6841..5ec5c3ff22bb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -811,7 +811,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the fence of the bad job */
+	/* signal the guilty fence and set an error on all fences from the context */
 	if (guilty_fence)
 		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	/* Re-emit the non-guilty commands */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b6b6491797761..4b46e3c26ff39 100644
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

