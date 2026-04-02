Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D701D6AAF9
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF48A10F2EF;
	Thu,  2 Apr 2026 18:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Hmn6qTl";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB0210F2E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPOO2r0GmhtdKDW3ughnOb3zDVa0JtVFpKXC/KYJcc+Hbv37YRFmPNrRJNR8I37ksBzvRyhnSqxqQNkHR1k81sS6Vht/ak2lBiTl3nD/TrGxSWJ1g/VVawRtxdCM3ZCA2wS7sIL10vU6dyeA52DC8/NVDrNn+FCmeM0IJ+SQWg4YkVzhKbljLQx8gyB6OXEdurumxpFIaBaEFpuObc3Pj78yDwomq0/Li1jkDMmwO3/GMkIdAOorR1/Ek6q7g1/f57CHnwjFLQ6WAbg2ZIkyU+Rf56vklpnsoYX7dLXvFQgyEZulldkZfgIzUYKXvUEZv4smTtIcNiSuT8+6YaeD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoAS2Jg2BN76/mGpfu1cStE0v1cE3gCufPaNmce9Tr4=;
 b=CMaLWpYeXNr6iVOHEAwpOTmleCmjZ9EHCG2Hb7SpOelP9X7buxDRiz0pCR5fTBpgPBcazSWTBuer2y+0/zZHduarJ6S7/3XmPw+VS1BJluXs/O68BdYF8nXL0Ou1v1tWMDSAt2CIbEvq+PWpXKhaOaqYmNOg45u/jP+vWm/YjtECBHfB67+/XC8zkQBhWgbwKGkCQ0eQFmEU2ncXzYEGHgpLj3WRI8EwRsJD2y7b+bY01FybcCkW5/3XiYI1aGia1tnP7vnrWGdbKuzc0gSICi394PYBmSXro89TfJFB/1SKY7xf0Xt1aPQeRUuXAYMDgD/8rHYlZr/mm77zsOn9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoAS2Jg2BN76/mGpfu1cStE0v1cE3gCufPaNmce9Tr4=;
 b=2Hmn6qTllmWKgrI+uyoJ8KR742DM7qff0orNOltTBlUZLrQXn1ctrM0RE8fNiT/AN+MGZATQ8KK44dpCK8Px1Aqv1wLPgPWEYzc2RTO88cQSRyqg0+hjF7DXFzKY33PDkXV7zKnUscBNs3QL/BXI0sCMrfGNCaBgCA4czOiho8w=
Received: from CH2PR07CA0044.namprd07.prod.outlook.com (2603:10b6:610:5b::18)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:33:37 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::d0) by CH2PR07CA0044.outlook.office365.com
 (2603:10b6:610:5b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 18:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:33:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:33:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 11:33:35 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:33:35 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Relja Vojvodic
 <Relja.Vojvodic@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 04/22] drm/amd/display: Rework YCbCr422 DSC policy
