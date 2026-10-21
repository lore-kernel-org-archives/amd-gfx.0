Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15036606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XA0ptqvu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BBB10F960;
	Wed, 21 Oct 2026 06:28:17 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CB210F960
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4s9kFWopQ2wXcmGWwW1C+bWBMzI0k/01ugk44nAJWfY6hGHf2wKfeWaRf+hg7Yn0Pu8dPjKVuHu1wNLceplJtO786/X42EQ6JTYo+YX+E1NLTjlO0t2AdRYnhQfeEe4jnOoEMf/zentrcXuQlCBiPp9lou5k2e+Z0LXvKDnTYboVUuD9qDm7ou/JSsJ5K1FVvYDmKUYfyb+9vEw7xrg+uP00hyFoEJZ2cs6E70vy75uwyB3hv064pBVgKc4zeX90keA1nT+051bWh5Gxzie9QEFhQ0CdRCGFHRSLJy9xmHe+nbodmBm01filhBYEYxQ3iYV8Ebfuki8sCI3LO0dNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR+RXDF+Qhpwnk/u7MVAV73+x9npvRAuFw2cZB0GKQc=;
 b=mn8ECxU+MFRcghls77zV71R3FxWGWzN1pgEpPYRZzteGrx1cZRkVP+snVvJaoQLUeqD4Jo4L4A4bKUdkFdSx3NLNitSGVbLlSR8bC/5zOdN/Z/AjwAv4je7lYCrqOoArY+Gtx2A/eAF2Si1bXJt1t3h+7kkV1fAF7GTZu5zDDgIyt8tmcOAOFaECHp0spwYpDQHyeXM7FH7L8CeQ8hWIoaCJ7HWdd0D5iKpeTM1110B6ZPswBYtoBaMMjFjocdBCWzgIT3lzYb9Dfk9Uqh4jN+uV2Y9SSGrcKy4XD3TfTVuKeHAlPuOi7aNPYMleqTKWKLMrhNkxV3K5pgB2NLX75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR+RXDF+Qhpwnk/u7MVAV73+x9npvRAuFw2cZB0GKQc=;
 b=XA0ptqvuRF09d34MLPT5+dNk1W+QZMZtRncKDznz0E9cLSSPZqU9h4JfRBhLgSn9LBRiGlhKzeR1djTWQihEXne9NLFKM0bl9Nhuz0ksY0H8w4w4vsdaX2vcXKzfaCuy9U43kBQq2bYQayVkX3k7VEpUXB11SUYb31Y8Fp0CYsw=
Received: from BN0PR04CA0041.namprd04.prod.outlook.com (2603:10b6:408:e8::16)
 by LY0PR12MB770130.namprd12.prod.outlook.com (2603:10b6:404:211::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:27:45 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::4b) by BN0PR04CA0041.outlook.office365.com
 (2603:10b6:408:e8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:27:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:44 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:41 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 38/49] drm/amd/display: Cap DSC bpp for USB4 DP tunnels
Date: Wed, 21 Oct 2026 14:22:44 +0800
Message-ID: <20261021062519.674697-39-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|LY0PR12MB770130:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a820fd-db50-46bc-fd7b-08df2f3c6b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|11063799006|56012099006|261009223027099003|10067099003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: X9dqRC6Me6w0S97OCz/22Y74A6hwVPHK3LegTktEbP/h88BtkdVUUw0qWEmOhznV96P7EEB3XDNS+lyggHM8t6ONmfp/6/u1MRZIynTUk8b/vOmxO3aUPju6fevw8UhjdaHHTt1W4E0jdhE2I3BT/GN3G0MtZ6FX0rLk7O+Z+tzW65MxPJJ7/qsPDtpsnX2SsWlPZesbazSHPU/ZgdDPFJRjjzqWzmjhR0AM6sAwas/LDIBI17oQfgXVPZ1p40ouVJfDGzAju1iexa5p0A0MfktxtKsCMmfOHqGIKbFfnRgJV/+B0ccdej7khbsE0BjlhwBtDr6bCpNgrk35hRq4ZrB+LpNPEEZtdrIBV4R9R8/Exa3jMkUNKuCb5u9IZMzYoJaEqtsDQZhCmhxHVJd0E4lcKGos5NgshcXbXj6oCsvxqbHvmdLOGOb3SUk3Dyf4DKmljcF58HrQT3Uz0BWmnqCKDq2EfXKFhtNrr0ZtDQwG16x1BeWmStmOHHx3uGDGnMTeP+y4QUKgQhKYOPWTblgTNL7z2QbwqxEa7Ek+bZH+e195vF0xqI18QHyrXtroiIcZ9E4DqX5yBz8l8yRI6YVcFvalOb4qQf2tTDjdqPHs3AH4EjfmEvPgDKpitho3i250nAq/PbfryhlTUk4wbvzmW2BMYFA7NuTC8LtneK7kmspKq/EhgRQa48TMa151rb/+ArT66KUlCjVBVrA5Hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sVmy8Wr1diqQNnQMitOCiW0g4BlH20wKWF9/Jc78PYvsoeHWU2un5/JYEHKHXg/3Cx+4tacH/gODg5CDlBsvWp9STdjHAClVRYqURAiNqD4a7v+TaxjSP4C6/SIgwHE94qnt1rrdpWMbJO1nGH/fqbW2e9yCWeISnZXksHEpTbmZnF06MceQZoid1OLusxc8p7dP0wGCSuF/2e4TMcMSWqt14MUOQeu5I445X2BTs4dnlnNUjZPbNfnPeCs+fnttYbiMVOQnDsoq0T1Mz6hvOf0FhJF0EgmLnL54AzpxfuffblVPcSwx3KmrsDIEM70tj9elzLYJfxb+ZERNQrN7eBdmqbWijvq7ntUYE7sT77xl/kMXMLuhVjhCqUgfz6ttRvBh4qQ37h9P63nIxOUi+ErWELPIZqcs0ByFTUKYGSwX+XOnucrOvoGPm20e2IRl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:45.3970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a820fd-db50-46bc-fd7b-08df2f3c6b48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB770130
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fangzhi Zuo <jerry.zuo@amd.com>

