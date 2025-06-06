Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC919C5B555
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6058310EA02;
	Fri,  6 Jun 2025 06:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WYchqT5Y";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E2910E9D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDI01wM5eQyobYVDsHaB+5u0wGDPOINP3eKAV7iSCZMxZnkj8/POwuogRCCf3LkjTJW5gF47hmQSvqvpShfUq1TPvyKA8ARX1ml79zKXFf52g3oBoxfSzyOOiO3gnGvYd4lJ95tBTB+Z4rVelQNpnsv6hy7kpfXoIBQT4jyvTjYo5HFIh+nO3bsG/S91H+WJ5yIMpIpKUSmRRUjt/H/Ftd/do5pXIMX1mddRy/0FmraGR3RMv7zxU8KJL10u/Q6SNUSPuYLsPs7H3t1b3GhT625kfWOUB2XSY7tJVJg6EnMW0cKfOIwMM7UtqLme02YFXh+B7gx9qlS0XcVxavC5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP/z7lXlUMsEoLiu3cugagTcFFniiyyNQ+yxmm9LRmQ=;
 b=w4ZIfN/VTp6PMkhCQLvmspkPwgDOkzMVO3wiB9AbdtBV2qwXCxS6SlpRK5DkhBM/ZH63sa5Wq0Hj2+VPKG6BEgW1fCOaFjacDhC6B5vvFBHQ8/uu63gPni4wv4EZPAs4rB9z7i64+OTN5rr2JHE262Ft0SQrH5+5VNNYeuhY+RSt4r0xHJqaVHAAcb4d16REKnm27GTN18gLB3yeddUo2E40Y0+rBfRKVi0O1wUjBuv5lh939QhnJ9OsIJMQ/b1tBOyw+b+T20qr15xlV3OnWza1W+EiiVJzUlPhRAG8nBhCRsSxOYCWMoBHQHUQ4dM2g/7CIhXu5OSazZbyDNmtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP/z7lXlUMsEoLiu3cugagTcFFniiyyNQ+yxmm9LRmQ=;
 b=WYchqT5YNPL9MmwKG15ydqvmB/M2CmLYWzO8m91dAsSfE7DmKGKqALdpIpfLl+mwpss0tsEHt85Nfl8LOMMOyjzg170fezJATqVIX6CecL5YxIhfu5NlyBYjiiGdDHMA9lRAt9BO4OvZIeYTYPfZTCw8d+7dQcl1Db0vIgdBV1Y=
Received: from SJ0PR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:332::29)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Fri, 6 Jun
 2025 06:44:15 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::5) by SJ0PR05CA0084.outlook.office365.com
 (2603:10b6:a03:332::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/29] drm/amdgpu: rework queue reset scheduler interaction
