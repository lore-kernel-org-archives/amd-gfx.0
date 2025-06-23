Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB53BC7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503DF10E410;
	Mon, 23 Jun 2025 16:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OkvZwKQ4";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0054110E410
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmc5p7P9djo8OZww20DNmCh9NZGeWf+CkQF58khMZolnFQJFPamUGzjsyVq/0mdQ9C/sXOGRJkePcgKAJqMnN4aQqKpkbu+6WpymFNJshgP4nH0U+esO3K5MDGxgIOp6WgKnbjQYxyKfitmQquk3fJ1cFb1V2aEA+1r6PZ1iBS8HrTI++tZuiWz4Zrf/p+ZCxLKXca0YTv1OMAJ/MWh60VZm5UZRIJ6S1ZPlNxRDNeTotY6EC5jo4uG+qStkKM78UX3VdDYZV7pShPz9mJUZMozvS6S+RLX+VlccN8mNjwmKH39MEaLw6FD0xYw4+fm+p+F3Pn4Jc47zX8RwgaYBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXQUYL7swdXAMOMR9YG7M1g2uDb3/Duf1vfYEsvPZjQ=;
 b=kQxWacrbdJ40ej4bPV+ytEMCeLQJ+buF34+CoBPXxEB1e4eZq6pbLdnK7Vx0l7PuZDjoLX/qTxDOlgdRfDhIJ+HCLvd5f2VuZno2r7Dg55INfExQD62Y4Nu48Ha66H/4JJ+YUggXGbK0HG85lrynCFM7g8aTUXUhQfpeLKrd6Cqv6+AY+eUeHsPMJ2Q/E7ox1YLwjO0LpumRGRuKQDPKA8V+OZ0C7g3mPTf/07LDMAJB3pHXFX8Y5YznX5gR7hqPO9RAyEg0NoEghfTzVCxpaLxJUpzjOXsDxC0Oy7dYg/RWiZNQ00dAI1RERVKrvyy7dBhe+p/a2Acwo5xkMkPSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXQUYL7swdXAMOMR9YG7M1g2uDb3/Duf1vfYEsvPZjQ=;
 b=OkvZwKQ48vtDOXOcE16lpykrKWQounF1vShmQ9FkfU4dfIP9dPRBAG4MJovbax9LYBrVgfjIdilTi5YQ0InJMwUEronYICQ3xox5OXNr7Gkda+IJlj134v3QCAgz6U7SMykoN0MwH5q/diZP49oQ6Sxsp6NR0bgSJR5syZNQSJM=
Received: from BL1PR13CA0223.namprd13.prod.outlook.com (2603:10b6:208:2bf::18)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 16:14:54 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::9f) by BL1PR13CA0223.outlook.office365.com
 (2603:10b6:208:2bf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Mon,
 23 Jun 2025 16:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:14:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/31] drm/amdgpu: remove job parameter from
 amdgpu_fence_emit()
