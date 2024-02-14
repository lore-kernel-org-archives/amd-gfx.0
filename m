Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAE8C48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C81510E3F1;
	Wed, 14 Feb 2024 18:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zhWaI28n";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB9710E34E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqBdCEFhq5tLZO9x78/qzQvAkeG4MYJG1WyOeBf2kmHCoSrJ1ihVu8POs9wtYYZPOPCKk3sfgpPBj+r9sowgsjxUuIu4GQRfwg19JUA2SToX6kB3j1MHLSySP/OCwzVMDVtdaom2J/ilxn05LwdKEY94O25GKQXw/QWbECO3uO/EwjHhyboo8Ie3FjJ9b4ViVNBe0d7GO6aKmykzsmpxCC7sXIR+bI1FA8HOAkBy+gE29DM1xyIVOHdZDq7f+sUtLshLHKNPfWPcqad3CzzW4egEBFmOsyT0KLmqSuhzfiL1h0C/5ngF9tjU49s3/biGy3gK1dyjOtbEbwFE5mkoZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6RZOekdCoFP1/L4toQIlJjygyvO+kxLCVgoIGcXoJU=;
 b=jPMYmmORMLKZiRgK+JRoB8imd+K3otSTL2H7KnpMkLcCqNl+XYbnfFqmGTutwoJlePJJBaYFU5pjAITXOhxEjuneXTrbMSPIWxUM1XXHbhjevVhgyOTG6IjXRpMJzFzhzXNyJc5HqVVidHa+eZdoMKwh1GsnUGhmqhlE3ZxXrM1yp0lcJVd/SnlZd3Eta4KBFH+g02yAmTmQylXHBMGAntOUZ4MaBUTA78nd1y1lZICOXd0QiCtW2IdPN0kdWDMog5bDGqpwc12XIwk9S7g2TkjK2dJCZ+A9+84drucIzFrnJUDpyW/4Qa22oWJaiRoIdUCA9Y8RKh/Ks7KPQkxhsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6RZOekdCoFP1/L4toQIlJjygyvO+kxLCVgoIGcXoJU=;
 b=zhWaI28nyKWDB5UgPoAfqtNvBgeKByuJrhVct+aGwmDbgQ/ZNgf+zgZ/SUi8Yx524lxwSmBsJ96Uv0uW8ImCrNu2RMDWf2q7/vQIBeGhzNGm9/+2V0W8wxGkn0Pc753GfYtllEMEMrT/IvMbe4YoMBIEDF5Qh7qygG+zqSntfTw=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Wed, 14 Feb
 2024 18:40:44 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::d6) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:44 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:41 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, George Shen
 <george.shen@amd.com>, Charlene Liu <charlene.liu@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 09/17] drm/amd/display: Check DP Alt mode DPCS state via DMUB
Date: Wed, 14 Feb 2024 11:38:40 -0700
Message-ID: <20240214184006.1356137-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fa214e-31e3-43dd-244d-08dc2d8c73e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RFZRzKHiuBV32Zvs9qM125EQnzXIST6Iw3x5J3Wp4PT19YLIAGygTVQ35UN4yQ9ZHhBwHa2bE6EPEnjQVgiZmFO+3jRFSk7lkwVsJ6T/20lXKm4q1KkA3uFhBLRICY1mRqb+znMGbuCkFx9ou+3hA/jH0gUChO0yCWPFvAtjJT25MIR5LZIlgd3sMRTcPfZSYJjaf6YZbMOdlvjdZbNVwgz38cwKK4iGj8km6nc0u/HXDi8DCJsIuDpuILnncSR6h8VyV56aIjkMhdfD8hgX/e6p5AlRKWIBeDBCIinD6KVWq8ouJM6iCLlm2qg72HLRmg7DhUitiNE2p6t4kkWjyp6yvSLi4cEtxELuHlxz6nfSM8kVM9zUWSiVywSmnOtvBFLRTUp03TS7UQNeWjZVwkA+qG15b8cDbuJlhoySN0fMNtTGJCPv3zofLIP7xYKQpIjhL4k2agZvSHzC5ZwVAOW2cPEoalrHPr9tAsjlvIJDMGRbhLIqBKgDhAhJM7lCa2/t21S3P4APiIVEvHTEpdmENI7V39/xBAW3Wo4ZsQiXu0zGAknTLSBNRTIHCXGqNNT/ZwciTakhY1f+IG441LhZGTQ+ulUxdGKaEKUC3jQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(2616005)(1076003)(83380400001)(82740400003)(16526019)(356005)(26005)(81166007)(426003)(336012)(478600001)(4326008)(5660300002)(8936002)(6916009)(41300700001)(70586007)(2906002)(316002)(54906003)(36756003)(8676002)(70206006)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:44.1923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fa214e-31e3-43dd-244d-08dc2d8c73e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
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

