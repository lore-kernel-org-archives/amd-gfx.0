Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56761CF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE42710E7B3;
	Thu, 20 Nov 2025 18:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qyMVaSfx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 775FA10E7B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAB+pK81lGE/YKhOS+OvB7+kxYJ72Zt3p7XqmkiQF0GeHjgeIoMYyAXjk5+OhKSdELr/AhQiv+OjaEy/+W3zXAShPFQ9a3ItUiFFxfdThCuQ3rwMtMu/mHaOt6KR7msUGIzX0R15i+MGdPelb7uXFxUWmVPDP4BY6iNb9e6+hhCtb4Cg6cp+xXSKJEqCtdBQ7gQ0MPgkGiXNfAOkq+WN5uYPvaY48l3U1cGwoJjOXOV5SQmBUYHix+8zCKX+byJPDAPaFjyaMTCNE7RLZWwOMnqeBgABqrHfBIw7XdMMgKrwTcHglVh2pRcr6T8eR3ySbVQoRLzsNJG9rXwKyD+beQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJQ7fmpRsGnJm6A+W0suD00gtM8gjoO6iLP4U1uhJNo=;
 b=jJCJqIr5EBdsQoAOhl8Yr0VtrnBIXiKRy2BiUDwmRq1Ut36f3+4gaR9AOYHF9HpoOFsMB7DDlDfUmeeIf6T+Mh3P4pzHI9hrpQnkrsM6yQLe2KH4OO4a0yYchLoJC+opAtRmMtMrUyOvLawiWzjxlqaR1FNTGWBHMwqbWHB9ESkMprsPPUqL5IMrv3/KpIWRyNUlb+VYTNriR7NcTJ3WWHhRw5QM88YEE1GYcyNo2zCgK8vH+sC1plzvAT5viq7S9c5+MUtN5AMMfQ7ZcIUvoSyrhLMCHFq0F1s/Peup08RdVu82cjnSopoP22L7usShH14gD46ZBvQnR6SAT0DjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJQ7fmpRsGnJm6A+W0suD00gtM8gjoO6iLP4U1uhJNo=;
 b=qyMVaSfxgBC74ezPXTUgsBsaCp7NceZHb8dV5po4pLj//z9kRfuTF+hQESM0Yid7Rfk//oOK9XBfrc+eg6LEDatUwtIbKIlcjvT/fwKHGItiURhSRT71cgJAYh/DpPIvDPSCb+4QsFjueX+gSNJ0PPQWwWP6a4kAJI80rdl4FQk=
Received: from DS7PR03CA0189.namprd03.prod.outlook.com (2603:10b6:5:3b6::14)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:19:06 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::ef) by DS7PR03CA0189.outlook.office365.com
 (2603:10b6:5:3b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Thu,
 20 Nov 2025 18:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:19:06 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:19:03 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Derek Lai <Derek.Lai@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 09/26] drm/amd/display: Write default Vesa Aux backlight
 control in dmub