Date: Mon, 23 Jun 2025 12:14:07 -0400
Message-ID: <20250623161438.124020-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: f589ac71-8082-4d5a-4e64-08ddb2711727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kE9qt76iY3kb+h7HaNagvn17NC2lrqwAnXGwKtlzY4REPoH+Sy6Qgufe1OP5?=
 =?us-ascii?Q?TSd1sShICNgi4dcAEd3Zi+vNOD/di9XwDRw1EQuKP0jTWnyfz1LVxsskQQbQ?=
 =?us-ascii?Q?d4KVB2+oTS6H0mTdGN6jstEU5PdX/0cYaQVGMYxbWSyEEjXbaNFLd3HO8Am/?=
 =?us-ascii?Q?sQD+EPRo8cK8pe0SWhhI7ZkDkrfZGRk6PPb5iPE0rI0MJsa2aj5FbAl+Z0Tv?=
 =?us-ascii?Q?Cq7ej9q8DsT6C2ImPZD8z2RV2o8N5Zr31+5V7tJ3bMM98A2c0CblHfeSxleo?=
 =?us-ascii?Q?3LpCjIj3YVPboRehBA863G9nLDLPWGiDJ6NrbzdYFcyNnPCWhmZBhPi+Kzbq?=
 =?us-ascii?Q?h67N63D07uf+JXOFEH/6FMHkRU6HUKhSbF75iX+om//4eHq/ejh9f8u1qxRR?=
 =?us-ascii?Q?DsRF0bXCsFAYJF7ZoQGkxtraFsmaHbL+O9tFMa8BmeQ+E8+uNcyDQ9j7eXX9?=
 =?us-ascii?Q?HdxU5TtW1Lsp672Sn1HzSvuLEexb4keQqcbc2JvVhILMCN883MZ2RjmkeYWR?=
 =?us-ascii?Q?t92LlYhMda6/o6zJ7K4a235EvDgUHGze5TryV6VSNKRNUCRxx/WycTXKCWhT?=
 =?us-ascii?Q?InmhRSOlSOdY3NOpq5g0mBOMCUFoYuKuyxJafdlYsv0ssq/VPwpxW5Fy3neD?=
 =?us-ascii?Q?DN9XepKaB4klP8M4R/MG2Yb8w37Tkqgjn8dSfd3rRSbwFZqozvweLWTqd9gt?=
 =?us-ascii?Q?E5ag5Rhf1c0Db3Q0WRZJw96NltnESksnPNMtEtgmacIyCZOyAo80YbkQolf6?=
 =?us-ascii?Q?yNTTxDH0YRJ9YFNX4zr9kDrDQELDNzoZIuVhHCODbOyY1O2aLRd1BnuiLPio?=
 =?us-ascii?Q?rQo45MYKNPpljuZ+qyOJHD2x1LGOc61+eOgoHYJLQ51rnN2vOOSDR6Z/TykV?=
 =?us-ascii?Q?F545DcLGWQQaOmMxG9zK2Ad7hXmJxHPZSUXnXFswuDfBxOoiQcVb1JYlF6VZ?=
 =?us-ascii?Q?+v0F3Rnx5IIa+Um2T1Uz+slwfgIvjNXVFt2ayxC1xmcxKLEWUM41V48fkZ/l?=
 =?us-ascii?Q?BrB1aiYlScNByPDMwIVWWjJwtQZvGRY9S8siyAYFkCVoj43F+m6OuDnOpfrK?=
 =?us-ascii?Q?Gqf6Nviz7N22nq8Je91Q/vRA3dgHdM+ezPg8KyewdslR5r49C1+bElPakQMb?=
 =?us-ascii?Q?vB8a13NanZ1xjtVeml/SC5ievpNq8rg1qvZS3d975UaM0xsvypuvpQuZ9J6L?=
 =?us-ascii?Q?rm8nZzfP/RdeZXttslBn82G/6e3rv8X+2AoRJ2OytD+p5CcM1PmJzwTDeVQ2?=
 =?us-ascii?Q?K+6VgcnZQu066a2m+582rfjh8zmGEj4/wDKo3BZ6p5Pj0USR+Uo3uPZCeX5N?=
 =?us-ascii?Q?tXujzqOhglMbEfouCQT4IiZMxHJeiE8Z7XehKu/ExIxfSGk3tJHAwxo4IwHd?=
 =?us-ascii?Q?nmJaYgUedcrHcL52GDGk6B5Qa+hbIk1dchngntaZ7BBBjCEtZYg9jumZl/uP?=
 =?us-ascii?Q?NkbjaR2wzPaT0D/CuPIncsm4NLGj6/ND0FlNOp5F160Cpqp7XI6hmfsGgy86?=
 =?us-ascii?Q?g320KzrDEg3tn/Ki2WJAPdtRikzfdDdnAKAt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:14:54.5552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f589ac71-8082-4d5a-4e64-08ddb2711727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 34 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  5 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  4 +--
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 59ac6afa4db21..28e2d63bea47e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -99,14 +99,14 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
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
@@ -115,36 +115,28 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 	uint32_t seq;
 	int r;
 
-	if (job == NULL) {
+	if (!af) {
 		/* create a separate hw fence */
 		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
 		if (!am_fence)
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

