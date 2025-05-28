Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D0CC5B552
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D63A10E577;
	Wed, 28 May 2025 04:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AvXWZNjr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B81010E54C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrgM9zRkaNWGVom4/ec8dTQy/hJ8QbxfF61PnveVEsQYczfzOAAVvbavJy9QoRgTIxl7I/uJcAwRjWDN2/f+/43G/ItISk/o1Nun1EdAAncmEVVkNrmZC5IUlwo+ZJrBRhQH5zkSNdE3qr2+zuWKjrJLBiKQXit41kfLj8b1s0N/5Yr/2H3v+BtY0q8cfUy5gbJIjqOojL8sfzCVTDxzxqG2EsB6iy0l19946VV8/HJuM+jKDyeH33+HiBBeCJ36vBF206C+r4EWUuDNWGkaKX+dZoEorrms2dY4kqH0B63YJapFujkiyluMjD1up2wC5rvIiKx2RDbCRSX0J3omKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C60vXMBVTZ0rMOQmE7BTf/m7u2cWanDWfNSnMVhpIkA=;
 b=wJBZC4OLeAlXuAqhz1W1YKqW0vH0GjMiTDgukb+WmzJWBsqMK55nd35JKrn44oXKpUI49N51Zo0ZbDTYy95OZHdIcVYY6128OHqSeweVtVTa4lR4tKZ43/25Lp1ra7RHtTOhMCmMO6//uGZKN0WoP4IY1TPb+dVAwXjxWqKNkWyDJs8IW7CJd62+ab0ptiwrWopzCbPXRCkpMdFztu9womlsbyoIv/0pH7rCLAFpKPTwW3ymeD0iCk4q09FAXa5VWJh4I0RcgjvIu/R52v+iRKAkOZQhxcVEGOO8FB0b+TDSoVoCs/aGAo6IYoyGyMqcC0kge0chkjriOggRIHTXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C60vXMBVTZ0rMOQmE7BTf/m7u2cWanDWfNSnMVhpIkA=;
 b=AvXWZNjrIIql6zB/G+LUsaDeuqVHp1u+Rn6u5CUYYtxRNTPZ/5vm6nYle1CSTyhRGTryUulEtrPEvHYh67l2esJ4kqlojR1kY1QLfHa1lKrMgVnS1QfHGUJAXsAI14umqfEAKMnZylxVt41ZSpmOQOq6kih8MjFQYUP0uWiGZXQ=
Received: from DS7PR05CA0048.namprd05.prod.outlook.com (2603:10b6:8:2f::19) by
 IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 04:19:34 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::61) by DS7PR05CA0048.outlook.office365.com
 (2603:10b6:8:2f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 28 May 2025 04:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/19] drm/amdgpu: rework queue reset scheduler interaction
