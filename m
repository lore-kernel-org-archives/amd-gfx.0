Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71A2CA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C46110F775;
	Tue, 13 Oct 2026 11:16:56 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 667B510E0A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbYtH2+l+u2CCNuprhPyi9k92NAqS104jcTaLaSQEjSlIqjhXauOVQEcGleIPm/pEIWMsP/ami/6owpSpE0BhMmn/z6yGCFs8BBcmD81BZSiKH8kKoTBUAW2yCrvAIjWXGZsrlBh6v4sgGP5OeEEb9lotUZG1g7E+D8sNtYT3AlOc3z6HbBQho+s30qi0P4XAG4w014wAcpQlMrTtkSS/W6JZt/LnOlK7p7gMHHYEbsFfl3pk40Re5NRsEolEWRaq60qf7k3IXJIS29RHuBFNOxUCTrHkKsQS+IXUCRib3jcjFlBt3343GsbrumF/8+BDhl6vu1DN8cjtQgmxtFXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56lmg00Jei36WcTlT2CJlMwbmwafC4f5BNSrYxwTL/M=;
 b=rclmeolhnxMpxdw6R/BLzIID4q3gnW5qBOQTOa6FjoRki+jzNsiqk4FoiqDv/yk5T9QLUEKDOqIw8t8TE8MpNVC9INBapC1DfMmOECjXapdKBn04tNSOykNSxghaDAZQjSsuDnzzpQLviFPp3dBw8dpBFVLzpD1Y4Aa1zpNS5D97ZVPFBZjC0npc03BUJSBIY+/HLy7A70edi9fhA8IJaWia9eKaPYf2nMAQXyxbIWqwzPHbBWdIdQA0v7OS/EiwJa5P/tmmuWByXnba79jPVtr4jxJgIqGqUSAHjtFqzm4LfZB7GnLbV8cbXvTmTR2Y7ey8LSG6VmUY6gGXSB6Aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56lmg00Jei36WcTlT2CJlMwbmwafC4f5BNSrYxwTL/M=;
 b=ZptE/qmrAgNVBkDU/IBLZI8CMFVizud4u2m6scL+kWKtIzPqCvcWRBDxwN3trfi0SRCWmCXzdmYxScGkfQtQThN3ZHhpdhmpzX0lVSk/cHw7SBEz0SDak8YRU7lgvesJHoRjkCc7FMIK8o6sxBY8AG+NmI8I5c0HR86r7Kbj/EM=
Received: from MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8)
 by LV2PR12MB999096.namprd12.prod.outlook.com (2603:10b6:408:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:16:46 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::a0) by MW4PR03CA0123.outlook.office365.com
 (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:16:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:16:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:16:18 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:16:09 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leon Huang <Leon.Huang1@amd.com>, Robin Chen
 <robin.chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 03/30] drm/amd/display: Add AS-SDP V3 support for VESA PR
Date: Tue, 13 Oct 2026 19:07:50 +0800
Message-ID: <20261013111616.2267344-4-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|LV2PR12MB999096:EE_
X-MS-Office365-Filtering-Correlation-Id: b0417c23-c314-4297-7b78-08df291b7795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5yuzK9SDQO++QdsMslxz7DzzcA6GOmeict1FbjWaKKu17o+OTdAnoCHxSoav7RZ2kzcSuwVsZn6g03Ff1fuNha0Mte4QW3gJWHV+f2RevdHf5aVKa4MYL/rYnAmoqw2iiyDOI7BaYI05vEcifWFSnCOKjn1x1j87yX06bTkFgZbBac9lrwOBg8k7asAEx1ANt7464LjL4AUCgI5K21aLBDrIw1Y9SzY3CdQMuhfvgq0ZrNJkBNH71TaXUGvdd8YCMcg9CHu+TgMfICAEwHJiVGuQgL7NzFar5RH9w6bkYRdizH+FTtuoPClY2kyoB0hqanmjk5E7MhbF+M0Oa8pY+Gmuc1SWRPJtpu/lDtshM6+BcGWFhGIEtyiWxJ8ppIEL42znEsZeiTWnZNjuS0+rptiBbT50w++GvyiHiPnMhYyd9zHSBjmvCDOdGl9B23sIujIuvY6dNZJSdgJOndlkgshSAUj+LpCfVtSCM5F9VLCneEVHimIfbmVvlKuClDvHEaW6z+ssIpU/fBSvwY54LtpoiTICWXmiaY7UwlDofxrpze7whmb5Hwku0Wra+8cXLfc/DynTWH67kbR+LYc5KSI7tMD0n2bxfy5D9pszXYic3Uj0Ka4uFfNnUdZi/JixQJhoo4Tmgy80H9QtBBBXFBu+MjQjlIZURPrqJ6uwW1NMpPiPdsuj1M6HSAmy0fx3AVIOdnuKJMS6optrmxN3ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6zmEA+y9dcqBnCssyffj6FxVhZM48lT2h6Nmu4i2vMXd/6VMMaC78od6yul52Zs12dDNrUgP72j010rn3kVssugCua79rM2q/xAMEBEqcaojrF/bmeZ50w3uMhMma7ntS3ikL+jH22rAo8CG36U8EeRdT4EaxrDM2pZNrPCensB9wr4c4j0uXI+eAwoMgmrNrEf3BTa/QykDsUXHznhcr2s4XMYAmyv6x/Jq5Z/mA/j7GNCb2xmOB7q1q4WIxyEW1RyN2rX8sj2cjuyhikRw4UZpM9eaKK+/+WnoNXmMHj2AjTktbVGGjzbfxoYrOlw96Q8u7Onl1P/4CCFas22JQimBpMnD2MexLHqbuPhpkqvFXbvx2sAPzrFw0JBBbe9dvZtNs5ydAB35XMc+bT4vBgeRAEfN5X0Uhl3oAI2607UEc7wfxE+TnLPILSHYhRTk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:16:45.5745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0417c23-c314-4297-7b78-08df291b7795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999096
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