On pre-DCN4.2 platforms, USB4 DP bandwidth allocation is unavailable.
SST and MST streams are sized against their native DP link bandwidth
even when multiple DP tunnels share the host router. A high-bandwidth
DSC stream can consume too much shared tunnel capacity and cause
intermittent display corruption when another tunnel is active.

Cap the DSC target at 8 bpp for USB4 DPIA SST and MST streams when
bandwidth allocation is unavailable. For MST, cap the DSC fairness
range while preserving its per-link allocation. When bandwidth
allocation is enabled on DCN4.2, retain forced DSC and the existing
minimum-bpp behavior required to fit the tunnel grant.

This is a follow-up to commit 08e7eacbd7a1 ("drm/amd/display: Force DSC
to 8bpp for SST DP tunneling over USB4") and commit 9dd08056f7fc
("drm/amd/display: Force DSC to 8bpp for MST DP tunneling over USB4").

Reviewed-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c |  6 +++---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 17 ++++++++++++-----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 349a6eae4556..d71aba44bf7d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1291,10 +1291,10 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
 
-	if (aconnector->dc_link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
-	    aconnector->dc_link->dpia_bw_alloc_config.bw_alloc_enabled) {
+	if (aconnector->dc_link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
 		dsc_options.max_target_bpp_limit_override_x16 = 8 * 16;
-		dsc_options.force_dsc_when_not_needed = true;
+		if (aconnector->dc_link->dpia_bw_alloc_config.bw_alloc_enabled)
+			dsc_options.force_dsc_when_not_needed = true;
 	}
 
 	/* Set DSC policy according to dsc_clock_en */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index ee3f3df6bb8d..5697645ef7cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1342,6 +1342,8 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_commit *state,
 	DRM_DEBUG_DRIVER("%s: MST_DSC Try to set up params from %d streams\n", __func__, dc_state->stream_count);
 	for (i = 0; i < dc_state->stream_count; i++) {
 		struct dc_dsc_policy dsc_policy = {0};
+			u32 min_target_bpp_x16;
+			u32 max_target_bpp_x16;
 
 		stream = dc_state->streams[i];
 
@@ -1380,7 +1382,15 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_commit *state,
 		    dc_link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
 		    dc_link->dpia_bw_alloc_config.bw_alloc_enabled)
 			params[count].clock_force_enable = DSC_CLK_FORCE_ENABLE;
+
 		dc_dsc_get_policy_for_timing(params[count].timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
+		min_target_bpp_x16 = dsc_policy.min_target_bpp * 16;
+		max_target_bpp_x16 = dsc_policy.max_target_bpp * 16;
+		if (dc_link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+			max_target_bpp_x16 = min_t(u32, max_target_bpp_x16, 8 * 16);
+			if (dc_link->dpia_bw_alloc_config.bw_alloc_enabled)
+				max_target_bpp_x16 = min_target_bpp_x16;
+		}
 		is_frl_endpoint_present = get_conv_frl_bw(aconnector, &frl_conv_bw_in_kbps, &frl_conv_dsc_bw_in_kbps);
 		if (stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported &&
 				is_frl_endpoint_present &&
@@ -1390,11 +1400,8 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_commit *state,
 		if (!dc_dsc_compute_bandwidth_range(
 				stream->sink->ctx->dc->res_pool->dscs[0],
 				stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
-				dsc_policy.min_target_bpp * 16,
-				(dc_link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
-				 dc_link->dpia_bw_alloc_config.bw_alloc_enabled) ?
-					dsc_policy.min_target_bpp * 16 :
-					dsc_policy.max_target_bpp * 16,
+				min_target_bpp_x16,
+				max_target_bpp_x16,
 				&stream->sink->dsc_caps.dsc_dec_caps,
 				&stream->timing,
 				dc_link_get_highest_encoding_format(dc_link),
-- 
2.43.0

