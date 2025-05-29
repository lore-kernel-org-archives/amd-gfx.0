Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BAAC5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B817C10E221;
	Thu, 29 May 2025 20:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K3YbhHzc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC1610E221
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dvyjid69sm1VvRU8GkuqRquefMn9evUxxe8pR9k+a8RcN9/KotoXO+8G3aIBcXe/ch2N4dERWxsGfqzazyjq/ZEFKKip/A/lByrzz0tRS1TXgQ4/2gJ+dUOXX06Tz1TRukNVlLmdx8OuliNGlT9pfeUKp8iETk89yIUjqo7+MUKOHgAjJU8wutdEsAfy3inZ7lCdjYww/cnCA6IX92ZKTK7AY4ybYCygj7fxxSAEDYFczCLq408R8kWEjIBXyNG2cGdHw0j8YdsK1BEC3HRLetD+Mu6gJzHJXU0iYqXkNeCWtcxR19MC7ZYwyvH/jqgAwDsXRStq05yv+gC2+CQw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C60vXMBVTZ0rMOQmE7BTf/m7u2cWanDWfNSnMVhpIkA=;
 b=V43fCHHjvTa3TGqhzaxEIFdM9NTQuL/3+uY5uH3uSxa0EBZg4e+t7kEcvbCfsU0FVs81NoquJllABjw6rJG3iyWPyKcgHjNAwLsOf5zVlh780bjkMqoEnK2mWqFlZ8/fCWYaGGTTVIO/gSOpVHkqNwZ5DRGyjENfGwq1r0Ox0ePXCtby2NtFAD4xxhhZ1zB3hoP88ws+GnRj/RVqEpJxDiMNcTYtHSLDk8Ldo35rp3ZghNNSOVJi6dA43GknzJI9bJ4PbAhrILFidC0oVyugKx8QKm11Sdm4jxVLYjtY/JUVDGCWDQY4R6rd3RYjI+ohXKaRHhGsJVtswfxbdnUpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C60vXMBVTZ0rMOQmE7BTf/m7u2cWanDWfNSnMVhpIkA=;
 b=K3YbhHzctZiHzz+ULvx1ke6WI9yQOnbZdKNclSX76iCM71udEABxTtnh2DFOyiXhI25kpe7h4rdCAR//V1/qS2vDnqXSCS8UFwuyy9/e/QCzsV81bEzb9/oKNPaFpKZCdQSYhRbzTu6iiC9LzfBEOFLX9W9f6K9GN9iPSGA0NF8=
Received: from MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::14)
 by CH3PR12MB9731.namprd12.prod.outlook.com (2603:10b6:610:253::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 20:08:22 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::34) by MW4P220CA0009.outlook.office365.com
 (2603:10b6:303:115::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 29 May 2025 20:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/28] drm/amdgpu: rework queue reset scheduler interaction
