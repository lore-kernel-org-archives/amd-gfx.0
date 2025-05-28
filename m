Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D69AC5B553
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E9310E6B8;
	Wed, 28 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="APv/28Ut";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21C310E6BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfHWKYqTcGC0ew6wjfWaLEdC3NPk5KxZO9s4ATCsw2JqtwJuhqCN2bklZPU2N11lHaM2TvA6/O7nS9l6pEQx3yrkf3s4jgM548aEiy8eowDyANXDj33OA4BZLBcVW6lfcPBtesUeq/BY7ZAMM3RhxXcwSYVozJ5MssL5KbgQ6U1hj92SMUvEnTac27PU+GHir512DNjPsI3PxczU0qLVwW8x8PrKEMygvORoQxkaMM2YVT7iCgQNE3u4MG8fEY/Oks9KJSibZnWdgj86UKteHu/enPsPZSu+Pn//hJgv8OnHmTQVmg2ZGXmQ3RLAmMGOcsEEC1UDYHqFDKtkZw9FXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C60vXMBVTZ0rMOQmE7BTf/m7u2cWanDWfNSnMVhpIkA=;
 b=oI99VbUssOQ+vGKcEFBxer7aX81fMkx8Ep7otPEA67BtI1KWEofEOKEFDEa1+DtYSP9dqs223ALNtQ0HLshY2oMvpriX9zi/zatRyNL/FdwXQG2uxFHI7s30oGizHTM+owguRe9XzZymJuvCQAQ/ix9xJWO7Bt3YM6FyUj8xdX1eIXihmwDM8Vdz6SrczUZuadv4BLQxQFPiYRaAY7lIhb1JKdfbCGXeuv3+xtBdKqsn8mdH8XhDy99kOPsOI+zbNmh5Xz++mk5HZZby2s+VEQAaGCj3RtlAG/1nbaeNjedbh+HwA8cGZ+bAppw3RiXVL1GLbCZ12znTg7GU/uGF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C60vXMBVTZ0rMOQmE7BTf/m7u2cWanDWfNSnMVhpIkA=;
 b=APv/28UtoSq4T9L9A8324t8a9gacdnmbESqmMd3Lyv3suxvZynlNEzd7aK6HamRZ6pCaRUaw0SkXVySK0YewUfzs7Sgdc6ds+4wtCwsgSfS7OCoI5NKQ1qv9PBEto4I7MmYtuWzv4UE9TRuqb99jDpy+A1VQ8vt8D0rrfLXoyls=
Received: from BL1P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::19)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 17:28:21 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::a3) by BL1P222CA0014.outlook.office365.com
 (2603:10b6:208:2c7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Wed,
 28 May 2025 17:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/16] drm/amdgpu: rework queue reset scheduler interaction
