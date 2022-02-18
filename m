Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A52C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C24E10EF0C;
	Fri, 18 Feb 2022 15:04:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59BAE10EEE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkHiHgWmJQ5Vd3jK5zV9JWRg675RY1SSUqc7nagk18Bx3aBIlXIWzQ7BDkSTjHW2KbzPHYtOxbxME5FvFmX4oXXYeNAxP0RHW5I1zo8obO4U3EXTh/jtl8vU5rnKxIch13vKMMc8NaXS9A7BY/9MjwLNzLEYdiPDIdmpDALgs9y1uL0d95jZhKBKaTN+WbJLSrhtz4eRzdgHHozaj5WrfZE1Rh2NB987UTYVM9J3EZ8ZC32l6fIdrNfTuS5IoRgcu+QoE+bjblidynSXHD2fTJlvsdWnV1xFwCH+ChYUTpGAEkDpFu/lMxOWvpSyAotxkc6ZWxfTURba0TNOrRP7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dttf8zF56NrzGOM7DljFD8+0CtTRVJb4Fp1TeE/kJ+M=;
 b=XaWrV+VMK8QD5oJnPjdar3i0S7GZah/f0poqY1CQK1QAi+alaQFkvWZfwYGahWxrwAYrD5Z9psqnEMHKb8MjHaAdAdGEWLhlpTYSZyDCBzuOMung+DWd5bECyeKO9wgZay1vLk3XcfP+SCEfv4Yd7bYn9CB+40/9RTSAVo2/pGOdXparvHxw/zx7F8OE9h/RoLavctPOLfK+Edgq4co37r89bUhlxJjPdQBRMkGSPHvO4mQhoHHQc+J7qxKlMLhI7CaSaobtxRAdZnffXFNWpubfLUbaAgT1SShslCtkn046kN3aNXnkexJuocv1q3wxGrgKOiT0WzF2KfiZKBLaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dttf8zF56NrzGOM7DljFD8+0CtTRVJb4Fp1TeE/kJ+M=;
 b=YWLMFWnZBXW+hsBvkvWfCcF0h8CRcXMC2njYYCNoZ9+mKVtM1DFjeQEQ9M1XDSgvihC8pFxqaqxxm1hL+TCgRCTcaEkoBJTtLCr3BjT6EzSWytb3CxwvsKCueSkXcijS9NT1L5I/rLyFUAd+FaAKlw6+FWSdOH1hD3kDxcwzt1A=
