Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC375C28B27
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C0710EA7A;
	Thu,  6 Mar 2025 18:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vOdX42Dg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CD510EA72
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdXC7rWlpAfuWqUeJmSYo/Jv3rOlfagFxLoaBlGfLfxhhjeBh7++y9gZLdEId6uMNTl8/04quKQeenn8Ot6LCLYRVCH/Wi5xDFj06HS8kkagk+mqOGUyk1snra3RaD3EpzD6tnJKosNYgRCaYa8CT7kxgo0Xorfi//LAHKIhp6NtFQCnITZbNm1D8tYLAfuqiaDynIrwWcphTAfAzdftkKj+M2yn9Z8rk2hkrjUjgnIdEJLyrY0tJJrvOGIrkoTHuRUrcp8RWGQgk26AWPkDYTXktywKvgX7ITzTkj0WN9XrNnb51E5hCJC9294RqHObxOUrz9qOulj4guas2NRhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2xCmy7bzHw2E13wYpn1vjdkdEJKwxcfIGciKPHxdSY=;
 b=yycsWq9XQ9GYhdOD6AK9G6Npxq+xpZVL+ctM8yetSq/z0LVWTiIEys/QuEzAnoUaIJALe3Q3vMV68gxLBeglWnygthmtSDx9thwZgoZSDVfDPB6HpYTULNE87tp7pG3An9BtN+82T/tfSLQMlMV4OlegtGFoP0vYtN5M62ErlED2vP9F6JmbHNlqoyPJxrvc6fTj8KZ1j8bNC6c13Cg4hgaVMhHOOmOIQGp+e7xCvvfjOjap9UUTclwRDEsKBJa1mq/z+eIHzpGEn+8ooZPyHEyLZ0ItNtzS3OjpxLwXEweeoViZeFWkqlProZhxQ68B7QBjimkIyC+zSDkhEYZ4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2xCmy7bzHw2E13wYpn1vjdkdEJKwxcfIGciKPHxdSY=;
 b=vOdX42Dg5ovWchqMHRymu8+MaiJdIpkWgwIN9AFHqWrC/dPBB1z3vE/L2Ra5316T+zquuFzfbZd8MQGsY1A0bheDAO9henCwOJO/fz35NQnEs3s59vKzbukhCGZAmJ7jGDMVd1eNHRwJRPHLjxzuDyUFR0c/f5fry0Lsp1YTsPg=
Received: from MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 18:46:32 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::3) by MN2PR01CA0057.outlook.office365.com
 (2603:10b6:208:23f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 18:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/11] drm/amdgpu/gfx12: add support for disable_kq
Date: Thu, 6 Mar 2025 13:46:08 -0500
Message-ID: <20250306184612.8910-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dac505c-bbf3-40bf-71e7-08dd5cdf36bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HBc0VTqZsILLpXACfmXNZJNIQ5Ci7R3WfzRwB0TFdoJWX4m8PUvP6EVnpSBp?=
 =?us-ascii?Q?PVKOfece242CNLdaer+7mFZrNnj/hws4xaRWUoCvatJkAFZj32Leo5J4MEGE?=
 =?us-ascii?Q?ltcTkkxq1TNyc+/lzIt8jknAQ+lsMMrQYjQWzvx5+UgwgzH5V5Er8CdCX9vR?=
 =?us-ascii?Q?qo4amstp3AXVjqtKLqAgvZjWFNyIxVVo6auMnXxiTCvR5vY2pUDGLDCRKwKk?=
 =?us-ascii?Q?VTvNw5Wj8dGNeCgxezBD7ncW/D7piOLELnJfbHDrCGfgQHyG9DjRBvO9IOhg?=
 =?us-ascii?Q?UNfNO8fvFcfULrrHW5CDINR78GvqlLesyd18zI+tSGPo/bGWeXD6DcS2zAox?=
 =?us-ascii?Q?b6ueNo+EVneiywExXu1dDgI1go2sHzQ954+4mHWJmEZdRqNbtzsuJWCippoA?=
 =?us-ascii?Q?L3P9890Ku+ziPALgKJp340lVc0UULq2RIvU3T/RZdDdLGB3csSUEuK6D8g4k?=
 =?us-ascii?Q?QKPenvQRnjKP6Q9PhpruW+H+p95v0aIrx1gC/lJ+O3MfggjH5YJFpmCMmkMg?=
 =?us-ascii?Q?N2KZeaOwtzyamA3CSdZ8xyPvoolWPzxTFHg8mGNgGZbu0SRO9sW6fXvrv5km?=
 =?us-ascii?Q?gNkgvCD/EYCFyqqeOOjqIo6yolgGZHtCB4TtKVMvBNxrtfqA3NElUMGCnaCk?=
 =?us-ascii?Q?e2ORr8fhW5d9zl2JoUU07dka1MKwUM2ueqXKSTXgD0OhZ44/SPipnTnCD+IS?=
 =?us-ascii?Q?MxtqObOaLMUd7pU/gGLcT5vqypA+1Oh3/cSFTN49QvFGqnf++9G+mJBAXZTD?=
 =?us-ascii?Q?fEDZs0MC6QtIJoB846+Q/8m/qxeMkvSQo8Y5PpfGFhbYCte0wv4bkcDfoyN/?=
 =?us-ascii?Q?/ZSsC0QufNlM1DdY/T2cLAsT7YoghA6BosKvja2spu/+yAUPEWvBsTV9Ec0w?=
 =?us-ascii?Q?iOaH6CcVTAf+bflmbKkDTV9TtQCS3kCj0TlyiN5rvw1LCGAesn5d4lhXvX69?=
 =?us-ascii?Q?JIOIko/INGE2eRsRGugvFNxNM3Xh90pObrk3hGoJ7fLcw7LLsgshLmJhTJ3L?=
 =?us-ascii?Q?xG3uy69VtMXphNLU7hVxTSYDeppqUq68PVexK1m4+uzH6+pcnIBnBV+seqQG?=
 =?us-ascii?Q?WB9QtMG8NUSBEKaPb0l9FezXpC5/ySCNGuthfHr7i+FdWoJH7yWvz7YVsITm?=
 =?us-ascii?Q?ThTY6IgYbGeh85LvVolmOE5hTs79isW7sMdAmpz9AbnqJpQ9sgl9ULyiYrLU?=
 =?us-ascii?Q?Xk9ASJGRtjE+vgT5U+iEZNya1v6+OIuxMx3OmpZiorcAQvCo7d8zd1tPD2ke?=
 =?us-ascii?Q?lvG+7IfN0fXYmV+I0B0TMp3rRgbfhGZT+5A/culvRuFn+Avs6easl6ZrfZuE?=
 =?us-ascii?Q?t0Qyja/GSuqoHB8Uwx2mYip1BNqNl7NifI3DTaaXmkve4DTgGMl+a4GvY4mD?=
 =?us-ascii?Q?N45IYzcJPN3xY4Ucvv9TP5pjuKkiwaXe+iWIrRI95yL/bVcCH3cAsnWBss8G?=
 =?us-ascii?Q?5SJR9pxFKOuXQpMdmo0rmGkR2RMqjl1Vz7rnbdYXQwjL/Ds1Ru2d790hMxGS?=
 =?us-ascii?Q?rf8dHnKuvwHERgc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:32.1726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dac505c-bbf3-40bf-71e7-08dd5cdf36bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
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

