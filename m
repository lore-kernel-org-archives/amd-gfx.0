Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAA5C5B549
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BABC10E84D;
	Thu,  5 Jun 2025 01:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hTpfcvOO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AE510E7C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiSjJjf3nv6zimXxlGXDaQxxBSYa0Cas53CMLq6Q3GITNITBxkTJdLlKV2M0AS0PY4DbkBWeLER2ZUQfTmGU/CNlE2XMu2PNnh8O+4SE1Ovh2FkOrfjERYaRToIiqLX/XoepDtenOr+oQu09UN+mbCv1CKZM8wAUOh5JNqCnq8kQu3bQjZARTc76pHhgBhNLIFflKxZ0v3GiJDmwJkA3BONigLKsKLKexXmfodVwF/EZaoJ3NLfhXosCb/8MSRONj92lTSd/YFFVpOfqHnO6mf0utWUAChF3Y4PFnEqS4cFUFYiq2DLGx4YgfogBlZHw1xj0Nl9yGNXXIGo/gUV+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CaLfERH8gifILkdxVxO8Us2q1cjeBRgabMT2wr+Rvk=;
 b=B6KbtxO8Pctokld/YQR2YG58elSu3kRuPQ8wgNfCJ2q+KxnoJJk2+lxf5n6224HFgApNPRLvDPwaK0Qxa434suvNAU2LCwJEAF5hVKl5eqcdjcWpNy2OApAVUzfJETE1ArAhsnB2kigY3j1cE29/l7bnszmI3O0wel/VnSTd/XN93zTMnvi462JyWTJ6BTH4GYIXbpGLCzH7IKKsA39IqOgy0yYtLL6V67eLD3BnNv9sM0wk0RAdg/JTLjZyJ2n0UkZ6IdIHt/vfdhQSKCmwqY0zKKvuaFYcfY4N4jMwr1Kj/LNnHNfoDIzhh+UOI9BUgIq8YiZdMhZBCEIAzNRTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CaLfERH8gifILkdxVxO8Us2q1cjeBRgabMT2wr+Rvk=;
 b=hTpfcvOO4YgG6ciooodkUr7JS9KE/Is/W95IILXFHc8aYjnya/AXxLkR4NJ8wnI00p4l4WTi14P0Hh8rGhHXieFXgN4d8buIheFSkMo4YxN5kINMEYXrcivAZCHCfz7Xo/ayD0W+rANw94ZNaMC7+DVR1g00pka87ZVELsonlKc=
Received: from SJ0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:a03:39e::17)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:25 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::12) by SJ0PR03CA0282.outlook.office365.com
 (2603:10b6:a03:39e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 5 Jun 2025 01:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/31] drm/amdgpu: move force completion into ring resets
