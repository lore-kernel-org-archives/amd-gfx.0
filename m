Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FB9CD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 08:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E4210E6A2;
	Wed,  4 Sep 2024 08:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ci/JWuu/";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF88810E6A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 08:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXGegin3waO3KpE4dG2XIKW3zUIA1KycMp6YZpOizL2PitD/QbtU3bzexpo9YmYeX8J3ICT9UzdiBypoV9+FQPaVzBw2i4tHhQDMCkXzndRVh0Pl0Afk4YAyGgV9goEud4+tsRlixSe9IkohrT3T1zf66H/vW+46gCfZWmQ73xxlHv7pqNJZEiyfhiI8zW8PZVm03fm728Uqu2znK3k8EBGDFHuHO2kevUamOEqv/3JwPXXmOfGI+kLrwMVLWsASm8ZJZJoODV70FYwUtPa+KAIKRo8QjeQBg94ZXOrcs9M2Hszs6vf3pS7CMH28KQd/5Fr6ashtUH8tZt0ux9NE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXHkUzQX8M+MG+uvMvBH1s/RUAx72iagMVBuiEC/EkI=;
 b=KCAzyGB7g6gi0BNW3YrPFR4squfTMEoqmDHJbi/XdYBOcI5oEgs6uyNXzTAFwVtUcTofay4ZVi4yuJCFWEZm3mY2Qj076ZJCKUVPEEGlGse0q27c8QWjk1ZRc/0QHyvyqxhFofvjd/wys4Jodqfs9CFRQgucJOfQZyHo/FckFZAXkJIqoGWpbw4byjvywm2tVYIIrRh2yZpc/zqzVz8sYTFc63VtcqFbKKxVYZIMG//mjcB/hgjBg7tv40HSg5J4Lgp1YiIV2264tiKqxx9dtgYoKZFc6G/1I4MMlJOWm3Z5vF1PFSSYtKyqtJ7yWHmcaUT4pPlTVWBqV0fjvZNy+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXHkUzQX8M+MG+uvMvBH1s/RUAx72iagMVBuiEC/EkI=;
 b=ci/JWuu/mFqhGt52VBwaDH+LmgFxrhfb228EgVpIlrJd1BHxxKYKjyuLZvfXE+Fmk1J6tUBaSMjDQ5jmf2pT6ihzH2lNbZT3jaXEAy9rUXDIY1LjM1+mqh7hKjXqU9Oc3dRhsow+NZwdtukTik9G4HCfjdMk2lOB/+ukpCRaA0s=
