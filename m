Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B58C7115C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89D210E47C;
	Tue, 17 Jun 2025 03:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r+LkjLap";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4281310E3BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8g4YIoVxGJWa75NPOpnVJSiw0o8LamsKolZF5GLfmHOdsfKzCZ8YpMocBdzXPqVdZP7etvYw+3hC57UGYoyXaofJ6eFpyL3N1A4sSXItXSMI7XxQWEwp7TPjZmKK3GPSdwL7aMhjgLF2DCwBaXqjl52Bu8xJxwgR3HEdOzxZJWqXCe9k+sTQW5qum7QP31qexGHcsDY6flLGFBh9Q1E0F7HtlngnCFaJuWY9h/qJTiDdcW9shJpvefHHmOz2Er4fBQn6ed1zw6INwcSS8BiyuOxR+LF5qYtHjqUjIAmiSb1jXGD8vPQoY89+LqSxmNyrulntYxXTigsIGZPVe7yHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki7J8GMoNf8M1cAe+w0Pop9oMgSfbgBb9r3ndpiNWC8=;
 b=ME2BkFUSaPjOmi++N6Ekvut70mJwnaSItjVezN2wuAmdK/3zqWaTIoDxTvRDHKWUazAqdYatkEOGV8u1zUBakw2TWWYgCfhrJmfuCjza4vOJp12dhaSSPHibP2hXfpuWAprdNDcl+IP8dPB4vcgWuVb5uFkgGh2cGCevutCwRpARdfUQywwGgP8EWbTejbduz8RUD3GE7l5tp5G6tN7bRsItDFX9+2CSpBNpUv+8zXe72Nbj6UI7rs6+oK5VUIjCHKUmdEUVftlmoFV/pUblveET8NDNoZtTIKs2wcuBp++FjbOeEN2gl2ijvpNcqljiuGlckOnPBP9+u51mOANMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki7J8GMoNf8M1cAe+w0Pop9oMgSfbgBb9r3ndpiNWC8=;
 b=r+LkjLap1Wl3iaawdiU3ow+HVa99DGK+q5ODDBFdvGCscZrzGUFgMCvuIYDLtKHjzo0o5qXbm+6NJEH3SksVg5XdlXUNcPI6SPXmLtHtb/vo5EI2Kn5xYIJW1VapK5oOesfhKnUw2WWJXrY94ovKQgJD+1f6xROxCx/EWf1NKYk=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Tue, 17 Jun
 2025 03:08:32 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::b9) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 17 Jun 2025 03:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/36] drm/amdgpu: remove job parameter from
 amdgpu_fence_emit()
Date: Mon, 16 Jun 2025 23:07:41 -0400
Message-ID: <20250617030815.5785-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: b4239ce7-8361-4e42-89fe-08ddad4c3e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iz2m4oScdIJ9umykLaLz8gssUqT7V+QbVHZ2N6T56bWsX7aXNichOt4fGixe?=
 =?us-ascii?Q?rNEFlhsPUZLdivlX6/b8fhzQ0tALDlgDY+ycr3HzzQ8MTD9CwGRiWHm1Q+wR?=
 =?us-ascii?Q?qTx3bgWCV9cyylPehgtEawSs1AJ0Z/dJ960c7qF0xVP4YM/CdooCJ86rVPPb?=
 =?us-ascii?Q?abdA0nwAjFh88K2uKp1FNmigMAjBLYqILUULPEGwtABVqmcawhT2lhnkeJt/?=
 =?us-ascii?Q?TvNYsBRfs3WhJ3opppyMCwslDCXTo0VYXhMAsijKGaB2ovNNUqwrmW2gE+tv?=
 =?us-ascii?Q?ZCE6HsKlhDd6Zm4ZfcAJhYLJTUq3gA/dwMs76n/+o1+tcOQs2Olpd9a+WGeH?=
 =?us-ascii?Q?od0BF0Sk3TMEtUDhwdduUdwoyNpGYcSzsZaY049/ZD2qeVZuXr8E2fbAEjtM?=
 =?us-ascii?Q?trLKqt6ezpxQX/O7i5w25anqiw77fsXozww9wE0S11OZZAxtS9NKqE/e3qQE?=
 =?us-ascii?Q?PrgkzrIztNXdarDTu3GGEUgnVAKxXo/dndxaLWzp9CKp5VQ9rdGJCdKfqSfj?=
 =?us-ascii?Q?flrpFSjE5dDpJa2KHbUScBoagrg0k4HTd0CDqbvmsX3u2u4ElavPDjixxfRW?=
 =?us-ascii?Q?700f5aA9wbX7Nm5LXxw5jaWeq/8bO/e64qRX5Zv/QBIss3xavenETZkt3ClZ?=
 =?us-ascii?Q?LbV/nm9jvJYTPsZO6fu2BtiwBByXuP5M/Pbk7Eq3vb1o0ED6vR+bB0WtqKXp?=
 =?us-ascii?Q?stgYTsYXMUfuDHk204/XgFA2x9xFT9F0oIi1b2CmibW5DbLXsU5ByEPUpKXY?=
 =?us-ascii?Q?rOMDcRICEp0EoQ0+UuZ0mWJoGwljBZOAtk8bsINaqyjm/9zbpzmJCP8OEUHF?=
 =?us-ascii?Q?dl8Z/bKYVQA/qr1z2s3g4rIrNfTvaKui0PpeaJo8qQuI0jzDh6AZDePOVz0a?=
 =?us-ascii?Q?dk0rqkT+cM2HWcp694sfVWLR1IWJXyiwucm8fBVX/p5bOgLVrcNqHC+3qacI?=
 =?us-ascii?Q?B8VlwEzyq5GSuhA88+MNBSo4hheDf/n+bJy/juqTZfdAieS9lkOj+NcqTbrn?=
 =?us-ascii?Q?Y5+qW6LOuoDzSQonTWQ6JJ+HCJx+9rDprxcp0W3RTvevu5i9xHUIoQNH4lZ3?=
 =?us-ascii?Q?DMLRnuGQ4MfWL40VE0tq8SiwfKGysnsj2qP+sKszwxc0W51cxJoewYvFo+eE?=
 =?us-ascii?Q?Pij6XiKYkH1m0SClH6OF6MfZ7LQrNKU9qLnEQ6J7/y++yATtvu7oc1DfQ9X/?=
 =?us-ascii?Q?6qY0ymvMgPiS6FeJMNsfoO+4CDRdiBy4YBXnFogBLs5tx5aEnwUCDjbvTInp?=
 =?us-ascii?Q?ZuEzzGPXKjTbfHMvqQTIT7oiHvA0IeTLvQc56CleOouB6yO+H3UVfEznSMNg?=
 =?us-ascii?Q?peS+taIug+QqlcN2Efzo3T/iaL47EXgYZaxfVSLTHN+OnXbpAg7XpbzGReAg?=
 =?us-ascii?Q?ihy4oJ2PIdNkuJabXLlA3sYUARLtJRLkc8fArGn36y940v2q7grwReTVVl3T?=
 =?us-ascii?Q?FAOSHfg9zjIQ3NjjmNYPyiQaPA+edHQrzh/jGQh0McCqpOOKkhBmJ4BQF1sr?=
 =?us-ascii?Q?dlDZ2kaijRAPotAzI3SE0JND02UzX6ZpzPVX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:32.5400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4239ce7-8361-4e42-89fe-08ddad4c3e0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
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

