Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA9CFEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7E210E65A;
	Wed, 18 Mar 2026 01:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ys+6MWO2";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E884110E65A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS7si5JXBR7NCFb0udyALnSRPv+xWhgAVJfEm9ccJovx3/qnptg5NLKZ9t1/SsUTWQbhK0Ic7DhL/T1SWyML4YJPIWcKZvqiN8aqL7LmPraZRqUtHvd5TyXnITMFwYRuKsfOgNjOBpc79m0F0SnwoNgFH7eij/ByaZpgcPSCzu0WSeVz47VuhKagR/BEHSBhNMoxlOhCaIr0sZ3szrynZvafPwZAXDvtwHOzB79banprRHoxDBpF26EQ6Ufj+Cz32+UDA7jBau88J0V3kv4DmIU51qc0H+D0yqHyR3dJC28Sf22qmMogTg9mTJ3918GSGfJV/0R9jS9txZG6M2lyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOlLm+pPYlaQMRPaiyRBD1GuVfwX2uoc33UteaqKP20=;
 b=ATSeJChuhAAVxJjKRNt8FTXgMmsST2II6+J5HzsVe2kA9goOkOSFmfGm/bltVny0aTAsrO58IMsssrzVotMVi4b0+ly5xR+ZSh3rguje7BOCxHvpv72Qnoy1gA68FL7Z8mYF6ySoZU4U6PtfwH3OcUaHrGFKkyqx+Kx1UOan9X8aQCxxc4CK6ISt+EdlkqI44wO6HSyXrmp7xYNZvlfrNxJP1Y9riGWZIbDjANJLSOX05Q57R360ZivTel6rCoHN+5iruKMWew3GTlZEfdHFQfq7veI6MyHRNbUKFuw79WTamDUZVHtQHqZgNJ97bANHKQwodmhpW/VhRmTjrHBSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOlLm+pPYlaQMRPaiyRBD1GuVfwX2uoc33UteaqKP20=;
 b=Ys+6MWO2Vv7csr0++gIGLZUyXSFk222pwulOOyjl+Uj7jzCBq3bNLX+rDLDsbxqkQoYa4DjiGwe6gEv81HcEjs+e5XvRRlHKXDX0R8sQg0QFaww2jMEjGzpv7plJXT95Ie8ZdVlJ7eRpq70oJ/GdijF29swzpWJhPTfv0NkIdw4=
Received: from PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::15)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 01:02:54 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::9d) by PH8P220CA0030.outlook.office365.com
 (2603:10b6:510:348::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:54 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:50 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 30/31] drm/amd/display: Rework YCbCr422 DSC policy
Date: Wed, 18 Mar 2026 08:59:39 +0800
Message-ID: <20260318010224.513094-31-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: eafe75b6-3500-4226-0e28-08de848a1606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: pojyNGsbEYJSli8wyWAVBIgLV7SlG+GrY08qCNRNYZwvQmJZMbrFlXUO6zfdEnanLz2/UcH5wrhEZQiutvSVsieR5rJLrDcuYd/zTSd1b4HiZOBamC997buL/iE2XDsLmoboLujnifd1RzzP88wo8sCeBB0H0SePfNzSPu1wGC7Idd2Nh+p/WPA4WT8jcSDvwAt16HUabjEiVRjG9/L1LwJBCLQ/evXByWfEgu3d0zekjaQdN6hR66Gxvl7IT20xTKUx+dbrAhFj6KJCcsNkLnqC2oWtGp/eX+SXZQUM2E0uQLJzp6Xxv4uXOjBypEwg7JajugLUfe3pwvGTPLjFDRa3LlLT9IYvQ2FfBGM+OgNeldO3q+UqLalD1xgiFKb9VSWJF032tEcqMUQ0WiJZXQqsaSrpqM5aT17L0MSBftOSKyctLoLSMfm3ccQXvbiwkX6Ovfj1fNJ2JrhyX8aXuz5lZHA0yQFRIo6BK0NkGkqNb8Kr1WQRWdgsNcMbao8tS5kEhtj1JhDQeeAchVBwgNhfsCexiRy6e0IdPNOMzRdK5prMpWnZE8XQgZpWUplKmNawk4YsYhBISPn3ux6cMf6Turlw8fbAt2r3o5/3+2Kgp9rcvJD9lWp0R3qqr4pbivZE098V8JoDtJ8uC8BJYd7Vp1zbNBCkUdhPNEy1hMcvHMntAP4+BRqGIg1kDA2eC88AifLNEZSTU2U1OwSY5CrQNByl8XKkk3L7knrJfpC8x6LKrb+9NApBuiU3n4vINP7tIgUy8c5guApZHTmnWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gTm9LlnZujGCz04oNq9dbxV15VuxtCc7z5eCa8VA7t2oeK/ludO/KfKHD2zwHUmjh+9gMJseGXUjzU4b2q0wIdDQaxosIPNwpsrT0KnO7MOrvLzC/osnZ+z+S6cwtesCEiNuhs0thmMzaydxNi7STQ3WN/cN3Pov2Ylx/tXNhfirpZg103rgXuYWx2Um1k3bocKVV4Wsn3dZP4c3VsKdFp3rnLfLjUxqXoC3GA0sN9oJVPg/P89dIcSfb+wFKXQM1B97BRQar7rRKQmtmpwcR0ITkpMtnS4ON3A2ek5YfLoWCwzWYYRoWbFfVFNMH8gOl2x6sogFgfTMa33Ut824otlf8yblM+cuDVNhqamiTOFdVSfGevi7y1t/UpiqmvIaHkcdrxNoa4P+oMz9p6IaL565bLjDuPzmDnjc1Hq0P4pByxZWSSnNs4t2NTvxVM2B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:54.2688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eafe75b6-3500-4226-0e28-08de848a1606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
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