Date: Fri, 6 Jun 2025 02:43:32 -0400
Message-ID: <20250606064354.5858-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad997ce-966a-495a-38d7-08dda4c58e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzZ3bUQ2dC85WkRLRWlBMHRQRTBHd0pOWGgrcEZVNlNQa3FpOXdoam0xQ3Yv?=
 =?utf-8?B?VUVwYlFPOGRnVEJjQjRKdkZWQlQ1ZU9jUkI0eHNzMXpYV2RaL09pRitQQ0lY?=
 =?utf-8?B?ZmpwelY4OVJXbHBtTEVQd3lucjY3WCszYjh3WE5ZWENqMjUvdFlMZXM2OVk4?=
 =?utf-8?B?QmtkTGZJNGxkZDhacFJmS09SKyt5T3I3ZkpEajFId3hvejFHa0dqME9nMmZa?=
 =?utf-8?B?cEQrNkZvZS9yVWtSdlg5YitZVkd3YVlWZEFlVDlvS2hxOWJjendma21qV2JI?=
 =?utf-8?B?a09XcmpCVXQ2OHgzYnF0bnZIcWY5TzRQLzJoQVdhWEtjZ3RjZ1Y5YjJId2d4?=
 =?utf-8?B?NDRSa1VHOGoyL2Z6MWx1c0xxTjhWYXpyVnZWcVRwQjJvMlViZ3NVQVQ4MTRG?=
 =?utf-8?B?dDNZUVB0R1A5QjkxT2Y0Zm9EUmI3T0R0M1JuajViQjlUU2RiTzdDaFBuUUNj?=
 =?utf-8?B?am1vY1RwYmJGay9pNWhWVXpud0txVTRoUlY5SXpzQnBxM204OWMzcVExV0k4?=
 =?utf-8?B?QzlmQUpJTXBPSUFZajRXMzl4bFFxTFBXaVZXcG5aZVFYR09PdXFOOGxFdDZv?=
 =?utf-8?B?QmxvNUl3ZG8veVAyeDFaTnZnSlU4YnNNWUlieW10Z0JNcnMwZkdDdGNLNktC?=
 =?utf-8?B?YXRRYmlnYml1aHZnZUFyQWFYNlhBN2hTenFuS2VyLyt6MGJVNjFjb0w5R0Vo?=
 =?utf-8?B?aVVqZ2FYV01INmE5Vm5EU3NJcGNqUE8rdDl6OEFHbXhJblNURkFPMjJuNWhB?=
 =?utf-8?B?dGFjdm9kdXVqMTlUOW1oMmJkWDc3WEZuUEhFK085cjZidVB3SXlaY3ArNWFk?=
 =?utf-8?B?MGlvbEpyZW5LY0ZvaGJlbkhSQ1dHbFN0ZmhZeGNDZVlKclN0QVNzTTM4MkF5?=
 =?utf-8?B?Tk4rNkkxdStPOUttQnQwMzJYdk1JM29vMmRVYlQ0dTgzREdkWGgvd0lGdklD?=
 =?utf-8?B?dW5GSk5TdUloelp1T0NOT1pHQzhDOHlkQklvZUFDSWVqM1JwalB1NzhtYzdV?=
 =?utf-8?B?dHc4MzZUdmYrU0Y1aFgxczZoenRPeFZPZFhNS0xXQjVnaWRLem1XdUxXZmRk?=
 =?utf-8?B?OCtXOVZlWENaa2Q3UHBKckJ2SXhNWTlqYTdBcThPdFFhUjJkVGVUaExBaTRS?=
 =?utf-8?B?bzU1WmhRYWdRWHdNczFEd09GZkFYWEkxenVjbTBtK3c3S2FzcDRuc00reDkr?=
 =?utf-8?B?ZlhoS2RZTkZOUGZyVW5qQnFWVG1BWE45ZFk0OEt2UGFac2x4LzdjZmN3K3pQ?=
 =?utf-8?B?amNMN2FLcG9BS3dRTk9wT1h5STFZK1d5WlE1KzNiUFpVUXZZV1ZEVVR6OUpn?=
 =?utf-8?B?am9zNm1ROTVnUVJZSGtFL3ZFSjdOV0J1WklmS0RyY0lwM0FYN3FmNjNkOFNV?=
 =?utf-8?B?N2w1QXdRTFBHVWhZQkt2YjAveDNFbVRqazhOTHhhSzRSUElVeEg5THhuYWhY?=
 =?utf-8?B?VkhEeFdxRHNqVjI2RTY2Y21CNFg4eFE1ZHlTcy9KOVQyTGtNTUcxb1JKWVh6?=
 =?utf-8?B?NStOZ09wcmZIZlFrSGJ2MldDVzBSMWFqMXcrRmFwNzNpcGRBMFpIVDRDNk5k?=
 =?utf-8?B?TUlzVHU3YUsyOFZuZW9weDJXc1dBZUQ0c2lQejZJR2RDdFBIVlJZVHR0Ylcv?=
 =?utf-8?B?aFNiQkxmVU42MWdRU1ZkcGZLaUZPcURWYU1aazc4REMrK1R5a1NNYVY3b3Rt?=
 =?utf-8?B?UEI0MUduZSt4RW45bkJsZkdkNnBUcCt1WU02YXFhV3E2cGMwSTdEaTB0QTdt?=
 =?utf-8?B?Yko4ZGtFaDdQcTJLcC9EL0ZwS1FyYVBianM1eCsySE4vMDdWa3BaeU53TEpa?=
 =?utf-8?B?WjJkU1YzK3NQdWVYY0lYNks1ZlVNYVBuTzRPLzZnSUIvMXVIU2U0WDRnMmJH?=
 =?utf-8?B?YjkwVmpTbzRMemFsWncyQmx4VzBiVTV2VExDQmFyL04zL1pVU0NaZlZITTZu?=
 =?utf-8?B?emVQTllQKzhkK0xHc04wMkhzSUZwQ0MzeE4xaXZ5cWFXRnZpd2ZKam1GK1Jn?=
 =?utf-8?B?ckF2R2Fzemhmbi9XSk5TQlNjVEhaVS8xQUxYY1Rmb284bWFQTXFvZklmbExi?=
 =?utf-8?Q?HKj2xe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:15.5323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad997ce-966a-495a-38d7-08dda4c58e22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
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
index 80d4dfebde24f..b398e7d097cc8 100644
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
 
 		r = amdgpu_ring_reset(ring, job);
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

