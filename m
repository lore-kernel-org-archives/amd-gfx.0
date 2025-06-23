Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23246C7EE39
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5372C10E415;
	Mon, 23 Jun 2025 16:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PB9VtuYA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C27E10E408
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAGiTSDyXy1yOgn7Ea5pRUX5rznVhz+FvjTyaYemq187v2zLw3vdZPrIvt0T0sOY+msAZnFqbGOWtvehxDjC49PpVSVXf+XRalll3GyO0VImP1UMChsOSJm9lwInsCNZQWOd9dijomepcL3ZV8LFUx2575HEIxjpwCR5ExS0V6I2tTCVhTcmFeCAtAV6NVcwIgTok0nPuV7UNhaZxusYli+vOsYddqKIeLug9DJ0izHQ2MsMqnG9i+mwr/1cA+KQLnPVNvwNPph9xKUk5g4dlbcwyUgQ/C2HnQ/WZfj6SttGdSKa8Eq8FjlYd48OrreBWS8Vy0NWXnd/kqELdgoNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyqB4eUbNOA/pYp4g+0l1eGAqH49pUxGq0Y3Jahgavw=;
 b=g/+Y9ku+9b8ShCb0FfpbaxYVjbL9ZDmowLHkIv9uGIi9DYp9Bp1KboSfj8QUpvHypl+UVH5RLzOsC4sTLeoHEddVk385rMCW9YFKhrVnMqQE8qbPJwovAUXy6zZlHYPcg6FxLlSliPXtn7i+DgC7vwwRq6EZTZ5C3xy+we+3HDU6B4toquvnf0BjLnagrZnW9DslnLtI9Fuh0YK62lhi2tsMGBAFbWkmm+jVbomzBRO8ER3U+j0dYvFAzS381e7i+Y9CWasGYT897TfARLP0QGXlpW8WK+vbhRsmiSJPh+tcCJwGhti4IEK+JbDLZ4hMXVAuoL2THZJBSOtahoTodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyqB4eUbNOA/pYp4g+0l1eGAqH49pUxGq0Y3Jahgavw=;
 b=PB9VtuYAYhagP3MNPA5J4Ts4sVDtXS3EFX04nKv9MPqa0URdv/P16/gauL9lcWQBiqBsd7zcFvkLWdRPX3es5gkGxALAjY0QmrzJJJCU0zCEw3HYb+iaYqfpcNHMV4BLQSKihxAQtW695d1sOrnDGyY+HGzFQZYytEVvu1Nug2c=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 16:15:00 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::b4) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 16:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:14:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/31] drm/amdgpu: rework queue reset scheduler interaction
