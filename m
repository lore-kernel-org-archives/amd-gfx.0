Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C390C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 02:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFE010FEA9;
	Wed, 24 Apr 2024 02:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pmdorjqf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFBB10FEA9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 02:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbSoeOQv16Cp7S2h/LbTpnNkBQ6qJxoa8MxCiF/+m3+/GzYPediUlTyrh82f693m8a3zIDvRHjb/kN43+iz9tqWJLV6tPK5i6pwIYs/k6ida7hdcIn171pVOxZcSUcca78LN3j3os1tOPWhMsd2gPLEYXnd+0KTOMEgLSIW2uPUJjTGzs8oYxIjW/Z5lyB+dCLjThAaGAfWmuX8z3rlJ0nq0y/CkCRiAJ2uYkyAzwVJ7CP5okTfdAzP0ls4OVG4eqjSikMZV9lOn3cjBZGaim8bjOUIHbt/dT2cIyyJy60qWj+LLqQCQ1FAES/5sscBkPVzug4TB4nHLFnErYamGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ3LF0AJw68dmKmSFp+wjh/N8RP08Ixt63nEo3rLO+w=;
 b=Pj49kLFMZ1asjGThgtahVSoNoeZbulhTgBZhSyDa+SDVKTLv4BxbPXyKuB3KrtlUM5BeGSi/F5iTKHiZKoBpo8N6RTo1fyY1GS7HEvjOIovEPizV3ceuO8IgtXJJ1o0yhPd+aukqTB6v3o1bu6b/ZCkCUrC8My/ixXkQHebsUMbo3OLCwXThKnH1T5zfgFY6Si3ByEL10Kba/NuVk3VF4A+OXBleF7ds5XU1sIR1OxQFdlDRsKtTKKWutQ45/6SCji1XbmYeJTLhqdBsS4DhGB0nsm9ggQ/QVGmths9gg+FOQvA5m+OSgVXTt61swIO2FZGsA39EvophtUoaLBYSgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ3LF0AJw68dmKmSFp+wjh/N8RP08Ixt63nEo3rLO+w=;
 b=PmdorjqfBDB8NKWs3ARE5v20+p5dPJ+XUUY6RQUrQNVf+X3J8ZRRzbTcn+Z+VJb7eau6JOZONGyycR67LXMlvI+WiQyzAHQqDTQkxcRFhrrLMzM0Flrk669bj0Y9+WxR+I7ReMdvmyzP8R6BS+QI9O3YIjo0QzT/qSZ0ej+2sPw=