Received: from MW4PR04CA0379.namprd04.prod.outlook.com (2603:10b6:303:81::24)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 08:39:22 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:303:81:cafe::17) by MW4PR04CA0379.outlook.office365.com
 (2603:10b6:303:81::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 08:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 08:39:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 03:39:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Replace 'amdgpu_job_submit_direct' with
 'drm_sched_entity' in cleaner shader
Date: Wed, 4 Sep 2024 14:08:47 +0530
Message-ID: <20240904083847.1768731-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b68cc6c-ab19-4099-f68b-08dcccbd1328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3Y3K0tpZnRJMzJkMUpTcWJIb0xHakZZNFhIN0FXRkdJemYxYTdFOElOZS9w?=
 =?utf-8?B?M2FPV0MvY01vWVphaTJwREZqK2hYNnIxYVN0MXhZOVhvVlRNT1BRZVJzWWpQ?=
 =?utf-8?B?VlBUMm44M25Ndnozc091R1dTOEo1aGlDODNKL0VBYkRXZ1lVZnRydmpEcEla?=
 =?utf-8?B?OENMTTh5d3Q2VW1JT0paOFBJR2MvRi9VLzNsdklYUTZmeEVxdXlDNFZZMTJm?=
 =?utf-8?B?NmQwWmFqbnRqR3JtUnM1OUhFb0Vpa1pScENhb29GUjMzUUtBUzFxVFZQOVY3?=
 =?utf-8?B?TlRRSkJNWEJmTDlUWm0ram9xSXBTaVdxcXNzemFLRlYrbHlaQkRSc2hiQUw0?=
 =?utf-8?B?cERPTTVHazhodjdqNkl6UUpwTktKbUJiSUozNXdUcmJQVWlNY1BQUFpCUmE3?=
 =?utf-8?B?cis4TXBaUEZMN1RaaUxLcjdSbTBSbXNHMWVYZnFPekJURGpZNm5OM1oveWl4?=
 =?utf-8?B?THFjS1VNbW9RYXdmTHd3SXNERm1sMVVobktKRll0VHFtL0JlS09DcjBDVFJN?=
 =?utf-8?B?WjNVdi9yRktGcVVYem5DZk5mbU1vTjNFR0RNWWcrOWZlODduOXFuUzJCZUpB?=
 =?utf-8?B?SU9xYllDUllBVTgyMEpRcGVnaGlqN213bzJMQjh4L2YwaGlpbTNUemNJS2dN?=
 =?utf-8?B?K3hOMkg5NnFSQ3Y4RWgra3VQbGJpSmZMV0Z5REpyTUpoZTJuemM3MFVQRWVM?=
 =?utf-8?B?ME8rVm05ODhrN2ZRazdCNWJFTjBpSGtWanNDNTArUzdIaGhtNlJRQ2F2VlM4?=
 =?utf-8?B?Z2toUXFOTWpsM0dRNW9CRS92Vll1ZXJoQVFhYXBHYkZ3aS9nWHpPVXhUNmR3?=
 =?utf-8?B?ZFd4STV3eDFsWXhjbnA4UzZ0cGREc0xRcnpmZUZPTDFqNEFMcWRMdTkyT0tP?=
 =?utf-8?B?d2dQQWc1WW9nd2xZNzFWNURQeXVpMmZoRmY5WnQ4bmhmNWN4bUg2ZDcyNGUw?=
 =?utf-8?B?NktMaUdBdWt4a0xxSHZwY2dVOWNIM3p0ZG91bFNRRFZZZG1HeFFIM2EvaWhJ?=
 =?utf-8?B?UGEvV29hYXVORGJwR28rVnlUS1AzQWZvSnQvYXlybkdrM1E1Mk5FOGRwZ0tj?=
 =?utf-8?B?b1hYUjdWbFFtS3ZRS21udWVmL0tCT0lzRllEZyt1SitJbCsxbVBzRXhjamlZ?=
 =?utf-8?B?U1QwMktqZFFwK01nN2JXMGo2RWVkUEczQTV0R1lYNThhTk9wejRibVlpdFVl?=
 =?utf-8?B?WnAwWWVxRlQzVXIzK0llRFI1TWJMNHFsUWUwQXdnVzB1djR2bm5OSU0wY1BS?=
 =?utf-8?B?S2ZYVyt0OUVrQXNqYmJlZ0pKSi9VL2hydnhITXZzVTJzVmx6Y0hHbWhzOFRO?=
 =?utf-8?B?VldqbDZ2TDBxNXVDTG12bW9mSGV4dHVNbElsbHhhVHIyY3NiTDdvVExNWUpD?=
 =?utf-8?B?UXhwcVE1bng5dnplZU0vSHJKbTh3NkttbmFKRzB6S0tzNWRHcFJqTmI4S3B1?=
 =?utf-8?B?Nm1WOUlvb0Q2c0pUcXJrVlFHQlBhUDkrdXY4Rzd1ald2S2tOeFZ0Z25zajNC?=
 =?utf-8?B?VytPNmJWYWh2MUJSWmhhZ2lFVUZYbzBjc3ZIeXBiN05ZdE8wWDQyZDYxR0VC?=
 =?utf-8?B?eTYwLzhtbkZvcWx5MGlmdjYwMlFiZStORUFhVFhHblRuOXducXBLbEQ1MEx3?=
 =?utf-8?B?aWVzSUVpQzhuKzg5dkZMT1lPbXRCNjZkZnJxekdna25YMGNMek5tdXdJY3Bp?=
 =?utf-8?B?RUI5NGhsa0x4UFJkRFNjSy9oMVByL2JCakU3K1FMalZNb1hTQS9FTnMzRFdm?=
 =?utf-8?B?aGdaQ3g1YXVVZ1dNMWc3Z0dKbEFZbk9yRmNLeGlaNW1MVWVkWGZJL2U0SW5z?=
 =?utf-8?B?YlBXYTZmZVQ3aXZQazF5U25UaDVoMWdVMzZaU1Awa1BSc3R2bVBLbUREQWd3?=
 =?utf-8?B?VisvaWI3cEVSSk93WUVJMVRPaXBub1dudndoUHhFV1U4Y3JQUmZMVXlCQ0xC?=
 =?utf-8?Q?kCPJKhDi+uwCv/jXMFu8hVJC2JPSUtZg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:39:22.0698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b68cc6c-ab19-4099-f68b-08dcccbd1328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
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

This commit replaces the use of amdgpu_job_submit_direct which submits
the job to the ring directly, with drm_sched_entity in the cleaner
shader job submission process. The change allows the GPU scheduler to
manage the cleaner shader job.

- The job is then submitted to the GPU using the
  drm_sched_entity_push_job function, which allows the GPU scheduler to
  manage the job.

This change improves the reliability of the cleaner shader job
submission process by leveraging the capabilities of the GPU scheduler.

Fixes: f70111466165 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
v2: 
  - Dropped default assignment of f. (Christian)
  - Moved drm_sched entity; to stack from amdgpu_gfx structure.
    (Christian)

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 35 ++++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b779d47a546a..83e54697f0ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1397,14 +1397,23 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
 static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	long timeout = msecs_to_jiffies(1000);
-	struct dma_fence *f = NULL;
+	struct drm_gpu_scheduler *sched = &ring->sched;
+	struct drm_sched_entity entity;
+	struct dma_fence *f;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(adev, NULL, NULL,
-				     64, AMDGPU_IB_POOL_DIRECT,
+	/* Initialize the scheduler entity */
+	r = drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
+				  &sched, 1, NULL);
+	if (r) {
+		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
+		goto err;
+	}
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
+				     64, 0,
 				     &job);
 	if (r)
 		goto err;
@@ -1416,24 +1425,18 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 		ib->ptr[i] = ring->funcs->nop;
 	ib->length_dw = ring->funcs->align_mask + 1;
 
-	r = amdgpu_job_submit_direct(job, ring, &f);
-	if (r)
-		goto err_free;
+	f = amdgpu_job_submit(job);
 
-	r = dma_fence_wait_timeout(f, false, timeout);
-	if (r == 0)
-		r = -ETIMEDOUT;
-	else if (r > 0)
-		r = 0;
+	r = dma_fence_wait(f, false);
+	if (r)
+		goto err;
 
-	amdgpu_ib_free(adev, ib, f);
 	dma_fence_put(f);
 
+	/* Clean up the scheduler entity */
+	drm_sched_entity_destroy(&entity);
 	return 0;
 
-err_free:
-	amdgpu_job_free(job);
-	amdgpu_ib_free(adev, ib, f);
 err:
 	return r;
 }
-- 
2.34.1