Plumb in support for disabling kernel queues.

v2: use ring counts per Felix' suggestion

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 96 ++++++++++++++++----------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 34cf187e72d9f..23ee4651cbffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1421,11 +1421,13 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
-	/* recalculate compute rings to use based on hardware configuration */
-	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
-			     adev->gfx.mec.num_queue_per_pipe) / 2;
-	adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
-					  num_compute_rings);
+	if (adev->gfx.num_compute_rings) {
+		/* recalculate compute rings to use based on hardware configuration */
+		num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
+				     adev->gfx.mec.num_queue_per_pipe) / 2;
+		adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
+						  num_compute_rings);
+	}
 
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
@@ -1471,37 +1473,41 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	/* set up the gfx ring */
-	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
-				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
-					continue;
-
-				r = gfx_v12_0_gfx_ring_init(adev, ring_id,
-							    i, k, j);
-				if (r)
-					return r;
-				ring_id++;
+	if (adev->gfx.num_gfx_rings) {
+		/* set up the gfx ring */
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
+					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
+						continue;
+
+					r = gfx_v12_0_gfx_ring_init(adev, ring_id,
+								    i, k, j);
+					if (r)
+						return r;
+					ring_id++;
+				}
 			}
 		}
 	}
 
-	ring_id = 0;
-	/* set up the compute queues - allocate horizontally across pipes */
-	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
-		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev,
-								0, i, k, j))
-					continue;
+	if (adev->gfx.num_compute_rings) {
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev,
+									     0, i, k, j))
+						continue;
 
-				r = gfx_v12_0_compute_ring_init(adev, ring_id,
-								i, k, j);
-				if (r)
-					return r;
+					r = gfx_v12_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
 
-				ring_id++;
+					ring_id++;
+				}
 			}
 		}
 	}
@@ -3495,12 +3501,18 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (!amdgpu_async_gfx_ring) {
-		r = gfx_v12_0_cp_gfx_resume(adev);
-		if (r)
-			return r;
+	if (adev->gfx.num_gfx_rings) {
+		if (!amdgpu_async_gfx_ring) {
+			r = gfx_v12_0_cp_gfx_resume(adev);
+			if (r)
+				return r;
+		} else {
+			r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
+			if (r)
+				return r;
+		}
 	} else {
-		r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
+		r = gfx_v12_0_cp_gfx_start(adev);
 		if (r)
 			return r;
 	}
@@ -3809,11 +3821,19 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_disable_kq == 1)
+		adev->gfx.disable_kq = true;
+
 	adev->gfx.funcs = &gfx_v12_0_gfx_funcs;
 
-	adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	if (adev->gfx.disable_kq) {
+		adev->gfx.num_gfx_rings = 0;
+		adev->gfx.num_compute_rings = 0;
+	} else {
+		adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
+	}
 
 	gfx_v12_0_set_kiq_pm4_funcs(adev);
 	gfx_v12_0_set_ring_funcs(adev);
-- 
2.48.1

