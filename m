Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55FCC7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DFC10E80A;
	Wed, 25 Jun 2025 21:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jx301s+f";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46E310E7FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0ff0tNh3RtnQ+xnheGj0phFXX48dId8jtMVkMk+c+FA1QYFWVJfWt+HwgQyruIAsNabMIaTyyAgZuAXC38taCrzNhBPXtaC0iOqWKXIdj49O+x4nKswy7OR9O4xMFTUH2vSYXiSDC+YQkdMeb8L26pxuLtGTjXX48dRwNaILpLxo9rplDI/Y6ZhvyZEJPtd9n7TD95k4gmf9f/ZuHueeNTNDQV4k8lo3GmOaw2YXwprjjtCvhnNRiNkARM3NbqcQbFbLHVQyIHCxR4ny2PwcUHMt2AooVQgzbcUL8YpFsmS4B9IDUnBpEqGrU95zqPEagIX4boxpHJoYAlyLwgZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86WAeOPk1JUb2RxrIr9thCiy8o6FauJ2/k1//iZPCz8=;
 b=cvUbcMnbQfJOP6J0kk1UEZvQofgq+WGeOJDMcFPJe4DIle4FDKob8T/i1+TPU3pCogxI+Es3J/m1vngNL7h6N5wM51xMNY5LGGf2/HLso+lL/kWcHi81smqQnFAdMWlky0HgNDcj2+n584NGt3Cuk7a5+Xh42WqxzWc9PSOX7cpmD0belTNAQ5yWZFTWB+uD52nQTDLYKuxj3qO4U21TIwdQHiHW8Afy5q6P9ujgsbbsvTIhXNu7WpiZQu4xi9Xco+RNuc5MUD5pTP00ABeJ7K5TnEV4vlyjl6AJ0iCjGK2+0DowmJ/IlYdsk5Z1N2COZN8d7AWZqlqOkFYkmcM91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86WAeOPk1JUb2RxrIr9thCiy8o6FauJ2/k1//iZPCz8=;
 b=jx301s+f+/qur5FjyJGBjH4qeWKYwccJZwSUYBCyyGNvRoIpJwveGpHg4AI1e4ciPvUWiQMN1vcdiz+UjKd5hhK0vdf5vHd7xIIuvR/iFJ4ZegRGa5/wXYt3wDoPNvWa/4ywEyn4wflXmEz9dVWWlwm9Evl6gUDYBfJxDoeuIlQ=
Received: from BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38) by
 SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 21:07:04 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::e6) by BYAPR01CA0025.outlook.office365.com
 (2603:10b6:a02:80::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/30] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:22 -0400
Message-ID: <20250625210638.422479-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: c80a899e-76ca-4144-d54b-08ddb42c3c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HImcYBfJO3x6CfjEpUvi5nYy5pQlPnt8ucrE+HBv8Q1gbs/JzywHeDeiXp+v?=
 =?us-ascii?Q?mzFNeeQbttoUqy4GVX9aJZJn9gder/zq5+ZJmaGLgxjd0njwDR/xJkDiULYY?=
 =?us-ascii?Q?6NOUNRFjRvSbGdtqC2TiLHv+dxVlNIdQc0JSO97OGK3HtmJBiLvNFFA4g9cu?=
 =?us-ascii?Q?e3TlconToKGHkHpMZnVdE7jzvGcb8/3t77a8H39Jjk7iKcRAkRQTf+Gs6Qfp?=
 =?us-ascii?Q?VTDOk8VtyDgrhTwXVExe5KKk8/jdYsT956e3WUluV+0bYDc4tUTGhpdo3eq6?=
 =?us-ascii?Q?1FXVnfrP/yLTnOcd+spKrHXoGZE2Fb9nTknzxAw600RHvXyAIH8h5rTr4sV8?=
 =?us-ascii?Q?RS7NpD8Cd6LedYnVXmMJu38wyhMQWOxzySmFZi6BWCsCIB1tugSBwzICurnl?=
 =?us-ascii?Q?HOl4mXktw4cqKZ7qoaYLm4wyV8Z8ugsw4KyOzhJPv2B8HI4CXLH0tJYMW+5G?=
 =?us-ascii?Q?aOVq94jm2hhjZVmj5F50Sx8YRV84sLJkLcQzhWisWCfj9ER6gY1n3dx4LGsN?=
 =?us-ascii?Q?6IcV+mOWTMgnz3FvUzkFXLZzR7sEvV7Uw2HEtfCuhjk4uir4wn+SNlvQZB9m?=
 =?us-ascii?Q?ophMIpMTamFOTGVfnzEvkIsJcddmYP8fHasbC0tpGtUUmHY6qw9EOABetps9?=
 =?us-ascii?Q?+NrkY/pWvBMEGqG/JrT2GET3PVYryRdLBtOCzxBZKgEkNxMZwVDxuscRt1b1?=
 =?us-ascii?Q?wAKRKMo4lH52ncffGghpQExaeC+JtY/RBk6Arig4aEYzCZIkHCnW17SBPaCD?=
 =?us-ascii?Q?9z8WTsYCOOTswlD6DvICY8ddV96zbjJjBobdKjSkofbutzOCBSQex5xlbMh4?=
 =?us-ascii?Q?4jRLH++jAuwR4RlRWIGJnn2vQwM3qfO9NxQkyiN6il/IXKXrWqLpw9bBIM+8?=
 =?us-ascii?Q?TNuZjQ69EIzkMYjJ85h+GiKiI7bb4cjdRh6nt2MgSaBsmHA1zPubfmzXCkiY?=
 =?us-ascii?Q?EBp2UCczg6lfaMgoNiZLeRyFEHWfsZGKcfynohionBpJ2iqXUui7d90zbgor?=
 =?us-ascii?Q?ZMR171xHCqnaNHshsOf4eNUcfKTBE4aVP6FBLVQ9eyKHMTS9HQYcvPnglsHW?=
 =?us-ascii?Q?gE/acw9/pbOAsv3/2MwdyJ3uEpa0RDLJK5jwHdvTvFxttbT6eoZSxSeUcyEI?=
 =?us-ascii?Q?6Ty42NrWt2xYm/BhsAyy2+2DLjYx0kPYmTJVFuXALovnDh6JZCMFQpzvZoXX?=
 =?us-ascii?Q?7uPGgJN7zOh1bQsT7N6ahjYn/dWCLCYns+xj4Gody2+7uOtYJh9kUj7c/rgW?=
 =?us-ascii?Q?9fYr8es2giTNsgJkFftKSyCn8qBY40h1gADjD/ivIvumK8eqqn5/QOpXaDIQ?=
 =?us-ascii?Q?4DIKQVD1gHqhaHOjJziIur1NlCmNp/Z60INK9ywTEYYv+MIPoLl5+nUy8mPz?=
 =?us-ascii?Q?a4XvqfOKKrkthcQ8FI62yFnAi3XgI5W6gtRtHyaD+CGYttfZ081JvB7zD/xg?=
 =?us-ascii?Q?T1zlASysEeQ9uRP9c4pVCwPBh9umGmZyrfs0LxhDGsRCoivx3dEyIuXA6rP9?=
 =?us-ascii?Q?yqR9eAhVa2pzjTklB5KMujNx0OmT1GHM2eFX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:04.1717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80a899e-76ca-4144-d54b-08ddb42c3c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 99a080bad2a3d..64322a836ebbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -807,33 +807,27 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
-
-	if (i == adev->sdma.num_instances) {
+	if (ring->me >= adev->sdma.num_instances) {
 		DRM_ERROR("sdma instance not found\n");
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
 
-	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 /**
-- 
2.50.0