- Reworked YCbCr4:2:2 Native/Simple policy decision making with DSC
enabled based on DSC caps and stream signal type

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                 |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h             |  1 +
 .../amd/display/dc/dml2_0/dml2_translation_helper.c |  6 +++---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c         | 13 ++++++-------
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c    |  2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c    |  2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c  |  2 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c    | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c     |  3 ++-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c  |  2 ++
 .../display/dc/resource/dcn315/dcn315_resource.c    |  2 ++
 11 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1dd0a2cf786c..2bb4c7751c01 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -563,6 +563,7 @@ struct dc_config {
 	bool frame_update_cmd_version2;
 	struct spl_sharpness_range dcn_sharpness_range;
 	struct spl_sharpness_range dcn_override_sharpness_range;
+	bool no_native422_support;
 };
 
 enum visual_confirm {
@@ -987,7 +988,6 @@ struct link_service;
  * causing an issue or not.
  */
 struct dc_debug_options {
-	bool native422_support;
 	bool disable_dsc;
 	enum visual_confirm visual_confirm;
 	int visual_confirm_rect_height;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 9d18f1c08079..101bce6b8de6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -52,6 +52,7 @@ struct dc_dsc_policy {
 	uint32_t max_target_bpp;
 	uint32_t min_target_bpp;
 	bool enable_dsc_when_not_needed;
+	bool ycbcr422_simple;
 };
 
 struct dc_dsc_config_options {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
index d834cb595afa..e25b88f2d6b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
@@ -1174,12 +1174,12 @@ static unsigned int map_plane_to_dml_display_cfg(const struct dml2_context *dml2
 		const struct dc_state *context, const struct dml_display_cfg_st *dml_dispcfg, unsigned int stream_id, int plane_index)
 {
 	unsigned int plane_id;
-	int i = 0;
-	int location = -1;
+	unsigned int i = 0;
+	unsigned int location = UINT_MAX;
 
 	if (!get_plane_id(context->bw_ctx.dml2, context, plane, stream_id, plane_index, &plane_id)) {
 		ASSERT(false);
-		return -1;
+		return UINT_MAX;
 	}
 
 	for (i = 0; i < __DML2_WRAPPER_MAX_STREAMS_PLANES__; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 5b3584ad5b6b..8dfb6dd14eb2 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -680,9 +680,6 @@ static void get_dsc_enc_caps(
 	} else {
 		build_dsc_enc_caps(dsc, dsc_enc_caps);
 	}
-
-	if (dsc->ctx->dc->debug.native422_support)
-		dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
 }
 
 /* Returns 'false' if no intersection was found for at least one capability.
@@ -1100,13 +1097,14 @@ static bool setup_dsc_config(
 		branch_max_throughput_mps = dsc_sink_caps->branch_overall_throughput_0_mps;
 		break;
 	case PIXEL_ENCODING_YCBCR422:
-		is_dsc_possible = (bool)dsc_common_caps.color_formats.bits.YCBCR_NATIVE_422;
-		sink_per_slice_throughput_mps = dsc_sink_caps->throughput_mode_1_mps;
-		branch_max_throughput_mps = dsc_sink_caps->branch_overall_throughput_1_mps;
-		if (!is_dsc_possible) {
+		if (policy.ycbcr422_simple) {
 			is_dsc_possible = (bool)dsc_common_caps.color_formats.bits.YCBCR_SIMPLE_422;
 			dsc_cfg->ycbcr422_simple = is_dsc_possible;
 			sink_per_slice_throughput_mps = dsc_sink_caps->throughput_mode_0_mps;
+		} else {
+			is_dsc_possible = (bool)dsc_common_caps.color_formats.bits.YCBCR_NATIVE_422;
+			sink_per_slice_throughput_mps = dsc_sink_caps->throughput_mode_1_mps;
+			branch_max_throughput_mps = dsc_sink_caps->branch_overall_throughput_1_mps;
 		}
 		break;
 	case PIXEL_ENCODING_YCBCR420:
@@ -1406,6 +1404,7 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		policy->min_target_bpp = 8;
 		/* DP specs limits to 3 x bpc */
 		policy->max_target_bpp = 3 * bpc;
+		policy->ycbcr422_simple = true;
 		break;
 	case PIXEL_ENCODING_YCBCR420:
 		/* DP specs limits to 6 */
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index 242f1e6f0d8f..6e1e759462bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -100,7 +100,7 @@ void dsc2_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
 	dsc_enc_caps->color_formats.bits.RGB = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_444 = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_SIMPLE_422 = 1;
-	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 0;
+	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_420 = 1;
 
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
index e712985f7abd..17acb64a9d80 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
@@ -128,7 +128,7 @@ void dsc35_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsigned int m
 	dsc_enc_caps->color_formats.bits.RGB = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_444 = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_SIMPLE_422 = 1;
-	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 0;
+	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_420 = 1;
 
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index c1bdbb38c690..bbb8b5b18a4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -78,7 +78,7 @@ static void dsc401_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsign
 	dsc_enc_caps->color_formats.bits.RGB = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_444 = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_SIMPLE_422 = 1;
-	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 0;
+	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
 	dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_420 = 1;
 
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index f992c2d16748..7f1761080aba 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -781,7 +781,6 @@ static void restore_phy_clocks_for_destructive_link_verification(const struct dc
 }
 
 static void verify_link_capability_destructive(struct dc_link *link,
-		struct dc_sink *sink,
 		enum dc_detect_reason reason)
 {
 	bool should_prepare_phy_clocks =
@@ -855,11 +854,11 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
 	return destrictive;
 }
 
-static void verify_link_capability(struct dc_link *link, struct dc_sink *sink,
+static void verify_link_capability(struct dc_link *link,
 		enum dc_detect_reason reason)
 {
 	if (should_verify_link_capability_destructively(link, reason))
-		verify_link_capability_destructive(link, sink, reason);
+		verify_link_capability_destructive(link, reason);
 	else
 		verify_link_capability_non_destructive(link);
 }
@@ -1453,8 +1452,9 @@ bool link_detect(struct dc_link *link, enum dc_detect_reason reason)
 
 	is_local_sink_detect_success = detect_link_and_local_sink(link, reason);
 
-	if (is_local_sink_detect_success && link->local_sink)
-		verify_link_capability(link, link->local_sink, reason);
+	if (is_local_sink_detect_success && link->local_sink) {
+		verify_link_capability(link, reason);
+	}
 
 	DC_LOG_DC("%s: link_index=%d is_local_sink_detect_success=%d pre_link_type=%d link_type=%d\n", __func__,
 				link->link_index, is_local_sink_detect_success, pre_link_type, link->type);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index b4f46408a000..e12c25896364 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -181,7 +181,8 @@ void link_set_all_streams_dpms_off_for_link(struct dc_link *link)
 	/* link can be also enabled by vbios. In this case it is not recorded
 	 * in pipe_ctx. Disable link phy here to make sure it is completely off
 	 */
-	dp_disable_link_phy(link, &link_res, link->connector_signal);
+	if (dc_is_dp_signal(link->connector_signal))
+		dp_disable_link_phy(link, &link_res, link->connector_signal);
 }
 
 void link_resume(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index a064d1fbce52..95c7ecdb3496 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1967,6 +1967,8 @@ static bool dcn31_resource_construct(
 	dc->config.use_pipe_ctx_sync_logic = true;
 	dc->config.disable_hbr_audio_dp2 = true;
 
+	dc->config.no_native422_support = true;
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 67102b4c881f..e488fa6f32e6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1929,6 +1929,8 @@ static bool dcn315_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->config.no_native422_support = true;
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.43.0

