Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9304CFD647
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6021610E639;
	Wed,  7 Jan 2026 15:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TpzkGWhs";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C86110E638
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDXv+F3v3f+BNHu+UQXQEvkqzqSElMmmvlK72IdIWjUUImQphXxCdpmAKGVWfpjxdRLZu7Dk5f8eUhsFw6jDSNAvVowIqBZcVl7oYJhPm+A/+zPQ/4IZXCVs8goFohiBDrq0I6V+hbYSjCnY+79AhLs9ZVGQgakf+91bSImx1qW3IK8+VoZG9Kyoa3ma+X1v1F6bdqqO464NnlqB3JrKEF9eyQB1llfVUEOiJUskcxp7v2eykOZ2tBYz/CTV41UoCQqW0JVvsyi1/huOFzBvFTUyrOPEcAmRwA35b5baQZ8nOMYbFZ+DnPBn/9Qn9GMtoX3skJap+wMsy+VOacjGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlijzAnanyNX2WuLDDaGplhrXgQCubeKZEJXT89YifU=;
 b=Pa1+DwqMpmSQh7wjujs52S6VUi+QP36odWqoF6+u/654zyrpCEWRF6uPi88nJT7TvZHIt2J6iD6wd5JCtWH883H1qTE+cpUGXTFJ4kizDdTiw3wmZqVneYEVJilujVRMoQhFAaTPFwxXBCZ1ujWA5xKyRLe+5Gss7ICldk5FKHJPZDUE54tpKaLEYZ6bIgnujADBhPLh+NAiUHHrWIHu9IZqnYOUInkqCESGHiLi/jBKFQ78a2ulfWqNDuGYuq+8eYEwW6Ddhtny8HHQ8iWalamDvMcDQ/YzooKajNFt5k0YxS62vEuhGp0z08ILQGLa9f/VnOKcZ45BYxMqqWE+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlijzAnanyNX2WuLDDaGplhrXgQCubeKZEJXT89YifU=;
 b=TpzkGWhs85ZVpJNFehHcxxVdi57CCtJqVGE1T/2n3j84/gioIUyihOPX+rkFmi3XCaxlDdDG45DI2CVYjmAJaDDh3b5FK+asTuB7oa2kE7Uq3EW0XK0sDuZKWbEU7ruKREAUvdUnmiHrlk3c+W4SRQiARz0HJ8I5/Sz9D2k/Sts=
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:11 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::bf) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:00 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:59 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Derek Lai <Derek.Lai@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 11/21] drm/amd/display: revert "write default Vesa Aux
 backlight control in dmub"
