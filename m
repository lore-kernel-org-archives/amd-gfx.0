Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F70C678DA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704B010E95E;
	Fri,  6 Jun 2025 06:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CibQU/PG";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECE610E910
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFOqfsBmTE8xtxoJAX32vLOgCPVGOzW6V5T3EGr5Ilcp+I7e8fXPisT877TsFuBWQlUltqDcFRnmF+TjaPYOfHREuBb50viyDz+De2A6ZbHrWrTMr3DDgMWjmVINBiDU/IYykycOAJvX47QsitD++y2fXfEBX5th/lfBaLM7poKJQX/fRxjyB99Ff6K2fyv5Y21UIkvtX52xL3h455iC1tOJRvD2cKgBwdYwJoFUtsvgwYqlcfv3Zocv9N+FmhzId1vVTrMLB0ftI+nBLlWl7f2lOFga5RmL5XiH+glA3Vy4E6xVob2ZQ4HR8iDKTHDlUHqYeaeieJtMlEw7BZenGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=265UzIzMyNJrKLOip2L9ccxYPWM9w2ibJMy+2QGs3Tw=;
 b=EWKQAnL88bUUB6w3CkzhviUt0S/UjmH6D9eTjgx3fsz20djQ8CIvRgiim2r9dpce0SQCH1Cum7+QhGSZOebUul6pL9VxdGZ0fPijY9Uq6buMUNC3bd4PjGJx4DN+HM/z0gpiJ0bBEHk+kMPlpX26vJU+CFWCLu4JCzvxOkrlYVtgQwPUvhx/BCBJ59co0/LtnpCBGRTi0fByk9aj4eg1yl69OazcQgPrV7oYzHMM1h/8NAoc399osDL5Lf6us2MlksZlPeayBTAkVhqJcWmgub3ZUV5bpDS91RJaBeQgnIJ5L5AzRkl88i8qR9SWVHaKlvPIQGkLgZd/AsoV8gegGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=265UzIzMyNJrKLOip2L9ccxYPWM9w2ibJMy+2QGs3Tw=;
 b=CibQU/PGb7rl8cOnUa08TeUfoLFFFD9b+weXBso3H/VPw50TgwALIytp07NSiC7yONs3nH1TCidZzSdEpxaXjPKZ+NN2Sah/7PelBc09/qgGgS1mV6h6ZjCuFF9MQjybQPjYKy9TM5FgkHNswOBM15uTsQot2Xth46D1jTiWHrY=
Received: from SJ0PR05CA0121.namprd05.prod.outlook.com (2603:10b6:a03:33d::6)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:18 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::b3) by SJ0PR05CA0121.outlook.office365.com
 (2603:10b6:a03:33d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Fri,
 6 Jun 2025 06:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/29] drm/amdgpu: move guilty handling into ring resets
