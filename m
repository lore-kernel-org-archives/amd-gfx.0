Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993CFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27247AA4B0;
	Fri,  3 Dec 2021 22:59:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5079AA4A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCJ8HZJ6uFXjyNILD/2rNtjQ+0LCmwWuZN735GUdcMT5TDe+5XSYTpEgfazL6VhmbTIw9On8E9fIBVvoxrrJkSAWcXr61fYRhm1by4nPxjeH1ehFZxzYZBhAnNqX1FwXNe0dlbz+EMoW4AYuJzzj222EqoOVwBhr9JYHJhRrQS8UAbtcVU4ZopNw/wMjZ3RV3NfgzNWYThOLB9DpLw+ftzsnm++P1nVxZivSAzwuiO/YGTKQ3awdONY6ydRgo7Rgf97fV/auZrfq8hS/IsDx5NPtOoSgz81OtG0gpPokuK5m6xtAiNllaRtfxJODFF1ufJDMc0gZJqteMKbIdTtM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60VCFWtUvcBU5ystSdI0p1gPA51ctfRg1Y9e/KzWqvw=;
 b=almeZCv9AgNBw/71eDCVwqtJUymeIzVPCIk2nqLc6514KVqow9LtKGG1lTe+aGcyLISxpMj1tUtsOk6ifj4zsqtqbC4INnmD9Rt5TinLGajghaT4kNKYVWPB4kXzLsPyO8n6wnFs2IvEcD8nA0AIZmYnV/rJsMMV1/VMLPGP/7nJMGx8/xWOzjTzdWyHDfjDjyB7vgB0yjWP/49pxPpwXrBqC7GmHXC9bP8e2AKpSaq+kxhybuDmlgdLBtl0zH0uL5k6Z1/0aJrwk3sTijyHBWiV5kTmW0JUtd707gsgIXU0fOR7rdocOoHy6T3l7wGSM1KMwMRlNV4nmBTxiWZtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60VCFWtUvcBU5ystSdI0p1gPA51ctfRg1Y9e/KzWqvw=;
 b=d10xcelvNObvJuoMnWfH3m60CS8CRh10KHCmA3XPowjb9bQmU1udRPgC94BwxO1Yt/p9p5Nxk0Lf8jbVfVCbZpSOVB4/sg5cwFxvubQkGYBAFV1JfK8xSL5Y38ucDDtrCSks5N52/2+Stuj2mGZof//RoJCWY4I4kIlOW0NHkXE=
Received: from BN1PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:e0::20)
 by BN6PR1201MB0225.namprd12.prod.outlook.com (2603:10b6:405:5a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 22:59:20 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::db) by BN1PR10CA0015.outlook.office365.com
 (2603:10b6:408:e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 22:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:59:20 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:59:18 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/15] drm/amd/display: Query DMCUB for dp alt status
