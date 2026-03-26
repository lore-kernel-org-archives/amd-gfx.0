Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E254109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDF010E938;
	Thu, 26 Mar 2026 03:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S7uMxlZu";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010057.outbound.protection.outlook.com
 [40.93.198.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0F710E938
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrqkLlWZ74h6Yf4U3JDfUq41nMTk0rzUWS2MAfKmRq7/aQrTDn1qWf9VxpKW0q907SoAjNylVlC1wf9Ct+GHlvni7db/IILfcAwjFt900rTMq7Vfj0B3YTTjfaHSVmM8de7fS5Zwe5Ob7YaLPk1UZpo9jG2gtxbCdVv50LEqPPPX3Pxu7MzPRtDubl+qCcY5Ne7v2U92otRnzjMdXdBZ2mIH9sHDNP5ktniGFk+b9KRWQ9FIMJD5yD+e17rcL++wVpJR0WQu9w3cU9pivW7TwZXCImDmzpA2fmAk45wE9/69oXyn/FV6dw+DUt+jWEr1PZUQyEdsfeB6N1hAlLh9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSfg/YO1IKZ9SsiQghBTh/T90MwdS8fEx0Pim3+itec=;
 b=dmEE2S7UsuEOTLPA7v1/oojGk8DZ+HzKKiOKDMCYA3HcZ62/ErhIh/haBaz/sVbLLbjoG/6ml3R77LiGECTRzpxey6NMKb24qkoPdFJQYn7+NTUaFFeH2DvrjLVFbRoiu9uHK45SFds79YfXH2F1GQUngoLsDQzz2ESRzsk+r3rSbDHrfS/VNckZftOvDFMSoa3coO0x1WU/m/deavBmOnDfsM9sVWHV1JF5Vb13wm/1XjudtXz7KXyPftJDyrg/QLkZaoPvKzz8bh1n9VJ2gsUJYttv3HYjVPHb7KQVxaH2fcVvOU2mQFKKxFqvApjOBwaU4fUiB/h0zsk5JltlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSfg/YO1IKZ9SsiQghBTh/T90MwdS8fEx0Pim3+itec=;
 b=S7uMxlZueXZM8dH4MS2UYt1nLn5Q+pb7ByezlmHM/zcotFnxrGf5E7Mmkjr7otvzTEFh4Rl/toERXOJFkIn2n+WNlVeXTjUowMIKXlNWchxxHoSiTMdyjwvmqPNkIh7fEjsaaGxwPE92Khqjbu0jqIYkGEsRBjnRePLCDwsfJCs=
Received: from MN2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:208:239::27)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::985) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:01:32 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::9e) by MN2PR08CA0022.outlook.office365.com
 (2603:10b6:208:239::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:31 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:26 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 16/30] Revert "drm/amd/display: Rework YCbCr422 DSC policy"