Date: Fri, 6 Jun 2025 02:43:34 -0400
Message-ID: <20250606064354.5858-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|LV8PR12MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: a965c86a-066b-40d4-337b-08dda4c58f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RIlULwug1aT+/rN1jmjhI0Ngz1f45IPFVVVVTb1vfXGUwNHHg5i91SSKvaWs?=
 =?us-ascii?Q?T0nIhaFM/gSvAQx7WLib5pf6mY7Yf/tt4p1SxOLCATYnSRQGU95WsKOjyYY+?=
 =?us-ascii?Q?12yZuBZu1V0VQa11mpaKtYe/3k6ZIgjwfcQz5o4UgF3FsHeEA1Z+Lsrq39Ko?=
 =?us-ascii?Q?c5mC3WXJR7JsTpHfulOEvEczJ+niGCASOqbyXQzBLl4N+tE2aMGFN51msWDv?=
 =?us-ascii?Q?rkdzz7GK5hF4xFkoVwzYoW36ihgHBu8WrV1YbWAbCp7cZP2OxQ6FYWQoqfjK?=
 =?us-ascii?Q?U6syDsdX3Qj77fFHDDOdbwcRIJoZF8i2GG+XQzx8y6wgtwajSO1vF1KtSi/u?=
 =?us-ascii?Q?mxF/GvXVkf98+Gcf11ZvzuUwz9no3wlbZeDBAI47lhIk4fdiMdOCLcw8OgC2?=
 =?us-ascii?Q?5v3fnzNwoXYDWmnrMADFETJXLXnE7ewRCaxHbPxjXuSF7v11+WvnABQcNIC5?=
 =?us-ascii?Q?nezZtQncGwx9uRLzo97CkkpTvRIEhkScNegzqe6aC1eDc3Nz1BqylDQhxc93?=
 =?us-ascii?Q?a7egQl7/GIaz+V481CSRQKhClNg/JpgJKKdcuPQyegHPt/+u9yuYUczlGVxg?=
 =?us-ascii?Q?A+oFpZ5YXZv6Gh8YrGib1iREMvqLbAUJCgsRjd+RCFIjAmwX1GcCnx26gZip?=
 =?us-ascii?Q?Rk1a5jlLxT+xtWVZcYKqwq033tOflDXm76/ZySzNUyW4NGOxLd4QIBGw6+Wj?=
 =?us-ascii?Q?ibSJ8IfHFKxUpCMspCOoES0Vpt1kYid4SmxNS+J2o0F8yZ6UfglhXyFumn+f?=
 =?us-ascii?Q?tqOjveR/tttIL0mTrOHIAqqB0VcLNYGyy3/NR8lcH5M6QCSAvx7+jZaQL6u6?=
 =?us-ascii?Q?QTv75iHR7xf53qXce0WG566seaK0Z1IwSjdPcKraCOaSf8NfEO8mxazWUl6w?=
 =?us-ascii?Q?wp9bhzvU8z0zV/bEushAfYqsG2AcT62fJU0BRQo0yRlVGBYvg9w+e+2PJ/FM?=
 =?us-ascii?Q?oLRDwwxJbFm4RN/wdHI/lokipbN7ipxXKfil/e8uAHraI74i2w07uYqKhWEG?=
 =?us-ascii?Q?T9Lkn5dJaLShm7RExmuB8ylLQfx7UqNqdQr11U0DaaYSbOc2AB+GfAysieHw?=
 =?us-ascii?Q?VZLZfNkZEgf4UCXpVzUKSWniJf86GmQ+bZRgSlBefePKlgcNLNKwlHpDNBoA?=
 =?us-ascii?Q?GH2UsM0mSxcfte2f/lCa7+h9KBvquvMX1cmtBOl5YTCZf5Mh62mtLlJ0sPre?=
 =?us-ascii?Q?HfdcVg84LNvoy1uNr13y4XiDtzsw8tkh0uhbBKgH5YOyBq3S5jFOtlFh8/YR?=
 =?us-ascii?Q?GP9HN7VcIf6xR0Rw7p6vRS8nCpm4VgyQexzkiNiZNWFIcKYYDG43w4VC7y3T?=
 =?us-ascii?Q?kOE0Sy8W4NdPtvwnewRrDJn15d0aGWb442J5NxfFbYbUIAaNJw3Dt8nem3dc?=
 =?us-ascii?Q?hGI41Nb8Fj83i2ml22THjWwPIIXNWJykNRiDHHAGGzd7yxNdhWzAUr/AfYkF?=
 =?us-ascii?Q?MffEcdzluFxwOvZdq5AnuzYe32Z1F0hICW/z8WbCyhrX2TvtNmwigSFuT/jB?=
 =?us-ascii?Q?xRUfKp5jSBTyGg0mEsBlv4C2fOG1L0Sjmgok?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:17.1003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a965c86a-066b-40d4-337b-08dda4c58f11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713
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

Move guilty logic into the ring reset callbacks.  This
allows each ring reset callback to better handle fence
errors and force completions in line with the reset
behavior for each IP.  It also allows us to remove
the ring guilty callback since that logic now lives
in the reset callback.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 22 +---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 56 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 25 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 27 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +
 22 files changed, 116 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 461bd551546de..308d3889e46ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,7 +91,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
-	bool set_error = false;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -134,8 +133,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
-		bool is_guilty;
-
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
 
@@ -145,24 +142,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
-		/* for engine resets, we need to reset the engine,
-		 * but individual queues may be unaffected.
-		 * check here to make sure the accounting is correct.
-		 */
-		if (ring->funcs->is_guilty)
-			is_guilty = ring->funcs->is_guilty(ring);
-		else
-			is_guilty = true;
-
-		if (is_guilty) {
-			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
-			set_error = true;
-		}
-
 		r = amdgpu_ring_reset(ring, job);
 		if (!r) {
-			if (is_guilty)
-				atomic_inc(&ring->adev->gpu_reset_counter);
 			drm_sched_wqueue_start(&ring->sched);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
@@ -173,8 +154,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 
-	if (!set_error)
-		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		struct amdgpu_reset_context reset_context;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ab5402d7ce9c8..2b3843f5218c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -270,7 +270,6 @@ struct amdgpu_ring_funcs {
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 	int (*reset)(struct amdgpu_ring *ring, struct amdgpu_job *job);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
-	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7a82c60d923ed..b57a21c0874c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9579,7 +9579,9 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
@@ -9655,7 +9657,9 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 9ad4f6971f8bf..02022c7b4de78 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6839,7 +6839,9 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
@@ -7004,7 +7006,9 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3c628e3de5000..a4e3ce81bc671 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5339,7 +5339,9 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
@@ -5457,7 +5459,9 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e64b02bb04e26..f699c8b0f7488 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7226,7 +7226,9 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 0c2e80f73ba49..d9eea11f52fec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3623,7 +3623,9 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index cd7c45a77120f..f2058f263cc05 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -774,7 +774,9 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index d936f0063039c..5eb86291ccdd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -653,7 +653,9 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 9e1ae935c6663..ff826611b600e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -565,7 +565,9 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index da27eac1115ee..179dd420edb15 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -733,7 +733,9 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index f1a6fe7f7b3af..c956f424fbbf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1156,7 +1156,9 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 3d2b9d38c306a..ef9289f78a46a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -847,7 +847,9 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 73328e213c247..fce8cc3ef066c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1648,44 +1648,30 @@ static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t i
 	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
 }
 
-static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t instance_id = ring->me;
-
-	return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
-}
-
-static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t instance_id = ring->me;
-
-	if (!adev->sdma.has_page_queue)
-		return false;
-
-	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
-}
-
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool is_guilty = ring->funcs->is_guilty(ring);
 	u32 id = GET_INST(SDMA0, ring->me);