Date: Wed, 28 May 2025 13:27:52 -0400
Message-ID: <20250528172801.34424-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 757b9b67-5245-4925-87c2-08dd9e0d0b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTE1bUJhaGVYbjA0aFNOZzJvS29YTm1pWng2S3U5M1RnUk1nd2psK3JDZ29k?=
 =?utf-8?B?WWNwL2VtblNKZk0rYUswRkh0c2FRNmUya0lPV1I4VElUUUl1Nk5PbXlmNWpR?=
 =?utf-8?B?YkVKWHlVc2IwdXd1M2ZyWjZMN1pER2dxaVBDZjBzRXZibjMwV1djRmRmWDdP?=
 =?utf-8?B?YW1wZ3A2UjA2clhZQ3U5QzR6VXA4WWZDSmp3cklFeFlJMmdMS1ZhVnZ5VTVr?=
 =?utf-8?B?WGR2TlZrVUE5OE05cFM5M1RRUjN4TWRuRG80dnVaV29GV2VRTEQrWlZ6QWNS?=
 =?utf-8?B?eUpLaEtGMlFpL3JLQ3RUSVdPeE03MU0vSzRpS1B1d0JxVU55VCswRWs1NXo0?=
 =?utf-8?B?SmRLRm9IN2dsQ21MT1FzbVJFOU5zVHhzOXgzbHJSNU5OZERVUVZVTTBUUXQv?=
 =?utf-8?B?TDFucTdiWDVhYzBsS1BSZWVGQkpkZm1TMk03dHpweFhlTDk0ODc5MDdleE1P?=
 =?utf-8?B?OHZEQnlLUGJvVFQ5VkIyR25QZkErZDh3eGlrY3REa1hsUnZNOFFVQmZWWkw5?=
 =?utf-8?B?Ti95TmpsWXJycWVvbGg4ZnJ1SCs2cFdXaXoreGFqdG1MbXY4RTRaVFBzZzNF?=
 =?utf-8?B?b0RyVnMwSXJGY24wdzJLV2VTQ2NQSnBqRS9Va1JCYm9SWml1cFNYVnZDNmxG?=
 =?utf-8?B?STI2R1F3WC9yKzhUakVWb1NuL056djNVcmZZTUxLelF4b0pvMEJvTU5WWkZq?=
 =?utf-8?B?V0NYVmhqc09oU2pOcm9ydkk1eCt2M2RackMyY0lhRDRFdDYwemVtWnVjczdU?=
 =?utf-8?B?eVlUaG1UVjd2ZlBGd0VUMXd3aGxDblJQOFpxdlhtOXB4MlFGL0YyTjZZanZH?=
 =?utf-8?B?REwrT3p2VStvNGlMTzU5UTdOcVZxOG9FUmg3M2RJS0hvakRLODl0ZmxMN1dW?=
 =?utf-8?B?a0k5RW80VVIyQksvelUwZTFUTkcrWTUvYlQ0NGtEUjZjZ1FkemtlbVVpZUJC?=
 =?utf-8?B?YzU5R3pVNmVUSnZiS3ZkaXhkNmhoanR1YVY3WkdLdHdxMm1FRFc0cjNwQjA1?=
 =?utf-8?B?MHFET3N4TDVUdHB3MzJDSklxNUg5dE9rQUhQMFl0NWp2NnRwaFJzYmYyTjB0?=
 =?utf-8?B?T251a1ZvTWlZeDZMQmxXUWtMRzZNcnkybFkxeW95cHdmYnRBbDl4RDYvYmky?=
 =?utf-8?B?VEllTnJoaFB0OUF0OUw1dnRLR2EvMGpjOGxDL3d6RWV1Y3dIMjd0eWk5eVlq?=
 =?utf-8?B?bzZpcFpwVjFrcUxaVytVSW1La2k4ZEl3Qm9iUzRqaEQ1bFlkd0pic0d1N1pW?=
 =?utf-8?B?RFJmV1JuQ2RsMXQ5OGhDTW9aY1ZzZTFTcGJ0dFJLaG15b3Rka3Roa1hUTlIy?=
 =?utf-8?B?OGRwNkFnRGRMNzNCSkVSMEtZbkNDUVMzZ0JJUzF4M3BkWWRVVC9yR096K1di?=
 =?utf-8?B?bGYyd1dQemc1eSsyRWtWdE4zendBMXFpUDRKNDUzbW95cno5Tlh5eXlnRkJ0?=
 =?utf-8?B?cGJmNkNnZS8rSHZvMEROM2dPTGdoOTRjcFFrc0p0SG1hcHRQNDZEUWY3Vmkr?=
 =?utf-8?B?RnRSWmVueTE3SUh1cnJUQlJLUW9Md1lIVjNwUGZIT0dGOWcza1ZxYkM1ZUNT?=
 =?utf-8?B?em03YThzQ1NvcnpFblZFYTBxdGswa0xhVEdFTUVaeFpxS1dLeU1HUVBIdlRk?=
 =?utf-8?B?NjVFNTYzK3l0ZjQrYjZwVHNHa0FDZ0FVRE95eDgraEZTc3VMdDVxNzdDOGhG?=
 =?utf-8?B?RUJORFI4Z3VTQmpwREs5RXhEMlJBY0QxK2R0UkFadjN5UUZvOTVHN25Mc0p2?=
 =?utf-8?B?SmdDQXpWditLdEVzaE1nOTR4WVFaZmFSUWxadGF2ZWtOSTRtNVFINmZ4enVt?=
 =?utf-8?B?YzdsOFhWNStCekJybWhvRmp2WWt6QS9zbmxpYmZ0dFovNVZSREFPaDVsRSth?=
 =?utf-8?B?VS9VWEQ4WEYvdEFXRWtKQjJNUVlTVXJpMXoxK3h3ZUJtb1RTa3VhSnd4cjVu?=
 =?utf-8?B?TFR0SkkzcW5KUFlSWUxjMFArbzlZdzFadkxZR0QzejFPVUlGUUdNcHorQmlF?=
 =?utf-8?B?cWgvV0U1b1RHRG9FTW9xQmZPZmYzRHo2eHNaMVJMd1NvN0cwY212ajZzMW5m?=
 =?utf-8?Q?dO8Lsk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:21.7588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 757b9b67-5245-4925-87c2-08dd9e0d0b50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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