Date: Thu, 29 May 2025 16:07:35 -0400
Message-ID: <20250529200758.6326-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|CH3PR12MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 1601c3a5-5631-4f1b-4566-08dd9eec9016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVZUVEtNVEFWaW4vVExXNzJwMDFITXpvbkNEcTNFSkxLbGErT09hU1pxOHgx?=
 =?utf-8?B?WnJBMjN0cXhmMUFuRmdwNlIrTW44ODU5RjZzWGVjY2JHd2hMSEx5Y0lKM3NN?=
 =?utf-8?B?VmxjaXE4ayttdkU0UlZVWW54VmhCZ1JycXhXbGVpQUxvdUN4OHJ0MW11c2Ja?=
 =?utf-8?B?L3poenEzZGtoTDFmYXVCUEZ6NXRDT0NXSUVhTzVxUnFqY21lT3RVVk1VbkZm?=
 =?utf-8?B?QytEazNFeDZCaGxRalpXekppdTMrYmZzL0Q5RFVhaW1ETkJtZERkcitsdWNC?=
 =?utf-8?B?OVViK3JKRmw2UnJEWllKcWJjUlFycEM5OU5IWWF6alpCbkovVEd3MXQzaGRS?=
 =?utf-8?B?eTkwWXhDemphRWpFcnBhVC9lcEpPazRKRG5jYUFMdUl5MlBLOTNrRndmandX?=
 =?utf-8?B?Tld5M1h4ZFZaZzBHOFJOLzJDQXhkSnhqZ0F6SmdyOGswQkJ3eVFpUzg4RVg4?=
 =?utf-8?B?NWRSRHpGMGJ3VlJNZm9HOURuaDBaTXF0VjBHOFRwbU9NZEFrMEFBZ205LzNs?=
 =?utf-8?B?aE9ZRGZkN3piTnB2MUwxeXVrMWYyZzdYLzBpK0R1eXowemFxd1IyZXNVMCtR?=
 =?utf-8?B?VWxhY3pvV3VLMzV5ZFNTZk5HbFAyMU50WFhlWkx3NXNUb2xQR29mWGdHTUJX?=
 =?utf-8?B?Q1dPZk5hajJYWk13YlJ5WG5Fc3FKYjgxbjhTQmhvMFFKUlpFMXljSGJCd0VR?=
 =?utf-8?B?SlF3WjRGd3lCMExtSEJIMmdjYWRZU3RHS3VNV1hMNmpuRkdYeVowOElENnNZ?=
 =?utf-8?B?d1dxeUZjY0YzSHJRMTBDWkluYytPc0NnY2RHbWdOQ1lOR1lWMmNieWlBN0pE?=
 =?utf-8?B?d3daTDZsRW8xQXZFWEtsSW8xMU85L01SbUF2ZG02SDVvVG9ERGo2ejZ4WjN5?=
 =?utf-8?B?NUoyRDNKVHZ4eVRINnFya21jak5QWjRNYy9odEhERXdEcU5Nc1lMQWNoTlM3?=
 =?utf-8?B?cUFLL0xzSmN3MTJPbVNtWHdPODZ5RTdxR3RWNXlSRlFMWFpPaW1iNFQyWkxC?=
 =?utf-8?B?VXJZaWFtOVhOQmVZL0VMM0p2TUJrcDk3eVVlREhjY3BQMERFNG9ETEVmY0Ju?=
 =?utf-8?B?ZkhoRXlZQzk3em9tb041RFFSZXdTZWxwc3ZiSGUwcldKQWRYMWpteXV5eVJV?=
 =?utf-8?B?SmlsTE9Rb1JGMjluWmEyM2trZHZPQUJxZ2NSbER4aVE4dlA4NHYrVFRMc1Ux?=
 =?utf-8?B?dnpWY1ZZMEZFc0VvcnZ3VEduRFI5cTBCYTdIN2FEaFc1VTNWU1UveXo5a3E3?=
 =?utf-8?B?a0xPL3JTZWlNRWF4bkY3VVFVSHo3OW1GUGZlTE1rY3EvZ2psYmtPczNGbXhJ?=
 =?utf-8?B?ZmtLZ1lDSGdiL1ptVEtsRUJZbVYzVzhXMER1M0l0Z2RRc21NSE45eUVua3Ex?=
 =?utf-8?B?ckhZdklmRnJnTGF1WGluM0dvcUMyWTdqZGhpSWZ3QXJ4S3MrK28wd0pVSjVY?=
 =?utf-8?B?RktTZUttbE9lN3RkckNoOHRad1FBNHBVbnJpbVNJbDFsUGljWFRTelBaMGg3?=
 =?utf-8?B?enRGZEZ0TERhb0FDUnlOc1Y5M21YOHFrZC9GcnJ4b1F1OXlZNWFGUStJL3lJ?=
 =?utf-8?B?R2hxNUtxcldyL3JUMzd0R0xvaDBsMjVySlcwNWhKeTA0QmxxWWpUR24zR25E?=
 =?utf-8?B?K2pESWxCUUJDUjBQUzYzRnhlVE93OWoxSUtvblNiakxuQkxOZUtYMklVUzV4?=
 =?utf-8?B?VjMrSEtYRzgxaG5mQjg2RGQ1YnZTUEh5VXRiTGxVNHlMUmJOeHFzcGxGWkJj?=
 =?utf-8?B?QllaQjBLN05YVG50eXZhYTBDc1lZbExmQzBMWXJsdVg3ZnNmMGhmUjhOOTZO?=
 =?utf-8?B?bFI3eU9LTHM0Yk02UlVVSzdwa3phaWdFUHEzNnVvMlB2dFMzMng4S0Vxd1h4?=
 =?utf-8?B?SGNaK2tJdnllMktSMC92NFNtQW8vcjgyd2VZY2FsYXFCdEsxZEhFSkJ1NzhF?=
 =?utf-8?B?bFhuUlpMMkVBcHBVMFB0QzU4RHZwcjAzeFNqTWVkTVBNeUwyR1QvSXBDOEQ0?=
 =?utf-8?B?RElHQzFoL0VEYVRoR0tiTnZWTlhtZ093VEpPSDVrQUlQbmFDdVFZODhPZFFC?=
 =?utf-8?Q?hQubmp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:22.2064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1601c3a5-5631-4f1b-4566-08dd9eec9016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9731
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

But using amdgpu_fence_driver_force_completion() before restarting it was
a really bad idea because it marked fences as failed while the work was
potentially still running.

Stop doing that and cleanup the comment a bit.

v2: keep amdgpu_fence_driver_force_completion() for non-gfx rings
v3: drop amdgpu_fence_driver_force_completion() for compute ring

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index acb21fc8b3ce5..0b9086a747c0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
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
 
@@ -157,19 +159,20 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_stop(&ring->sched, s_job);
 			if (is_guilty) {
 				atomic_inc(&ring->adev->gpu_reset_counter);
-				amdgpu_fence_driver_force_completion(ring);
+				if ((ring->funcs->type != AMDGPU_RING_TYPE_GFX) &&
+				    (ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE))
+					amdgpu_fence_driver_force_completion(ring);
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
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
-- 
2.49.0

