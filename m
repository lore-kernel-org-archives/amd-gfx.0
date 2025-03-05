Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458D3C28B28
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A0E10E344;
	Wed,  5 Mar 2025 20:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VjKt0JcM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F0510E335
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCJqw6P0czgebYWOng90nw3MGBx/rUAmVageFLy4koky7pN8mmgKidNTdy8UbsfUo3KMcfSW0oCVjjpVWKuVYv+QtoxEGcmFMotHt9S98gHkERiox01Q4N5YWB9PH/Jiw0ItSM/qTwk1K9y4L6yl+9Qnb1w+r9QtoTqB3CblSMRNoLKOgUZCNW0anSE5wUZ4rv8BnJV7O2uwa9jyOZ3Jov3mqgdSZiFzerjB+XnoV8cgOQWCMHOmn20waf6O4ytsQYXQo0vWOZ3uIP71x39g2GpUOm+3qdG3Hcyae6nohWMlHucYJ1kkDMpqyQ/EdC4qip8mafRUyZxS3kNSljhQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ereo3r9TCdJwnaFcUHsTWv4ANm0fzTBGgpTfbTm9hF8=;
 b=WMUPYIh0UfUm6C1DzmuJ5+bHT40oqM/tiunaH7e9A6hrxVUk+Zs8kIgD7bvri2+Ij48AZRDX+gEEpnwRBXNA/T+ZjJR49ToIbNp0ru1xTLEPRxUcY2MmwvdWyIULP08UFU1ZC2XgY4zmGxhi9uBFJA9rWrtXGBDjEHWe9eN4NLas3KbdkgTCkHuixfHu+0Ui6nTynm6cy686Nio+8LpW4FXf5mHZCGtXvrzzHtIP4ghw45IGmyh9WrK2IJCKMtvvHbjPDCC13VKpUkkHFjumiuqF/hDY8M/rzzc/ImEFf4cZXpNCHEiNosAdniwmXmDUIy74fTuAV2AWQK0YJ+Ki1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ereo3r9TCdJwnaFcUHsTWv4ANm0fzTBGgpTfbTm9hF8=;
 b=VjKt0JcMtAYw7uv1XMtvFHpUZ0Zmj9P8djkXyfRv6/dNwtn5nPQDWIJ01g3ocx9u4t2oI4xGonbpr4iJFrJXjUXxSvgUSuGasZLV8dCWy45DXf09rfbYUP5HB30XIHMJr7Yl1H6y594Bru1qY+g4+37P9bmvnuy9uqOZHiiQ5qU=
Received: from BY3PR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:217::28)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Wed, 5 Mar
 2025 20:47:42 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::40) by BY3PR04CA0023.outlook.office365.com
 (2603:10b6:a03:217::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Wed,
 5 Mar 2025 20:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/11] drm/amdgpu/gfx12: add support for disable_kq