Date: Wed, 7 Jan 2026 10:48:03 -0500
Message-ID: <20260107155421.1999951-12-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: ad542d11-b63f-4522-5848-08de4e058ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gn4N+uSfzWmgGUTAi3WpPiCzXwtw6Apds51+vGrXFK5F8ZMxtG17oFopX1Bk?=
 =?us-ascii?Q?1PE8bEkgl0QNPfV12MTeMgZjk3SevYtrvPauheJ4XIOVptjAPb5rpbpyGI3E?=
 =?us-ascii?Q?OnvQE2N3hYxp/cHMSXidWfIOZ/YNDP4snu8rXlBtyriBCoXyHGmqgO4vbRCu?=
 =?us-ascii?Q?RfwIgImCeK40iWhy2ZZOqp1L0+IdX21a6EyLaN58D/EWdk6u8YdAqJQ64odv?=
 =?us-ascii?Q?YSKwplggIy2pQss2lCZSi8uoITpe+b1aBq/jHcVhzWRfM6jqeL4fsbcw/Gly?=
 =?us-ascii?Q?04SBK9F6ZuMME6lXQMw9jXahKH8kywgRgGNu1X8uIKotH0x8954XZ5rLO52m?=
 =?us-ascii?Q?jxzLGxF7uJZqkbbcjvrE0DaUnCFQgBkoo299Sgn1GjMzDO2AzsOr+go5emLY?=
 =?us-ascii?Q?mBVVySaQDo9QsS+vDVdYgnFqYAg6xC/SMVvLmhzjJ9x7Y/PL726nVxKbjsUq?=
 =?us-ascii?Q?82k52DAvyCasSvqPjz4HRFPr+H1ugdU5yPWzAcDngIh2CCkVSEd4YS+vsP3g?=
 =?us-ascii?Q?cF7nw+D5vXGcIgJk45c/aeYGU4+j6NJAJW+b0n3lk1abusNzI1OrzLBMcrx5?=
 =?us-ascii?Q?bv5QZ7GVqLepbeeidgTGml9y8zeu+dQgZSThvrrkKI1DIMOrE37eFxYIwnWB?=
 =?us-ascii?Q?UP/u2Z0WN1REfj2MjuMgGcPT30XXLcUw+NJUrRhvZOgGGKFDhMkcNb3XJLjS?=
 =?us-ascii?Q?AzwWqsPAsEoaUIoviSmtBR/wlFQLj3JBNxavIgkVrtWOZN1E/1CIRFETgOOv?=
 =?us-ascii?Q?iypSmarsAY2GJmHCvGpa5iqnNtGcyvicYltBGwZT5glGbA6tbUnRVf8NS8jz?=
 =?us-ascii?Q?D8gj+BxLLIzuXJlg38BtbQNnDZDrFQKep9taydl1pofnIuPniq8RfNyqqVZf?=
 =?us-ascii?Q?JYzbMoJ4xsJhLuH8aRmz1elJCCbi/KEZ8XbaL559BMlOsMsScfEyaRpIqrjA?=
 =?us-ascii?Q?Cp3P6mhXXU88FOQEz2TQq+yTyz71jLabKQyr9ljz7Nrm72fHIxNq6c8Ju2im?=
 =?us-ascii?Q?O/FSxBILlmVSut3Eh4Iscr9wtdsXUMTdffWCc3PhFdi39YqshdoKjSsWDXPp?=
 =?us-ascii?Q?Utz3fdq4eoatO+tzMXUjc5jDN8WMMcZH2yF2JIDwxCW2k+/wFIP3y0C4ZqMB?=
 =?us-ascii?Q?WX3Jis9b2Vhc1oJjNQha86B91cyLDT3sNMN9lW+ss24DoLhG7mMf3kgqUXQY?=
 =?us-ascii?Q?rUfulTQrLhVnYniGqXQmI9oBoqLfpHpCBLA9+L9clZw4c7KHG+9+9b8o6TbP?=
 =?us-ascii?Q?wNVYQD2R99o5dWNYZc3LGe9NCLRVweyB8atKNMy66s660lZzwvvIwf6D+1PC?=
 =?us-ascii?Q?rJVs2qdcd5u4QBGXujqGKuE0m9rke/LmVzF63Lsgv0kYkOOGLDqjSl3F4/xo?=
 =?us-ascii?Q?tpClCs2ZgllU/Gby6nDnV93reoC8AaLwyEZa/jgWz1O4eEeT3jzF3sQDzl5b?=
 =?us-ascii?Q?Rt/zuynye3zqoKmGO8FA1B8uasRCAowEC/bBALUOAdwodqw/t2k9YrUsovql?=
 =?us-ascii?Q?3JY4DMwPDLMbhvm+UCFEvo1yudDYMp1s0aQz2QO3ZdOpb5C2HAESgZuUVXLS?=
 =?us-ascii?Q?Nj6QsLNqAgH2LjBeymw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:11.3088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad542d11-b63f-4522-5848-08de4e058ef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
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

From: Derek Lai <Derek.Lai@amd.com>

This reverts commit 60349741aa11.

Commit causing backlight darker when the system wakes up
from standby mode, and green screen w/ secondary screen only
when the system wakes up from standby mode.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Derek Lai <Derek.Lai@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../drm/amd/display/dc/link/link_detection.c  |  2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  4 +--
 .../dc/link/protocols/link_dp_capability.c    |  2 +-
 .../link/protocols/link_edp_panel_control.c   | 26 +++----------------
 .../link/protocols/link_edp_panel_control.h   |  2 +-
 5 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 2c9d2b932482..578509e8d0e2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -995,7 +995,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			(link->dpcd_sink_ext_caps.bits.oled == 1)) {
 			dpcd_set_source_specific_data(link);
 			msleep(post_oui_delay);
-			set_default_brightness(link);
+			set_default_brightness_aux(link);
 		}
 
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 323cc0b3c09a..7e46ea98952c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2061,7 +2061,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		skip_video_pattern = false;
 
 	if (stream->sink_patches.oled_optimize_display_on)