Date: Wed, 28 May 2025 00:19:02 -0400
Message-ID: <20250528041914.5844-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb57ac0-0825-41ae-1812-08dd9d9eda13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnNRK2owSlpIWUlvZFZ4MXNxYjhkdEJ1MC9RQVg0ZzVna0VJUUpKY3pZaTZt?=
 =?utf-8?B?VWZjNXZuS2Q1dFpBeGZJbXhuQmNIQ3pLZ2o3WmhWZG1lK2JjNy9IRFowT0RQ?=
 =?utf-8?B?b2xTUnN0VXhmQjhYU29Kam9GSFprS2pHQU84b1JEYWhJclVjdGF5dG9TZkFx?=
 =?utf-8?B?QzVkd2hoVUpxZmZNQWg3NDhwdXh0Z0FmNXBHcXZVelVUTDl6dlQxSHc1Z0pu?=
 =?utf-8?B?eXY1MHpxYXA1aUZLa0RpQW9KcWtRTG5qZCtnMU9UaGNGTllrY0lkK0dXUWsz?=
 =?utf-8?B?VGZXZ0ZUMEZQazZFRllGdmNzZ25Hcyt0clZKUG5QK2VMN1VpZCtnUmxsSDJ2?=
 =?utf-8?B?WXQ5QXZ1K0RUbFNLVExXNEgrSG1QbmhBd1VvdGZudk00NWw2K0tmaGRWTjg2?=
 =?utf-8?B?ODRVR0VQaEdMQ2N3cEFqc0dMcERPUEU2V1hrT1VKbzVLWlJCSC8yYXl0dVlW?=
 =?utf-8?B?OWdUaVViTTlHcVpuQ1JZWGpSSnNXcXdzdDBpZEZxMXUvQ21kY0VidngzZzZs?=
 =?utf-8?B?KzR2SjZYRmc1S0ZzRnRsVWl5aG9uc2RPbk5EYTdGM1VodVQ2bU1HNHNiVk52?=
 =?utf-8?B?ZmFPUHFTTWs2eUdHVDNtVkpkWWdQVGRLbnRFaDc1MW90YXhjTFNJUDBmdGU0?=
 =?utf-8?B?cjhjYU41dSsxbGpkSmYxT3FSbmpKRml5VmhpMDFXZzdaQ0ZOOVBEaVIzcDJi?=
 =?utf-8?B?NnFXUVo4T3ZOWDZob1ZRSjdEeGg1bnRJZ1NsdlNTeEduQjlLY1A0aGVCZzZm?=
 =?utf-8?B?bTRib2EvcmpEWEo3VlF6VU9QSUc5MkpicW1nWkoxL21RL0d4dDZrL3BTUjRm?=
 =?utf-8?B?MkVsWHpQNC8rTUh0NGNvNnFSWWFlVXF1VjJ2YTZKdVk2b2licWFnSlYrWnRm?=
 =?utf-8?B?aGdnTEtEMm1Xd0JSRTBxOWJTU3VIQ1U1OWc3VWUxbndOQzRiSVU2T0crbGcw?=
 =?utf-8?B?YlJtTGZMMlhRenhXQTBiZ3RRZGhPNk1iWk9uekJwOENMQ3hldFdSUzgydVZI?=
 =?utf-8?B?dSt0YXBzVmU5Z3dlR1lRaUlCOHhjbTJLZm5Ka3dJaDBRL016MzdrMmhYQ3hq?=
 =?utf-8?B?T0NUZWw1V3BaK0EwMjgwcDg2TmtJbVlCUVZseGljMmE5OVVxS0tKQmJYU2FN?=
 =?utf-8?B?eld3UUw4VDAyS1RRcUxNQmxlY1JsSVZoM09MRzBVY1BkazIwUlZ1d3ZHUkVh?=
 =?utf-8?B?LzgxYW9KeTZPT25oZjAzODR1Qk9QdnIwM0ZVZXdQOFB4dmt3SzFqWjFoczh1?=
 =?utf-8?B?N01iQk1TN09SblV0bkNnTlJuTzhHYmxQZHJDSGIyOHZ3dEVReUlBcXViZjhQ?=
 =?utf-8?B?S3EyS09kY0k1OVpvYnZZV25zM3Q4L0E1c1NPanV5ZjRRQnFDMHB6b2tMaXlp?=
 =?utf-8?B?YjdrajRTa2xvZllLY1QwNXh6V2FlUjBQaHBmRzVJTFVleGtUWXRLTzVJeFd1?=
 =?utf-8?B?NGtrc3ZXV3pCSGlQWkZ3QzN1NWNhN3B5OHROZlprMXlBcGZaRnkvdUZjajEx?=
 =?utf-8?B?U1NXd3QwWGttMmdtSEt2YTlsbXpoOTNpYnB0aDBYVExZZC90Tll5MWx1YVc1?=
 =?utf-8?B?emhHd09PZVpWVHBDZkhQeG1zdTMzUEVxd2RUdUs4TW15Q2tCYVIyTis5cEg5?=
 =?utf-8?B?azdjWjJNYlVuanpuZW9JT1NuWHJ4UHJTNXQyQy9LRUQ3b1lzbU9Jbm80by95?=
 =?utf-8?B?S052TS9CSk9sWjFKWG9GM1A0UmFQam1VWWlxYTdINVFVN3gxYzlFRE9XWWVB?=
 =?utf-8?B?enVaVVBiMDNkdmVOdXR5aVo0ZUNKWmtqb1E4eDAvZ1d6RWRSUkhsNGxSNitk?=
 =?utf-8?B?NU4zM3ByRHNsbDlBL3Zkak1qL0NYRkQzN2NxdDBGOS9DdXJMcjFpYnBRakdu?=
 =?utf-8?B?TFk4WUNDaEhVUEM5YXAzcW9Qd1pBYkZOMmtydWdhaTl4UjlKWnY3bmdJY2lE?=
 =?utf-8?B?bzBzZndvc1lhSVJaUGhaM240SkpITzZZNDlYSXB3ekRRSFo4RHQ4Zys2ME5I?=
 =?utf-8?B?N3VvYVRIbkJjcFlUZ0tuQ2pKSVN4ZjE0U0dtZUJERHcxeXNqSURvbFFTbWMr?=
 =?utf-8?Q?hO4gY8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:34.4752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb57ac0-0825-41ae-1812-08dd9d9eda13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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

