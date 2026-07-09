Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61EEC44510
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35ABA10F70D;
	Thu,  9 Jul 2026 21:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GYGsoLOx";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013055.outbound.protection.outlook.com
 [40.93.196.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4BD10F6ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBteZPQ5pb1nKc8FXHJUyVse8QebrEnPVosHz8sPDAxpwZc0rCoUu6kULaGtOqdCMVLESGtvnlNdIwOUYUl6MODDk3L5Q2PW0TedmmL6e7RSpQnR82NQk5ajREJVFIukYIZ9nJicZ+VnTsYQCSiiEq/QI6aBUufmc695npp0XJhYZgO3BjgV0eevuBC/HOc+qINktvyid7n7H95vbGv0c6q/GnCeeyHtenizFbyYG8Mx/MGtlzYyQpGAp42p1uRlNmSwzWye2tsxGRuHTpgKn+RcqBNeFkrns/ZTVmDdlyjnh2z4hqz8tB+b7gnwjrrIFiHs2HU7W5u1gD+xfhboFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sfgm+W/Suz77Qb7rq8BiiiyhJXQig2ksTNOgEZHKKng=;
 b=XrHKm7LfYhnOp7EwthLQ3g1fvYKs5Gv2XTsQoFbvOfGopkG7pJHJGh5KwYNZ/l0UG3D9ymfy2f4uU2+Mu3krSJOjXUCrO9iMdCXzskXJd22iFGrHaURj7jRWWZvsLQTY6m9pT0XrnhvvNIQ79l1d06wi21LFvMRaTATT0rcLgwqnFhjOZT+kXBEfEjCR13gAuoPwPPlmDuBTs0TEng9WGx9FLsQbI2VnaH/YXcsXHhj+4LOutgIFBpKd4PXohE4/tNBKkiP4a63egPi1ksZIhNsQB4t1do/XuBKZlaII7lAZungvwyarJdVFVtXJpGXduTOTl9KHTqEFadkWs9/zUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sfgm+W/Suz77Qb7rq8BiiiyhJXQig2ksTNOgEZHKKng=;
 b=GYGsoLOxtGAJ07QZ6Huvnn3U9oGTWOYfwcKYmpYtsSrqAjRu+yawd71wqjKVvEcd57cD4Y1MzyogKBmcpEXFLZb7ZPDq44NI1ZZamVTda7111YlV3hkw7T1Nj7q6FM++KNSC+r+FTxro64M8mPUseEucXKAh499YKFAnRZO0zSw=
Received: from BL1P223CA0043.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::9)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:33 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::63) by BL1P223CA0043.outlook.office365.com
 (2603:10b6:208:5b6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:33 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:17 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Iswara Nagulendran <Iswara.Nagulendran@amd.com>,
 Anthony Koo <anthony.koo@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 George Zhang <george.zhang@amd.com>
Subject: [PATCH 54/80] drm/amd/display: Fix VABC Init and OLED Support
Date: Thu, 9 Jul 2026 16:48:22 -0400
Message-ID: <20260709205936.5719-55-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c0a1ae-0e04-4a6a-f23a-08deddfd65cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|3023799007|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: fWMvMpTZTqnpeax/OJBefsxJ0E8l6BxP/9T7vDB0/scXd5J3wlu0NE/DL38YGugEMq1Dy5NKKEmgyGPWrJmcnDBEr+M1TvVuSFO6a2uj3hvXNbOHGmQWbgfHa/O2MQQsgD7u84tQ7I1YoQ/36dBp82GNTOh1868ihlDe68RTkaJU2H406P5njluEMLSz+ZHoavNTT/M/HhfsrSvzNipmOVT9PRbH9LMjjHTRSdGO2q/2790stZyJ5CrZv5LsFFYR+oO0lrjoxq76jkbY1x7mIZ2CZUkW92r0MCNgyQdseqRntcMcDfNp6ab+vfpe8Sqq4D9p7ZWLqHLxIxODDAmAgTRA8ZrLn/K7IapiG+0Dkpwv+4/G/QRj0eKgVGpatWJB4yfsO2ttXjsNeJvBCa9wwsrZho4kL3QEDl8VcO72fkqstuWOmDnjPcyDjhZEO5Oe9yksLB6oPi+/TIxGO9ZUBK6rPfdocus8CUtZsoL6B1GcN8mwHMXDpBkWSMWGiyXsH6btQAvXaeT6I95dyryfr4FPB9DgncuvEmByl6HqLp/RvROMYUxjDqH8dxpsT3hD6ra0LDTwc90jXX2zebuttEvwHXf8shL2oujJJPhqyzFRD0imEk+U9fI427XWO54z0no6tPypyrHcF76MjRZFS2qXqcDcov+y1H935zsL5zvwt8p9vLsldjD4GES4X/EDn3OC2vf9wJDp4/g8qtZNRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jntqElIb5ix5n4EH8681vhDmaWS4byVVxbxjMytWKgw+jmNMPvL7ebVvVAbIsXu+sXYasZOS195+q7/VtuPPzgHmvxv+y80nDF1AgBKGaatlg6UA3dyNfQicmrXJ2bWj1C5lrBCwgB4Y34dld6yQdTnCpANE110uYomYnmXHF5thOME4K4doeWY7oSWbttH42AKICnhUhnor59GwBbPZlIA3BCPwXb+1FC+x5Fc628MBDRlCvhFlHNEpwQ6NOXNVwq0T7JqAW6qPaxtdxKK93Il6wWBQwH3yZIB4H3CblPWIIvZ3tiqTrUvEfEb//YPl7iaKDx9JBmt/u85ELLiN1jv2Xn5impvL6Ilo8v/31T4GLe84O5m2/0+7ZiIcLlt2hpVmiBj4YkKE8UfA7isscM1N74k75ECo9U3e56MeFXt87RoxzzRDGKdj5NrRtdZM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:33.7210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c0a1ae-0e04-4a6a-f23a-08deddfd65cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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

From: Iswara Nagulendran <Iswara.Nagulendran@amd.com>

[Why]
TCONs supporting VESA AUX Backlight does not always
support VESA Smooth Brightness. Driver software
needs to implement smooth brightness by periodically
updating the brightness by small steps. Driver
implementation is completed and verified on LCD
panels but solution is missing for OLED panels.

[How]
Updated driver to include smooth brightness for
OLED panels using VESA Aux Backlight.
Revert original workaround for VABC on oled issue,
as it is no longer needed.
Add VABC backlight Initialization sequence from
driver side.
Add fix to remove conflict between FW and driver
backlight programming for future ASIC.
Enable VABC for all future asic revisions.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Iswara Nagulendran <Iswara.Nagulendran@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 41 ++++++++++++++++++-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  2 +
 .../link/protocols/link_edp_panel_control.c   | 13 +++---
 .../drm/amd/display/modules/power/power_abm.c | 10 ++++-
 4 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index e72e10c276de..b6f3c0480ab6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -719,6 +719,34 @@ static void dmub_abm_set_backlight(struct dc_context *dc,
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
+static bool dmub_cacp_set_backlight(struct dc_context *dc,
+	struct set_backlight_level_params *backlight_level_params,
+	unsigned int panel_inst)
+{
+	union dmub_rb_cmd cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cacp_set_backlight.header.type = DMUB_CMD__CACP;
+	cmd.cacp_set_backlight.header.sub_type = DMUB_CMD__CACP_SET_BACKLIGHT;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.aux_inst = backlight_level_params->aux_inst;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.frame_ramp = backlight_level_params->frame_ramp;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.backlight_user_level =
+		backlight_level_params->backlight_pwm_u16_16;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.backlight_control_type =
+		(enum dmub_backlight_control_type)backlight_level_params->control_type;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.min_luminance = backlight_level_params->min_luminance;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.max_luminance = backlight_level_params->max_luminance;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.min_backlight_pwm = backlight_level_params->min_backlight_pwm;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.max_backlight_pwm = backlight_level_params->max_backlight_pwm;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.version = DMUB_CMD_CACP_CONTROL_VERSION_1;
+	cmd.cacp_set_backlight.cacp_set_backlight_data.panel_mask = (0x01 << panel_inst);
+	cmd.cacp_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_cacp_set_backlight_data);
+
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return true;
+}
+
 bool dcn31_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	struct set_backlight_level_params *backlight_level_params)
 {
@@ -746,8 +774,19 @@ bool dcn31_set_backlight_level(struct pipe_ctx *pipe_ctx,
 			panel_cntl->inst,
 			panel_cntl->pwrseq_inst);
 
-	if (backlight_level_params->control_type != BACKLIGHT_CONTROL_AMD_AUX)
+	if (link && link->panel_type == PANEL_TYPE_OLED) {
+		/* For OLED panel with AMD AUX, skip set backlight call */
+		if (backlight_level_params->control_type == BACKLIGHT_CONTROL_VESA_AUX)
+			dmub_cacp_set_backlight(dc, backlight_level_params, panel_cntl->inst);
+	} else if (link && link->panel_type == PANEL_TYPE_MINILED) {
+		/* For MiniLED panel we need to check if CACP or ABM is being used */
+		if (link->panel_config.cacp.cacp_supported)
+			dmub_cacp_set_backlight(dc, backlight_level_params, panel_cntl->inst);
+		else
+			dmub_abm_set_backlight(dc, backlight_level_params, panel_cntl->inst);
+	} else {
 		dmub_abm_set_backlight(dc, backlight_level_params, panel_cntl->inst);
+	}
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index f415473517d4..cc8e96ffe7d1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -281,6 +281,8 @@ void dcn42_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver > 0;
 		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
+		dc->caps.dmub_caps.aux_backlight_support =
+			dc->ctx->dmub_srv->dmub->feature_caps.abm_aux_backlight_support;
 
 		/* sw and fw FAMS versions must match for support */
 		dc->debug.fams2_config.bits.enable &=
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index baf57692bbb5..16951a9550f2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -161,9 +161,7 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 	if (link->is_dds && !link->dpcd_caps.panel_luminance_control)
 		return true;
 
-	// use internal backlight control if dmub capabilities are not present
-	if (link->backlight_control_type == BACKLIGHT_CONTROL_VESA_AUX &&
-		!link->dc->caps.dmub_caps.aux_backlight_support) {
+	if (link->backlight_control_type == BACKLIGHT_CONTROL_VESA_AUX) {
 		uint8_t backlight_enable = 0;
 		struct target_luminance_value *target_luminance = NULL;
 
@@ -273,10 +271,11 @@ bool edp_backlight_enable_aux(struct dc_link *link, bool enable)
 
 	if (link->is_dds)
 		return true;
-	if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_ENABLE,
-		&backlight_enable, 1) != DC_OK)
-		return false;
-
+	if (!link->dpcd_caps.panel_luminance_control) {
+		if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_ENABLE,
+			&backlight_enable, 1) != DC_OK)
+			return false;
+	}
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
index 5b972f04bf7a..b26ceaba940d 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -716,8 +716,9 @@ void mod_power_update_backlight_on_mode_change(
 {
     struct set_backlight_level_params backlight_level_params = { 0 };
 
-		if (link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
-			link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)
+		if ((link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+			link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1) &&
+			link->backlight_control_type == BACKLIGHT_CONTROL_AMD_AUX)
 			dc_link_set_backlight_level_nits(link, core_power->bl_state[panel_inst].isHDR,
 				core_power->bl_state[panel_inst].backlight_millinit, 0);
 
@@ -746,6 +747,11 @@ static bool set_backlight_millinits_aux(struct core_power *core_power,
 
 	link = dc_stream_get_link(stream);
 
+	// only use internal backlight control if dmub capabilities are not present
+	if (link->backlight_control_type == BACKLIGHT_CONTROL_VESA_AUX &&
+		link->dc->caps.dmub_caps.aux_backlight_support)
+		return true;
+
 	return dc_link_set_backlight_level_nits(link, core_power->bl_state[inst].isHDR,
 			backlight_millinits, transition_time_millisec);
 }
-- 
2.55.0

