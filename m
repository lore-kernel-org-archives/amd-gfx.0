Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A223C5B556
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2BB10E77A;
	Thu, 29 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gpln2ynk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4F010E221
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QY0p05ZNMSdGpZwpH9rKMLLR3GAURPdJVglXrku33ZgpEzn0EPn+ZxIx2FSF+lLzN0mo5l8UfOKiedHEHUbALDsBMdkHsHA0fAlU+wwBS7TwsHtBCLhjY3/JMtQFyPj2ulUrPygUrq5FpW4lcobZ7J+dh+Qf3X6YD5yRzq+WjisipT1gEMrdmFebBBKpfdT0fe1R0KvqgkHTMT8aiKSVfFQYqCdq4RzGDeKcp4lpeDm/VIqjMGuFexIRviTxO9zVEvvBVHtmxz4cM7238EcnthFt0Z1AzqMwdeF5CkNUB26nwRyurLfnKC4vQSrdNXNlvMKNeVnYFtGP+X6Pb7RsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aV6e5KqeEPYtM4gF27L2majzrDm9G2DAwQsypLyDIw=;
 b=A54In534cpusIOBnHFD1sejiz9GLd1CxFK3bzgPMJlwAgEwZaEU4QKIuDWSgDFDyaq/PH4PSGuJk24fB4JAuCJp78h1QL52YOwIDAc1sOXM8OHdQqXJTqAbiigscsAMpLPwXoCkKM6W0lKBuX5R25c4XgrygR95Yph73GRJVqH4/lq9HHNs6lMWkz2+Q71r1V8/HoO3Eb78FZn0IIyjgEEjH/4Fbk7IKy5TQWJMLgrsNdvaY3oWfwPGu25IngwLfSz3QMaB5lrTu8UPxdEIs0ahg5xFxcQeIYDWBJeZP7WhdN14XMNo3Tbq6yOasj0Cv2XIYuKwkCZG1tbJAXTQcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aV6e5KqeEPYtM4gF27L2majzrDm9G2DAwQsypLyDIw=;
 b=gpln2ynkqltpPFULaHUG3Gh32qc0rRerxbiNORzuDLRsOVR39gJ7rTl1paJTa7lCLDY08gloefIWxSMXYAEIM1oz8eQDNETpot90ABuN+yzREJNYQKEB2EM8QsLMCf8HnbHHTXrTZpnW+U5+3P6/YRVSHKqCXpNPiYjaip5tUGU=
Received: from MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::12)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 20:08:23 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::db) by MW4P220CA0007.outlook.office365.com
 (2603:10b6:303:115::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 20:08:23 +0000
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
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/28] drm/amdgpu: move force completion into ring resets
Date: Thu, 29 May 2025 16:07:36 -0400
Message-ID: <20250529200758.6326-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfb74db-0191-4aaa-80ac-08dd9eec9086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U3ePza6V0x73EOu21h7zf7I5fkkF7/0+uRcs/k59RbnEvS7DZ+p3tbsd/3EK?=
 =?us-ascii?Q?PiRbUvteYeCOIovkov+AfN8ZDqv5ItNmMdvCTgKPJXTPMDkXosqt7mRPC6Zw?=
 =?us-ascii?Q?bxz1Z5pZ0GxcOGZXYyXk4DXSrIo5Fb+yu9Ka6cLWRC9w3oD66lndR8ss/wU5?=
 =?us-ascii?Q?+RC8L3GDPpV4/b1ge6jJH6PH3WLgmFVmPu9bJTgX5nw5JwcA5vSU83CyPFOK?=
 =?us-ascii?Q?CFTLgtzljJ4grKnKXdE6HUPGK1BhgfjRPx690pSWMzmrj7+Xt82v0SRNtgbv?=
 =?us-ascii?Q?kC0yfK2LRLL3+PDhrp9ZuW/cFkg0s5jknVsPuqWyoQYHj52w6yvqRI8EVo+r?=
 =?us-ascii?Q?caoUzrFQi+0g4w7mQT42xxA7bNYRV/RSBXpgKCsQg45mDtBaKCxnc2JRXaaW?=
 =?us-ascii?Q?V0nztSpiAL8CApu3NQ53HAi4qOykkInpRODLJ9G86VBJQo6p9YTTpz+zFoFn?=
 =?us-ascii?Q?UoxOl0P7FAzTcHvnoeFA1wwPu+MsZZGwaHHxtBxDkd0opiszs+G/9Zwd1dyd?=
 =?us-ascii?Q?6XKIVQpYlZCUzXK5cCstoQHnvPdOC+OGjaDcSWocpJg+u9l4K8k4q010Z8eX?=
 =?us-ascii?Q?0fvNcpZH0gJJaYOaQ4uvS+B96heY0UpHoHeKHyv634zSv17nmtzGPaiy1nk7?=
 =?us-ascii?Q?dvgSxbNQXnHS9s1hYCWfkQHH/ktXNc+Qk0w97CBrh9+zE21T44+tuHPnA+v5?=
 =?us-ascii?Q?mjUhluiiKg5MKIothyqG3p3wYBU5uvDKmkgfRt/1ZrPTQGxVAfc5/Cz/00iW?=
 =?us-ascii?Q?ndYljfsLZNyYxbbHdldugrsNI0J050FBN4Pq37GyUoarGgu/cIa71ZTl5CSF?=
 =?us-ascii?Q?2az+YmD3EyxReaDGUGvl1n87fBu7wLREgYC/qv+222qDN9x41+lWn/AT7m3Z?=
 =?us-ascii?Q?2TdeUCkQL4MHBm+HwmcPUjgNCmyI/qfqjV0JWcOgcwmbsz/sa7Nq3nS0yIF5?=
 =?us-ascii?Q?2ag0dldnhH8K5/oU43GiPzwTUKDDsN9zhijGavBfpNTVKkUAsSib/oeoHmsA?=
 =?us-ascii?Q?GHfVML+0QpcUDK1de4OI99YAduqqZMVOxU9caInIHQFkuCqoLWCTvR+0UeoB?=
 =?us-ascii?Q?U7iKuXiyPGCd1remx4DcJDA5TNvV5bGfic0TYSEt9ZC+3LrSQ+FNZru4vt5x?=
 =?us-ascii?Q?PMiHXl5AEqkIxO1or1vLqf6hSyujuBNwKK+CG8bdhxhFjYexUTKllG0DRHco?=
 =?us-ascii?Q?pLWnL0b0O95B8Y03wWRHWMRMgfo7pj8PhNLlwog6QFf0DA38euvTyVid30kV?=
 =?us-ascii?Q?lY+QCUJnLE+ZtKvhVCU8dhWW0OzRxnOVoaZsnyecn4+AkawfzJNE4YCuOGjA?=
 =?us-ascii?Q?jHxmVLLLjj0nGreMqzC8//ofLSkRTio64wP0Cm62BBZFSYA2a+Kr2ggKyheJ?=
 =?us-ascii?Q?UbPn+Hxvrow4aLdHDCwimxtnkpVaASyhYHEnQNmPQt0aWGlUnHw8AilAkB0M?=
 =?us-ascii?Q?+niA2qZozdBwzhNk7k8D+QvQuSkJ05gBSCRTxu9NGnWW7+Quu0tlVdBoixzA?=
 =?us-ascii?Q?8KqOskRhylnhiwS9FFx52kVoB5Qf4P/HpY0s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:22.9426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfb74db-0191-4aaa-80ac-08dd9eec9086
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 6 +-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 5 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 1 +
 16 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 0b9086a747c0a..a0fab947143b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -159,12 +159,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
