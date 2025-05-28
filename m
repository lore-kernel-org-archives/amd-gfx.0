Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21227C54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9BF10E1AC;
	Wed, 28 May 2025 02:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="amOwEFiS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C011D10E1AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNh9i60XYPPW/1jgnJEszWPAZLo6EoWbcGJ8ovuKIM227nErrsOh90oN2SBI1DOYnHs4dcwp0IV5ODsxpPLfTctLNA1lpDrsUKJ8o+HGwzm7iJzlqSopbyIu/vMikKyvGfuNjeSLljri/ORw9WVVevN+SnsNX7lNCygx6662vA7zhE+oklendA4oPFIR+/vbz3jt7vmEXnGgxGJI3S3aCfTP1H2d1WazR/7rGCPeHQKAsvMiR0woXyVCnGhV/zVndUBPlOsyyF4jHxi57PJNmUg19emMnz0RN2hBivsYlpUuA/yMa6MMghmsLrcVFowiDtWvJeX17Wa/foEU6oL6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt+3+ZVlmp2NvBNkx5IJeZg3JVpg9blR+pQ2zBh7Q6Q=;
 b=q0GN38NbJ7prK0oSHj6I/ASgFLtcTUh3kpgg+cOzMCDBWkbEVqSWM69Cv4Z8pGIoezYTcbNswV9VxuX3oRV4N3fRzgl5GdGbj+z5kpsgoVUr9eq48P5S2Jq2pZ1mvibcLV5zZDrwg3YClthpSXLtW9tKUDiDbkdc1kSXbcaCos1kB6j6UW4Q2wcYvEdwDf/788Q5bUOLh1Hdw1pAtohcy5p7ltZiPRPEclHFLbpUqYnd6Oj1itXge1I9nTGbSVK26rINR8EhlUhH9Bq2+cQbdEV7V4/bKFOYzvjRFZG8hpEXQ+Gs8jQ9EiW6OxvPHv8qIZz1+gnMNS2gEeuNqnbXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt+3+ZVlmp2NvBNkx5IJeZg3JVpg9blR+pQ2zBh7Q6Q=;
 b=amOwEFiSnvl2OQXVHgocCxGaXqHrMWNn9aa8B6ZJyM75/0I8cRbbhSmmSMoWQ0yRqpkqgE/Lu8IR5yL9cxCaaUG+YGrixL7kA6utQYyAQWCUC77uz4I7004DHNmkgTGc5YTUBlPY3qBm3a610G4mOzukd9yYFDxfGjkyJUO1OC8=