Received: from BN9PR03CA0599.namprd03.prod.outlook.com (2603:10b6:408:10d::34)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 02:49:26 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::2f) by BN9PR03CA0599.outlook.office365.com
 (2603:10b6:408:10d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 02:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 24 Apr 2024 02:49:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 21:49:21 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 21:49:15 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <tim.huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add check before free wb entry
Date: Wed, 24 Apr 2024 10:49:14 +0800
Message-ID: <20240424024914.727436-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 024d0d3e-1ea4-4e28-5487-08dc640927b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YtBx/CppeZGU35pRJ1a2xvA5WMWJgxZXISqWqH8t0ucpGq7MSCw/v2fqGkti?=
 =?us-ascii?Q?6pPU58e0bFBDZlIiWDJKWcu47NAB7/mUZMGA52I4+dD33dkHUHpmYW70AYn6?=
 =?us-ascii?Q?E03azgYUbjhrYecwh8u9NZvjCEd0ks3WpKBLwtHkPs9g98U97Lh3+KiR52P8?=
 =?us-ascii?Q?aEk2V+JIoqOG+arR0oi8m7g/MwJDfE3IBuKDR/Z+zu3uXnpysFJe6IMlupAL?=
 =?us-ascii?Q?hbSPZ/vwcpmcVoJy9RIcgLk+/oYqgXCo0fVvRbuUZO4PUcx1e0LSxcjD61ZE?=
 =?us-ascii?Q?7P1K5y6tAXSsEj92wfLjJzY76r6wl3JN25E0vS+yA9vk68/vDluqJjSyktLE?=
 =?us-ascii?Q?W/rxFkLKnPuSc1maOKSofz2J4YQUYFc7Z9baWE+aXgskCi54AdIpZJNmzDTj?=
 =?us-ascii?Q?s2+UT5G2e4aBu4y/SWUQdnhP43Bka/JCPbmxsJQNf+ei/gn2DOcc0sD96Y2j?=
 =?us-ascii?Q?Apyef3uM1wKERXyMX4x7JM+9Ia/4bya+0G9+8feX+7qR6tEM2lIRnIGsZe5c?=
 =?us-ascii?Q?gXVr+5FNdI6pZiq/1UqrQ8W2/hHHo2TAO1o//XDudDkYTgeet1VTT7KrhrGF?=
 =?us-ascii?Q?X3KwSBXJtZgbeXgaM2j09q9bHQAHgnx8E6XXWQ21p1OOsjF2H6yCs6/xY6zQ?=
 =?us-ascii?Q?oBApJvy49FljmmGj320I/6xlHRlkWhY4d0B/YlRmVcKowosFzRDxJsiQIMQX?=
 =?us-ascii?Q?YqOd5R3kEICvjgLT/u6px/N+34k8DwFFHl+IDOFbKSE2UOkkz38l/yp6udN/?=
 =?us-ascii?Q?OLIey273xerfQExYUz1xztFYb3iSVLc2oDl/yeC2p0artSonPsbuSfYVtjKi?=
 =?us-ascii?Q?/sMipJC6OToLXptMuvsR2Y2ncujd9/7Rbo1Fi1yXMoPPWpC75zMUbbktESET?=
 =?us-ascii?Q?jEfaidHTzBfyT4v+MUa1Rdbr51WRuvKyAwR7FbhHQFleO7/oO+/DxGKx3pSd?=
 =?us-ascii?Q?Dn+s/TMzgC68PajmSCXfCaERcRRWzGtkHxlRVVODjyUPJ18/adF4K/pf8th0?=
 =?us-ascii?Q?/6NMbbQigUaMQ+/w/LRL7ZgTGL+VKRiGJX2iVKnR7KRvDcMpYdeBERzGbGVb?=
 =?us-ascii?Q?4655NBAGqeQw3HRv5DI9IALeFHy2ik/B3GKiMvW6AKjyuZ1gozcicw3+svGh?=
 =?us-ascii?Q?CfxiX8WEf+7P80lMyhkVEZt+qKR7bvXnRN9HP6b2X5ONSL3/WZvHWG2L13HB?=
 =?us-ascii?Q?TRvDsxVFtFKct4aSvAJWBEGRHSBFyiOmdaz1LGVxdjlpNQStV2vlWHfouEst?=
 =?us-ascii?Q?+7mou/V38VGCddwkR+czBqcVNX3YGcgVa3STWtNST6RCuYB/e2VjxSqPMZ8u?=
 =?us-ascii?Q?NDDeacyV/SHJT6Qqp9O7y+/wvVHEUqs+wzDWbIdcvQVmYl3VsGo10PAILZk4?=
 =?us-ascii?Q?YYgSlcUZNqv+tTD+LOj4cmZrG9Je?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 02:49:26.3264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024d0d3e-1ea4-4e28-5487-08dc640927b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
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

From: Jesse Zhang <jesse.zhang@amd.com>

check if ring is not mes queue before free wb entry.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 45a2d0a5a2d7..b7d33d78bce0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -999,7 +999,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 20);
 	if (r) {
 		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		if (!ring->is_mes_queue)
+			amdgpu_device_wb_free(adev, index);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 43e64b2da575..cc9e961f0078 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -839,7 +839,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 20);
 	if (r) {
 		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		if (!ring->is_mes_queue)
+			amdgpu_device_wb_free(adev, index);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 1f4877195213..c833b6b8373b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -861,7 +861,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
 		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		if (!ring->is_mes_queue)
+			amdgpu_device_wb_free(adev, index);
 		return r;
 	}
 
-- 
2.25.1