What we actually care about is the amdgpu_fence object
so pass that in explicitly to avoid possible mistakes
in the future.

The job_run_counter handling can be safely removed at this
point as we no longer support job resubmission.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 36 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  5 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  4 +--
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 569e0e5373927..e88848c14491a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -114,14 +114,14 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  *
  * @ring: ring the fence is associated with
  * @f: resulting fence object
- * @job: job the fence is embedded in
+ * @af: amdgpu fence input
  * @flags: flags to pass into the subordinate .emit_fence() call
  *
  * Emits a fence command on the requested ring (all asics).
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
-		      unsigned int flags)
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
+		      struct amdgpu_fence *af, unsigned int flags)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence;
@@ -130,36 +130,28 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 	uint32_t seq;
 	int r;
 
-	if (job == NULL) {
-		/* create a sperate hw fence */
+	if (!af) {
+		/* create a separate hw fence */
 		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
 		if (am_fence == NULL)
 			return -ENOMEM;
 	} else {
-		/* take use of job-embedded fence */
-		am_fence = &job->hw_fence;
+		am_fence = af;
 	}
 	fence = &am_fence->base;
 	am_fence->ring = ring;
 
 	seq = ++ring->fence_drv.sync_seq;
-	if (job && job->job_run_counter) {
-		/* reinit seq for resubmitted jobs */
-		fence->seqno = seq;
-		/* TO be inline with external fence creation and other drivers */
+	if (af) {
+		dma_fence_init(fence, &amdgpu_job_fence_ops,
+			       &ring->fence_drv.lock,
+			       adev->fence_context + ring->idx, seq);
+		/* Against remove in amdgpu_job_{free, free_cb} */
 		dma_fence_get(fence);
 	} else {
-		if (job) {
-			dma_fence_init(fence, &amdgpu_job_fence_ops,
-				       &ring->fence_drv.lock,
-				       adev->fence_context + ring->idx, seq);
-			/* Against remove in amdgpu_job_{free, free_cb} */
-			dma_fence_get(fence);
-		} else {
-			dma_fence_init(fence, &amdgpu_fence_ops,
-				       &ring->fence_drv.lock,
-				       adev->fence_context + ring->idx, seq);
-		}
+		dma_fence_init(fence, &amdgpu_fence_ops,
+			       &ring->fence_drv.lock,
+			       adev->fence_context + ring->idx, seq);
 	}
 
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 802743efa3b39..206b70acb29a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -128,6 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
+	struct amdgpu_fence *af;
 	bool need_ctx_switch;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
@@ -154,6 +155,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = job->csa_va;
 		gds_va = job->gds_va;
 		init_shadow = job->init_shadow;
+		af = &job->hw_fence;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -161,6 +163,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = 0;
 		gds_va = 0;
 		init_shadow = false;
+		af = NULL;
 	}
 
 	if (!ring->sched.ready) {
@@ -282,7 +285,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_emit(ring, f, job, fence_flags);
+	r = amdgpu_fence_emit(ring, f, af, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e1f25218943a4..9ae522baad8e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -157,8 +157,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
 int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence, struct amdgpu_job *job,
-		      unsigned flags);
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
+		      struct amdgpu_fence *af, unsigned int flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
 bool amdgpu_fence_process(struct amdgpu_ring *ring);
-- 
2.49.0

