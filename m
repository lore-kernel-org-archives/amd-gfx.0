Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5ACC77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D16910E40E;
	Mon, 23 Jun 2025 16:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XT7LGhU5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C0310E409
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnZWxUa6PXSKYaqvAg9gA2MaMkKs3sZpFIHGt5UN+C9RcQJl0VBncSqoMskUbAYfEBO511hIYZxt5+uFBuxLXAjWtQef+ssJIkdsfoMwDCDNabgWM4QQzLeDuWrc6GWSbXjihbiUtarKsnGRQhDogKoL5R+V3GtD+rHi0YN9ds04QhV5Tr4MP8kb9GieaEys0Yes1IA4Y+GFFc5aaK0S/Yo6oHG4B2UfqZ1JcHSVc39xg+nVKpYCPr2N3i/zhOUp19E1TJ1RHCLa2c6Dl8C0eUuY/B5bRAUUEndjqySp9zfj1E90xWtGWT1QZPfT83kUp3BRU6Ghq6Q2ZiZm1bEGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds0lEE2ipGj76GFu9yr6712sxQsYM+7zDKmnaRk05RE=;
 b=J3bYQ5vNJPslgQaXIVHBItwkThg4M7s2gAxO8hosaC4be8o7uNm23QTu7IGXzqITMREhSIOKddYNOVLoJc/ObROb2A5aBiuEmbhx8FmabaAy1JTbMWgSRHT9ASH4WRo/v3I1GKB79CxPc901Unywo1cLZxjeUWzTlFJ1TOjvrZhrM9hAN29cCip346c5EdB39Dqr0MpVie454D4IWydrRxq0+TrhyIuUnmwbS3j0bo5di/1bWKc1yMR4c0HRxP/Zae8ps3GbNuSyJjUyNRnTlqbV4qnCv2HLhKXPnMPP3B7/b2/kt1BIVUPZtvRKN6QQIZIWnX7ObjCYJwhg1Ua0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds0lEE2ipGj76GFu9yr6712sxQsYM+7zDKmnaRk05RE=;
 b=XT7LGhU5Q4a4pBVNbQJTxOT/U/Gc1WPqEz+w8LE4UokNzCRlSKqtZVfeYm5mjOmgvnS/r2JAClS8Yw6+F7m9OAyr7PFIjaV+4M5nFxqf4FD+0OzLs2eQqgha8WAdy8DoHyTww9Mr6C5se4r86rzmbehUQwt2MYqvKaXB6SiOoPw=
Received: from BN9PR03CA0078.namprd03.prod.outlook.com (2603:10b6:408:fc::23)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 16:15:00 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::cc) by BN9PR03CA0078.outlook.office365.com
 (2603:10b6:408:fc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.29 via Frontend Transport; Mon,
 23 Jun 2025 16:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:14:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/31] drm/amdgpu: move force completion into ring resets
