Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D90C61CE8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFAF10E9A9;
	Thu,  5 Jun 2025 01:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qgT/M5H+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9621710E7F0
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TByqnhUMpNzMbSi3Zu6WC2cuJAGew7KXWASHGvpvJ0fc7/51wPK+tlC5jNKhj8+HcE6hmMrGMM1a8YhU6ULVB5aHnaJPTOs4lRQQRuySHkyDuHPARaX1gblrLVTPLWByKeWNJWLuXa3OepHZINH9fFN1j5eKeC7GtwVqtpp4cAgd06UEq5fasn5DLeXSZIjprjCRu5NQa3SJxHi/66sOJmo9wgwJQrzWgL3dkteqczCRfR14UszIzGWA7EpvVD+odXRhdcYqy2dvSP9QDH9c4OWscRHs/uoUXTRh1YHPEKyA7Y745rCh8Ux9V9K5bWCfhLP3i1Yz3jpvXlIfFm1xVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRWGqshHOaUWZE5XxAUa0iEIKHQEWy2yfilDOI1FvvA=;
 b=mI0PL7TGVb/BJBhPvUSa0KFQwScbj6vV9sj72bCR/njFPBXpLXdyNN59gp/ccmryZyMCogVb3+21h1kb55pa7J9KyT+aR74aRAuzXB/L8MLpjXQjFMuoEfFHagcvAZ2dY5pVKq3FdESSaSg4SWlPu0ZuW2Cs8kiysr3xleVvN5/fLYmhwtzAQtHAXoN8jdk2oAgK4YEDtAvuhDGtqhwA0RXM/FfXHXyqhJtmj/aaSw+7Vb4WNIdOIcjZvLvTzxtEe2nLhiM4Ll5YpJZJDwTGM4sbAXdYgv5YbaPdTR2XAyo1zEnbWaw6XWkBxG/S4MKj+CbSWiBKi8zbAnhWcf7htA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRWGqshHOaUWZE5XxAUa0iEIKHQEWy2yfilDOI1FvvA=;
 b=qgT/M5H+tw+MAUpSJkmxVgtqp2nshi82Epdma4dJK3Apyb3M+EbN52UpRs6ipwpAOcOn8bZZQYFP4zYrg/rTmfhyoBZy4BN8SjPrkj+uVz5n6uQ+uPR2Oxh1gPn+b03H49A3rpwKGPzWWdrKgVEVkqDktHG0nFKQlXbVFisCvzw=
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Thu, 5 Jun
 2025 01:46:30 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::f) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/31] drm/amdgpu/sdma5: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:46 -0400
