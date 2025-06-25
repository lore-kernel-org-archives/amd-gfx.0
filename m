Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB61C7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A320E10E7EA;
	Wed, 25 Jun 2025 21:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="evfPET95";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E5210E7EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcTk4U6pSpf+gZoI507e3P3zqQRhoMb5m5XymBhTtbhPHum27PRfo1ZT5uwKCAgh0Pi4L5h6dpLm4QQTEfneoA4uVLMpVlp0apQfhcNmWy9WKRFvbBUJ2sqMPKOnlk9aXqr5hLJjsSIdKSHlYawVn2ckSlYEUPx7+Nnmo5n6hyqz0+rF9OKY0YUY4jhH8cm89allZDVR2B5M4KTEXbQWjbG8SYVmVgqSfqKAFjUbJPv1v2WRmLSJQGPKY2sUYGOiStPtqdqVv6/MIm46G4+UggYgbDxjCeI3s9Pfe/rzi+BMD01a4ty3WrjZk5q3hNplZU894PUEzJQyeRp904C/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0uOx4QAm1qRItiIw8b/FeG5HkcaSMOAe+iwWLZ0QD4=;
 b=wgupoo307p5Iuip1t357bLjTfLNYgp+ZUzzxh95dBhiIJtpjh+rwY0NdPmoS32yVY3O40Ukde4zssLOTWobC9BUC4CHFKRvOxKtn2okotupfnM4Pm8reYFhuKtnGxA2IO7jCqDA86zTp0nlUh7Y3aBHoxWlKoGx5pSAcG8N298bBiWV0VcSNc+6osZQc77lpBBcscjTTxgzto0y8HaUErIMbjPXpsNqldxNvx2sN47/DiEimRY7pqQdsxVnwI97zWtxnuhvMMa0MMjbveNxkJHGjKuD4I7WGPIbuOwm6wNIn4oVjTGbehmQHYseazBafkDy6cg2ngrgJa4TuGuj7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0uOx4QAm1qRItiIw8b/FeG5HkcaSMOAe+iwWLZ0QD4=;
 b=evfPET95r61bHhPWEym+3ctwovsnxM6d8eDlrpUmVtwXCXvVSY/gOA1H+S5ZckxntJEnAS7NP+XufaSvhbPCxcpDdzyyNtOkgxTIpY7+056wa7Yj7lnEXYFEK1SMCqFyc9hM3mrj5rwkPBdILSciBVkUqkGH6jMlDmt7m9Q7Uec=
Received: from BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39) by
 DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Wed, 25 Jun 2025 21:06:58 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::b2) by BYAPR01CA0026.outlook.office365.com
 (2603:10b6:a02:80::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:06:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/30] drm/amdgpu: move force completion into ring resets
