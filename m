Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA19C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 22:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5934B10E34F;
	Wed, 22 Dec 2021 22:06:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F5410E33B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 22:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7N3Jce51lbK0RhSsFiDhQqcpLpRnlvMKithbKTlDfdMZduuglWfnIVaZa5+qH9MFhi527PNw5Ero39Hsssvv0oSzbEWOzSZ1Lx6fjVhSoy6Lcv/8OkDoBZJkJPPDXCapLUWnjr24j5YGGhxqNgpD/5b/HyF1U5NCprpFPX418FVkaR2cEtgldI6HG4htkP58MsneO9HgvgPaIDngjiJYCf6MLH95Sh2W953+A21AJk/sz2oG8rKmKbjZzvhqrwE6Bd9nQJ5aFqtI4yGNapf3Cw+uGZGKASL8DoYy8/jah62AFLIqGzr2x6zvqUzuC8kWlYZzE0vwLPdpQ7TWPTsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKjrNTcVZSVWJNjrv8se6xUXc+TqdRFqR0wyngB6baA=;
 b=mftctzP0ps/07Xl+yTxILJ94TGiy2sDPRh1GihlMkmYSGjaITxE81PzVXqQ5vqjgEB4ymYzQYgAnoj7JzryUsqSTECIgo7o+ASpPHjEdFJQdG0rZYHsvLG73YAPxwwlDLFzZ6rK/L4TZjaMdUczqIgYjMS37yNvq3eQsC+HVGEoHGGbZ6M35TDNSYW8hyqFAJRtwUwjqDEgEoCdQ8ghYrNzUxFSTeSsECPPPn9L9XBeMrQCNbYPkdeqB7yokPvJC5BXKXyBwGHTlJUa6HQwPXTMiYI92TBiDilsaU1yjO9jq7u3Q8Dq047pyA2pHIUs86AMxTG7sUzPsRsY0J9nGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKjrNTcVZSVWJNjrv8se6xUXc+TqdRFqR0wyngB6baA=;
 b=zLNxA21agjQPifZPv3AHNriR0b50BUn0x4FuH7CksWLuqRuPyNZPjyT3Gyn9R5oIYssNj0w9yBXNQ2TnI/L0gEXdv4ffcYacYcI6HW1uBqJwyCV/9RAVcu43Oa6gMJ0ckQZjM1/IfS8cD54CQQdlf1pt69HD3IC/0A5F8Zs6h18=