Message-ID: <20250605014602.5915-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1eef80-67ea-4128-a353-08dda3d2cb29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?66shWN7pGsfHuq01KwaIrATddb3DtDfScmBtRBkZOJ5bYVpF5jEtNB2CAmkB?=
 =?us-ascii?Q?xym4X8MLbvESdoe49ixRyD6lq/EHYYYdSbN5aZBwAt7EpAvgqS1p6rHyTIkJ?=
 =?us-ascii?Q?x6HGI0OgBOGgudSSvJU74c3Pbab0/qZhGK12EvFSUASoILhbDhr2DCXwsFzk?=
 =?us-ascii?Q?U6NBAnTIRcgahsWqJEm45o9F5Tp30IodO80eImxGAAi3pLx1STmiBa0p2HVd?=
 =?us-ascii?Q?hBpjCb7SFkMOQvwe9uuy874jNVsaJZ09ckpei+xIT0a2d4PXezJQqM5F6qVf?=
 =?us-ascii?Q?jiEfvcrZVECNiHeaOOCc1aZxj/I3uglbj0oNpKaecUCRMNOsdQBDH5NFq7Cb?=
 =?us-ascii?Q?77WZdJHGu+MB9lPlAjn9i/UUg2Eh48FQZLNSyVZP7mzgArutVQj/MUH1axTH?=
 =?us-ascii?Q?WXF6PhGttQCNLGYiW7N5VGSkOxCvpaIuKRX3sOFw+LX1UIOHtFAGuzGXcW/w?=
 =?us-ascii?Q?X9n7Cs1puBixEqoOyTibbYGz2zrCdZAbdNrGvI898JSIZu8841Phg6VL1+9P?=
 =?us-ascii?Q?8tK6s8FhFybGDOlK8uNtbx1XHjVET1FBR4EpiS5uXR1/vHapF0k2Z0WUSlbj?=
 =?us-ascii?Q?tLSxLQ0IhlKGT3qPLu3YAG6ojL3EgnKfzaQKiySBW7TxDWRvcHe6ZlLo4uD6?=
 =?us-ascii?Q?vAQ2trkFfvV2AOQsebeHpa/uOPnnPfn/IdpRMmlbBV4ybRw3JfuVMOcgWOuT?=
 =?us-ascii?Q?1ay5ZgpXwet/bZJyvjexn/7Km0gJjP3y7cMby7NegOI3NIeWFg00NbwA1GhI?=
 =?us-ascii?Q?d9N2eeaq8/WwNU+zS/tIYPuly62kDIZX8kFYjqQZgCuEWMYAXqQCoJ8fROpD?=
 =?us-ascii?Q?NMO9J58tt9ooyqI/vhOZ++t7fN2BdpjAu3ZYClH7Vo05bWlbUMKQ9GpbuqVs?=
 =?us-ascii?Q?OYiwLszONx8kJkD5xdZmgur0JmnFLFTgRkGfuVQbwDUEReEIECNQ/ZZG5IgX?=
 =?us-ascii?Q?JpQJOaAKTdB31RRemEWzZeJpSe5PEbvQTtlm8Xt3aQJt3RpicVHIU0fUznYV?=
 =?us-ascii?Q?a3azz7oKs1xWaACFU1ejWa3RHPwsS6/4kyzi0kLbN9GAXh+Ky+F3KUCOYHLj?=
 =?us-ascii?Q?PRYKTSfg00sJpbZXrhVGpKz00MchBw4EoOgRNciGkD7LjzhmLtC8SFU2LLSI?=
 =?us-ascii?Q?yZSdyCO7m0vdQ8DMIcijzZ8wDOPodLaJpGvNsCpxHlD6MSq9mvjYoOlnj5fI?=
 =?us-ascii?Q?uJfnKi4KNma3zVRoKH89w7PTBli4kgloArxwETVPZRI5AhaFx/snepcwRTMp?=
 =?us-ascii?Q?8O2/E0gz2DFD4HonPTuR+zQPBxGDt6nV5R9NHOLV21K2+CZHygJtpkaWbqUa?=
 =?us-ascii?Q?fLv8epFZMR3yx2wxtHNQTXXlFnLGygoYcUwx3ItaFZC2mmxc5wWkM5lJpDPm?=
 =?us-ascii?Q?NnYiabnafFLCVTyEE0tC/w7bVg8xkZrQHweltZAK38VgBO+cAdPdnCxRVR/1?=
 =?us-ascii?Q?78fQFaVKvHkGGMGr10zFFSrau0mlXk4qUEPB57Yq8e3coC7VIx2yq5dELBoW?=
 =?us-ascii?Q?0fxklPtNN7i4N5UUlubX6DDKIayKZ6bpKtsf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:30.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1eef80-67ea-4128-a353-08dda3d2cb29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 43885dc04b632..39352605e3fe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1542,11 +1542,8 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
-	int r;
 
-	r = amdgpu_sdma_reset_engine(adev, inst_id);
-	amdgpu_fence_driver_force_completion(ring);
-	return r;
+	return amdgpu_sdma_reset_engine(adev, inst_id);
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
@@ -1613,7 +1610,9 @@ static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
 
 	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	return r;
+	if (r)
+		return r;
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
-- 
2.49.0

