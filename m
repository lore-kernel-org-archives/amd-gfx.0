Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBB8C71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8499F10E48D;
	Tue, 17 Jun 2025 03:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1/LhEzN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E005F10E488
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZ93YcemYDzfpQ8O4dcqOkwZG+UBv1PiZFUMBSwuNPxdywiO9MUaQUOnQQbR1Dd0kzSGH/Ve8L7BPwsvVC124GiM1e1jHvXZ+f9xhGUjsPJr57PASyNxdIiopaxjH3p8e43tRfPmyFlnwepQzlQtlwRpTqfZBYhlpzDwYvLBojiw4tYBfoUPOkPoN8Rb+1sy1S0R0rdQHbE3ZT2b3BqPE/YtFGEarftBptHEtdsiD20Auz+8fZPogZk3T/Wf5W21g4gOoYT3cJqvBqPIRHagigfZyn76WVhRBqRxxGiGXRstVxWCYzrofgjjYAg9FuLnO3nau/y0lfMEEf1b4cWcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSP4F/BSeroc7K6JHXGTzl9XmEeEhs29oFcrTE3JBkQ=;
 b=gYUDhwcyLXOQlfu8LkH94t4gYaKpAbgYzOi1k2xBFB1jSLx578mbfLGTy740z+q9p1KVQjKa0HogZzIxuExLPa/mF3LKJdF9qEUCHEy0eUeHZjqgzD+S6H7x7ZWfv2tWKyM+vzzvg9AE0W6n+BJiMaIMsr9DouB31AVJ6gbAVoZHst6OBLyFPR6LnYHyGIr+AwkNDVTjVN9dES9BuZ8t4ApHnV1aLUnF+kwijv9y3ehxrxyj0JLWc7/bWBrZHTc6WH7Jxw2YT1WDIaTo3f5Cepf9K6YfAvwnyIJfcr3/3ER7K8bIXpt8tE9QqFm1pqCKNFfFxt78ANeitLyER49Vog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSP4F/BSeroc7K6JHXGTzl9XmEeEhs29oFcrTE3JBkQ=;
 b=Z1/LhEzN/r3TqmoDShAy+tTzcwal90QE7SJuyy1e8qlEGMncU44TJ/aGuAnigZRemSsKgayt+hAK3/vovWT948k7p+yOmGCoQzVY9tg+BEOKK+dLiQJBfZgBMICWsK6YbLn1JbTK89nrevXLOud1NDN2PqnE+1b+qRrf5OgmuAM=
Received: from MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:08:42 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::30) by MW4PR03CA0008.outlook.office365.com
 (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/36] drm/amdgpu: move force completion into ring resets