Received: from MWHPR07CA0002.namprd07.prod.outlook.com (2603:10b6:300:116::12)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 22:05:51 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::b3) by MWHPR07CA0002.outlook.office365.com
 (2603:10b6:300:116::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14 via Frontend
 Transport; Wed, 22 Dec 2021 22:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 22:05:51 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 22 Dec
 2021 16:05:49 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amd/display: Add version check before using DP alt
 query interface
Date: Wed, 22 Dec 2021 17:05:19 -0500
Message-ID: <20211222220519.1682537-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
References: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f005a67f-9a65-4afa-5418-08d9c5973788
X-MS-TrafficTypeDiagnostic: MN2PR12MB4390:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43900716C9A697EE4A543DF0987D9@MN2PR12MB4390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNjyHnnValdPrQ/27tz//UA+3VqgR8PgPIglenGcBtGD8Kff1AnJLFw+j//28VZESuhpHsUVdIyKnEk1mB/X8jxhQwBwTDYYtUeVNm41vr9EvKaIV4AwHLFPo/UA5X5voDRxkVAxxmrpyCe9dDyI6HxGliKOX85itLAx3dtyiWxPcZBD0lYYZhwUWJKJ6DSTYF/9xufap9mlzzzABSjm6y+rh2RkDlySe5rPutULDJSVPDY+FD5NmoiHyIZdBKNE+c7p2eUc7TinZucA4Cf6kI5lqEA8fdqnc3Qd7pDw8ZXhayOhRMtMFhmovvKKVXmBpkJGmLLGJjtgLgXTYoVcSrGM9m/TzviiJSLWRsYi7/38RTf0g/a5gPbxUOFwdZ+NtSciRN7Ts47eT8lwUmJBCDB5My/VxXkxKgox5I/C44aSBPJLbu8rE9teaYCrhidQsy/tDgx6Dk/NCAiDmbeDvoBm3kWXO+mIGjQdBRxES4ww3jehOgOCkIM4AM0A1lU1Ivbewz8Wvd1N/8Z6VlbiUPwaUSftWylQ+m9uS0N/R7WI6j7NDoxeViwEimufj3xM+OV8o1Gf1r9HqexUt8aZmHY5x3rBxWoNhQ8AHxPxkutCO2Dyp90PhYEkWT9hc8QNDCYvjNQlfbLufpL/0vcVgGa4rVdF9ATgnaxIab3zH3fqT7FShsACIBG8Ox5iPIxt0PgF/UleJjzfIQioSUT5j5xML8siCy+gFcYdAZ4BjRjaNABPTczw28mAiZFWDWxX5rRrX+T7pE4QHPO0ESpP81FbDtWEkUoawfKYvxKu8AM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(316002)(40460700001)(336012)(6916009)(508600001)(83380400001)(47076005)(36860700001)(426003)(82310400004)(186003)(6666004)(356005)(4326008)(16526019)(86362001)(8936002)(5660300002)(36756003)(26005)(1076003)(70586007)(2906002)(81166007)(8676002)(70206006)(54906003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 22:05:51.0332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f005a67f-9a65-4afa-5418-08d9c5973788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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
Cc: stylon.wang@amd.com, Hansen Dsouza <hansen.dsouza@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
To maintain compatibility with firmware older than 4.0.11.

Those firmware may have interrmittent hangs with RDCSPIPE or the PHY,
but we shouldn't regress their previous behavior.

[How]
Use the new path if firmware is development or 4.0.11 or newer. Use the
legacy path otherwise.

Fixes: b60a041393f7 ("drm/amd/display: Query DMCUB for dp alt status")

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 114 +++++++++++++++---
 1 file changed, 94 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 71c359f9cdd2..8b9b1a5309ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -100,6 +100,35 @@ static uint8_t phy_id_from_transmitter(enum transmitter t)
 	return phy_id;
 }
 