Received: from CH0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::7)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 02:53:32 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::1f) by CH0P223CA0019.outlook.office365.com
 (2603:10b6:610:116::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:53:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:30 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:53:26 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Ilya Bakoulin <ilya.bakoulin@amd.com>
Subject: [PATCH 14/24] drm/amd/display: Add support for 2nd sharpening range
Date: Wed, 28 May 2025 10:49:09 +0800
Message-ID: <20250528025204.79578-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: e5733966-26d2-416c-c6ed-08dd9d92d4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Rs7aCuZjU9B6sYeDSsGOYvSsa1v7m7rM/Hck2U1lY3+SF3intlYD/pBSp8L?=
 =?us-ascii?Q?QXJWsHmkM74mfK33ZE3PW/KceLfqbevu1SNVZ8vcwGVbyuQXdiczxRDYpfZJ?=
 =?us-ascii?Q?+TPA/cOeE+7iflzQb1AL6RGZ6Vbto6mgeS88/P8RClRdyTtjBjLyqQkxMGMJ?=
 =?us-ascii?Q?/vw9N6bT4+jqzMW8uIbY8QIzHNuSWFz4SQxYXtgyoxyiY/q2U0rvRTRKdfyE?=
 =?us-ascii?Q?ZZbiZOsc9eJT787ahglNPF1KWAE50k9/EUyzCjhnviUk/X4h7OAjFGH/qd2K?=
 =?us-ascii?Q?aj9mkOIhFyQJEVtPP3tkXYWWdD3kCwRvILMvEnsAL+ruaiNi88EkKPBDrRgW?=
 =?us-ascii?Q?barVCFTzvLllyjbnUAMdLUCA0OBFGzEZVvV8J+MMPQ1GNhJmJl6KSUnxoHfX?=
 =?us-ascii?Q?G3IbVvbmki8lfDkooY8Km2ZmV1QFdT+uG6G1domKaWUDaNdMzG1pR7avSP2Z?=
 =?us-ascii?Q?bNescDgqL16zXJMxNWxFBEs0dO56YaNruRb31B6bOrot2OeBQxsYKVc7F9zu?=
 =?us-ascii?Q?pLfvdX/Bc5NF2bvh5My9ssbpyr6HNV3QNY8gBUWDaJ/UZmR1IYCvItsMBPCJ?=
 =?us-ascii?Q?yc+ZSTtMQGA/Tye4HRvpxt+faV+nVNXNKm1z70vwu0GRci3wCc9Iwkeysmwf?=
 =?us-ascii?Q?Lfsx0f5Poy2x4cgdnOTGba28YiuFFzAfQM1thmQ/6QNQ5X25t64i7H2k0bC9?=
 =?us-ascii?Q?Gf94Z2xhY1mIG8OYRSVXtx59Vsyq0derWw0xp8mgqoQ3dCb3V9Fbl+Oc65AJ?=
 =?us-ascii?Q?zGyypImmSluIb50F3q6zUIwG/SWBcjqa+KeLcQyn4lpqbbvHzj5f6sHfdqCO?=
 =?us-ascii?Q?W1+FhQNaUtUvLsYqep3KKTdYT/8nEwsiV/UcCG8MRBoAtF2jTG5My6G1H6e/?=
 =?us-ascii?Q?mZlglQ7+ZNGUFh8wZNcOlUbZu2SkN1UDYPO461MDC/ndQKDSlt0CdGomMFRV?=
 =?us-ascii?Q?ZRCGiV1ovf6/C9wN2AjzweqoKYVAQz6zGMuu1aGvR5Si8nDLwGX6GIt5TQJD?=
 =?us-ascii?Q?C4xhZqic2yR820GqclBPLw7yAhbmvxW7gxOQxkYi/ZAu1ig/Vhc1ii8PrDR8?=
 =?us-ascii?Q?fHR7RpabxqjPqFdAd2tpj+NEVkg67UHFsyg2gYO1daX+56nxjKEGUxPnbD1v?=
 =?us-ascii?Q?zzly3/lgz2FMpPGT0UkBe0CzJpTbFDqYVsQbe+D7f3PjB5SCvsPBOl89uvXz?=
 =?us-ascii?Q?s42qedqEN92KDUPTHawzn4L2CN6EV8ITkMw1iVY9JBNw+JL+2jumnTm4Hs8Q?=
 =?us-ascii?Q?u3GItQ00Ch2TP2qxIbpPFcFhy1LTCs9gfEnU9na3GpPGrvOii9LKrRZp6pRX?=
 =?us-ascii?Q?3jvTngT2VUY4aiQQQN84+07TDzJ4/4YxLGD62NKu1S7e4SoZz5wnqLyrNVK8?=
 =?us-ascii?Q?I+AlJME8JUwU+wSybtSwF0mkg7XqlH5w5YXWTvh582GUKzXV6gnhg1ApQKRf?=
 =?us-ascii?Q?xN44TRPHHQ7t/JvkeLFheJNX3OM6q1BhtAhDdIsy+jsnX20882EEKQtUYCLM?=
 =?us-ascii?Q?kEWhNKU0sZEiCPXu1Wz3fVlwolFREphVgGGJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:53:31.6238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5733966-26d2-416c-c6ed-08dd9d92d4c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
Add support for 2nd sharpening range for cases where we want
override existing DCN sharpening range

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 ++++++
 .../gpu/drm/amd/display/dc/dc_spl_translate.c | 19 +++++++++--------
 .../dc/resource/dcn401/dcn401_resource.c      | 21 +++++++++++++++++++
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a63f7fe277fa..6b0471f635f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -46,6 +46,8 @@
 
 #include "dmub/inc/dmub_cmd.h"
 
+#include "sspl/dc_spl_types.h"
+
 struct abm_save_restore;
 
 /* forward declaration */
@@ -512,6 +514,8 @@ struct dc_config {
 	bool set_pipe_unlock_order;
 	bool enable_dpia_pre_training;
 	bool unify_link_enc_assignment;
+	struct spl_sharpness_range dcn_sharpness_range;
+	struct spl_sharpness_range dcn_override_sharpness_range;
 };
 
 enum visual_confirm {
@@ -1420,6 +1424,8 @@ struct dc_plane_state {
 	int sharpness_level;
 	enum linear_light_scaling linear_light_scaling;
 	unsigned int sdr_white_level_nits;
+	struct spl_sharpness_range sharpness_range;
+	enum sharpness_range_source sharpness_source;
 };
 
 struct dc_plane_info {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index e3a8283b4098..7f57661433eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -156,15 +156,16 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 		spl_in->adaptive_sharpness.enable = true;
 		spl_in->adaptive_sharpness.sharpness_level = 0;
 	} else if (sharpness_setting == SHARPNESS_CUSTOM) {
-		spl_in->adaptive_sharpness.sharpness_range.sdr_rgb_min = 0;
-		spl_in->adaptive_sharpness.sharpness_range.sdr_rgb_max = 1750;
-		spl_in->adaptive_sharpness.sharpness_range.sdr_rgb_mid = 750;
-		spl_in->adaptive_sharpness.sharpness_range.sdr_yuv_min = 0;
-		spl_in->adaptive_sharpness.sharpness_range.sdr_yuv_max = 3500;
-		spl_in->adaptive_sharpness.sharpness_range.sdr_yuv_mid = 1500;
-		spl_in->adaptive_sharpness.sharpness_range.hdr_rgb_min = 0;
-		spl_in->adaptive_sharpness.sharpness_range.hdr_rgb_max = 2750;
-		spl_in->adaptive_sharpness.sharpness_range.hdr_rgb_mid = 1500;
+		/* SAT: read harpness_range from dc_plane_state */
+		spl_in->adaptive_sharpness.sharpness_range.sdr_rgb_min = plane_state->sharpness_range.sdr_rgb_min;
+		spl_in->adaptive_sharpness.sharpness_range.sdr_rgb_max = plane_state->sharpness_range.sdr_rgb_max;
+		spl_in->adaptive_sharpness.sharpness_range.sdr_rgb_mid = plane_state->sharpness_range.sdr_rgb_mid;
+		spl_in->adaptive_sharpness.sharpness_range.sdr_yuv_min = plane_state->sharpness_range.sdr_yuv_min;
+		spl_in->adaptive_sharpness.sharpness_range.sdr_yuv_max = plane_state->sharpness_range.sdr_yuv_max;
+		spl_in->adaptive_sharpness.sharpness_range.sdr_yuv_mid = plane_state->sharpness_range.sdr_yuv_mid;
+		spl_in->adaptive_sharpness.sharpness_range.hdr_rgb_min = plane_state->sharpness_range.hdr_rgb_min;
+		spl_in->adaptive_sharpness.sharpness_range.hdr_rgb_max = plane_state->sharpness_range.hdr_rgb_max;
+		spl_in->adaptive_sharpness.sharpness_range.hdr_rgb_mid = plane_state->sharpness_range.hdr_rgb_mid;
 
 		if (force_sharpness_level > 0) {
 			if (force_sharpness_level > 10)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index f420c4dafa03..fbb6db1baaad 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1959,6 +1959,27 @@ static bool dcn401_resource_construct(
 	dc->caps.color.mpc.ocsc = 1;
 	dc->config.use_spl = true;
 	dc->config.prefer_easf = true;
+
+	dc->config.dcn_sharpness_range.sdr_rgb_min = 0;
+	dc->config.dcn_sharpness_range.sdr_rgb_max = 1750;
+	dc->config.dcn_sharpness_range.sdr_rgb_mid = 750;
+	dc->config.dcn_sharpness_range.sdr_yuv_min = 0;
+	dc->config.dcn_sharpness_range.sdr_yuv_max = 3500;
+	dc->config.dcn_sharpness_range.sdr_yuv_mid = 1500;
+	dc->config.dcn_sharpness_range.hdr_rgb_min = 0;
+	dc->config.dcn_sharpness_range.hdr_rgb_max = 2750;
+	dc->config.dcn_sharpness_range.hdr_rgb_mid = 1500;
+
+	dc->config.dcn_override_sharpness_range.sdr_rgb_min = 0;
+	dc->config.dcn_override_sharpness_range.sdr_rgb_max = 3250;
+	dc->config.dcn_override_sharpness_range.sdr_rgb_mid = 1250;
+	dc->config.dcn_override_sharpness_range.sdr_yuv_min = 0;
+	dc->config.dcn_override_sharpness_range.sdr_yuv_max = 3500;
+	dc->config.dcn_override_sharpness_range.sdr_yuv_mid = 1500;
+	dc->config.dcn_override_sharpness_range.hdr_rgb_min = 0;
+	dc->config.dcn_override_sharpness_range.hdr_rgb_max = 2750;
+	dc->config.dcn_override_sharpness_range.hdr_rgb_mid = 1500;
+
 	dc->config.dc_mode_clk_limit_support = true;
 	dc->config.enable_windowed_mpo_odm = true;
 	dc->config.set_pipe_unlock_order = true; /* Need to ensure DET gets freed before allocating */
-- 
2.43.0

