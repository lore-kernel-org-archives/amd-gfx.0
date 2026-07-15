Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E468C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D106D10F072;
	Wed, 15 Jul 2026 13:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bMiBY0TM";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F2210F076
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1OZdMqWrHKMGlp6aOBeBCs+HNj1ysoYpA7Tx417BpD8UT1HzL0qzo9+Z5hG+tJHIn08oL/Qv9JgStwHQi90/liayn7ypEsJzfrhLfXIo6fHEGaH6/sxG95Lguz3JkKUQNIwzuYdQJ4nLGXSu7hj7Ip/Q5sbNvdlFIScZHv3+HtTzUun1Ghq1YYaOBv7RB/SqORAgIA5xA0Pt4KeudxQ/V7Yp+dIILq8C+rBL84Mv6tihKqp4lbzpHfilbqLSUqNAwUwsoU2p4aoXX9DlG3o+E945XUwIVCqxjO7Bz2U/hMKyjmi9roHDs7/P8XJt8r1UATvtJIfGSw35amM1cS8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNm5THZaqBHHsuG3KagbpWUMXq0LkvcZ/SmvATa94lk=;
 b=djhpOGDtq+WjIDBsq1p9aIz4Cv3AamkH8UYRr5nznjVw4Iy2i9gO5cdIAwXZUkxemCvUs46YbpAElytmTUiPYjUjJ8a5MQBNsT++gWLh/kJdaPVC2fKEfvyRjJBnJtwsbUgFS/6zlVQeWu+VIOZNwddEMXLQWR0CKD5Fun1m9xwvhNkhkczUGIhyAEVUrNHCIG5dnfBwd6IQ5zRqWI7qS4xdVLFflw0V/v8te6QSz1fjktg24bP23EjC6n9f+tre3Yg3tUwyuV9/2A+iAuw9SZyvsC9nEVDmpXHsmcpIPu4UtMF7fgd7GirYp1gISeF6/XUHPWIORoRJAfTY6IpjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNm5THZaqBHHsuG3KagbpWUMXq0LkvcZ/SmvATa94lk=;
 b=bMiBY0TM4NeJMm1DWFwbJRHYbkO2FZkGchgi/OSH1RrpHezx5Lt3VVUdYlzNGiUr4X+LrlxaNKVCSc0+ZWN0JEOE8qVx5niOnBuafFSjjEfwCBz0hwqrWwMVKcoysVxOhBPMQP+yhKHUuTfYPxQkGunbUNB6JWTeylcxi7cmzXo=