Date: Fri, 3 Dec 2021 14:58:00 -0800
Message-ID: <20211203225802.651367-14-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e5371cd-b16a-4590-02a6-08d9b6b08aa3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0225:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02253A491378108318CA7C84FC6A9@BN6PR1201MB0225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDQPVn69o2Mn2C3rmhi/auRBMS96idemYJxQ6sX8ii1lms1qQbsI5CZII9tSRsZ6cmxscroXXuq81SgLss6CHxgYsDz/b9cXQdPMeMMY/WY5iP+NZ5Xk73d78QcWeF9I9CE1PAIgKxMKvnkz2+HT6nl5wMkQzg4KXPVrSDXyb46YejvJlolvTfxUOfCyDhGG6JO+VEvBFO0etLkRde3tiYQIlKhsObv2w3fy0H3XbeyIQBBtvdf6zqa7AAdaN+47Iwo6P+X49G950+fGAUdQ6nLXc6ciYJ3OLdOkzah5yMoP8PCV7rBt/G7ctcxADgQZLc9zuTzVeJld3T18N179f2hvNHvsONkKY5O6DDXUwkxLOAu2+Q0x/cgmLyyM9MqIbN09MjQSwpsQ5WBbJ8HGb6Wmj7IQR1J6QfaTJRsLzqFDvBDMtkUXYiUjxewuCILnFOg9lxdXzupGaYg9sA76tJ1UBVj01hNE5qNnrIvHDJYSaIE1NBb+gA6dhYdYLxqIirFZIz4xxSPz+hjQuqMhsBgyTQZW2zKMAoXxwnI/IxDhb4evwiQtOYp9pD5Fwx0DVuvfYd4/2AZYLdyLZK0Cdia6lApCWYDB6MOF7aYpClt09aD660wX54tI1xX5d0BS9KeElns+OxgzuT/CUUh2bAlpnZlEvBAK8/cRz0qX1pSOLW3LbqIYfWha4oUhZCvfOq+fvmEaesAWOyS5hIeYfyVPNfBtEWhtOyH6IVfCnPSQz498oLceU13zJmGVd78j8GEh1nje+nmPM7hLQxHFc9H5WPd7FT4TO8Z7W438cQA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(186003)(6666004)(6916009)(86362001)(508600001)(54906003)(26005)(70206006)(16526019)(426003)(36756003)(82310400004)(81166007)(336012)(8676002)(5660300002)(40460700001)(316002)(8936002)(4326008)(47076005)(1076003)(83380400001)(356005)(7696005)(70586007)(2906002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:59:20.5605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5371cd-b16a-4590-02a6-08d9b6b08aa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0225
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
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
To avoid hanging RDPCSPIPE when INTERCEPTB isn't set.

DMCUB owns control of that bit so DMCUB should manage returning the
information driver needs for link encoder control.

[How]
Add a new DMCUB command to return dp alt disable and dp4 information.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 97 +++++++++++--------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 29 ++++++
 2 files changed, 88 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index ee6f13bef377..80bb09db5e4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -67,6 +67,39 @@
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 #endif
 
+static uint8_t phy_id_from_transmitter(enum transmitter t)
+{
+	uint8_t phy_id;
+
+	switch (t) {
+	case TRANSMITTER_UNIPHY_A:
+		phy_id = 0;
+		break;
+	case TRANSMITTER_UNIPHY_B:
+		phy_id = 1;
+		break;
+	case TRANSMITTER_UNIPHY_C:
+		phy_id = 2;
+		break;
+	case TRANSMITTER_UNIPHY_D:
+		phy_id = 3;
+		break;
+	case TRANSMITTER_UNIPHY_E:
+		phy_id = 4;
+		break;
+	case TRANSMITTER_UNIPHY_F:
+		phy_id = 5;
+		break;
+	case TRANSMITTER_UNIPHY_G:
+		phy_id = 6;
+		break;
+	default:
+		phy_id = 0;
+		break;
+	}
+	return phy_id;
+}
+
 void dcn31_link_encoder_set_dio_phy_mux(
 	struct link_encoder *enc,
 	enum encoder_type_select sel,
@@ -536,57 +569,45 @@ void dcn31_link_encoder_disable_output(
 bool dcn31_link_encoder_is_in_alt_mode(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t dp_alt_mode_disable;
+	struct dc_dmub_srv *dc_dmub_srv = enc->ctx->dmub_srv;
+	union dmub_rb_cmd cmd;
 	bool is_usb_c_alt_mode = false;
 
-	if (enc->features.flags.bits.DP_IS_USB_C) {
-		if (enc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_B0) {
-			// [Note] no need to check hw_internal_rev once phy mux selection is ready
-			REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
-		} else {
-		/*
-		 * B0 phys use a new set of registers to check whether alt mode is disabled.
-		 * if value == 1 alt mode is disabled, otherwise it is enabled.
-		 */
-			if ((enc10->base.transmitter == TRANSMITTER_UNIPHY_A)
-					|| (enc10->base.transmitter == TRANSMITTER_UNIPHY_B)
-					|| (enc10->base.transmitter == TRANSMITTER_UNIPHY_E)) {
-				REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
-			} else {
-			// [Note] need to change TRANSMITTER_UNIPHY_C/D to F/G once phy mux selection is ready
-				REG_GET(RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
-			}
-		}
+	if (enc->features.flags.bits.DP_IS_USB_C && dc_dmub_srv) {
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.query_dp_alt.header.type = DMUB_CMD__VBIOS;
+		cmd.query_dp_alt.header.sub_type = DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT;
+		cmd.query_dp_alt.header.payload_bytes = sizeof(cmd.panel_cntl.data);
+		cmd.query_dp_alt.data.phy_id = phy_id_from_transmitter(enc10->base.transmitter);
 
-		is_usb_c_alt_mode = (dp_alt_mode_disable == 0);
+		if (!dc_dmub_srv_cmd_with_reply_data(dc_dmub_srv, &cmd))
+			return false;
+
+		is_usb_c_alt_mode = (cmd.query_dp_alt.data.is_dp_alt_disable == 0);
 	}
 
 	return is_usb_c_alt_mode;
 }
 
-void dcn31_link_encoder_get_max_link_cap(struct link_encoder *enc,
-										 struct dc_link_settings *link_settings)
+void dcn31_link_encoder_get_max_link_cap(struct link_encoder *enc, struct dc_link_settings *link_settings)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t is_in_usb_c_dp4_mode = 0;
+	struct dc_dmub_srv *dc_dmub_srv = enc->ctx->dmub_srv;
+	union dmub_rb_cmd cmd;
 
 	dcn10_link_encoder_get_max_link_cap(enc, link_settings);
 
-	/* in usb c dp2 mode, max lane count is 2 */
-	if (enc->funcs->is_in_alt_mode && enc->funcs->is_in_alt_mode(enc)) {
-		if (enc->ctx->asic_id.hw_internal_rev != YELLOW_CARP_B0) {
-			// [Note] no need to check hw_internal_rev once phy mux selection is ready
-			REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &is_in_usb_c_dp4_mode);
-		} else {
-			if ((enc10->base.transmitter == TRANSMITTER_UNIPHY_A)
-					|| (enc10->base.transmitter == TRANSMITTER_UNIPHY_B)
-					|| (enc10->base.transmitter == TRANSMITTER_UNIPHY_E)) {
-				REG_GET(RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &is_in_usb_c_dp4_mode);
-			} else {
-				REG_GET(RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &is_in_usb_c_dp4_mode);
-			}
-		}
-		if (!is_in_usb_c_dp4_mode)
+	if (enc->features.flags.bits.DP_IS_USB_C && dc_dmub_srv) {
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.query_dp_alt.header.type = DMUB_CMD__VBIOS;
+		cmd.query_dp_alt.header.sub_type = DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT;
+		cmd.query_dp_alt.header.payload_bytes = sizeof(cmd.panel_cntl.data);
+		cmd.query_dp_alt.data.phy_id = phy_id_from_transmitter(enc10->base.transmitter);
+
+		if (!dc_dmub_srv_cmd_with_reply_data(dc_dmub_srv, &cmd))
+			return;
+
+		if (cmd.query_dp_alt.data.is_usb && cmd.query_dp_alt.data.is_dp4 == 0)
 			link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 45af0a7b7da4..a473e17d3d3e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -409,7 +409,14 @@ enum dmub_cmd_vbios_type {
 	 * Enables or disables power gating.
 	 */
 	DMUB_CMD__VBIOS_ENABLE_DISP_POWER_GATING = 3,
+	/**
+	 * Controls embedded panels.
+	 */
 	DMUB_CMD__VBIOS_LVTMA_CONTROL = 15,
+	/**
+	 * Query DP alt status on a transmitter.
+	 */
+	DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT  = 26,
 };
 
 //==============================================================================
@@ -2394,6 +2401,24 @@ struct dmub_rb_cmd_lvtma_control {
 	struct dmub_cmd_lvtma_control_data data;
 };
 
+/**
+ * Data passed in/out in a DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT command.
+ */
+struct dmub_rb_cmd_transmitter_query_dp_alt_data {
+	uint8_t phy_id; /**< 0=UNIPHYA, 1=UNIPHYB, 2=UNIPHYC, 3=UNIPHYD, 4=UNIPHYE, 5=UNIPHYF */
+	uint8_t is_usb; /**< is phy is usb */
+	uint8_t is_dp_alt_disable; /**< is dp alt disable */
+	uint8_t is_dp4; /**< is dp in 4 lane */
+};
+
+/**
+ * Definition of a DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT command.
+ */
+struct dmub_rb_cmd_transmitter_query_dp_alt {
+	struct dmub_cmd_header header; /**< header */
+	struct dmub_rb_cmd_transmitter_query_dp_alt_data data; /**< payload */
+};
+
 /**
  * Maximum number of bytes a chunk sent to DMUB for parsing
  */
@@ -2601,6 +2626,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
 	 */
 	struct dmub_rb_cmd_lvtma_control lvtma_control;
+	/**
+	 * Definition of a DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT command.
+	 */
+	struct dmub_rb_cmd_transmitter_query_dp_alt query_dp_alt;
 	/**
 	 * Definition of a DMUB_CMD__DPIA_DIG1_CONTROL command.
 	 */
-- 
2.32.0