From: Leon Huang <Leon.Huang1@amd.com>

[Why]
AS-SDP V3 extends the coasting vtotal field from 16 bits to 24 bits
by adding DB9 for bits[23:16] for VESA Panel Replay.

[How]
Parse the capability from DPCD and apply when VESA PR is enabled

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  3 +-
 .../amd/display/modules/inc/mod_info_packet.h |  5 +++
 .../display/modules/info_packet/info_packet.c | 34 +++++++++++++++++--
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index b0e91b321f43..9353292edc0b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -922,7 +922,8 @@ union dpcd_dprx_feature_enumeration_list_cont_1 {
 		uint8_t AS_SDP_FIRST_HALF_LINE_OR_3840_PIXEL_CYCLE_WINDOW_NOT_SUPPORTED: 1;
 		uint8_t RESERVED0: 2;
 		uint8_t VSC_EXT_SDP_VER1_SUPPORT: 1;
-		uint8_t RESERVED1: 3;
+		uint8_t AS_SDP_VERSION_3_SUPPORTED: 1;
+		uint8_t RESERVED1: 2;
 	} bits;
 	uint8_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 5181d889fe7f..45ba1a974094 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -52,9 +52,11 @@ enum adaptive_sync_sdp_version {
 	AS_SDP_VER_0 = 0x0,
 	AS_SDP_VER_1 = 0x1,
 	AS_SDP_VER_2 = 0x2,
+	AS_SDP_VER_3 = 0x3,
 };
 
 #define AS_DP_SDP_LENGTH (9)
+#define AS_DP_SDP_V3_LENGTH (0xA)
 
 struct frame_duration_op {
 	bool          support;
@@ -78,6 +80,9 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 void mod_build_adaptive_sync_infopacket_v2(const struct dc_stream_state *stream,
 		const struct AS_Df_params *param, struct dc_info_packet *info_packet);
 
+void mod_build_adaptive_sync_infopacket_v3(const struct dc_stream_state *stream,
+		const struct AS_Df_params *param, struct dc_info_packet *info_packet);
+
 void mod_build_adaptive_sync_infopacket_v1(struct dc_info_packet *info_packet);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 32b697f46788..48d0e164e62b 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -770,9 +770,12 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 	case FREESYNC_TYPE_PCON_IN_WHITELIST:
 	case ADAPTIVE_SYNC_TYPE_EDP:
 		if (stream && stream->link->replay_settings.config.replay_supported &&
-			stream->link->replay_settings.config.replay_version == DC_VESA_PANEL_REPLAY)
-			mod_build_adaptive_sync_infopacket_v2(stream, param, info_packet);
-		else
+			stream->link->replay_settings.config.replay_version == DC_VESA_PANEL_REPLAY) {
+			if (stream->link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.bits.AS_SDP_VERSION_3_SUPPORTED)
+				mod_build_adaptive_sync_infopacket_v3(stream, param, info_packet);
+			else
+				mod_build_adaptive_sync_infopacket_v2(stream, param, info_packet);
+		} else
 			mod_build_adaptive_sync_infopacket_v1(info_packet);
 		break;
 	case ADAPTIVE_SYNC_TYPE_NONE:
@@ -815,3 +818,28 @@ void mod_build_adaptive_sync_infopacket_v2(const struct dc_stream_state *stream,
 	}
 }
 
+void mod_build_adaptive_sync_infopacket_v3(const struct dc_stream_state *stream,
+		const struct AS_Df_params *param,
+		struct dc_info_packet *info_packet)
+{
+	info_packet->valid = true;
+	// HEADER {HB0, HB1, HB2, HB3} = {00, Type, Version, Length}
+	// For eDP VESA Panel Replay the coasting vtotal (DB7-DB9) is filled by the
+	// DMUB firmware,so only the header is built.
+	info_packet->hb0 = 0x00;
+	info_packet->hb1 = 0x22;
+	info_packet->hb2 = AS_SDP_VER_3;
+	info_packet->hb3 = AS_DP_SDP_V3_LENGTH;
+
+	if (param) {
+		//Payload
+		info_packet->sb[0] = param->supportMode; //1: AVT; 0: FAVT
+		info_packet->sb[1] = (stream->timing.v_total & 0x00FF);
+		info_packet->sb[2] = (stream->timing.v_total & 0xFF00) >> 8;
+		//info_packet->sb[3] = 0x00; Target RR, not use fot AVT
+		info_packet->sb[4] = (param->increase.support << 6 | param->decrease.support << 7);
+		info_packet->sb[5] = param->increase.frame_duration_hex;
+		info_packet->sb[6] = param->decrease.frame_duration_hex;
+	}
+}
+
-- 
2.43.0