Date: Wed, 25 Jun 2025 17:06:12 -0400
Message-ID: <20250625210638.422479-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 568641ea-3bba-40bf-f9e0-08ddb42c38b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3V0ZFNoWjczMy9uTnJkaFRFSnpZcmgvSGh3Y1Nma1E0ZVFoZU5Db0RHajAx?=
 =?utf-8?B?SzlhcTd4cndMZ2dEL3lUMEZ5VGQzam5pcnJtV0RDVHh0R1hSL3NvcFM0VTRx?=
 =?utf-8?B?bFA3QkJEUVRFbDNHVWMzQlUvUXN3WlFIb3gvUzRvVmRpNUZ6VExoVjZNTFFj?=
 =?utf-8?B?WmdENmE5OGJjbSsrb21uMm9EN1U1NFZTQlBQNkJYL3BTTmd5YStldm5zUVRD?=
 =?utf-8?B?dDFoNGlPcGE0QXNKY2Z6N0ttQkhtN2FobUFIbVFTWlZNUGpNNFJhQmMxai9O?=
 =?utf-8?B?WXh0U3FvZzFUQkwxRm10dEhITFRiSHNkY2I2Q1NMTGxIeVlRbFoyVmlLb29a?=
 =?utf-8?B?SUtBZHFaOEpoeU5kR2VzdHpQdVp6YjdpOFArbHpsYVpYVjRrSXJSS3pxQUpp?=
 =?utf-8?B?OTFmZzl3M1Y4dTZsWWxxMWFyTVFZazFrM2czSFZJbDVxL2NORGk2akdIL1BN?=
 =?utf-8?B?Mkhkb0ZXV2srWTV2eWJ1YitSaitibDRBbTZhamxsckFyQUFEckhRMEg5SnRY?=
 =?utf-8?B?b2lDRWtxNlVEVlJoR0ZmeDBrK3VoMHhNbnJtL1EyVHlLKy9hVlptb0JnZkVD?=
 =?utf-8?B?VVQvOWxSdU1YVVNIK1EydXZyWkVPSURRblN3S1BMS0dUMDMvaDN0NmUzQ2RU?=
 =?utf-8?B?Mi81d0tZZjVzekMrQk84TmZCeVJxeHlEd0MyS25uYllQSTJvaGZ6TGZxSWJX?=
 =?utf-8?B?MDJCY081aTR1WnNUL2t1TjJnS21SZkJRS0xWZ1BqdmRvcGYvVW95eS85WnZS?=
 =?utf-8?B?UWRkTGx4a2FFdWRQODNJdjVJQ1ZDUjFHSUxtV0Q1cVBJUWppaUthclJEd0JX?=
 =?utf-8?B?Yzc3VCtMY1RLZXdjZjhnd3ZiSjZkcWdqWmNFQTlxcHFsbkFQQS9uQlZYaUt5?=
 =?utf-8?B?bjduT3UyQnNLTUlWc25CY0ZtTk4yYTV0ekUrTXpISngyOXZKMCtLcmgrTU5r?=
 =?utf-8?B?Q0VEMFVBeUVoSTlLNHZvUU8xQldYY09yRkdwVmJuWUw2ZURGaDJVUVkxUGRL?=
 =?utf-8?B?NE9RMXNZTUt5Mld2K3lJQ0FzTlZ1cjEyRnlYNmRTdFI4d2xxQzJWRzlHcFBy?=
 =?utf-8?B?U2R2RVhNVGV4b2ozbEFZUlRGT0xHYnFBSXBjc3pyanBrUEZTd3Y5MFBpUjBY?=
 =?utf-8?B?ZVp6OWRjdy9UMTdrQWo5OGhYakcrN3ZySGYxVEdwWW40RVRZREp2L1dISlpp?=
 =?utf-8?B?bWM5TEIzME90Vi9sZjNTS1k1Q2NRMUJ3eTFQTFdLc2pFZEdQSWJ1bFlxdjNM?=
 =?utf-8?B?aDQzSWZqMWtNU1FTcWY4ZVhLRFZBS3RoU3FHV1ZJSUtGQnNxdFgrTnA0dVpD?=
 =?utf-8?B?bER5QjI4UkZkZWhJalpFY3BqY21yQUUrOW9KT2laT2FHQXlWN0E0VThzK0lk?=
 =?utf-8?B?TTk1c0Zxa09ZMXYrdFBabnMrYjJLeVJ4akJISUZpcWk1ZDNrQ2dlYjgrSTFC?=
 =?utf-8?B?UXZOUVUxb1J0d0JtakJyUlFJZDAzQTlOMFFxUzJzZnA0a1pmMFVhVUt5ckJS?=
 =?utf-8?B?dDdYckZNVm5tcXhZZFJCemFOS3EzUjRVaFNyUnQ2bzJ3VVcxdW9CcTV4bXJM?=
 =?utf-8?B?djlxMkN2Nlo1aUVxLzk0SndDbW5TbUJ1aUpyYTlxMkRTRG1wSWxwNFdXNjJO?=
 =?utf-8?B?M1luZmxtNHltV21aUVdKNjMvWktaNFFEODRxYkl6RTJqMTF4RDg2TTdMRzRI?=
 =?utf-8?B?d3puUWpHdkRDRjhPRHc1Wk9nL2lXd0tSTTlMWUE4SGorUFZLRW83dGpCRkdi?=
 =?utf-8?B?VTlnOXV3c0ZVWW9xem9vamUzL3N6R29vdzJtMWx6bHpaOXN3RURhaGF5Umg0?=
 =?utf-8?B?SzdwRzJlZG52M2kxOG1jTEpORmU5emxnT3BRL2s1VU9IRFV6a001ZUxBWHJV?=
 =?utf-8?B?RjlyOHR3TGxPUkFpWUZmZVBjcGtySXMzQVJ5ZkRsRmw4Q0xYQUdycXo2RlVy?=
 =?utf-8?B?WUpHdDFjbUFnWXhNZEZmaGNxUTNZTzZ5RU5ZT2Q1TjNNS3YrVHBFZEhaRUh1?=
 =?utf-8?B?VHdqQjZ1clVYOHo5WG53N2ZhWm5nTnJ1MHM5Rk9HaFEwN09UN1E2dlpwdlRu?=
 =?utf-8?Q?YZA97j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:06:57.8346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568641ea-3bba-40bf-f9e0-08ddb42c38b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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
index 4b2af95203b26..4d0ee3ffe9858 100644
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
index 8d5c0ab016d2b..39f4dd18c277b 100644
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
index 795bd353a9cea..964fa3f2e2719 100644
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
index d91e0423c4820..95e319974f221 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7242,7 +7242,12 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
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
index 272f0f8e41d45..8bfee17a826e2 100644
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
index 93eb71d2ce304..6621a7b1f29fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,9 +768,15 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
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
index 45b8702d20ad9..44a5c0e82ca43 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -647,9 +647,15 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
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
index 9bd0ae4a24a1a..e813af4eedd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,9 +559,15 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
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
index 4fc1ef85b2945..190f0742d7016 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -724,12 +724,18 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
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
index bdc7612ba56a5..04755b7a62d9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1147,12 +1147,18 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
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
index aee4f50a0f52e..e7f942dc714a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -838,12 +838,18 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
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
index b8828432c98a3..c13ae87d4e648 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1679,6 +1679,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   unsigned int vmid,
 				   struct amdgpu_fence *timedout_fence)
 {
+	bool is_guilty = ring->funcs->is_guilty(ring);
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = ring->me;
 	int r;
@@ -1689,8 +1690,13 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
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
@@ -1734,8 +1740,8 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_mask;
-	int i;
+	u32 inst_mask, tmp_mask;
+	int i, r;
 
 	inst_mask = 1 << ring->me;
 	udelay(50);
@@ -1752,7 +1758,24 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
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
index 2fd72c85cf014..4d72b085b3dd7 100644
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
index 21421f1bd2095..42a25150f83ac 100644
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
index 2cd5f60aef859..4b6a799704f1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1590,7 +1590,11 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
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
index 6210be7e4a52f..b00c63812899d 100644
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
index 244359fa4aacb..6c25e9fc4f0f9 100644
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
index 75c07ebf7fe4b..1e1dd61b774ec 100644
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
index 731f7762c3e0a..9c02446bb1a54 100644
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
index f975994b3ff44..c8924f97cf58a 100644
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
2.50.0