Date: Thu, 20 Nov 2025 11:03:05 -0700
Message-ID: <20251120181527.317107-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: f2eb24bb-ec7d-447a-e821-08de28614a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NSy6Lc9R0GoFcN1C/D43fSLgLjaSk+VX/ZvA0qh8uS0sCeWJh9Jnn3i52R6e?=
 =?us-ascii?Q?YbOB0qnzCwPIZVn8vzintfSSdh/FkffRtJFlsBNAYFWPek36zA+ZPuGlSBPw?=
 =?us-ascii?Q?9+dfYwzTEylib6vTL2K0dSbKd7r/D424Um3zoIo3rysFDwSW23NffCEpUkUj?=
 =?us-ascii?Q?F6Oa2dVAMj+7wmcqXjHZtgDaVA8xu60Lwzuvtl/9CP7QFfdkmVT+u0wRUgvE?=
 =?us-ascii?Q?EdzP0NEw6OWYT4pNpojUWA9cJsMs/W4UEnca3g1bbM+Ho7EgdTZSle+nhgUw?=
 =?us-ascii?Q?nOesKhh3Igz4PZKAf9OW8hnVdwIjvdoLdKM1fXIhBxhSP1TWObELV2Yqo9lU?=
 =?us-ascii?Q?rGfY/ocpMb+9Oe0hMxFD7b/15NJQT3d7+we91gPQ/pWHJDwi8jTVMggS0Jn8?=
 =?us-ascii?Q?aFJSoGBj2hw1cEIyvBWkmip76Jf/Q6tJ+mRPJm/i/MV3z9jMfd4yiwnKRHCg?=
 =?us-ascii?Q?/qrvAMXHLOejxxUIrIBqa7ez4W+t4KemQIElnpBs5QgD1Rk9Ytjd/qc7fTen?=
 =?us-ascii?Q?iDsYY2gPi/MDQHTH9ibLGU16J0urz9EOVo9PZ1WeV6SEjB51r7chI9J8/mCl?=
 =?us-ascii?Q?dnzUR1zPXC1v8QGBdUE91MaL/tKil4BeAF6rA5/dvpElS1vYrudeIY2wk9jr?=
 =?us-ascii?Q?cAp2n9NzhL9d2o7JwSvQ7dIO5dg/0LLPO3O4J6VzBGgvEe3GJPvWOF5BKMVG?=
 =?us-ascii?Q?DXGBn3fIIUZP8OmMUliNbpAmEmA67gLkngI1QT41FkhbTa1GyjXKShAgv1iS?=
 =?us-ascii?Q?neDmOEanaaZ0iDgp6UyxouA72xSwTDOQM2ZFqTxtnpDK5lZrUkHMVdzVwYWc?=
 =?us-ascii?Q?qjj8s0tYgsXpwvdW7uxHga8P30q9sN5GklVlB0UTpfyyuG04WaZq3UICIwKu?=
 =?us-ascii?Q?VESwOrzdDhxIkNSvSmkg/u8xPjU6lXiH6aboFYI3VN5wtBxJTkCAU6bEjAw4?=
 =?us-ascii?Q?UwNOV4TRdZFgL7MuRlFHAkbHfXb1m8cMMLATPYGr2LOwcrzNnBw+nVFoi7kY?=
 =?us-ascii?Q?fo7ZpCfAOKTmK65HSmKBkl4r4WSuHwdh6flXDfy9gf2zFf2wHTq97Uc3bNCh?=
 =?us-ascii?Q?2Knu+fvWvAA8sckrAKjtWkoGFej+s7EsyEK1X1ogeT4gulNfYq00K5yHV39X?=
 =?us-ascii?Q?yaVZVxN8bAtLW/vOE6Ck7xnhE3RG/XC3dgJXdMMV1cvN7XvPYOEnVpCxqFiW?=
 =?us-ascii?Q?34PpPLwMFWr1kJb1YQrb37zxQOIhulNr3V7M0T2/mt/5tIN6Kw6Q5/mMGpNr?=
 =?us-ascii?Q?op0p4Ah2dQnWJqbkQC39E1CP6KWr9ztzFIMdUChXvRHxETjnxur/iZ3cyJHw?=
 =?us-ascii?Q?zcWMiRvW+kfkGRmmnPMFqyxhrBiwsRsEmqv4DT2cCSedkrTfatsHNZ0j4Vgl?=
 =?us-ascii?Q?ADMBx2T5ba44ximxJoxaD0U5rwsWYAu2h2uaVD0DBz8vU42cbkQ3aYoMJmcX?=
 =?us-ascii?Q?KrSvFC2TrnNavwgxiX8Oa0V4GDXD8RWjS1uV4saSgusUnOX6QL0HsckIoVE3?=
 =?us-ascii?Q?fmBBWYwBLAMrT6Uncn/E3jBv0GcwuY7nTfmcLBDRnVJrxWJjWgZUp6mX5ftF?=
 =?us-ascii?Q?kkmbz6L8VOVGdi1JqSU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:19:06.0792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2eb24bb-ec7d-447a-e821-08de28614a97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
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

[WHY]
Some OLED panels require driver to write Aux BL before link training or
turning on backlight; otherwise monitor brightness will change.

