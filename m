Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67FAC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5770610E213;
	Sun, 23 Jan 2022 18:21:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8C910E213
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j855KyK36QRXrkSntu+yg2f71X7QT8n6D8oQeqffj9O/yAmOv9El93FuWRqy0u5DahTMkGNBuLi0+avejpeZiVmcbVkwVL2YpRI/q8J4amSdyRFTV32Ay461dzqpFiA7ipgnNOKG/u9tzl3u7UVMnEUQI7RI8SIgXRfQY8OMPZic3qsD+zKckHmuxt/NOUNhRxJJRW4ew3CkJZvPm1WWjNYNeUG3ZqRiXbJ1Knk0kRArpTw9fAP+FampCSDk5x/3e6QC+A9r9xwt2VYaBLEeQhGYc2Ks3qyIxB17mN/z7kn3A8lQB9c1wYHzlwE1THlRlrseh2Ad7Cvfd2BXhYnklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T082mYEuHzgSLlMVnSRy6iGjjWQac80NI8KoAue2jTY=;
 b=lLiTFCjMvtK9pU62c9q2b/T+iQfMGxbcmaxzg3c2TkHjIg7qOZM+5nJUdgoEgCcsFfPs8a9oiEA6pSyJar4Y4hUh3oQPrBesvHrIbzWKFcSXFIlQMLClQYgapit+P8ieiWP5p5NvtDeooMGKJ6a1xExAoR4SFHacsd9WWgUK+2tQX5bCV6Y3ji+vopRLoJ5gqB+N9H/CesTb73QDquA/8zlAPfrU7p7WImY7gsOxtr7gGjNeYILscc12T2BU8HDoUKKiCI9hg2gDv1jWVPFJjr1kkyYXGxqwL6Na9f2ES0dY/mpp5u46JCACu/VQNQjFTakFb470nw5BFrIhaqmKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T082mYEuHzgSLlMVnSRy6iGjjWQac80NI8KoAue2jTY=;
 b=qMQH+mfqpx4ORqAABez0FoE4d2SnDyjiD1fJ5X4OTCbA37OiJkPITB00tf1pcki7k4JQxQev+xYxQ28A+TCf4HX/xQ/G4QnsUdzSncsaUJ7tgGnahaR2pLQRHxdluPmLpDfLhQv2OD9Rs82biP/zhfynXwCuCUgboDLceIxSKGY=
Received: from BN9PR03CA0609.namprd03.prod.outlook.com (2603:10b6:408:106::14)
 by SN1PR12MB2526.namprd12.prod.outlook.com (2603:10b6:802:2a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Sun, 23 Jan
 2022 18:21:02 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::1e) by BN9PR03CA0609.outlook.office365.com
 (2603:10b6:408:106::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:02 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:00 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/24] drm/amd/display: Add Cable ID support for native DP
Date: Sun, 23 Jan 2022 13:20:05 -0500
Message-ID: <20220123182021.4154032-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a671906-0818-471a-10d5-08d9de9d1cb5
X-MS-TrafficTypeDiagnostic: SN1PR12MB2526:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB252651655CCCF2281BBB35F0985D9@SN1PR12MB2526.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4oKiBBTJmeXjYCF8wDSllvyhU3NaPSB6YHzWHzXknFpt/jJaOiP0vB4vr5D74E0irUIAE4UK/QZ0dGwpc9mn9IAFVZPHKDZElU3L/89Cx/d7NtKO3jPKFb6z2ik3gPq2r4zIqiVAFfgLIj5P8uUc0PzwLSJPi7d/5UCnCsWgnTH4F09cs1Rnj3JTHQd8rAJ3r/P7kf9HkgQ41fa73qbCcv4abIZ9dt0//3Hy+iof0zdzdU9qfmhzuhiTM6/T9UuRue4han4sB08i2SJhK1T4zSBACgcfKxLN1rT99X/RJ4rHnohO/REyagPWPieFGKcLB86CmR1rH0DMNG2VC2OqDNwPJpWgz7ipcgL7jR18waIHtJfGhHOj76iivXXfG+glCGjVySIxaq+CeD4SPU2D4UhPoOiZL5GntvY1r+Wu+7FkR8T/QaHgms2P5sgmsk97y/yzyplmAqGGX3C/PTUw56D43e4SNiWytXjDZ5UUEi3KNp4BuIwNUF2rMKNQEN/aYkuJtGEUxrXUWE0Ld/lINliEhEZC+GZK/VB5L7abYZjI6amKuAXL7L0K4f2Wz9xSTcKpLh+bp56BACs8phTUgQoUBn2DhY5YwIFmeX0KxiYR/OUQ79eZkuvarPZr9KOWERoB5mwO/2/tKTKhbXOX5uwzGHuYI0673TreNFGOs8Mnz37M/FV3aixsoPqeGq87yJXOPo3SIBXh8xGx8M5H3i9hwRRM1Qlu29QvsC8fZYa7WnCcJJKZRPJ14kMYq8ZmftouYgfkVHFdHk2hITu+dYdMNCYJEF7ir/side/oTTM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(81166007)(83380400001)(82310400004)(356005)(5660300002)(70206006)(86362001)(8936002)(36756003)(47076005)(2906002)(4326008)(54906003)(6916009)(70586007)(1076003)(2616005)(36860700001)(426003)(8676002)(336012)(16526019)(186003)(508600001)(40460700003)(316002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:02.2027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a671906-0818-471a-10d5-08d9de9d1cb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2526
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
 qingqing.zhuo@amd.com, "Shen, George" <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Shen, George" <George.Shen@amd.com>

