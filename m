Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1118ACA1002
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 13:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9FE910EA45;
	Thu,  4 Sep 2025 13:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bC9lAkpW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5235610EA45
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 13:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLQUbPHB0glxVHzmZBSjZPZ3Nh0I0538x97XXFEetl8Xebim/13e+RD9+uEjEWBNqAjan3nmH/DxL3vTybBHOebi1LkmMmweUV4f3sc/UiFakC8aA0iwdd9JCQ/eIJkeLM6JkR9FP2jjRIqP5jhFRWers05lFBKN8tkeLvjwEALMFsPjlSlGDbPdAlaOA0TGUk490UhnROZl5Z2ppfCpUXj3KHmK8fohuvhj6Vr3eqZqk+6ppT2srO162RCksLQBLBQSS2eu1x4zJmKByLTHpZLxHHuE/ZjDVpsUtyO7w5ZSN0j8ZGITWfB4eHnQANpGj9RRzsR/dO28KkN/C75BtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7cA1jmqYTrv+XW67DtUXPGk05p4KrtcexO9Ebx4g0I=;
 b=duS6FdLjHFfhO5Pg2SNMJxMIOMCe0+xEjHQmS5+UoxwW9dM7ciOYKADbL7+OrIze75mrTwiVnY0BdtmIxioOOGEakVj7g5VKEOLAgQKuAVR8skP4Puogn439U3eao7V2uEjrUrwGoUusY/2joMBMJhygIL+e6kzL5jQNithFcPm6ILvEoY2q8Y1waOx5Rbur1jG6Kf2VBQ4ixyPUrMWFoS5e11uysIVzndeCAbqeCZG/9/ylyFL+UUcYA5I/SBz319PxhOdI7SEDPqd7swiz7dnFxCFxQi0pN2qvM/CCrkpPuuRhnphDys4FE/XlofHSczSt7u5R9/m9sQKLTlrYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7cA1jmqYTrv+XW67DtUXPGk05p4KrtcexO9Ebx4g0I=;
 b=bC9lAkpWMNDAZ9xME2f1UqroePvuLbDx5SEl2tYekkhH3nNaj9DWodccfnqpSVc4GHX8nzvvLn0zhxSf/Ng28QF5ODDTfxNat2ZU60F6qFmzqT84h2V2QYXQsUwpeUC9BpBki52yA/8xJ+QYGS1j3nofO0b1EdOiJ+cRBLcikm0=