[HOW]
Write the default Vesa Aux backlight control in dmub.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Derek Lai <Derek.Lai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/link/link_detection.c  |  2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  4 +--
 .../dc/link/protocols/link_dp_capability.c    |  2 +-
 .../link/protocols/link_edp_panel_control.c   | 26 ++++++++++++++++---
 .../link/protocols/link_edp_panel_control.h   |  2 +-
 5 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 6d31f4967f1a..9746bb2f6c3b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -989,7 +989,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			(link->dpcd_sink_ext_caps.bits.oled == 1)) {
 			dpcd_set_source_specific_data(link);
 			msleep(post_oui_delay);
-			set_default_brightness_aux(link);
+			set_default_brightness(link);
 		}
 
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 475f71bb48ff..1b1ce3839922 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2115,7 +2115,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		skip_video_pattern = false;
 
 	if (stream->sink_patches.oled_optimize_display_on)
-		set_default_brightness_aux(link);
+		set_default_brightness(link);
 
 	if (perform_link_training_with_retries(link_settings,
 					       skip_video_pattern,
@@ -2141,7 +2141,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1 ||
 		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1) {
 		if (!stream->sink_patches.oled_optimize_display_on) {
-			set_default_brightness_aux(link);
+			set_default_brightness(link);
 			if (link->dpcd_sink_ext_caps.bits.oled == 1)
 				msleep(bl_oled_enable_delay);
 			edp_backlight_enable_aux(link, true);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ad90a0106938..3884851e2a9e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2167,7 +2167,7 @@ void detect_edp_sink_caps(struct dc_link *link)
 	link->dpcd_caps.set_power_state_capable_edp =
 				(general_edp_cap & DP_EDP_SET_POWER_CAP) ? true : false;
 
-	set_default_brightness_aux(link);
+	set_default_brightness(link);
 
 	core_link_read_dpcd(link, DP_EDP_DPCD_REV,
 		&link->dpcd_caps.edp_rev,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 99741c1334ca..0b05ee9f6ea1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -50,6 +50,11 @@ static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
 /* Nutmeg */
 static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
 
+static const unsigned int pwr_default_min_brightness_millinits = 1000;
+static const unsigned int pwr_default_sdr_brightness_millinits = 270000;
+static const unsigned int pwr_default_min_backlight_pwm = 0xC0C;
+static const unsigned int pwr_default_max_backlight_pwm = 0xFFFF;
+
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 {
 	union dpcd_edp_config edp_config_set;
@@ -309,7 +314,7 @@ static bool read_default_bl_aux(struct dc_link *link, uint32_t *backlight_millin
 	return true;
 }
 
-bool set_default_brightness_aux(struct dc_link *link)
+bool set_default_brightness(struct dc_link *link)
 {
 	uint32_t default_backlight;
 
@@ -320,8 +325,23 @@ bool set_default_brightness_aux(struct dc_link *link)
 		if (default_backlight < 1000 || default_backlight > 5000000)
 			default_backlight = 150000;
 
-		return edp_set_backlight_level_nits(link, true,
-				default_backlight, 0);
+		if (link->backlight_control_type == BACKLIGHT_CONTROL_VESA_AUX &&
+			link->dc->caps.dmub_caps.aux_backlight_support) {
+			struct set_backlight_level_params backlight_level_params = { 0 };
+
+			backlight_level_params.aux_inst =  link->ddc->ddc_pin->hw_info.ddc_channel;
+			backlight_level_params.control_type = BACKLIGHT_CONTROL_VESA_AUX;
+			backlight_level_params.backlight_pwm_u16_16 = default_backlight;
+			backlight_level_params.transition_time_in_ms = 0;
+			// filled in the driver BL default values
+			backlight_level_params.min_luminance = pwr_default_min_brightness_millinits;
+			backlight_level_params.max_luminance = pwr_default_sdr_brightness_millinits;
+			backlight_level_params.min_backlight_pwm = pwr_default_min_backlight_pwm;
+			backlight_level_params.max_backlight_pwm = pwr_default_max_backlight_pwm;
+			return edp_set_backlight_level(link, &backlight_level_params);
+		} else
+			return edp_set_backlight_level_nits(link, true,
+					default_backlight, 0);
 	}
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 360129732109..fd63b5d0f948 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -29,7 +29,7 @@
 
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
-bool set_default_brightness_aux(struct dc_link *link);
+bool set_default_brightness(struct dc_link *link);
 bool is_smartmux_suported(struct dc_link *link);
 void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd);
 int edp_get_backlight_level(const struct dc_link *link);
-- 
2.43.0