Date: Mon, 16 Jun 2025 23:07:49 -0400
Message-ID: <20250617030815.5785-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: e05f3a17-e056-4aeb-b0ae-08ddad4c42da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHV6d0l6a1RORCtndW1obUlCNVRHdjV2RDZ2YThxekFLNTZSYURHb01vM1h6?=
 =?utf-8?B?VEcxZythN1ZpZVBDTnhGMWtxb3hPR0FDVTcrUHNDSVoxN2J0aWNxaFBReW1U?=
 =?utf-8?B?V285L01iV1pWb3JIeUh5SW5Ya2JFSlM5ODk0czB4Sk5WTGlHRytMMjdNa1VS?=
 =?utf-8?B?NXh3WlloUlBSQXNWc3UyQTFkUzc2ZVV1Q1JBRWQ0WDU5U3FQSXZHWGVxNmg2?=
 =?utf-8?B?M3ZwYlo5c2pOYTdma24wVE1JaDFBbkNjdXRGNk9ZM3ZxY3dkSWRnRGFGejZj?=
 =?utf-8?B?QjFjY3hPQUJnblNXZGNhcTIvVzVDK3F3RldQTlFMcHo0UDNPMWZyYlU3UlYz?=
 =?utf-8?B?akNUeFNocU04bjNnNU5UYXVBaHFoK3lhSlJMS0dmSjgrTGlBYzY5R3pibm1k?=
 =?utf-8?B?R2hwUVFGblFtSU45Njk4VlI5clp5WmZxZG1PY0M5dlIySERuSlUwMkdPR1VF?=
 =?utf-8?B?MkNYa0ZjdkxHWnF1c2hXNUYzQUhPY3BvdXU5eTVaUG5jV1kzYzc3aXY0UVps?=
 =?utf-8?B?QVVxc0dkclFNdGdGMGZVUWlYY1FEOENLZVZia0txRHoyZTJJQS9neGdndWYw?=
 =?utf-8?B?dTFVRnJtTHR1NlR0NFk3ckpZek1XdkIrcFltRFFHMFFWamdTN2VaSU9NdnlX?=
 =?utf-8?B?aE1wRGZvSHN6cURycVZWSlRSQjB4SHRuU016VlMvaXRTWnpkWC9WeGdhNzVP?=
 =?utf-8?B?c3dXY1pvRFlSSUMrOVJtT3Z2YXpSZW5rbFcwcm5GK3pXRWI3SFFNeWlnRXdv?=
 =?utf-8?B?V2RoQVA1WDM5V09YTm1pdmVYUTZ6S2JKcTFVRWRlREpsZnJYdllVa2RqSnNV?=
 =?utf-8?B?SG1nMEdoeldlNC8zTmNoYzZsNjl4U3JONS9FdUdTVXR4TUJ0L0VSUEM0dlE3?=
 =?utf-8?B?YTBUdy9ja3plZ0t3ZzlnaUVEZFNlMjRiZVphUDV2OEtOaVRKYVdDdElWRHFw?=
 =?utf-8?B?c2dkNFFnNnBmWHFlVVdkLzQzMTdQS3lUZXIwOEhxT3duT2FFV2VzckxQWFBi?=
 =?utf-8?B?cWVTekNNRVJ0dXJXN25Kc2dYQWhPbFVVUDZrSVBaV1Y2WDVVZ042a1Q0N3l2?=
 =?utf-8?B?YUtBZkttL2t5b0pYUW9IeEg2NVJGY3FDWElJa1BmSWhBZVhUOHdjclZOdlJ1?=
 =?utf-8?B?cWYvM0xwVUtQY3hYWmlmVE04WUlTZmdIQ1B4ZjVQazBjTTMrK093c3VJL0hh?=
 =?utf-8?B?bWY3S3QwNGwvNFlTSVY4NFlCdGI4V2ZDSlFZZC9SUVFiYVhzdEw0N2xtZVdo?=
 =?utf-8?B?OXU1U2RTTGhkMlBrc0IvV2tEV1hUa1BKY3VHRElFRktUOTdGZEFLVytGVHhI?=
 =?utf-8?B?NVpVeVRFVURaRHJTSW4vN3E0MDI2N0MzYThKdE5DNk5zQmFmNzRSZWhuYkRB?=
 =?utf-8?B?QWJGeThaOEg1c1BmYStCbkZ6TXp4ci9QbW01dURjcEJyL2M2eFRCUWZJbXFp?=
 =?utf-8?B?dGhWU3ZTZUQ0K3dTejhCSWdoL3BPbWt5N0tmVFBVeXpGUFZSUFpBQ2diYjFq?=
 =?utf-8?B?N1ZJMHdwVUozaExYTlpqL3FobnJqa1J0ekZJQ0dLVmhEU3djNjllMW52bmxy?=
 =?utf-8?B?cStwc0hEK1UzdDdMYU4zQ2tDYmRmNGR2ZzVlWjJLWmdmMW5Qam1UR3IwSFEr?=
 =?utf-8?B?ZnJEZHBWWjJOM3NtUU1oUmNLM1BzcnVJaTNRdWQybjdkRmFwRFFKZExRVlZ4?=
 =?utf-8?B?WjBqTGhRY3NFa3lsQVNvaGJFZlc0S0RYMm9JanZZVGRuWXhJMVh3akFSb3Rr?=
 =?utf-8?B?ZXFTRUtucFpCMGh2RmpEd0tQUzROa2d4THpmQi9ZVWdTbEtQdnUzc0hiZjZU?=
 =?utf-8?B?NmFIUGNndHp5S0lwMCtKT0oxQ29ncHZ0a0lrM2RjaERmZ0Z3NTNHZ0x4UEFH?=
 =?utf-8?B?ZGppR1lIWjBOSWFWWDF6T3RIMVdmZ1kyRGFiQmpua3BOeGpnUDY5dUxaV1B0?=
 =?utf-8?B?ajlBblVCbzF2RDNhTkt5eU5zL3UzcnhCanEvd0lqL2ZvL2x5SlIzbkZrMml3?=
 =?utf-8?B?eTcwWGpOYXpBandwdTZyRk5GU0pHRFVFcnFid3IydklyZExabVNFOWROWDFC?=
 =?utf-8?Q?H7Xcrg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:40.5851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e05f3a17-e056-4aeb-b0ae-08ddad4c42da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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