Received: from DM6PR03CA0074.namprd03.prod.outlook.com (2603:10b6:5:333::7) by
 BN6PR1201MB0115.namprd12.prod.outlook.com (2603:10b6:405:59::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:04:46 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::18) by DM6PR03CA0074.outlook.office365.com
 (2603:10b6:5:333::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:46 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:40 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: add cable ID support for usb c
 connector
Date: Fri, 18 Feb 2022 23:03:25 +0800
Message-ID: <20220218150329.7976-9-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5197fde2-1186-4e1f-d651-08d9f2f000ac
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0115:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01151DF8E9E9AEE73DF98AE397379@BN6PR1201MB0115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8hXGes6sMPBrKD1uEFWtdm7KkZSleFdbLDW4KhDCNj9MU8WotY4KR0XHKwDKkaqx+QHeUcGjhjjQA1wso+JvvO8G5QOiQgQpxkqwwXnyZ0RH2O90UKOMh4Wy3H1gqb5gVRnSZNXyHS9BxOpeOLs4bodU/7KbzYLZeW2teZBycOTgatMKAysfBvLYB4jXafQ1IQUliO9Leln5LLU510vHWzCnJqQ4Smdvdipf8h1bhGPn8h42ediLQcdmdqBabfdUbkH9Y8FZFHIfdxvL/gi+8ln49cf+pkem8idPJrMCBHY0DEugRI+qV5N4GbIFnFxZAlJ1/3Y6ymgGhfjwkFfil9nwhUrdZAJ4SiTGkoTxko0vjDrk7X5VciDTicqFhDGYT55dv+gHCe7Ei57JLLCoF+xaZfqL0067P7Ndf8kCsDyGPjoTbj22eCdrGPXvrjQjjMj3kN60yk18HgpR1UmZYxAGSCaNBi2K8we9zCJPkJ3kQB9L5ReKluwenbqLN/PNvi0XtnJvDMSxyDML7JDw7phBN25Tu9MvR2EA16bSna44mgoniB+/Wnd5Ws4Xe/gLtiBdtRyMkvVTBoWux64QjsfgikE/NcIQmwxlEYnBvppW3YdVnrwfWCAM75r6q6qqBftzW59LbuVptgU6jLEpdqsobtzpHV3WJpLIGz6Yq5SAtg27MgQiSyGJiYqCIFEmYDdZ/a3DvQa5sFfgOuIPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(44832011)(5660300002)(2616005)(36756003)(1076003)(16526019)(4326008)(8676002)(83380400001)(336012)(426003)(70586007)(70206006)(36860700001)(7696005)(82310400004)(316002)(6916009)(54906003)(6666004)(2906002)(81166007)(8936002)(508600001)(30864003)(40460700003)(47076005)(86362001)(356005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:46.6098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5197fde2-1186-4e1f-d651-08d9f2f000ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0115
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[how]
Call to DMUB to retrieve usb c cable ID data from PD firmware.
If cable id is retrieved from DMUB, skip reading cable ID from RX.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 100 ++++++++++++------
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   8 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  40 +++++++
 7 files changed, 117 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1d6b6ed3f24c..34ca1ffcf4d1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1305,7 +1305,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		 */
 		link->dongle_max_pix_clk = 0;
 
-		dc_link_dp_clear_rx_status(link);
+		dc_link_clear_dprx_states(link);
 	}
 
 	LINK_INFO("link=%d, dc_sink_in=%p is now %s prev_sink=%p edid same=%d\n",
@@ -1986,7 +1986,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 		msleep(post_oui_delay);
 
 	// similarly, mode switch can cause loss of cable ID
-	dpcd_update_cable_id(link);
+	dpcd_write_cable_id_to_dprx(link);
 
 	skip_video_pattern = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index bc6161f52bfa..bfd0e48d67a5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -51,6 +51,13 @@ static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
 
 #include "link_dpcd.h"
 
+#ifndef MAX
+#define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
+#endif
+#ifndef MIN
+#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
+
 	/* maximum pre emphasis level allowed for each voltage swing level*/
 	static const enum dc_pre_emphasis
 	voltage_swing_to_pre_emphasis[] = { PRE_EMPHASIS_LEVEL3,
@@ -2986,11 +2993,11 @@ static enum dc_link_rate get_cable_max_link_rate(struct dc_link *link)
 {
 	enum dc_link_rate cable_max_link_rate = LINK_RATE_HIGH3;
 
-	if (link->dpcd_caps.cable_attributes.bits.UHBR10_20_CAPABILITY & DP_UHBR20)
+	if (link->dpcd_caps.cable_id.bits.UHBR10_20_CAPABILITY & DP_UHBR20)
 		cable_max_link_rate = LINK_RATE_UHBR20;
-	else if (link->dpcd_caps.cable_attributes.bits.UHBR13_5_CAPABILITY)
+	else if (link->dpcd_caps.cable_id.bits.UHBR13_5_CAPABILITY)
 		cable_max_link_rate = LINK_RATE_UHBR13_5;
-	else if (link->dpcd_caps.cable_attributes.bits.UHBR10_20_CAPABILITY & DP_UHBR10)
+	else if (link->dpcd_caps.cable_id.bits.UHBR10_20_CAPABILITY & DP_UHBR10)
 		cable_max_link_rate = LINK_RATE_UHBR10;
 
 	return cable_max_link_rate;
@@ -5051,11 +5058,52 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 	return is_lttpr_present;
 }
 
+static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
+{
+	union dmub_rb_cmd cmd;
+
+	if (!link->ctx->dmub_srv ||
+			link->ep_type != DISPLAY_ENDPOINT_PHY ||
+			link->link_enc->features.flags.bits.DP_IS_USB_C == 0)
+		return false;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cable_id.header.type = DMUB_CMD_GET_USBC_CABLE_ID;
+	cmd.cable_id.header.payload_bytes = sizeof(cmd.cable_id.data);
+	cmd.cable_id.data.input.phy_inst = resource_transmitter_to_phy_idx(
+			link->dc, link->link_enc->transmitter);
+	if (dc_dmub_srv_cmd_with_reply_data(link->ctx->dmub_srv, &cmd) &&
+			cmd.cable_id.header.ret_status == 1)
+		cable_id->raw = cmd.cable_id.data.output_raw;
 
-static bool is_usbc_connector(struct dc_link *link)
+	return cmd.cable_id.header.ret_status == 1;
+}
+
+static union dp_cable_id intersect_cable_id(
+		union dp_cable_id *a, union dp_cable_id *b)
 {
-	return link->link_enc &&
-			link->link_enc->features.flags.bits.DP_IS_USB_C;
+	union dp_cable_id out;
+
+	out.bits.UHBR10_20_CAPABILITY = MIN(a->bits.UHBR10_20_CAPABILITY,
+			b->bits.UHBR10_20_CAPABILITY);
+	out.bits.UHBR13_5_CAPABILITY = MIN(a->bits.UHBR13_5_CAPABILITY,
+			b->bits.UHBR13_5_CAPABILITY);
+	out.bits.CABLE_TYPE = MAX(a->bits.CABLE_TYPE, b->bits.CABLE_TYPE);
+
+	return out;
+}
+
+static void retrieve_cable_id(struct dc_link *link)
+{
+	union dp_cable_id usbc_cable_id;
+
+	link->dpcd_caps.cable_id.raw = 0;
+	core_link_read_dpcd(link, DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX,
+			&link->dpcd_caps.cable_id.raw, sizeof(uint8_t));
+
+	if (get_usbc_cable_id(link, &usbc_cable_id))
+		link->dpcd_caps.cable_id = intersect_cable_id(
+				&link->dpcd_caps.cable_id, &usbc_cable_id);
 }
 
 static bool retrieve_link_cap(struct dc_link *link)
@@ -5114,9 +5162,6 @@ static bool retrieve_link_cap(struct dc_link *link)
 	 */
 	msleep(post_oui_delay);
 
-	/* Read cable ID and update receiver */
-	dpcd_update_cable_id(link);
-
 	for (i = 0; i < read_dpcd_retry_cnt; i++) {
 		status = core_link_read_dpcd(
 				link,
@@ -5236,7 +5281,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 		edp_config_cap.bits.ALT_SCRAMBLER_RESET;
 	link->dpcd_caps.dpcd_display_control_capable =
 		edp_config_cap.bits.DPCD_DISPLAY_CONTROL_CAPABLE;
-
+	link->dpcd_caps.channel_coding_cap.raw =
+			dpcd_data[DP_MAIN_LINK_CHANNEL_CODING - DP_DPCD_REV];
 	link->test_pattern_enabled = false;
 	link->compliance_test_state.raw = 0;
 
@@ -5363,8 +5409,6 @@ static bool retrieve_link_cap(struct dc_link *link)
 	if (!dpcd_read_sink_ext_caps(link))
 		link->dpcd_sink_ext_caps.raw = 0;
 
-	link->dpcd_caps.channel_coding_cap.raw = dpcd_data[DP_MAIN_LINK_CHANNEL_CODING_CAP - DP_DPCD_REV];
-
 	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
 		DC_LOG_DP2("128b/132b encoding is supported at link %d", link->link_index);
 
@@ -5410,6 +5454,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 			DC_LOG_DP2("\tFEC aggregated error counters are supported");
 	}
 
+	retrieve_cable_id(link);
+	dpcd_write_cable_id_to_dprx(link);
+
 	/* Connectivity log: detection */
 	CONN_DATA_DETECT(link, dpcd_data, sizeof(dpcd_data), "Rx Caps: ");
 
@@ -6342,29 +6389,18 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 	}
 }
 
-void dpcd_update_cable_id(struct dc_link *link)
+void dpcd_write_cable_id_to_dprx(struct dc_link *link)
 {
-	struct link_encoder *link_enc = NULL;
-
-	link_enc = link_enc_cfg_get_link_enc(link);
-
-	if (!link_enc ||
-			!link_enc->features.flags.bits.IS_UHBR10_CAPABLE ||
-			link->dprx_status.cable_id_updated)
+	if (!link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED ||
+			link->dpcd_caps.cable_id.raw == 0 ||
+			link->dprx_states.cable_id_written)
 		return;
 
-	/* Retrieve cable attributes */
-	if (!is_usbc_connector(link))
-		core_link_read_dpcd(link, DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX,
-				&link->dpcd_caps.cable_attributes.raw,
-				sizeof(uint8_t));
-
-	/* Update receiver with cable attributes */
 	core_link_write_dpcd(link, DP_CABLE_ATTRIBUTES_UPDATED_BY_DPTX,
-			&link->dpcd_caps.cable_attributes.raw,
-			sizeof(link->dpcd_caps.cable_attributes.raw));
+			&link->dpcd_caps.cable_id.raw,
+			sizeof(link->dpcd_caps.cable_id.raw));
 
-	link->dprx_status.cable_id_updated = 1;
+	link->dprx_states.cable_id_written = 1;
 }
 
 bool dc_link_set_backlight_level_nits(struct dc_link *link,
@@ -6765,9 +6801,9 @@ void edp_panel_backlight_power_on(struct dc_link *link)
 		link->dc->hwss.edp_backlight_control(link, true);
 }
 
-void dc_link_dp_clear_rx_status(struct dc_link *link)
+void dc_link_clear_dprx_states(struct dc_link *link)
 {
-	memset(&link->dprx_status, 0, sizeof(link->dprx_status));
+	memset(&link->dprx_states, 0, sizeof(link->dprx_states));
 }
 
 void dp_receiver_power_ctrl(struct dc_link *link, bool on)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6176904e22fc..9fa87a426f9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1236,7 +1236,7 @@ struct dpcd_caps {
 	union dp_main_line_channel_coding_cap channel_coding_cap;
 	union dp_sink_video_fallback_formats fallback_formats;
 	union dp_fec_capability1 fec_cap1;
-	union dp_cable_attributes cable_attributes;
+	union dp_cable_id cable_id;
 	uint8_t edp_rev;
 	union edp_alpm_caps alpm_caps;
 	struct edp_psr_info psr_info;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 5f848a2fa21d..a66460858783 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1017,7 +1017,7 @@ union dp_fec_capability1 {
 	uint8_t raw;
 };
 
-union dp_cable_attributes {
+union dp_cable_id {
 	struct {
 		uint8_t UHBR10_20_CAPABILITY	:2;
 		uint8_t UHBR13_5_CAPABILITY	:1;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 9ad3ee4079c3..ce6e8d013459 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -43,8 +43,8 @@ struct dc_link_status {
 	struct dpcd_caps *dpcd_caps;
 };
 
-struct dp_receiver_status {
-	bool cable_id_updated;
+struct dprx_states {
+	bool cable_id_written;
 };
 
 /* DP MST stream allocation (payload bandwidth number) */
@@ -205,7 +205,7 @@ struct dc_link {
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
 	struct dc_link_status link_status;
-	struct dp_receiver_status dprx_status;
+	struct dprx_states dprx_states;
 
 	struct link_trace link_trace;
 	struct gpio *hpd_gpio;
@@ -466,7 +466,7 @@ void dc_link_get_cur_link_res(const struct dc_link *link,
 void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map);
 /* restore link resource allocation state from a snapshot */
 void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
-void dc_link_dp_clear_rx_status(struct dc_link *link);
+void dc_link_clear_dprx_states(struct dc_link *link);
 struct gpio *get_hpd_gpio(struct dc_bios *dcb,
 		struct graphics_object_id link_id,
 		struct gpio_service *gpio_service);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 477c4d9a972f..ab9939db8cea 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -106,7 +106,7 @@ bool dp_overwrite_extended_receiver_cap(struct dc_link *link);
 
 void dpcd_set_source_specific_data(struct dc_link *link);
 
-void dpcd_update_cable_id(struct dc_link *link);
+void dpcd_write_cable_id_to_dprx(struct dc_link *link);
 
 /* Write DPCD link configuration data. */
 enum dc_status dpcd_set_link_settings(
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b01cb5493b76..bc889492f9d7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -668,6 +668,10 @@ enum dmub_cmd_type {
 	 * Command type used for EDID CEA parsing
 	 */
 	DMUB_CMD__EDID_CEA = 79,
+	/**
+	 * Command type used for getting usbc cable ID
+	 */
+	DMUB_CMD_GET_USBC_CABLE_ID = 81,
 	/**
 	 * Command type used for all VBIOS interface commands.
 	 */
@@ -2484,6 +2488,38 @@ struct dmub_rb_cmd_edid_cea {
 
 };
 
+/**
+ * struct dmub_cmd_cable_id_input - Defines the input of DMUB_CMD_GET_USBC_CABLE_ID command.
+ */
+struct dmub_cmd_cable_id_input {
+	uint8_t phy_inst;  /**< phy inst for cable id data */
+};
+
+/**
+ * struct dmub_cmd_cable_id_input - Defines the output of DMUB_CMD_GET_USBC_CABLE_ID command.
+ */
+struct dmub_cmd_cable_id_output {
+	uint8_t UHBR10_20_CAPABILITY	:2; /**< b'01 for UHBR10 support, b'10 for both UHBR10 and UHBR20 support */
+	uint8_t UHBR13_5_CAPABILITY	:1; /**< b'1 for UHBR13.5 support */
+	uint8_t CABLE_TYPE		:3; /**< b'01 for passive cable, b'10 for active LRD cable, b'11 for active retimer cable */
+	uint8_t RESERVED		:2; /**< reserved means not defined */
+};
+
+/**
+ * Definition of a DMUB_CMD_GET_USBC_CABLE_ID command
+ */
+struct dmub_rb_cmd_get_usbc_cable_id {
+	struct dmub_cmd_header header; /**< Command header */
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD_GET_USBC_CABLE_ID command.
+	 */
+	union dmub_cmd_cable_id_data {
+		struct dmub_cmd_cable_id_input input; /**< Input */
+		struct dmub_cmd_cable_id_output output; /**< Output */
+		uint8_t output_raw; /**< Raw data output */
+	} data;
+};
+
 /**
  * union dmub_rb_cmd - DMUB inbox command.
  */
@@ -2649,6 +2685,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__EDID_CEA command.
 	 */
 	struct dmub_rb_cmd_edid_cea edid_cea;
+	/**
+	 * Definition of a DMUB_CMD_GET_USBC_CABLE_ID command.
+	 */
+	struct dmub_rb_cmd_get_usbc_cable_id cable_id;
 };
 
 /**
-- 
2.25.1