Received: from SJ0PR03CA0284.namprd03.prod.outlook.com (2603:10b6:a03:39e::19)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:45:45 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e) by SJ0PR03CA0284.outlook.office365.com
 (2603:10b6:a03:39e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:45:30 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:27 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, "Rafal
 Ostrowski" <rafal.ostrowski@amd.com>
Subject: [PATCH 10/70] drm/amd/display: Drop CONFIG_DRM_AMD_DC_DCN4_2 from
 3dlut code
Date: Wed, 15 Jul 2026 21:37:20 +0800
Message-ID: <20260715134432.1975118-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: e0332a1d-be5c-4106-9ff3-08dee2775eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uO46+5aLdR72+49MpphJ9b2slTfPrU9QLtYA/pYP4eqxMl/RdHfguvGPow+d1KhKtUe3pFqeYHFQVgdJjoMl8HBk/tPzmnkUBmkPy3GaffqGiQIEDRzHOTMD0uUsSpAM9nVQ/KMhmjW+WKHtQFcoFkmVSVbrb5WedXqhXQsd+mVic0zivlokVC8YQfa5t6DOw88f4R0f6EymjDjXiuxJvQQWM+ITpFRWir8/+Ni3J8/PCv74BGdGoSHGcNqP4Ju6EaO/Q3pEX8u5n6DgUwPVD/k4Dq3C6lEu7gfvikk4M5JutMUPtHqnXoWyzZ2m4o3GBDgyPots11vicnGWfkfYzb5psstYeo8DsY2Aw7tnQEifHZGYN1+8ZvlevZU4dW0scLb12FMuhtQahR/DZyVbZCcqaMZZZ6v7Ak4YryX9P43pb8N/aMLjZ3Bx0lhfChF6CoOpd9KeOjb2/nqVjery2RxEX0GEcw87lH9bH9Y0yrN+dxs8zHvyoyGPsLxwBfAkefL13MJCSZW0+72HQ+HmqMFlFXdJE6BCFe3r0wCPukUF9jyClyF7NknqEYcsoZdSGpwJdY9L3qt/4uDd104VwWKPMMG64MR8mlk2Uf0S27QvfHDo+GfiKuito/zyj32Qi64Mha0ar7M4uj6QaN6YlSC7auf4hbBVkTo5a+T6EV7AwAaxLH1XbMF+mbgHYR3CNRh7mLiTsZNPKj4Z/ma3mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /e71SJirw11JzhaEr7EiK4hGXfffiJUoo3jBoIsyLEgK8OaKuAH9J66By73e4OGU4tzVpKdA9aAd5araQ6u/yRnXO8ftYBLU7YriOGeBEA9LUIEFaPJ6wDu4+p93j5+nb59Ue00fc/cBHLO1uAjF/p5CMv+IcqHQ3HVasskZPHAnrzCWUCopOSu+MI/4gPhix4IOhU0AT2+BW79/2ZB0QPgGeCQp7UZe1Dg7agI7JPr6SxEZ91iUyCD8PRvC1Br9msLHYEAbrXCzkrybb0//57+ehHsWOA96T/aIrSuZJ/eVaOiV4GXhLWkEHVpkChJi1wFx49RdCeQk8BHF0836rsJIvBl4arjDc/IcR9YSyxyGLohZxpSKChSi813vespUZw41MtCFdr7U2AWs9nPj/wPGXZbdupFNE6ywHjHUKEAhPhwebPbTFgW5IQuKrkT+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:44.9730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0332a1d-be5c-4106-9ff3-08dee2775eaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457
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

From: Tomasz Siemek <tomasz.siemek@amd.com>

[why]
CONFIG_DRM_AMD_DC_DCN4_2 were readded to DAL by mistake resulting
in parts of dcn42 3dlut code not being compiled.

[how]
Remove readded CONFIG_DRM_AMD_DC_DCN4_2 guards.

Reviewed-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                       | 4 ----
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 8 --------
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 --
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 7 +------
 4 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e1b7d359d917..436277acd034 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1508,13 +1508,9 @@ union dc_plane_cm_flags {
 		unsigned int blend_enable     : 1;
 		/* whether legacy (lut3d_func) or DMA is valid */
 		unsigned int lut3d_dma_enable : 1;
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
 		/* RMCM lut to be used instead of MCM */
 		unsigned int rmcm_enable	 : 1;
 		unsigned int reserved: 27;
-#else
-		unsigned int reserved: 28;
-#endif
 	} bits;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 5ba7a2fffcf0..fccf9cb359f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1414,28 +1414,20 @@ enum dc_cm_lut_swizzle {
 
 enum dc_cm_lut_pixel_format {
 	CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12MSB,
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
 	CM_LUT_PIXEL_FORMAT_BGRA16161616_UNORM_12MSB,
-#endif
 	CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12LSB,
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
 	CM_LUT_PIXEL_FORMAT_BGRA16161616_UNORM_12LSB,
-#endif
 	CM_LUT_PIXEL_FORMAT_RGBA16161616_FLOAT_FP1_5_10,
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
 	CM_LUT_PIXEL_FORMAT_BGRA16161616_FLOAT_FP1_5_10
-#endif
 };
 
 enum dc_cm_lut_size {
 	CM_LUT_SIZE_NONE,
 	CM_LUT_SIZE_999,
 	CM_LUT_SIZE_171717,
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
 	CM_LUT_SIZE_333333,
 	CM_LUT_SIZE_454545,
 	CM_LUT_SIZE_656565,
-#endif
 };
 
 #ifndef TRIM_CM2
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 1862670ea042..308085d24775 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -515,12 +515,10 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 
 		/* Select width based on the requested LUT size */
 		switch (cm->lut3d_dma.size) {
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
 		case CM_LUT_SIZE_333333:
 			if (dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_33)
 				width = hubp_3dlut_fl_width_33;
 			break;
-#endif // CONFIG_DRM_AMD_DC_DCN4_2
 		case CM_LUT_SIZE_171717:
 			width = hubp_3dlut_fl_width_17;
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index cc8e96ffe7d1..4376bf26f4ce 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -470,7 +470,6 @@ static bool dc_is_rmcm_3dlut_supported(struct hubp *hubp, struct mpc *mpc)
 	return false;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
 static bool is_rmcm_3dlut_fl_supported(struct dc *dc)
 {
 	/* size was previously hard-coded to TRANSFORMED in local_mcm,
@@ -480,7 +479,6 @@ static bool is_rmcm_3dlut_fl_supported(struct dc *dc)
 		return false;
 	return dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_17 != 0u;
 }
-#endif
 
 static void dcn42_set_mcm_location_post_blend(struct dc *dc, struct pipe_ctx *pipe_ctx, bool bPostBlend)
 {
@@ -724,9 +722,8 @@ void dcn42_populate_mcm_luts(struct dc *dc,
 		false);
 
 	//RMCM - 3dLUT+Shaper
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
 	if (cm->flags.bits.rmcm_enable &&
-		is_rmcm_3dlut_fl_supported(dc)) {
+		is_rmcm_3dlut_fl_supported(dc))
 		dcn42_program_rmcm_luts(
 			hubp,
 			pipe_ctx,
@@ -734,8 +731,6 @@ void dcn42_populate_mcm_luts(struct dc *dc,
 			mpc,
 			lut_bank_a,
 			mpcc_id);
-	}
-#endif /* CONFIG_DRM_AMD_DC_DCN4_2 */
 
 	/* 1D LUT */
 	{
-- 
2.43.0