Date: Thu, 2 Apr 2026 14:32:56 -0400
Message-ID: <20260402183314.1388755-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b97b535-59e2-4ab9-27f1-08de90e65ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: l568Dirq6dvc8PDHElfzeTx2pkcnzFMihD0bVD0HDc4lDoRJ2GrD5cN83YGNi5dEiTy2kQsXWhTMfbxG+vRyNxVpWd1Btgv0hPQXewZDBuiUYXkfL9zBGbhXOmlOcV+75gCz3V1fDJ8R5Frq7u+7sog1uCE6Of+ywqCb636+BLsHoPPemKQl4EUYdvUU/XLt71SAxcKXsznKyAwFqwARNj2nXRymWbhor6Lfk/g/XkZCtucowGWNogvzNX9TkJpyCYywV0S7OdY36Rj1QQccHmt1BzDiief84ReQFBB79efDinegyJQv9wjOVej++kjhLxvHX/Spt+T0JFMRIX7ZElnsLl4oLIQRBgRu4fhiSQnPf0oFrxg0GeLRUu97/B2oCSYWV4jikyDAy5tJW5ow6gHzOoHdjBO5hprFwJSDdOLNG2DzJLmzBQLRcqU1611l1N67zakYUNH1Oxxk1TsUrPukxOSO/vUYWe1HxwmDgm8hs1Vasa5hhlhwVGiEEQySOmZ7CdXfEJBkCSfJ1nVa9WXqtooBKhQlf48SQEz/aPe7vCJCYIX/Dk4Of2/u5yTj6r5kaGcN4mqdiDNXYx3/t5EQVTjGtwUtfOWMxCNhcu8OTBAPyM9lKN5UiqO50RojRmPj+J4U0WZ2F93OXiJgvMBllUexo4OyXE17XBdJdwYK8dNl+PIcFxcGDnDZA5By9k7iKuXj8M2KY4hTGXOACJ+f20K/SRgkBj/3+Wu44ZJA3q4oPjlqJohHrqrZ9D8DOwimQAld97DJkEa1+SNhrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zk6SF9TzMGFZa+S2RcpR7G7+oQoxYTYl24g8LKeWxujAOwy26dnS60VsPHHQfbVZsmHj12uWwIGiu/70/MBYlAnoVR4SHoUFM74H3nqqJS2irvYxcLYF1ESgxAxktEa0u8Lucla3BuyQKgZKO8HJpPR7B22nipXORipb5mbN0yKrWKmoNJ+eVF3xYEphZsJGKBnZQN8DsYDeOtrUhkgvMt71jo8/VLiKwNcGyVQfrTri8VrPqJVFTSpJMFcviyykw+X7RRw9oiuvOcf1gWTOqgZtls1LkNl6v1QWHJ2vPXqCgb9Z8D3GgVzR3bd8sUeAHrxibD2pTI/AIePrQeUn8a/2P9jUhTYkgI7qn6eJXx6Zw3uRoD1pRa6fwlaMJgNsqPHPvJtbBS/QGTCKPW+JOUZGuy2ERNh9E9apIA6Sofdz/GRXWZ/4i+9xcC7Z+dXC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:33:37.2762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b97b535-59e2-4ab9-27f1-08de90e65ac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                 |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h             |  1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c         | 13 ++++++-------
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c    |  2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c    |  2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c  |  2 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c    | 11 +++++------
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c     |  3 ++-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c  |  2 ++
 .../display/dc/resource/dcn315/dcn315_resource.c    |  2 ++
 10 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 55ec281db3b7..5ceadcdca524 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -562,6 +562,7 @@ struct dc_config {
 	bool frame_update_cmd_version2;
 	struct spl_sharpness_range dcn_sharpness_range;
 	struct spl_sharpness_range dcn_override_sharpness_range;
+	bool no_native422_support;
 };
 
 enum visual_confirm {
@@ -986,7 +987,6 @@ struct link_service;
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
index 3bf737195bac..41c3b814b6bd 100644
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
index 59851924bfcd..714370e773c1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -781,10 +781,8 @@ static void restore_phy_clocks_for_destructive_link_verification(const struct dc
 }
 
 static void verify_link_capability_destructive(struct dc_link *link,
-		struct dc_sink *sink,
 		enum dc_detect_reason reason)
 {
-	(void)sink;
 	bool should_prepare_phy_clocks =
 			should_prepare_phy_clocks_for_link_verification(link->dc, reason);
 
@@ -857,11 +855,11 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
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
@@ -1455,8 +1453,9 @@ bool link_detect(struct dc_link *link, enum dc_detect_reason reason)
 
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
index 295ff6366462..87a22c38656e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1968,6 +1968,8 @@ static bool dcn31_resource_construct(
 	dc->config.use_pipe_ctx_sync_logic = true;
 	dc->config.disable_hbr_audio_dp2 = true;
 
+	dc->config.no_native422_support = true;
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 63a84b37c854..fb44892c1ecb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1931,6 +1931,8 @@ static bool dcn315_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->config.no_native422_support = true;
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.34.1