+	bool is_guilty;
 	int r;
 
 	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	is_guilty = sdma_v4_4_2_is_queue_selected(adev, id,
+						  &adev->sdma.instance[id].page == ring);
+
 	amdgpu_amdkfd_suspend(adev, false);
 	r = amdgpu_sdma_reset_engine(adev, id);
 	amdgpu_amdkfd_resume(adev, false);
 	if (r)
 		return r;
 
-	if (is_guilty)
-		amdgpu_fence_driver_force_completion(ring);
+	if (is_guilty) {
+		dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
+		atomic_inc(&ring->adev->gpu_reset_counter);
+	}
 
 	return 0;
 }
@@ -1731,8 +1717,8 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_mask;
-	int i;
+	u32 inst_mask, tmp_mask;
+	int i, r;
 
 	inst_mask = 1 << ring->me;
 	udelay(50);
@@ -1749,7 +1735,25 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 		return -ETIMEDOUT;
 	}
 
-	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, true);
+	if (r) {
+		return r;
+	}
+
+	tmp_mask = inst_mask;
+	for_each_inst(i, tmp_mask) {
+		ring = &adev->sdma.instance[i].ring;
+
+		amdgpu_fence_driver_force_completion(ring);
+
+		if (adev->sdma.has_page_queue) {
+			struct amdgpu_ring *page = &adev->sdma.instance[i].page;
+
+			amdgpu_fence_driver_force_completion(page);
+		}
+	}
+
+	return r;
 }
 
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
@@ -2146,7 +2150,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
-	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2179,7 +2182,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
-	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 8d1c43ed39994..4582a11b411dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1538,17 +1538,35 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static bool sdma_v5_0_is_queue_selected(struct amdgpu_device *adev,
+					uint32_t instance_id)
+{
+	u32 context_status = RREG32(sdma_v5_0_get_reg_offset(adev, instance_id,
+							     mmSDMA0_GFX_CONTEXT_STATUS));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA0_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	bool is_guilty = sdma_v5_0_is_queue_selected(adev, inst_id);
 	int r;
 
+	amdgpu_amdkfd_suspend(adev, false);
 	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	amdgpu_amdkfd_resume(adev, false);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	if (is_guilty) {
+		dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
+		atomic_inc(&ring->adev->gpu_reset_counter);
+	}
+
 	return 0;
 }
 
@@ -1616,7 +1634,10 @@ static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
 
 	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	return r;
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f700ac64fb616..711064ea22d5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1451,17 +1451,35 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+static bool sdma_v5_2_is_queue_selected(struct amdgpu_device *adev,
+					uint32_t instance_id)
+{
+	u32 context_status = RREG32(sdma_v5_2_get_reg_offset(adev, instance_id,
+							     mmSDMA0_GFX_CONTEXT_STATUS));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA0_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
 static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	bool is_guilty = sdma_v5_2_is_queue_selected(adev, inst_id);
 	int r;
 
+	amdgpu_amdkfd_suspend(adev, false);
 	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	amdgpu_amdkfd_resume(adev, false);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	if (is_guilty) {
+		dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
+		atomic_inc(&ring->adev->gpu_reset_counter);
+	}
+
 	return 0;
 }
 
@@ -1528,11 +1546,12 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
 	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
 	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
-
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
-
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	return r;
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 25c01acac2cd9..abb5ad697fbb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1563,7 +1563,9 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 97ea5392ab85d..76ae1a7849a56 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -828,7 +828,9 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index f3ff3c6c155fd..d68bd82f8eab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1983,7 +1983,9 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e15057333a459..a9d8ae4ab109a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1624,7 +1624,9 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 9fd3127dc8828..93bc55756dcd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1481,7 +1481,9 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c5afe2a7f9f5d..d74c1862ac860 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1208,7 +1208,9 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
+	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
 	amdgpu_fence_driver_force_completion(ring);
+	atomic_inc(&ring->adev->gpu_reset_counter);
 	return 0;
 }
 
-- 
2.49.0