From: George Shen <george.shen@amd.com>

[Why]
Currently, driver state for DCN3.2 is not strictly matching HW state for
the USBC port. To reduce inconsistencies while debugging, the driver
should match HW configuration.

[How]
Update link encoder flag to indicate USBC port. Call into DMUB to check
when DP Alt mode is entered, and also to check for 2-lane versuse 4-lane
mode.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../display/dc/dcn32/dcn32_dio_link_encoder.c | 85 ++++++++++++++-----
 .../display/dc/dcn32/dcn32_dio_link_encoder.h |  5 ++
 2 files changed, 71 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
index d761b0df2878..e224a028d68a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
@@ -34,6 +34,7 @@
 #include "dc_bios_types.h"
 #include "link_enc_cfg.h"
 
+#include "dc_dmub_srv.h"
 #include "gpio_service_interface.h"
 
 #ifndef MIN
@@ -61,6 +62,38 @@
 #define AUX_REG_WRITE(reg_name, val) \
 			dm_write_reg(CTX, AUX_REG(reg_name), val)
 
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
 
 void enc32_hw_init(struct link_encoder *enc)
 {
@@ -117,38 +150,50 @@ void dcn32_link_encoder_enable_dp_output(
 	}
 }
 
-static bool dcn32_link_encoder_is_in_alt_mode(struct link_encoder *enc)
+static bool query_dp_alt_from_dmub(struct link_encoder *enc,
+	union dmub_rb_cmd *cmd)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t dp_alt_mode_disable = 0;
-	bool is_usb_c_alt_mode = false;
 
-	if (enc->features.flags.bits.DP_IS_USB_C) {
-		/* if value == 1 alt mode is disabled, otherwise it is enabled */
-		REG_GET(RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, &dp_alt_mode_disable);
-		is_usb_c_alt_mode = (dp_alt_mode_disable == 0);
-	}
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->query_dp_alt.header.type = DMUB_CMD__VBIOS;
+	cmd->query_dp_alt.header.sub_type =
+		DMUB_CMD__VBIOS_TRANSMITTER_QUERY_DP_ALT;
+	cmd->query_dp_alt.header.payload_bytes = sizeof(cmd->query_dp_alt.data);
+	cmd->query_dp_alt.data.phy_id = phy_id_from_transmitter(enc10->base.transmitter);
+
+	if (!dc_wake_and_execute_dmub_cmd(enc->ctx, cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		return false;
 
-	return is_usb_c_alt_mode;
+	return true;
 }
 
-static void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
+bool dcn32_link_encoder_is_in_alt_mode(struct link_encoder *enc)
+{
+	union dmub_rb_cmd cmd;
+
+	if (!query_dp_alt_from_dmub(enc, &cmd))
+		return false;
+
+	return (cmd.query_dp_alt.data.is_dp_alt_disable == 0);
+}
+
+void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	struct dc_link_settings *link_settings)
 {
-	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	uint32_t is_in_usb_c_dp4_mode = 0;
+	union dmub_rb_cmd cmd;
 
 	dcn10_link_encoder_get_max_link_cap(enc, link_settings);
 
-	/* in usb c dp2 mode, max lane count is 2 */
-	if (enc->funcs->is_in_alt_mode && enc->funcs->is_in_alt_mode(enc)) {
-		REG_GET(RDPCSPIPE_PHY_CNTL6, RDPCS_PHY_DPALT_DP4, &is_in_usb_c_dp4_mode);
-		if (!is_in_usb_c_dp4_mode)
-			link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
-	}
+	if (!query_dp_alt_from_dmub(enc, &cmd))
+		return;
 
+	if (cmd.query_dp_alt.data.is_usb &&
+			cmd.query_dp_alt.data.is_dp4 == 0)
+		link_settings->lane_count = MIN(LANE_COUNT_TWO, link_settings->lane_count);
 }
 
+
 static const struct link_encoder_funcs dcn32_link_enc_funcs = {
 	.read_state = link_enc2_read_state,
 	.validate_output_with_stream =
@@ -203,13 +248,15 @@ void dcn32_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
-
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
 	enc10->base.features = *enc_features;
 	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
 		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
+
 	enc10->base.transmitter = init_data->transmitter;
 
 	/* set the flag to indicate whether driver poll the I2C data pin
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
index bbcfce06bec0..2d5f25290ed1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
@@ -53,4 +53,9 @@ void dcn32_link_encoder_enable_dp_output(
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source);
 
+bool dcn32_link_encoder_is_in_alt_mode(struct link_encoder *enc);
+
+void dcn32_link_encoder_get_max_link_cap(struct link_encoder *enc,
+	struct dc_link_settings *link_settings);
+
 #endif /* __DC_LINK_ENCODER__DCN32_H__ */
-- 
2.43.0

