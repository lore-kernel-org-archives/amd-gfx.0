Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC8DFEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE2AE10E7A5;
	Wed, 25 Mar 2026 07:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sTLVO7ZN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A1E10E7A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WViS7Zaw0DR4/xTLEvZO55R1B4CvDph8K+UQIE16g1ZurYsmSMMXneeebUSxDb8xMHN5EOmux9bT3X73WOrT7cHZcY/hkAf2v8A/2IcpnTaFiJu2/mMMGQi+18OO1eZ7EYhTKh/SLkdTNO+hbov3WzrEy4XSI7rq80CMh51gIhsW7PxZyw4vHrt16Maxc0RvjBcKZm7mp4OOoxCaoj8w8rsPIxoLoKBvPLSBqxRM3nCwoi/VAoX9eQRjKmOIg3IvglAfpDw//UcYWzKb3XHwW4UFMxUe8gVww0P/lC0o6hj5NIGCmD0FMfIm9gmbMjhKAvWjOeWnH1Q6dtKf2UrZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSfg/YO1IKZ9SsiQghBTh/T90MwdS8fEx0Pim3+itec=;
 b=j/m1F9oXYPVq37GyMoJp0JaxgN8YO3Nxmkaqdgg4sUEM7M966R5e4x6mxn+lQPP71LmOjl79wz5W9gOfYh2YFdaxRcZDtYWLr+4Hcl3xGYZsYe+F1frIH4tieHOERbBKn7mc9Kd5PYC2/mYwv8IANrO7dnzKpOmDC821Pkzi1R+x1tMAr0OLzQpXvp5vrGP3GEt2StjR/xNftl2XyK69u4A2etwq072fSYCf+KS8GtPmvVcIAzNT2XBj41M7FpdWUq1ByN7DyEaLAlhms4QOJmy8AtMIH/TPwdm7kB2N6e+i4NXSXQLGI+eZtdaLSNMnxshHWettP5XlHAxK/VjUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSfg/YO1IKZ9SsiQghBTh/T90MwdS8fEx0Pim3+itec=;
 b=sTLVO7ZNQxVDs7RJLEQrvRlPlY+5F8m7uPY44Kc5N5Bs+yc+qGxKXgQ45dbgHgvbgYcnt+AgbBqHgMJu4oA26zZONj+lt5uazDNPz2Ejtt1KuuXB+9aVk36LLzx9W1GH6ay07NtphGCOlZVhx/+46vGl+sTGbxvvSJPAivEPFCc=
Received: from BL0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:91::15)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:09:32 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::77) by BL0PR05CA0005.outlook.office365.com
 (2603:10b6:208:91::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Wed,
 25 Mar 2026 07:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 07:09:32 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:28 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 15/29] Revert "drm/amd/display: Rework YCbCr422 DSC policy"
Date: Wed, 25 Mar 2026 15:06:21 +0800
Message-ID: <20260325071003.4022594-16-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: de07b95f-d8b7-46f2-dfa0-08de8a3d76af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 60O1Lx8oavCcmgdDPAV1sILwOVbZoX1sCULLS8upgiSTzYGnCVlQy8tRfF31qAVWeSQh4k0yrYHTeYcqIwHKJhsRyimgjcwLA3SFpeXtYlGiuKKwLCVIv5hCbDiA1A9ckodMOJUXPLxBi/isb0UUWPdZjL14tf58e0wbYTith/AeyuLpXSHp6NkxJIQ3LP1VUL2g47/7mnsPnCMpgGeJ3LQx/zPMlFXsxMbjBf9tG2rUnDNHDj0ItVZXJzZUaysFtesSBzy0p2UxJu/l6uZ65s268SuAKc7osQfDWvPEUYtVAtJZl7QYjCD4p7i5Un9P/yI51wI3HKlnT6tu2FF8d0J0VadrntX+QjvShLV73hkn0H5HpRyvzYnbS04l5C+yoKjiYmuHOS580Er/bZPT/HYSytMUEAdexl5qWrgtGDRtAJYAeJm1K3s0L8Svtti2TPTrRKQqhOCsggM703Y01McBETyR9HltHymZZvKOUwZXcfXCXc+QPCI1DjUM1nuLm+j0f8aG5pr5HTeKYBnxYrqz+i9fksi4MJtaA+mEf84RXeD3eZiO34kqVqujvBzbxwbIkts60Ys2vy27eVx0ifMChCwVcblH5oOnU2044KInXE1RJ1kWCzv9cwBHxkjACLT2d3MxouqrzjgcQQF0vuh4Sg/n+Juo6B0zH838eUxB6XAgKtR0yt9YKlXinbDG+0jdqoLWjPG4ysItXEO17c3Z9EBmz3wdBXrunrMMkZkCUZ8uHF50KAEotNnEck45q87wPDhAdHAt25433R3/hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OuwHdn889zTjN6ogJumROP/vtG0iIo5a4IFpZGuTFMvojnDCmmBiWp92s8K1uaSQr0h13ngKgzz86RgOZ2MTjK3a5AkYi3wIwGqA5K9icPlaCEF/KNf1UAO2xFcclStGuFhP0Cjww2W35M83UA/15DhZvKuobZHOXxOBeBQkbsYGYiRDmNPrbE6rwAQHu4aZkIJ0ftxFcIggNa5ZfzaFGI20MhtnHgikJeHFnc4g7a8U1zDTwzWSTYK9VyXaf7YNS9h7gwxcKHDiXXfa6vi+oLWIa2Dr2rWm7sHUMCJVopD23CJ7VN+KlQqqiRg4v19DkBQWv4pSKedhN6AUVontlQlGzoFz2AarvzfsHEKCwb4tLiXwYozmuUEI1ouwttpzHbCRnwiDudS6mpQgDpgJb/3qJnVC8S4pZ8hxg6XuyJGruB1aPN7TzAfXlhhksf0J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:32.1584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de07b95f-d8b7-46f2-dfa0-08de8a3d76af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
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