Date: Wed, 4 Jun 2025 21:45:37 -0400
Message-ID: <20250605014602.5915-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b8a3ad-bbf5-49be-e07f-08dda3d2c84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ky9mQzFLcWpaZWhuZU9oR3puWDRkVFNDSUhYRDg5VE1MUG9vNzJ5Wi9yUTdq?=
 =?utf-8?B?QVdaUnh5T3EzT2hmR29TOUx5WVdqQ3JjZTcxK1F5RzM1c3Y2bkNxb3p0b0dy?=
 =?utf-8?B?VHk3VG9pdUE5ejRTUFU1ZUZLWlFnZzRPeGdKN21tQUUvdzdxdkFzMnFsb0NQ?=
 =?utf-8?B?cjJmYUVDMVdkajdDL1plb3pUY1hOVW9qcnY2Q1VBMU5jU3E0RFg1UHVFSmoy?=
 =?utf-8?B?OWVodlhmZUhlaGxVQXVSY01rZmhyUk9ZRnVDZzVSc0dRZUdRYkViNkpWbzhE?=
 =?utf-8?B?MGRsY2dwOW1rUGtOcFpkQVlpQUhiM0xjOVAwVXVoRVdZZDYxYk56Z01LSUJs?=
 =?utf-8?B?SzVDeVVCU3JMSGFvYklKOFZrUGJJSngwRkxVZXdPRm9EOXRnZ2NMNU9wUWxJ?=
 =?utf-8?B?UjR2dmJBeGtvd1VkcUEzTTBtc0MwcnBBRHdrMGlBVitiRm1FQTJhUVpqU3Ft?=
 =?utf-8?B?S2pMZTZqWHRjL1IxZEQ1VVlLWmE2dnJiaHB4YkxzSk5CSzhiVS9ZQ0xBUnRn?=
 =?utf-8?B?d3FKZ0J0SHZBOFc4OVFmL0hQRGdMMkd6STBRSExvT2l6YjlEZTZsV2JWVkM5?=
 =?utf-8?B?ZDlkNk9rTzRaNmFtdFA5YnJwVExnS1VCdWtYT01ldk40Mzc4M0F5am1GNFdN?=
 =?utf-8?B?Z0JpZS8wSklKRmNrZ1BneDBBaG4xbFBTZTM5ZHVtS1FKblN3Z2VPTGN4cytt?=
 =?utf-8?B?L0pZWkk3V2tZemh6bFNyS2JkVXE3WjZqd0FxaGRBb28vNit2ckprN2p0YS8y?=
 =?utf-8?B?OSszQ21WcW1nb29oemZEdFoxeDBTZFBlVXdkeVNpL2VaeVBtMEdHS2U2aVpU?=
 =?utf-8?B?dk9YQWY4M0dvN1lUVzRiQWMrOEZmTTFtdkx0MVZpa3dqUytkUjcxUm9PZVFJ?=
 =?utf-8?B?STI2anptbERCNEczN2lkNVRZU3NPZkNuVzR0Z2R6SHJFa05lOGl3dWFnaWZQ?=
 =?utf-8?B?a2M4Qm5yaEZKcC9KWTNHb1BpeHUrVWFKYUlja1FqSHhLYmNEa0F3VzVCa3F4?=
 =?utf-8?B?QUlHWmFrdUFJTU40dUlNeW0vd3lxUFVmODNUWmgzTnZLZUxEcitpcEY2SkZm?=
 =?utf-8?B?Ynd3STJodnNwUXFxR1JFc3dDOTU3RitJaUk1SXRMeVdIL1hWY2VkTDZrS3Vz?=
 =?utf-8?B?ZDhvNkwwektwVk4yNG1kSkNrZC8yL2lCcStNVVpTMm9jcjk1QjNvOXNoV2Yy?=
 =?utf-8?B?cFd4OFk4ZWRpTzBFOXZjT1hMZllnNVdNNHlmR2dZckNsVmlJbzd5S0JYVkVX?=
 =?utf-8?B?Zk5OMy9ZY2ZVdTJBWEE1UTRYdjlXamo2THhiR2phN0ZVSjlOc01ESEpEQXpC?=
 =?utf-8?B?WHVzUlZnQmo5Ym10a1o2NGFxd0h3M3hhbDlzRGk5ekZURThlbDVqN283N3BT?=
 =?utf-8?B?dmRJT241alNwT0RjMzgxVXA1ZVVJRERyV3JncWtic3N2VmNUYWZzYlJlT0xO?=
 =?utf-8?B?ZnFWWldZSTBFdlBaTE0xQXBiRFF4NzRIaFZpMnF4MG5iSnRFWGZVYTJCS1RU?=
 =?utf-8?B?KzI0THdnank2Qm9HZXpiakZIbWo1Rzl3NVNTY0VtRFdaV2NQNXRSaG1QWWlk?=
 =?utf-8?B?cklHL0FXQk1oZ1g0VnZHUStNeGtoMU5mQWNhc045ZzdIazFJR2xOaUZ2MmFT?=
 =?utf-8?B?M29kUHBJdHpteEkxdUdQT253bzMzem9XMWU5c29SaGFNSDk5bE1QVEY1cDRW?=
 =?utf-8?B?UGFPRE9jeUNNUUc0ZWVmbXQ3RHp2NUhKZmgwQWdQZDI1TitSV1pQaUxjZC9p?=
 =?utf-8?B?bWVlRzdKcDdoS3lLT3BhTlVnVTBnRWVKL3NSaTBYRzNObTdQcng5TVBlUDJR?=
 =?utf-8?B?THZCNHhJWTVpaEZJWU8xSWFlSGd1K2hBd2ZyWWMyaGRoWnduV2J2dS9ZSytU?=
 =?utf-8?B?dDdZbzNoUnNHZHllMHZIWWRMT3VJdWJFWVgwRi9DVytod0dLdVFwRnVzWTdB?=
 =?utf-8?B?SGVZWk8xZ041cDh2bmRmY2F0YXFYVGFISGhkRTdIN2RaaVBJQnE3dTZxWW0v?=
 =?utf-8?B?U0loRTZIWmpZV05UdkNsUmxKaFBQVlNYN0NjWlVDMlVQSllNOUFPbmgxVGdS?=
 =?utf-8?Q?XQm4kS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:25.4556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b8a3ad-bbf5-49be-e07f-08dda3d2c84a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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
index 821f88b64f3f6..23b6a0fc0c691 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -161,12 +161,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
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
index ad47d0bdf7775..25cec4de13131 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -824,6 +824,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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