Received: from BN0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:e8::25)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 13:54:24 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::9a) by BN0PR04CA0050.outlook.office365.com
 (2603:10b6:408:e8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Thu,
 4 Sep 2025 13:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Thu, 4 Sep 2025 13:54:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 08:54:23 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 06:54:23 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: set an error on all fences from a bad context
Date: Thu, 4 Sep 2025 09:54:10 -0400
Message-ID: <20250904135410.5573-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 6353f372-d052-489d-ead1-08ddebba8e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Y0ZzCkJfShQrqYTGdd1GK54jYM3L/oQoNvdi+moZmhiJKEjMDg+EYLYXvzZ?=
 =?us-ascii?Q?U4Rn1517j9Za6qP6d/0y6DM0/JpOs/Yd9Wt3O+IBNG38LWrjYJjv3Iu2weAD?=
 =?us-ascii?Q?+jk6E6+vT7wmXTwdhoITKorezl+/UvCPFask4wmuMvQzhiVLz6iaIGJTtEL2?=
 =?us-ascii?Q?VA3EkbzcwXv3BouFIyglWrmGxD7HAu18jzqpDt4g21wOaJuTHZ0v+rIFuy+N?=
 =?us-ascii?Q?5tQduMcXoASm5x8wMVBQN+WbH3gLMKzlXlXR1RMxjJC1u4giJqrKT2IIUP97?=
 =?us-ascii?Q?lpWlZGZK/pdKCBYQCghKKvvxW7FbalJ4Q1gGu0RNTCECuafbMkTELM6OvAPk?=
 =?us-ascii?Q?vb4+Vi1cQJ+3DOZFnH/6mPmSrTmv+RuFZ8EfdWYeTMCpyjFruMrcb7+JeSEZ?=
 =?us-ascii?Q?2iUbw38M53uyGGoBBBo3EStpFlkkk1yXfauEzl9++q+cQX+Rmb0teELpp+GH?=
 =?us-ascii?Q?vS0zP0M1zCPTavc4llO6cAypCU2ols4me7WvzBlOWIVn0AqYNaXXOpQIht5V?=
 =?us-ascii?Q?82Pez4qxi4L+33LHxdW6Vs79CPfKMkt5fwbnrh9J4JdYMhFu4HheQQZ3v6t+?=
 =?us-ascii?Q?pCeP+ePgvNJ5VybHKesvKWgK6x9hFwS/eyorOxfTAbM7lFoKLAE1KY0i+SwS?=
 =?us-ascii?Q?91oxcWLJWLYbUJBTQHLDqPQ6dq6ycS/IGX3u2+C1qRSXPp/Z96xx21x7TDGT?=
 =?us-ascii?Q?nP8U7ePc38vF0urmI2jXagUjjQpaMWDEP40zmBhhv9G5PV2+lCoA05HAx+lb?=
 =?us-ascii?Q?z//Qy264uM/z3Hp4g6rgjYZb11yrofH9cSduaP35keIO7uDMJP+D753bNTh1?=
 =?us-ascii?Q?ouzN1acjpZ8Pu9bywDc08p8FKC8Yf9P/6XNYmr2RSg5CDuMdJHkvJEcZg9Tt?=
 =?us-ascii?Q?NPIzeZsTiny62n3j9wq/3lxtwCA6eJNX1+0Ljs957Y/pyj7JXpj9Sk9IAdk5?=
 =?us-ascii?Q?TARzDbns59SzlUQ2hxxOWyjDW97L9FZa79O/sQtG0j8KV9SY88qLCC9iggHa?=
 =?us-ascii?Q?MoZNufACA+OqMEv7O0sf1PXFCRQZ7JXWMA6fNOVVekxeOVBcs273mKIUd8Io?=
 =?us-ascii?Q?ynhsG5uP3GjwbowkOYs+Y6ViUq/zrkdf+w7DYg55LfIwhkj/tZ1iiWDZm5MH?=
 =?us-ascii?Q?31oc6pAMHPtr3xJh7wfm8QqRq1FPfudb+do4uq34PlQi/dfyMV9kAXu1Zax6?=
 =?us-ascii?Q?I5vB+WkdBnfUbxoj4tTtuS1qXWyKQieJ10A1PstanOFcrYsIaUJUiLF6qNZO?=
 =?us-ascii?Q?ZEJ7GZWnQZa+gJB7O+fv42MJvOVNYrC0WmXhhDBykgnQ5G7Rpiu50GXrTm6C?=
 =?us-ascii?Q?A7cOUgIIvzV9WSSzyo66HjWg9wW3l+u7v6d9cMhPia9VbngAxifOygq/kFe4?=
 =?us-ascii?Q?M7roxYAAJd9vrvUO1htqU47sktJzLewRwaMi+Lm0S9OKe/D+6y7SK17p+3D+?=
 =?us-ascii?Q?jyITQZYVtWVt0BSHQhTuqmiarQHIxNz3WK8KEXGYgurgUuHKJznwHTCLhk0S?=
 =?us-ascii?Q?dYlqzCBvONvfGyGzHr0fedi7AJFxZgRyfHPc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:54:23.8650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6353f372-d052-489d-ead1-08ddebba8e39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
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

Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 34 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  3 +-
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index fd8cca241da62..1b689a4226291 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -752,17 +752,31 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
  * which data needs to be saved out of the queue's ring buffer.
  */
 
-/**
- * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
- *
- * @fence: fence of the ring to signal
- *
- */
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_ring *ring,
+						 struct amdgpu_fence *guilty_fence)
 {
-	dma_fence_set_error(&fence->base, -ETIME);
-	amdgpu_fence_write(fence->ring, fence->seq);
-	amdgpu_fence_process(fence->ring);
+	struct dma_fence *unprocessed;
+	struct dma_fence __rcu **ptr;
+	struct amdgpu_fence *fence;
+	u64 i, seqno;
+
+	seqno = amdgpu_fence_read(ring);
+
+	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
+		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+
+			if (fence->context == guilty_fence->context)
+				dma_fence_set_error(&fence->base, -ETIME);
+		}
+		rcu_read_unlock();
+	}
+	amdgpu_fence_write(ring, guilty_fence->seq);
+	amdgpu_fence_process(ring);
 }
 
 void amdgpu_fence_save_wptr(struct dma_fence *fence)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5ce..725d6437fe8e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -812,9 +812,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the fence of the bad job */
+	/* signal the fences of the bad job */
 	if (guilty_fence)
-		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+		amdgpu_fence_driver_guilty_force_completion(ring, guilty_fence);
 	/* Re-emit the non-guilty commands */
 	if (ring->ring_backup_entries_to_copy) {
 		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7670f5d82b9e4..7a362ce8435fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -155,7 +155,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_ring *ring,
+						 struct amdgpu_fence *fence);
 void amdgpu_fence_save_wptr(struct dma_fence *fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
-- 
2.51.0