+static bool has_query_dp_alt(struct link_encoder *enc)
+{
+	struct dc_dmub_srv *dc_dmub_srv = enc->ctx->dmub_srv;
+
+	/* Supports development firmware and firmware >= 4.0.11 */
+	return dc_dmub_srv &&
+	       !(dc_dmub_srv->dmub->fw_version >= DMUB_FW_VERSION(4, 0, 0) &&
+		 dc_dmub_srv->dmub->fw_version <= DMUB_FW_VERSION(4, 0, 10));
+}
+
+static bool query_dp_alt_from_dmub(struct link_encoder *enc,
+				   union dmub_rb_cmd *cmd)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+	struct dc_dmub_srv *dc_dmub_srv = enc->ctx->dmub_srv;
+
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->query_dp_alt.header.type = DMUB_CMD__VBIOS;
+	cmd->query_dp_alt.header.sub_type =
+		DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT;
+	cmd->query_dp_alt.header.payload_bytes = sizeof(cmd->query_dp_alt.data);
+	cmd->query_dp_alt.data.phy_id = phy_id_from_transmitter(enc10->base.transmitter);
+
+	if (!dc_dmub_srv_cmd_with_reply_data(dc_dmub_srv, cmd))
+		return false;
+
+	return true;
+}
+
 void dcn31_link_encoder_set_dio_phy_mux(
 	struct link_encoder *enc,
 	enum encoder_type_select sel,
@@ -569,45 +598,90 @@ void dcn31_link_encoder_disable_output(
 bool dcn31_link_encoder_is_in_alt_mode(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct dc_dmub_srv *dc_dmub_srv = enc->ctx->dmub_srv;
 	union dmub_rb_cmd cmd;
-	bool is_usb_c_alt_mode = false;
+	uint32_t dp_alt_mode_disable;
 
-	if (enc->features.flags.bits.DP_IS_USB_C && dc_dmub_srv) {
-		memset(&cmd, 0, sizeof(cmd));
-		cmd.query_dp_alt.header.type = DMUB_CMD__VBIOS;
-		cmd.query_dp_alt.header.sub_type = DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT;
-		cmd.query_dp_alt.header.payload_bytes = sizeof(cmd.panel_cntl.data);
-		cmd.query_dp_alt.data.phy_id = phy_id_from_transmitter(enc10->base.transmitter);
+	/* Only applicable to USB-C PHY. */
+	if (!enc->features.flags.bits.DP_IS_USB_C)
+		return false;
 
-		if (!dc_dmub_srv_cmd_with_reply_data(dc_dmub_srv, &cmd))
+	/*
+	 * Use the new interface from DMCUB if available.
+	 * Avoids hanging the RDCPSPIPE if DMCUB wasn't already running.
+	 */
+	if (has_query_dp_alt(enc)) {
+		if (!query_dp_alt_from_dmub(enc, &cmd))
 			return false;
 
-		is_usb_c_alt_mode = (cmd.query_dp_alt.data.is_dp_alt_disable == 0);
+		return (cmd.query_dp_alt.data.is_dp_alt_disable == 0);
 	}
 
-	return is_usb_c_alt_mode;
+	/* Legacy path, avoid if possible. */
+	if (enc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_B0) {
+		REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE,
+			&dp_alt_mode_disable);
+	} else {
+		/*
+		 * B0 phys use a new set of registers to check whether alt mode is disabled.
+		 * if value == 1 alt mode is disabled, otherwise it is enabled.
+		 */
+		if ((enc10->base.transmitter == TRANSMITTER_UNIPHY_A) ||
+		    (enc10->base.transmitter == TRANSMITTER_UNIPHY_B) ||
+		    (enc10->base.transmitter == TRANSMITTER_UNIPHY_E)) {
+			REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE,
+				&dp_alt_mode_disable);
+		} else {
+			REG_GET(RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE,
+				&dp_alt_mode_disable);
+		}
+	}
+
+	return (dp_alt_mode_disable == 0);
 }
 
 void dcn31_link_encoder_get_max_link_cap(struct link_encoder *enc, struct dc_link_settings *link_settings)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct dc_dmub_srv *dc_dmub_srv = enc->ctx->dmub_srv;
 	union dmub_rb_cmd cmd;
+	uint32_t is_in_usb_c_dp4_mode = 0;
 
 	dcn10_link_encoder_get_max_link_cap(enc, link_settings);
 
-	if (enc->features.flags.bits.DP_IS_USB_C && dc_dmub_srv) {
-		memset(&cmd, 0, sizeof(cmd));
-		cmd.query_dp_alt.header.type = DMUB_CMD__VBIOS;
-		cmd.query_dp_alt.header.sub_type = DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT;
-		cmd.query_dp_alt.header.payload_bytes = sizeof(cmd.panel_cntl.data);
-		cmd.query_dp_alt.data.phy_id = phy_id_from_transmitter(enc10->base.transmitter);
+	/* Take the link cap directly if not USB */
+	if (!enc->features.flags.bits.DP_IS_USB_C)
+		return;
 
-		if (!dc_dmub_srv_cmd_with_reply_data(dc_dmub_srv, &cmd))
+	/*
+	 * Use the new interface from DMCUB if available.
+	 * Avoids hanging the RDCPSPIPE if DMCUB wasn't already running.
+	 */
+	if (has_query_dp_alt(enc)) {
+		if (!query_dp_alt_from_dmub(enc, &cmd))
 			return;
 
-		if (cmd.query_dp_alt.data.is_usb && cmd.query_dp_alt.data.is_dp4 == 0)
+		if (cmd.query_dp_alt.data.is_usb &&
+		    cmd.query_dp_alt.data.is_dp4 == 0)
 			link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
+
+		return;
 	}
+
+	/* Legacy path, avoid if possible. */
+	if (enc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_B0) {
+		REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4,
+			&is_in_usb_c_dp4_mode);
+	} else {
+		if ((enc10->base.transmitter == TRANSMITTER_UNIPHY_A) ||
+		    (enc10->base.transmitter == TRANSMITTER_UNIPHY_B) ||
+		    (enc10->base.transmitter == TRANSMITTER_UNIPHY_E)) {
+			REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4,
+				&is_in_usb_c_dp4_mode);
+		} else {
+			REG_GET(RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DP4,
+				&is_in_usb_c_dp4_mode);
+		}
+	}
+
+	if (!is_in_usb_c_dp4_mode)
+		link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
 }
-- 
2.25.1