Date: Thu, 26 Mar 2026 10:57:07 +0800
Message-ID: <20260326030153.406612-17-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: d14eb0f2-cf99-4bb5-dd2a-08de8ae3fbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: iLLkvQmeZo3l+t8qQSH5F2l77OxaIGNyyjt2CScC9BFAK4gZbiPeLr0fbqdoqukjypdt7o0GYAuNxIqS/gDoyVxPQ75IvE4czSSQAGr+KCmtokT2kz92rJqPkJqFQHXEWBuHpHgH2wo7BoPESjAbB7CyqqlpWRGPHPU3QDkJnFKlPUw/z+tYE0g2mfcybHY5CAQo/l1n1Un1yyF59WeI34ZgAuAqtVKW3EI6wCAfN/LB7+/x5R5jHsh6PcwQgPRRn6394/Yn/HDJb5RFuZfBrQaq8laDnqsmUEVvElZcrvwCH6I0bIm5QcnP2nAkICv3nbYZ18cj0JSzQ2n7h5IOLBfp0Tu0eq0Nt6U36rLIu3h/Vsb9X6uhcGue44AeSgB4QEZaoS7Qa3Vi53ni7nm3fEhgqaCzfeiP/OdR4C3QroALLvRlPpajO6Z/UdLN9iPKcSEqycc/57lCu2fft1WbhKF3VMU9DZzYIxygPiw46+E46FSGic/zKngeC3RkBXJ9E4iiHhQJg0mrj9NdUww6wUQ9Vc/Q1CUujF5zEYd6WxZ9Tnv75Pna0j0nvrumlazPu4ThHyLzEPBnM5d8P8Vs5nMYtwlFqBUj9ajZPvJSyBBHZPgFf31KIZtlf5IMZpemaPLfCMGT2M7SYeTyc/e9gbFsg8sEGxbFmmw2FoxDUZ+4e42g639Lcbao+r9BVU9zBUD/RxQldYaMPf0SgxkOhzs1SlazzRJbbe6kyijUUoNPcJCefaw29XhJZEXoLhdMqeL01CuY/AekN7MbBoAE8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5UaWIONkqrOpda5Et+LXe76NvDHL8PvCuXRA+FYftBuD+8Uk+L4ANs2qKBXFCKB8hAcueegdCVV9sJUHtcbgzJIFDVp72LdXoj2bB9AWMuvuK1jQJ4bsVeDtF7+2KE8ea0uv7Wn/pNiDrxsz3scSMN1WotQrMpAOLD78rMWE1L8na86vmhEr99hQiWGeQdtgtf/2ZjFuLNLQwuyjADirvMDjiBeHMV50ToDU8kBIYQ3YahKL1L8J+hHgC3etSLP4goA8qRmXnY9Xq9KhE4VQgb0PcGlxtIDu13GjGPChOupSpInNxEVQkhMvgQ2JJNF8Bj2ytc7lAnelBnsoK+7LBShrQ+q+FaxTd/yox7cw2BzDrHaD4emTXryw5Nk1RjjFzu5km572Ht0q+P5torP7+JpyNdbiprhZKtfQ+KHgatTR8vFk5Dxr8WDwlloDZC1m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:31.9981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14eb0f2-cf99-4bb5-dd2a-08de8ae3fbd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2
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

From: Relja Vojvodic <Relja.Vojvodic@amd.com>

Revert commit 085d98740327 ("drm/amd/display: Rework YCbCr422 DSC policy")