-		set_default_brightness(link);
+		set_default_brightness_aux(link);
 
 	if (perform_link_training_with_retries(link_settings,
 					       skip_video_pattern,
@@ -2087,7 +2087,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1 ||
 		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1) {
 		if (!stream->sink_patches.oled_optimize_display_on) {
-			set_default_brightness(link);
+			set_default_brightness_aux(link);
 			if (link->dpcd_sink_ext_caps.bits.oled == 1)
 				msleep(bl_oled_enable_delay);
 			edp_backlight_enable_aux(link, true);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 8bbf5637b166..cdc7587cf0b6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2210,7 +2210,7 @@ void detect_edp_sink_caps(struct dc_link *link)
 	link->dpcd_caps.set_power_state_capable_edp =
 				(general_edp_cap & DP_EDP_SET_POWER_CAP) ? true : false;
 
-	set_default_brightness(link);
+	set_default_brightness_aux(link);
 
 	core_link_read_dpcd(link, DP_EDP_DPCD_REV,
 		&link->dpcd_caps.edp_rev,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index ab047ff556a1..cb4129c0937a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -50,11 +50,6 @@ static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
 /* Nutmeg */
 static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
 
-static const unsigned int pwr_default_min_brightness_millinits = 1000;
-static const unsigned int pwr_default_sdr_brightness_millinits = 270000;
-static const unsigned int pwr_default_min_backlight_pwm = 0xC0C;
-static const unsigned int pwr_default_max_backlight_pwm = 0xFFFF;
-
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 {
 	union dpcd_edp_config edp_config_set;
@@ -313,7 +308,7 @@ static bool read_default_bl_aux(struct dc_link *link, uint32_t *backlight_millin
 	return true;
 }
 
-bool set_default_brightness(struct dc_link *link)
+bool set_default_brightness_aux(struct dc_link *link)
 {
 	uint32_t default_backlight;
 
@@ -324,23 +319,8 @@ bool set_default_brightness(struct dc_link *link)
 		if (default_backlight < 1000 || default_backlight > 5000000)
 			default_backlight = 150000;
 
-		if (link->backlight_control_type == BACKLIGHT_CONTROL_VESA_AUX &&
-			link->dc->caps.dmub_caps.aux_backlight_support) {
-			struct set_backlight_level_params backlight_level_params = { 0 };
-
-			backlight_level_params.aux_inst =  link->ddc->ddc_pin->hw_info.ddc_channel;
-			backlight_level_params.control_type = BACKLIGHT_CONTROL_VESA_AUX;
-			backlight_level_params.backlight_pwm_u16_16 = default_backlight;
-			backlight_level_params.transition_time_in_ms = 0;
-			// filled in the driver BL default values
-			backlight_level_params.min_luminance = pwr_default_min_brightness_millinits;
-			backlight_level_params.max_luminance = pwr_default_sdr_brightness_millinits;
-			backlight_level_params.min_backlight_pwm = pwr_default_min_backlight_pwm;
-			backlight_level_params.max_backlight_pwm = pwr_default_max_backlight_pwm;
-			return edp_set_backlight_level(link, &backlight_level_params);
-		} else
-			return edp_set_backlight_level_nits(link, true,
-					default_backlight, 0);
+		return edp_set_backlight_level_nits(link, true,
+				default_backlight, 0);
 	}
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 8780bbc4e8c5..8fdb76d9953e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -29,7 +29,7 @@
 
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
-bool set_default_brightness(struct dc_link *link);
+bool set_default_brightness_aux(struct dc_link *link);
 bool is_smartmux_suported(struct dc_link *link);
 void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd);
 int edp_get_backlight_level(const struct dc_link *link);
-- 
2.52.0