[Why/How]
We need to handle cable capabilities for cables that support cable ID.
The cable attributes are intersected with the verified link caps to
determine appropriate max link rate. After determining cable attributes
we update the DP receiver.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  5 ++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 59 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 16 +++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  7 +++
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  3 +
 6 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b826ac9bd85d..d0aba8d7b1c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1290,6 +1290,8 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		 *  Clear dongle_max_pix_clk on disconnect to fix this
 		 */
 		link->dongle_max_pix_clk = 0;
+
+		dc_link_dp_clear_rx_status(link);
 	}
 
 	LINK_INFO("link=%d, dc_sink_in=%p is now %s prev_sink=%p edid same=%d\n",
@@ -1969,6 +1971,9 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	if (link->dpcd_sink_ext_caps.raw != 0)
 		msleep(post_oui_delay);
 
+	// similarly, mode switch can cause loss of cable ID
+	dpcd_update_cable_id(link);
+
 	skip_video_pattern = true;
 
 	if (link_settings.link_rate == LINK_RATE_LOW)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1730be6c64ed..0033d2a0cfe5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2981,6 +2981,20 @@ static enum dc_link_rate get_lttpr_max_link_rate(struct dc_link *link)
 	return lttpr_max_link_rate;
 }
 
+static enum dc_link_rate get_cable_max_link_rate(struct dc_link *link)
+{
+	enum dc_link_rate cable_max_link_rate = LINK_RATE_HIGH3;
+
+	if (link->dpcd_caps.cable_attributes.bits.UHBR10_20_CAPABILITY & DP_UHBR20)
+		cable_max_link_rate = LINK_RATE_UHBR20;
+	else if (link->dpcd_caps.cable_attributes.bits.UHBR13_5_CAPABILITY)
+		cable_max_link_rate = LINK_RATE_UHBR13_5;
+	else if (link->dpcd_caps.cable_attributes.bits.UHBR10_20_CAPABILITY & DP_UHBR10)
+		cable_max_link_rate = LINK_RATE_UHBR10;
+
+	return cable_max_link_rate;
+}
+
 bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
 {
 	struct link_encoder *link_enc = NULL;
@@ -3009,8 +3023,10 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 {
 	struct dc_link_settings max_link_cap = {0};
 	enum dc_link_rate lttpr_max_link_rate;
+	enum dc_link_rate cable_max_link_rate;
 	struct link_encoder *link_enc = NULL;
 
+
 	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
 
@@ -3029,6 +3045,14 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 			max_link_cap.link_spread)
 		max_link_cap.link_spread =
 				link->reported_link_cap.link_spread;
+
+	/* Lower link settings based on cable attributes */
+	cable_max_link_rate = get_cable_max_link_rate(link);
+
+	if (!link->dc->debug.ignore_cable_id &&
+			cable_max_link_rate < max_link_cap.link_rate)
+		max_link_cap.link_rate = cable_max_link_rate;
+
 	/*
 	 * account for lttpr repeaters cap
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
@@ -5059,6 +5083,13 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 	return is_lttpr_present;
 }
 
+
+static bool is_usbc_connector(struct dc_link *link)
+{
+	return link->link_enc &&
+			link->link_enc->features.flags.bits.DP_IS_USB_C;
+}
+
 static bool retrieve_link_cap(struct dc_link *link)
 {
 	/* DP_ADAPTER_CAP - DP_DPCD_REV + 1 == 16 and also DP_DSC_BITS_PER_PIXEL_INC - DP_DSC_SUPPORT + 1 == 16,
@@ -5115,6 +5146,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 	 */
 	msleep(post_oui_delay);
 
+	/* Read cable ID and update receiver */
+	dpcd_update_cable_id(link);
+
 	for (i = 0; i < read_dpcd_retry_cnt; i++) {
 		status = core_link_read_dpcd(
 				link,
@@ -6292,6 +6326,26 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 	}
 }
 
+void dpcd_update_cable_id(struct dc_link *link)
+{
+	if (!link->link_enc->features.flags.bits.IS_UHBR10_CAPABLE ||
+			link->dprx_status.cable_id_updated)
+		return;
+
+	/* Retrieve cable attributes */
+	if (!is_usbc_connector(link))
+		core_link_read_dpcd(link, DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX,
+				&link->dpcd_caps.cable_attributes.raw,
+				sizeof(uint8_t));
+
+	/* Update receiver with cable attributes */
+	core_link_write_dpcd(link, DP_CABLE_ATTRIBUTES_UPDATED_BY_DPTX,
+			&link->dpcd_caps.cable_attributes.raw,
+			sizeof(link->dpcd_caps.cable_attributes.raw));
+
+	link->dprx_status.cable_id_updated = 1;
+}
+
 bool dc_link_set_backlight_level_nits(struct dc_link *link,
 		bool isHDR,
 		uint32_t backlight_millinits,
@@ -6689,3 +6743,8 @@ void edp_panel_backlight_power_on(struct dc_link *link)
 	if (link->dc->hwss.edp_backlight_control)
 		link->dc->hwss.edp_backlight_control(link, true);
 }
+
+void dc_link_dp_clear_rx_status(struct dc_link *link)
+{
+	memset(&link->dprx_status, 0, sizeof(link->dprx_status));
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ff5093e52f2d..0dc183d6af5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -687,6 +687,7 @@ struct dc_debug_options {
 	bool set_mst_en_for_sst;
 	bool disable_uhbr;
 	bool force_dp2_lt_fallback_method;
+	bool ignore_cable_id;
 	union mem_low_power_enable_options enable_mem_low_power;
 	union root_clock_optimization_options root_clock_optimization;
 	bool hpo_optimization;
@@ -1234,6 +1235,7 @@ struct dpcd_caps {
 	union dp_main_line_channel_coding_cap channel_coding_cap;
 	union dp_sink_video_fallback_formats fallback_formats;
 	union dp_fec_capability1 fec_cap1;
+	union dp_cable_attributes cable_attributes;
 };
 
 union dpcd_sink_ext_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 6d813db6b8dc..ac2c59bd024d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -901,6 +901,9 @@ struct dpcd_usb4_dp_tunneling_info {
 #ifndef DP_LINK_SQUARE_PATTERN
 #define DP_LINK_SQUARE_PATTERN				0x10F
 #endif
+#ifndef DP_CABLE_ATTRIBUTES_UPDATED_BY_DPTX
+#define DP_CABLE_ATTRIBUTES_UPDATED_BY_DPTX		0x110
+#endif
 #ifndef DP_DSC_CONFIGURATION
 #define DP_DSC_CONFIGURATION				0x161
 #endif
@@ -913,6 +916,9 @@ struct dpcd_usb4_dp_tunneling_info {
 #ifndef DP_128b_132b_TRAINING_AUX_RD_INTERVAL
 #define DP_128b_132b_TRAINING_AUX_RD_INTERVAL		0x2216
 #endif
+#ifndef DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX
+#define DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX		0x2217
+#endif
 #ifndef DP_TEST_264BIT_CUSTOM_PATTERN_7_0
 #define DP_TEST_264BIT_CUSTOM_PATTERN_7_0		0X2230
 #endif
@@ -1011,6 +1017,16 @@ union dp_fec_capability1 {
 	uint8_t raw;
 };
 
+union dp_cable_attributes {
+	struct {
+		uint8_t UHBR10_20_CAPABILITY	:2;
+		uint8_t UHBR13_5_CAPABILITY	:1;
+		uint8_t CABLE_TYPE		:3;
+		uint8_t RESERVED		:2;
+	} bits;
+	uint8_t raw;
+};
+
 struct dp_color_depth_caps {
 	uint8_t support_6bpc	:1;
 	uint8_t support_8bpc	:1;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 9014c0a0a63b..b1c79b3f26aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -43,6 +43,10 @@ struct dc_link_status {
 	struct dpcd_caps *dpcd_caps;
 };
 
+struct dp_receiver_status {
+	bool cable_id_updated;
+};
+
 /* DP MST stream allocation (payload bandwidth number) */
 struct link_mst_stream_allocation {
 	/* DIG front */
@@ -201,6 +205,7 @@ struct dc_link {
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
 	struct dc_link_status link_status;
+	struct dp_receiver_status dprx_status;
 
 	struct link_trace link_trace;
 	struct gpio *hpd_gpio;
@@ -459,4 +464,6 @@ const struct link_resource *dc_link_get_cur_link_res(const struct dc_link *link)
 void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map);
 /* restore link resource allocation state from a snapshot */
 void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
+
+void dc_link_dp_clear_rx_status(struct dc_link *link);
 #endif /* DC_LINK_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index b7c5c42d67ed..3ed2dbbf5642 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -112,6 +112,9 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
 bool dp_overwrite_extended_receiver_cap(struct dc_link *link);
 
 void dpcd_set_source_specific_data(struct dc_link *link);
+
+void dpcd_update_cable_id(struct dc_link *link);
+
 /* Write DPCD link configuration data. */
 enum dc_status dpcd_set_link_settings(
 	struct dc_link *link,
-- 
2.25.1