Reason for Revert:
This commit is causing compliance failures

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                 |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h             |  1 -
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c         | 13 +++++++------
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c    |  2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c    |  2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c  |  2 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c    | 11 ++++++-----
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c     |  3 +--
 .../amd/display/dc/resource/dcn31/dcn31_resource.c  |  2 --
 .../display/dc/resource/dcn315/dcn315_resource.c    |  2 --
 10 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 48b523fabbbe..ab7dea9d47f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -563,7 +563,6 @@ struct dc_config {
 	bool frame_update_cmd_version2;
 	struct spl_sharpness_range dcn_sharpness_range;
 	struct spl_sharpness_range dcn_override_sharpness_range;
-	bool no_native422_support;
 };
 
 enum visual_confirm {
@@ -988,6 +987,7 @@ struct link_service;
  * causing an issue or not.
  */
 struct dc_debug_options {
+	bool native422_support;
 	bool disable_dsc;
 	enum visual_confirm visual_confirm;
 	int visual_confirm_rect_height;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 101bce6b8de6..9d18f1c08079 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -52,7 +52,6 @@ struct dc_dsc_policy {
 	uint32_t max_target_bpp;
 	uint32_t min_target_bpp;
 	bool enable_dsc_when_not_needed;
-	bool ycbcr422_simple;
 };
 
 struct dc_dsc_config_options {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 8dfb6dd14eb2..5b3584ad5b6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -680,6 +680,9 @@ static void get_dsc_enc_caps(
 	} else {
 		build_dsc_enc_caps(dsc, dsc_enc_caps);
 	}
+
+	if (dsc->ctx->dc->debug.native422_support)
+		dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
 }
 
 /* Returns 'false' if no intersection was found for at least one capability.
@@ -1097,14 +1100,13 @@ static bool setup_dsc_config(
 		branch_max_throughput_mps = dsc_sink_caps->branch_overall_throughput_0_mps;
 		break;
 	case PIXEL_ENCODING_YCBCR422:
-		if (policy.ycbcr422_simple) {
+		is_dsc_possible = (bool)dsc_common_caps.color_formats.bits.YCBCR_NATIVE_422;
+		sink_per_slice_throughput_mps = dsc_sink_caps->throughput_mode_1_mps;
+		branch_max_throughput_mps = dsc_sink_caps->branch_overall_throughput_1_mps;
+		if (!is_dsc_possible) {
 			is_dsc_possible = (bool)dsc_common_caps.color_formats.bits.YCBCR_SIMPLE_422;
 			dsc_cfg->ycbcr422_simple = is_dsc_possible;
 			sink_per_slice_throughput_mps = dsc_sink_caps->throughput_mode_0_mps;
-		} else {
-			is_dsc_possible = (bool)dsc_common_caps.color_formats.bits.YCBCR_NATIVE_422;
-			sink_per_slice_throughput_mps = dsc_sink_caps->throughput_mode_1_mps;
-			branch_max_throughput_mps = dsc_sink_caps->branch_overall_throughput_1_mps;
 		}
 		break;
 	case PIXEL_ENCODING_YCBCR420:
@@ -1404,7 +1406,6 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		policy->min_target_bpp = 8;
 		/* DP specs limits to 3 x bpc */
 		policy->max_target_bpp = 3 * bpc;
-		policy->ycbcr422_simple = true;
 		break;
 	case PIXEL_ENCODING_YCBCR420:
 		/* DP specs limits to 6 */
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index 6e1e759462bf..242f1e6f0d8f 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -100,7 +100,7 @@ void dsc2_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
 	dsc_enc_caps->color_formats.bits.RGB = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_444 = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_SIMPLE_422 = 1;
-	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
+	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 0;
 	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_420 = 1;
 
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
index 17acb64a9d80..e712985f7abd 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
@@ -128,7 +128,7 @@ void dsc35_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsigned int m
 	dsc_enc_caps->color_formats.bits.RGB = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_444 = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_SIMPLE_422 = 1;
-	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
+	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 0;
 	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_420 = 1;
 
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index bbb8b5b18a4e..c1bdbb38c690 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -78,7 +78,7 @@ static void dsc401_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsign
 	dsc_enc_caps->color_formats.bits.RGB = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_444 = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_SIMPLE_422 = 1;
-	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
+	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 0;
 	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_420 = 1;
 
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 7f1761080aba..b761f330311f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -781,8 +781,10 @@ static void restore_phy_clocks_for_destructive_link_verification(const struct dc
 }
 
 static void verify_link_capability_destructive(struct dc_link *link,
+		struct dc_sink *sink,
 		enum dc_detect_reason reason)
 {
+	(void)sink;
 	bool should_prepare_phy_clocks =
 			should_prepare_phy_clocks_for_link_verification(link->dc, reason);
 
@@ -854,11 +856,11 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
 	return destrictive;
 }
 
-static void verify_link_capability(struct dc_link *link,
+static void verify_link_capability(struct dc_link *link, struct dc_sink *sink,
 		enum dc_detect_reason reason)
 {
 	if (should_verify_link_capability_destructively(link, reason))
-		verify_link_capability_destructive(link, reason);
+		verify_link_capability_destructive(link, sink, reason);
 	else
 		verify_link_capability_non_destructive(link);
 }
@@ -1452,9 +1454,8 @@ bool link_detect(struct dc_link *link, enum dc_detect_reason reason)
 
 	is_local_sink_detect_success = detect_link_and_local_sink(link, reason);
 
-	if (is_local_sink_detect_success && link->local_sink) {
-		verify_link_capability(link, reason);
-	}
+	if (is_local_sink_detect_success && link->local_sink)
+		verify_link_capability(link, link->local_sink, reason);
 
 	DC_LOG_DC("%s: link_index=%d is_local_sink_detect_success=%d pre_link_type=%d link_type=%d\n", __func__,
 				link->link_index, is_local_sink_detect_success, pre_link_type, link->type);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index e12c25896364..b4f46408a000 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -181,8 +181,7 @@ void link_set_all_streams_dpms_off_for_link(struct dc_link *link)
 	/* link can be also enabled by vbios. In this case it is not recorded
 	 * in pipe_ctx. Disable link phy here to make sure it is completely off
 	 */
-	if (dc_is_dp_signal(link->connector_signal))
-		dp_disable_link_phy(link, &link_res, link->connector_signal);
+	dp_disable_link_phy(link, &link_res, link->connector_signal);
 }
 
 void link_resume(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 9d7520a384ae..e14b00cba962 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1967,8 +1967,6 @@ static bool dcn31_resource_construct(
 	dc->config.use_pipe_ctx_sync_logic = true;
 	dc->config.disable_hbr_audio_dp2 = true;
 
-	dc->config.no_native422_support = true;
-
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 9ded310c74b6..999fef8879be 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1930,8 +1930,6 @@ static bool dcn315_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
-	dc->config.no_native422_support = true;
-
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.43.0