Date: Wed, 5 Mar 2025 15:47:18 -0500
Message-ID: <20250305204721.1213836-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d0c9f6-f609-4b9f-3c27-08dd5c26f97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nFDjG4HSAwaIuwhAVBJbCN3cvdhp6+xhRvdIpLABJ6dIn3apRw6MT461OaHn?=
 =?us-ascii?Q?TCN1uXwrFMjfKcZBaB+iENtNk0QBDp4XMt0R3wrvmyUR0g8S4ePvu+GtH8PL?=
 =?us-ascii?Q?ain4eEH11N9E7nBNt+Ks8s3Ls+W85Ge4mK5qN9lRjZXUJTE2jKeV2obtMBFT?=
 =?us-ascii?Q?pt0eZahTwWvApKhpPDzWWs+VvoxBql3VyUyB+jcvKaLvhiCvFXQklZMlwEWa?=
 =?us-ascii?Q?JJoYLOK9MYeQ7ADNdS+nD4vmO7Y3/SuVhMhEKkeJxqrJPIYOrUhBEdvqH4Tn?=
 =?us-ascii?Q?98WtlGFeun4WZSQTG7AZD30W2bUZ33XxK6kEA/WoCMMp2cswNNGqfMe2So0+?=
 =?us-ascii?Q?esy4pWdqV6OPBdJQlfLc9Z1doAku+W5I4TgevNOSqM8eIF9WAxCPkpiGlBFo?=
 =?us-ascii?Q?ROERRPVR9sL7y+Ok+7OTqzJuZfq9eFdM24vBr+Rlbf4lTEQpVx26ro4hYrFs?=
 =?us-ascii?Q?QKHAOUoNIzpUs5HDhkZBu/bAs1yi0ezfMjCS/kwBXFba7XUbL+5lcLUGK5ul?=
 =?us-ascii?Q?uJtW+CWzEzyGzGsAJ/TpTD2V2Nw0uVlQsf2n1h/y/NssLKvvzQYbrLL5HeiT?=
 =?us-ascii?Q?nVQY3mlbgkDfKeUYOE/KzzF1dmXO1akDepUc1kyeyn3AdAyjeEp6XfCj60E3?=
 =?us-ascii?Q?4zPdtBRPMTm0vV/wRxXrpsLwbThRE9sRF+GCxsX4ZuTUpg4WWKy0zl+81Wn8?=
 =?us-ascii?Q?wLAZeUiPYJTQEQACwCxMOHu9m0UYBE3K9PktWMwffbGsvJepTEPcvD/m6ja/?=
 =?us-ascii?Q?oYz+GR48VjgGuHGXo0SJdKW3ZMUxQFzcVlM3hDL3vLRLQ1XuG06H8wKoLV0C?=
 =?us-ascii?Q?m0dRNqPgizTA7Dp8y+LciJptHRDtKNzJzPyZh9Ly0FZf2MmbJrc+9qlA7KE3?=
 =?us-ascii?Q?ln6ZeWzEssidafHjdxoE66oaOeN3RHW7ukrBM7TCd0XsmWoNKaFXop/lM5fx?=
 =?us-ascii?Q?WUVync5T832pbcI3NU3usR1hSZbk8nDgrOeMKdCfbYEqhShEvm+5Az5++UcI?=
 =?us-ascii?Q?C9W/0s8sVkS1h4D7YVdqwn42TwWrIN8ppNho40AYD25EQ8xxPcNTAdrkXErR?=
 =?us-ascii?Q?T3JnMmigrJxvtK26EIQ4EcoEO/nheR2Afh0l4FabXc+lwkzabPFA3BnZ8bJW?=
 =?us-ascii?Q?myLxSLyDO06gBgoO353Xjkqa+s9ZN66D2FAsBQho3xCTQpNNo+Foq9gumFJh?=
 =?us-ascii?Q?vGKK379qsAza2t+U6T65qwmAo/S70jwxDjChLMTG9XW1m0lHCgCLAXFZpOxS?=
 =?us-ascii?Q?/R3GYkntEntBsSdroiiAWkTY/f5v6RUDqp82w9HW+C91ZzuGLIfEo0U1/ccv?=
 =?us-ascii?Q?9NyX2SVVFqY7yv2Fq2oi72yLj8/TJqo5BBRFFPlMCXX2tvYOOCnRpz1Bz1Da?=
 =?us-ascii?Q?Z7zHFwC9lk8wpvnLoG6HuokNLAnO3QQW2fT7WY7/+7yYuM3oV5mCJkxjPS/M?=
 =?us-ascii?Q?R1w2DVXFFMZzfectLv/6y4WpBi9hBppjcS8/GyM84EGf7+dpYgUCkvUMPLG/?=
 =?us-ascii?Q?fV3G0w1YYKRaWfE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:41.8915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d0c9f6-f609-4b9f-3c27-08dd5c26f97e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 114 ++++++++++++++-----------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 8a448a20774a8..8fde7b239fdbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1453,37 +1453,39 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
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
+	if (!adev->gfx.disable_kq) {
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
-	}
-
-	ring_id = 0;
-	/* set up the compute queues - allocate horizontally across pipes */
-	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
-		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev,
-								0, i, k, j))
-					continue;
-
-				r = gfx_v12_0_compute_ring_init(adev, ring_id,
-								i, k, j);
-				if (r)
-					return r;
 
-				ring_id++;
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev,
+									     0, i, k, j))
+						continue;
+
+					r = gfx_v12_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
+
+					ring_id++;
+				}
 			}
 		}
 	}
@@ -1572,10 +1574,12 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int i;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
-	for (i = 0; i < adev->gfx.num_compute_rings; i++)
-		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
+	if (!adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
+			amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
+		for (i = 0; i < adev->gfx.num_compute_rings; i++)
+			amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
+	}
 
 	amdgpu_gfx_mqd_sw_fini(adev, 0);
 
@@ -3418,6 +3422,9 @@ static int gfx_v12_0_kcq_resume(struct amdgpu_device *adev)
 	if (!amdgpu_async_gfx_ring)
 		gfx_v12_0_cp_compute_enable(adev, true);
 
+	if (adev->gfx.disable_kq)
+		return 0;
+
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
 
@@ -3477,28 +3484,34 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (!amdgpu_async_gfx_ring) {
-		r = gfx_v12_0_cp_gfx_resume(adev);
+	if (adev->gfx.disable_kq) {
+		r = gfx_v12_0_cp_gfx_start(adev);
 		if (r)
 			return r;
 	} else {
-		r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
-		if (r)
-			return r;
-	}
+		if (!amdgpu_async_gfx_ring) {
+			r = gfx_v12_0_cp_gfx_resume(adev);
+			if (r)
+				return r;
+		} else {
+			r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
+			if (r)
+				return r;
+		}
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-	}
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i];
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			ring = &adev->gfx.compute_ring[i];
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 	}
 
 	return 0;
@@ -3791,6 +3804,9 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_disable_kq == 1)
+		adev->gfx.disable_kq = true;
+
 	adev->gfx.funcs = &gfx_v12_0_gfx_funcs;
 
 	adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
-- 
2.48.1