Date: Mon, 23 Jun 2025 12:14:11 -0400
Message-ID: <20250623161438.124020-6-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SN7PR12MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e02e246-2083-4429-84fd-08ddb2711a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVl5Q1ljQzdZNUloYzhMR3pQaUR0TjNkS3JGam9PZWxBM3FqZ0IxbFFnQmhO?=
 =?utf-8?B?ZmoxL0R3aU41b1lYWWdzT0VPZUk4MCt5SWRtcEpNdXlJNHJsN1JtYXZCN1dP?=
 =?utf-8?B?QzdNcUlTZmpPLzAwSnBkbUtWMldGRHVidmFkS3RlWTFNQ3kvR0ptV1B3MUVT?=
 =?utf-8?B?THduaHVqWjJFRVRWWXJBMk51QzJHTjFacktreThQOHY0QmFLZEFJcGZzOHFD?=
 =?utf-8?B?enZaam1BY1J6VkVWMTUyQlFHbG5qZEd3V2cwcmw5TnBZRlBZdmhnUURSL0ta?=
 =?utf-8?B?aGNacHRMUm9YWVJmZTFxL0FaQlhDT3dwemVjRTMwcGdoMlltaTZocVg4K3lv?=
 =?utf-8?B?UUorVFVQTEpmYWF2NWhGNEhKSmJLSVFDY0JrT05tQ0FDckNBZk9oTHZNY1lR?=
 =?utf-8?B?RlVscm5DbmprRWhzZmh6V2RhL3llcEZsZWZxeW54ZDhaYUFMRVlucFN1MWYv?=
 =?utf-8?B?ZnJjU0d4T3RhazlZbVUxcTFrYjk0OEhEZHRLNjEzMVVUeG4rS2VFOGdhcGVr?=
 =?utf-8?B?R2F6aVJ2OUVnUHJ3elJ3OXBBRnh0eklkNnBJbFBEVk5HT2tLM3BKRWhKTmtH?=
 =?utf-8?B?RHVDY29XVTJtV1pZRjhKRnNqQmVaR1J6YStmVlFEYmdEcS95SER2NFNGVmN4?=
 =?utf-8?B?UU5idW94K1ZWTnNYRi9FVnN5aG9qbzRRUWl3QjVDc045VG9Ta1dqUVR6Sm94?=
 =?utf-8?B?UFpwbEY4TTFicCtIWjNJWWFlcGJCZ2M3SUxMM0RtcG1IRlJYTEJmc2pKSU1R?=
 =?utf-8?B?ZysxbmR1RkJIWWZvdW90YVdUaEhvdm1rMXorYStGYS92a08wanRWRmlwd0hy?=
 =?utf-8?B?ZEtuU2drbGoyb3NhVU84YXBqZEhQM01CVTgwUTVGeno0S2M2ZmVRaDd6YmV6?=
 =?utf-8?B?anhNcm54VGxMZlhQWTNqR2E1cCtKM3JYM3VrblRWSGRDcm0zdmRYRTVzMURY?=
 =?utf-8?B?NzhxNDhtMUM3ZE8xa2dRN2FKOStTSHl2akl1d0M3a215R2M3QkxkaHJJVHNK?=
 =?utf-8?B?OFI1c1NQUnhBZFVNem45QnFNSGVKaUY3RkdLQ1JPVUIxYzRWY1c3TkNBQTNU?=
 =?utf-8?B?cGx1YWwrVkp5TFVDYnc5STFoSVN0N0FXMDhFU0dyS0xxcFF3YWkxMzAvekp2?=
 =?utf-8?B?UmRTdVNubVhWcFhxaVBOQW9uZFhiSGVQNnF6Qm1tUnFqR0pEeFliaFBXOWI5?=
 =?utf-8?B?MzFoK3IyT0JGTjdrQ1pJWFNhVzR4cytKZUgrUVFNYmJrK1dhR3V1VzhzbEpI?=
 =?utf-8?B?azlLS2YvMGZvMzJDcGVpcHRLcG9Sd3grSExYOFp4UmZYOVo4Z2pWWDd3NEZw?=
 =?utf-8?B?OHVXcEFERk5DNk1CWGNYc1JPa1dyTlY2SVBkWkN5WjZpbjBQWHNNZE1uTWQx?=
 =?utf-8?B?OVZJWFNCU1I4ekU3YUVtbTcwditjajcyM2lmTnFrVmREVVdCdmltYm9zbGZI?=
 =?utf-8?B?Vm9NcitsUGhVbUlqZzJBY3lmZ0dWVjFzRk02ZnNvNlA3RHNyK0V6a1Y1c1Ir?=
 =?utf-8?B?SVlBcnJTOWpZYnRmb3ViSDZQYnVIc0N0VnhXSlZTMWhvQ3FsSU1pK3R6aVlH?=
 =?utf-8?B?cGJRRW1DL2FSa3F5WjVOL0hoazBuM3Z4azY0enhjamU0NHFnbWpZMEZTWWtX?=
 =?utf-8?B?MW5Jd1NIQnVOYlV0Y3BlMDlFYzR4K3AzYkZtbmxMMTlFVEhaczdYZnVRZ3hw?=
 =?utf-8?B?WUx5c3VBSEtMUlh2S0N2OTZoSUZmQWFFRmhHQThXWFRwQ05GQU5WKzNUNEZk?=
 =?utf-8?B?T0I3aWpPK1ZKQVlQMDBoZHJsMDJpYnlaWXJ2VWZCbEdYbWl6cGZZVlV5aExi?=
 =?utf-8?B?YjMwc0hQdDkyK1pSbkV6NmZsdTZnOURTMStma2JWamU2eXB3Vnd6MWI1Yjdw?=
 =?utf-8?B?ZmNvbWs5QlpjbFIwdVNTT3grMWlSV2lUbTJVS0wwSjhJK1RIN2pObXQyRUxa?=
 =?utf-8?B?RmhrYm1LVTZ1NDBQRlJNMG5kMjFqMEl0allBZDVyS2dpWmtNZGV4cm9kME5U?=
 =?utf-8?B?aDloYTR4bjh1T3lFUVE5c216YS8xODZra29pMnlHYkQ0N2VnRWlYMWczZC8y?=
 =?utf-8?Q?7o+Oqh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:00.2654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e02e246-2083-4429-84fd-08ddb2711a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818
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
index a54b2b7f04b20..d34c20202bd1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1678,6 +1678,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   unsigned int vmid,
 				   struct amdgpu_fence *timedout_fence)
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
index 8684529166160..0c8707b18b5cc 100644
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
index 56f0a404c8e35..341695d0afb52 100644
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
2.49.0