-			if (is_guilty) {
+			if (is_guilty)
 				atomic_inc(&ring->adev->gpu_reset_counter);
-				if ((ring->funcs->type != AMDGPU_RING_TYPE_GFX) &&
-				    (ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE))
-					amdgpu_fence_driver_force_completion(ring);
-			}
 			drm_sched_wqueue_start(&ring->sched);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 4cde8a8bcc837..336ca44950dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,6 +768,7 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
+	amdgpu_fence_driver_force_completion(ring);
 	return amdgpu_ring_test_helper(ring);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 8b39e114f3be1..72d739e38a8ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -647,6 +647,7 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
+	amdgpu_fence_driver_force_completion(ring);
 	return amdgpu_ring_test_helper(ring);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 2f8510c2986b9..7974d04c15e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,6 +559,7 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
+	amdgpu_fence_driver_force_completion(ring);
 	return amdgpu_ring_test_helper(ring);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index f17ec5414fd69..9301d0ff2593b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -727,6 +727,7 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
+	amdgpu_fence_driver_force_completion(ring);
 	return amdgpu_ring_test_helper(ring);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 79e342d5ab28d..ef5075e111300 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1150,6 +1150,7 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
+	amdgpu_fence_driver_force_completion(ring);
 	return amdgpu_ring_test_helper(ring);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 3b6f65a256464..858b930d1dd54 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -841,6 +841,7 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
+	amdgpu_fence_driver_force_completion(ring);
 	return amdgpu_ring_test_helper(ring);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c169112a5e7b..eb78bf04a490b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1670,6 +1670,7 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool is_guilty = ring->funcs->is_guilty(ring);
 	u32 id = GET_INST(SDMA0, ring->me);
 	int r;
 
@@ -1680,6 +1681,9 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	r = amdgpu_sdma_reset_engine(adev, id);
 	amdgpu_amdkfd_resume(adev, false);
 
+	if (is_guilty)
+		amdgpu_fence_driver_force_completion(ring);
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9505ae96fbecc..43885dc04b632 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1542,8 +1542,11 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	int r;
 
-	return amdgpu_sdma_reset_engine(adev, inst_id);
+	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	amdgpu_fence_driver_force_completion(ring);
+	return r;
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a6e612b4a8928..ee94e457ee25d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1455,8 +1455,11 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	int r;
 
-	return amdgpu_sdma_reset_engine(adev, inst_id);
+	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	amdgpu_fence_driver_force_completion(ring);
+	return r;
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 5a70ae17be04e..86ef0e30a89e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1559,6 +1559,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
+	amdgpu_fence_driver_force_completion(ring);
 	return sdma_v6_0_gfx_resume_instance(adev, i, true);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index befe013b11a78..c9993424b3923 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -823,6 +823,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
+	amdgpu_fence_driver_force_completion(ring);
 	return sdma_v7_0_gfx_resume_instance(adev, i, true);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b5071f77f78d2..f1ccc6c7be390 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1977,6 +1977,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
+	amdgpu_fence_driver_force_completion(ring);
 
 	return amdgpu_ring_test_helper(ring);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5a33140f57235..6ef5944584e56 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1620,9 +1620,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	r = amdgpu_ring_test_helper(ring);
-
-	return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return amdgpu_ring_test_helper(ring);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 16ade84facc78..1c13ceb3bed8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1475,6 +1475,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
+	amdgpu_fence_driver_force_completion(ring);
 
 	return amdgpu_ring_test_helper(ring);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index f8e3f0b882da5..a998708bc0745 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1202,6 +1202,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
+	amdgpu_fence_driver_force_completion(ring);
 
 	return amdgpu_ring_test_helper(ring);
 }
-- 
2.49.0