Date: Mon, 23 Jun 2025 12:14:10 -0400
Message-ID: <20250623161438.124020-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 7648ac94-ff63-46ab-095a-08ddb2711976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c25vVnBCRFVzZG40YWFsM0hZV3dDSDRlRkh6UE5xNGlReTlxbWRtVmp0ZHpJ?=
 =?utf-8?B?bWpDMFVTeHJWOUZiS3FTc2F5ZG9GTGNKUlROT3ZmNTlzT2dZOGhyNEJGbXh5?=
 =?utf-8?B?Qk1IRllxdExnbG9SOTJjOXdCUlJtZU5tQVAwVU10cWtqMmpRODJBVm5vSkdS?=
 =?utf-8?B?bXd3WTY4RFdmR2c1aC91aEVPOHgvNVp0cEVxSUU5Z3hTVWVWVzlNVWdPYnNX?=
 =?utf-8?B?dnNIQklkZkFEbzZaQ0xZazJTRmhqR2E4bEVrU09jNzZ2dERmN0VHc1p2c0w1?=
 =?utf-8?B?NjZXcnV3WjZjTjhhbkloeVhQUFR3UjdtMHZtWUsyZ3lqRll1QytUWUNkZUly?=
 =?utf-8?B?emxTeHN5ekpFRjhSd0sxSjR0R1h4OUNBdzFLeFJxMTRIV2k5cEp3OHJzWXJG?=
 =?utf-8?B?Sit2bDlSMHBQS1JoY212MGdjS3dsakVZcTNYMUxadUQ1SUk1Yk02cDFmaUFL?=
 =?utf-8?B?Rk5zZERFWUl5aVNSUWN1UXkrWGJuSGora2U2dWY1SGRzbm1HMXV3azlYRks3?=
 =?utf-8?B?QWdvUndxMWhGakZUR1VIQVg4cmRlSFFVcFZIZExmOEtBZWNEZHdkT0ZwdTNR?=
 =?utf-8?B?RGFoa0NoVWRPTDZkVG9MSmR5a0tQVFF3bWVUam5HM3hPd0RkajFqZWVCN2th?=
 =?utf-8?B?SldLaHRWM1RLaHZzTlNhTVJrZjlyekwvWTJIc250Z2JoM2RWY09zeDI3RC9C?=
 =?utf-8?B?aWJjai9VUm5KdDVTcTJqdXhNTWd5RElqNHBnTkZ6NlN3ME8xVzFQMjlWZklz?=
 =?utf-8?B?U1lZdmhOeGFZblBhenAxK0FBdG05ektKODR5SVJXbllWbEpBSWpXZ2loc2F3?=
 =?utf-8?B?QkQ2OVlId1JWSUpaMC8rK1YxM1gzaENoY2xmZGwzS3JWL1ZRb3NlNmtydldt?=
 =?utf-8?B?SW5SY0dsREhzcDJ0c0F2YndkRklFbFNFYTNOWFVqZmNzSXp3SkIyaDAxbmVZ?=
 =?utf-8?B?eDNHRkROeDQvN0ZGQW90VTRheHJUZnk1VkVwY09RSjVHbDFIVkZhMEZkNFZZ?=
 =?utf-8?B?Wm9WUFFKRUVpS1dxNXdKZEd3ekpiSE5yNzJCbEo5R2pqbWxBY25FNFRlVDBN?=
 =?utf-8?B?YjVwTktYT1pBWUVtaWoxWWVURHMxTmhVeU9mSGZDTjdZSHZFV2xFdnFobEJv?=
 =?utf-8?B?aFZYMlJhNEtrTTVERjdhbmIrc3NnV2ZRcDR4djlwK3l5TDRaSXZmaVNBNGcw?=
 =?utf-8?B?UWc4eFlUa1dBSVU3UmMzRHdKZmNhQXlQOFN1VGxxUk1RQzRYSEVaUnVyRURZ?=
 =?utf-8?B?WS93aTUrcUdOQmFEOHRFa2xQTWRsT29OanVPUlN5WG52ZlYrNW9Vek9LSzdE?=
 =?utf-8?B?NEVTNW9NWFVMT3oyNlJlRXZ1ZWhIWmF5ZzdRTEpxZTVRcWJLaE5yQkRkc2Mr?=
 =?utf-8?B?VkVJOHhidzI4S05tL2hURUFNMW1yOUt1cW9xMURKd1dFWjRiSDFXT2xuQjRX?=
 =?utf-8?B?WjMzZHcwNWtUQUpNdHdZemdxQThVZVQ1SnJWejNaV2tSNDdWVDdvS3BiaWJO?=
 =?utf-8?B?eDBxai9EOVZrR3lpaXdzNHlTRHhJMHprK0hkQ2thVytYSzNRYUxpMUs1QzRu?=
 =?utf-8?B?dW1UWXMwanEwSWdMWEpqVnF4RUIzU0orNGpuVEd6R0lXUUkxZlVWWG5CR0tQ?=
 =?utf-8?B?dkJkM0RxVWdIeE9DRlVxUFJTWGlHRzdNVXNNT1c1RzhiZHNkNERnOGVLYnY2?=
 =?utf-8?B?b3J2NHFjZTdpMzAxeENpVUhheGx2U3J4azg3MDFKL2FCQVc1N05UMTkveEJU?=
 =?utf-8?B?Rm9QRmVZSWRkb3huS3JvTWwwZ0FjbjNielJLeW1RRWdsaDkxejBINzFvcWZ4?=
 =?utf-8?B?TEJPTE9nRk9zZlVBeldsRzZlNFB4VzgwdGZQTllUR1BrOEcvdThOZVlDbVJZ?=
 =?utf-8?B?dnc0V0NsRjRoV3R4N1hMeUVIdEY3bEc4MXQ2dnVKaUNPRVpOclZ5NUgwM0NF?=
 =?utf-8?B?dXArOUdzTUNJcGR1VjhIL0NCK21vNkFyODVVNXB3NjB1VHhVcndrVllhWk1Y?=
 =?utf-8?B?TEhQSGxwdEFYK1dub25jSlViZHQyQVlQOEVERmVveEw2WDNuRGVXaGRUN3VI?=
 =?utf-8?Q?57QGiL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:14:58.4283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7648ac94-ff63-46ab-095a-08ddb2711976
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Stopping the scheduler for queue reset is generally a good idea because
it prevents any worker from touching the ring buffer.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 35 ++++++++++++++-----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index a7ff1fa4c778e..93413be59e08f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,8 +91,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
-	int idx;
-	int r;
+	bool set_error = false;
+	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
 		dev_info(adev->dev, "%s - device unplugged skipping recovery on scheduler:%s",
@@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		bool is_guilty;
 
-		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
-		/* stop the scheduler, but don't mess with the
-		 * bad job yet because if ring reset fails
-		 * we'll fall back to full GPU reset.
+		dev_err(adev->dev, "Starting %s ring reset\n",
+			s_job->sched->name);
+
+		/*
+		 * Stop the scheduler to prevent anybody else from touching the
+		 * ring buffer.
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
@@ -152,26 +154,29 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		else
 			is_guilty = true;
 
-		if (is_guilty)
+		if (is_guilty) {
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+			set_error = true;
+		}
 
 		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_stop(&ring->sched, s_job);
 			if (is_guilty) {
 				atomic_inc(&ring->adev->gpu_reset_counter);
 				amdgpu_fence_driver_force_completion(ring);
 			}
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_start(&ring->sched, 0);
-			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+			drm_sched_wqueue_start(&ring->sched);
+			dev_err(adev->dev, "Ring %s reset succeeded\n",
+				ring->sched.name);
+			drm_dev_wedged_event(adev_to_drm(adev),
+					     DRM_WEDGE_RECOVERY_NONE);
 			goto exit;
 		}
-		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
+		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
-	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+
+	if (!set_error)
+		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		struct amdgpu_reset_context reset_context;
-- 
2.49.0