Move the force completion handling into each ring
reset function so that each engine can determine
whether or not it needs to force completion on the
jobs in the ring.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 12 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 12 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 12 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  7 +++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  7 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  8 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  8 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  8 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  8 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  8 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  8 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 31 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  5 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  5 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  6 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  6 ++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  7 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  7 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  7 +++++-
 21 files changed, 152 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 93413be59e08f..177f04491a11b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -161,10 +161,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
-			if (is_guilty) {
+			if (is_guilty)
 				atomic_inc(&ring->adev->gpu_reset_counter);
-				amdgpu_fence_driver_force_completion(ring);
-			}
 			drm_sched_wqueue_start(&ring->sched);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 444753b0ac885..b4f4ad966db82 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9577,7 +9577,11 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9650,7 +9654,11 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4293f2a1b9bfb..5707ce7dd5c82 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6842,7 +6842,11 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -7004,7 +7008,11 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index aea21ef177d05..259a83c3acb5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5337,7 +5337,11 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5452,7 +5456,11 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c0ffe7afca9b8..e0dec946b7cdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7223,7 +7223,12 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 79d4ae0645ffc..e5fcc63cd99df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3620,7 +3620,12 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 4c1ff6d0e14ea..0b1fa35a441ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,9 +768,15 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5a18b8644de2f..7a9e91f6495de 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -647,9 +647,15 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 4963feddefae5..81ee1ba4c0a3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,9 +559,15 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 327adb474b0d3..06f75091e1304 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -724,12 +724,18 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index c951b4b170c5b..10a7b990b0adf 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1147,12 +1147,18 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 51ae62c24c49e..88dea7a47a1e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -838,12 +838,18 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 502d71f678922..d3cb4dbae790b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1678,6 +1678,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   unsigned int vmid,
 				   struct amdgpu_fence *guilty_fence)
 {
+	bool is_guilty = ring->funcs->is_guilty(ring);
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = ring->me;
 	int r;
@@ -1688,8 +1689,13 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 	amdgpu_amdkfd_suspend(adev, true);
 	r = amdgpu_sdma_reset_engine(adev, id);
 	amdgpu_amdkfd_resume(adev, true);
+	if (r)
+		return r;
 
-	return r;
+	if (is_guilty)
+		amdgpu_fence_driver_force_completion(ring);
+
+	return 0;
 }
 
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
@@ -1733,8 +1739,8 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_mask;
-	int i;
+	u32 inst_mask, tmp_mask;
+	int i, r;
 
 	inst_mask = 1 << ring->me;
 	udelay(50);
@@ -1751,7 +1757,24 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 		return -ETIMEDOUT;
 	}
 
-	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, true);
+	if (r)
+		return r;
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
 
 static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 6092e2a9e210b..07fe6ba1612fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1618,7 +1618,10 @@ static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
 
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
index 2cdcf28881c3d..45f8b04324a1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1534,7 +1534,10 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	return r;
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 43bb4a7456b90..746f14862d9ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1561,7 +1561,11 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return sdma_v6_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index b5c168cb1354d..2e4c658598001 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -826,7 +826,11 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return sdma_v7_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 083fde15e83a1..0d73b2bd4aad6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1973,6 +1973,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
@@ -1980,7 +1981,11 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
 
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 57c59c4868a50..bf9edfef2107e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1623,8 +1623,10 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
 	r = amdgpu_ring_test_helper(ring);
-
-	return r;
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 4aad7d2e36379..3a3ed600e15f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1471,6 +1471,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
@@ -1478,7 +1479,11 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
 
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index b9c8a2b8c5e0d..c7953116ad532 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1198,6 +1198,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
@@ -1205,7 +1206,11 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
 
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.49.0

