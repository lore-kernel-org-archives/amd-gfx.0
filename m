Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114ABC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 14:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 771E36F4C6;
	Fri, 26 Nov 2021 14:32:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B9226F483
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 14:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT6aNFW+bklUbqw14lbl7rJW6fwIETif8YKjsImWZXP46Fjr7ZKE8lPXqQmk73pRJYJfNXDRaHzEGMSv7xie+Mmpz+feN6awf3a9XDMxfYEJWn9TpsQ+PoRgJspDX93a8J3GN9RvIReeW35+bNv606UFqLszydyb1W+xuaRogxNtGmgMdxID/knMBVrkIq1uQ09Mc9e8hIXkN+9yR3poXAQrLANe9DKbOAL5uWVMlMhBJl7sTvhsH1wJNrn4nO3SO17nyKwD730EKkmFYgmkDZDqWLbH23pcsqJUyIduS5NJmHi0N1Z1pQfvI24HYU2VwGRMyTjgAFK+R9BxFVXuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWQzTmLFc6+nhM6jiZXvLH/RDyMse6t7caZ95zn42K0=;
 b=VkttTsjpmWYcxzvXhw3sbmaktYlo/RW8H8QlSrybWiKna0DhIQU87D2yi1j8qMPmr3uv5Um7q+QxXBlBWowS5Dqj6b/BDQ/LMi/pw2Szml3OKZloPmM4/mIRgmzMAqOhu8kNS1F5OFdtRH8Lny6Ab066a25cwjf84cxQ08+u5PL9/Du1jFvhBwJ80wf9sop+ASfgIrpLULKVDI4Lk3aeGhczY0dEQhBegpU18WM+wdhMfogCwGz2nm7jEOOZ1hivr8Bya0zB4jzxgjlg6Vls/fYaMqsc8D8sAx2oG+LLICW9RobfZF5f+kTfUjvF26+Xbk0JOQvRezqXJ7Hl67eNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWQzTmLFc6+nhM6jiZXvLH/RDyMse6t7caZ95zn42K0=;
 b=MSsVy0hU3oxcES59vwSmyWwCrtIfUoSgsQTLPzTLEPyhTCDL3p3TBlXt3NqlqDuUHVQdzPeRXF2DdrBclRQQuCL5hxQatwoF7pYys27B9Y//HhQ/svwpOfiAxQoSooKRiU7KkQzSuowK1sjk6ZxepfYZFjb9+/HoFVTJtkRoAB8=
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by MWHPR12MB1694.namprd12.prod.outlook.com (2603:10b6:301:11::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 26 Nov
 2021 14:32:33 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::3f) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 26 Nov 2021 14:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 14:32:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 08:32:32 -0600
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 08:32:31 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH v2] drm/amd/display: Add DP-HDMI FRL PCON Support in DC
Date: Fri, 26 Nov 2021 09:32:24 -0500
Message-ID: <20211126143224.134823-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 399b2bb1-48fc-4e63-2dfe-08d9b0e9956a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1694:
X-Microsoft-Antispam-PRVS: <MWHPR12MB169484755E77AB1631F3553AE5639@MWHPR12MB1694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jr1ClXc/b+OtR4QLOcoSuJhjsyrQWCMyjPoeBtr48dPdLjJwT7NLvx1s7AxIKG18OrdU09Z3awVpWNmt1zz80dz+h5NzlWfzv4iLSzhdv4uMOc1NNcw4ASRU7X+T3KJajY35nwQZD/cI5/8psjHCzIiXJDl/3hT7rxFwwhfJNgkDA9Jklt/ei49eck+lViG6YFWDlmIP+eF/25afPcQBMj7MeJLOp89RXJNFLK4vafQIRHaEUhKEU93qN80S529K17kH8c9QPq44kJmep9dKLmz4fXgJAztboWH5RtfhvwazoSrVGPG77ObIsyfdXN33gYAzOOnuQFUZpABDg+a1WslNYlYcsemr/n1+FCDNOUFUWDMKQQMhWtjRX2kwTv4xAB0opgwqgEgArwNMh2yVh/exuyStB4ICpkdzifzeDWTMIzO8nDD0sOJoHe0ed+m33hWUydCcC6rcQBmAhU+1AsAVtW67bnX1oPJzEzYhCghxfsZ4qitUUczOQzgEmBUIc6qAjQuaehEDVx5siyyzGbvdIjBFzqswjW3+HjHqUhQ4ySLHPZfWy5959NQ3Wj4drER/arvg+67bqO15OBJDolYMFkNKttyyfdQ89/cQuO36sWOkKdOLYDCNH35MsfXG3/VQeACUkjV4LpzG9+0cmW2m5UXuY4YyjuM8UZfUcCMAoueRrQFHa7VVB556hqFT6XXZMv+xOnLK7DH87nswodquvyWuQqeNXxjw4dFxL88=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(5660300002)(2906002)(36860700001)(47076005)(6636002)(6666004)(4326008)(426003)(54906003)(70586007)(508600001)(7696005)(70206006)(8936002)(8676002)(2616005)(186003)(336012)(1076003)(82310400004)(36756003)(81166007)(26005)(316002)(30864003)(86362001)(356005)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 14:32:32.9828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 399b2bb1-48fc-4e63-2dfe-08d9b0e9956a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1694
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
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>, wayne.lin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change since v1: add brief description
1. Add hdmi frl pcon support to existing asic family.
2. Determine pcon frl capability based on pcon dpcd.
3. pcon frl is taken into consideration into mode validation.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 15 ++++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 71 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 ++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 31 ++++++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  3 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  2 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 +
 11 files changed, 135 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3d08f8eba402..dad7a4fdc427 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2750,8 +2750,23 @@ static bool dp_active_dongle_validate_timing(
 		return false;
 	}
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps > 0) { // DP to HDMI FRL converter
+		struct dc_crtc_timing outputTiming = *timing;
+
+		if (timing->flags.DSC && !timing->dsc_cfg.is_frl)
+			/* DP input has DSC, HDMI FRL output doesn't have DSC, remove DSC from output timing */
+			outputTiming.flags.DSC = 0;
+		if (dc_bandwidth_in_kbps_from_timing(&outputTiming) > dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps)
+			return false;
+	} else { // DP to HDMI TMDS converter
+		if (get_timing_pixel_clock_100hz(timing) > (dongle_caps->dp_hdmi_max_pixel_clk_in_khz * 10))
+			return false;
+	}
+#else
 	if (get_timing_pixel_clock_100hz(timing) > (dongle_caps->dp_hdmi_max_pixel_clk_in_khz * 10))
 		return false;
+#endif
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 84f3545c3032..da1532356c07 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4313,6 +4313,56 @@ static int translate_dpcd_max_bpc(enum dpcd_downstream_port_max_bpc bpc)
 	return -1;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw)
+{
+	switch (bw) {
+	case 0b001:
+		return 9000000;
+	case 0b010:
+		return 18000000;
+	case 0b011:
+		return 24000000;
+	case 0b100:
+		return 32000000;
+	case 0b101:
+		return 40000000;
+	case 0b110:
+		return 48000000;
+	}
+
+	return 0;
+}
+
+/**
+ * Return PCON's post FRL link training supported BW if its non-zero, otherwise return max_supported_frl_bw.
+ */
+static uint32_t intersect_frl_link_bw_support(
+	const uint32_t max_supported_frl_bw_in_kbps,
+	const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
+{
+	uint32_t supported_bw_in_kbps = max_supported_frl_bw_in_kbps;
+
+	// HDMI_ENCODED_LINK_BW bits are only valid if HDMI Link Configuration bit is 1 (FRL mode)
+	if (hdmi_encoded_link_bw.bits.FRL_MODE) {
+		if (hdmi_encoded_link_bw.bits.BW_48Gbps)
+			supported_bw_in_kbps = 48000000;
+		else if (hdmi_encoded_link_bw.bits.BW_40Gbps)
+			supported_bw_in_kbps = 40000000;
+		else if (hdmi_encoded_link_bw.bits.BW_32Gbps)
+			supported_bw_in_kbps = 32000000;
+		else if (hdmi_encoded_link_bw.bits.BW_24Gbps)
+			supported_bw_in_kbps = 24000000;
+		else if (hdmi_encoded_link_bw.bits.BW_18Gbps)
+			supported_bw_in_kbps = 18000000;
+		else if (hdmi_encoded_link_bw.bits.BW_9Gbps)
+			supported_bw_in_kbps = 9000000;
+	}
+
+	return supported_bw_in_kbps;
+}
+#endif
+
 static void read_dp_device_vendor_id(struct dc_link *link)
 {
 	struct dp_device_vendor_id dp_id;
@@ -4424,6 +4474,27 @@ static void get_active_converter_info(
 						translate_dpcd_max_bpc(
 							hdmi_color_caps.bits.MAX_BITS_PER_COLOR_COMPONENT);
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+					if (link->dc->caps.hdmi_frl_pcon_support) {
+						link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps =
+								dc_link_bw_kbps_from_raw_frl_link_rate_data(
+										hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);
+
+						union hdmi_encoded_link_bw hdmi_encoded_link_bw;
+
+						// Intersect reported max link bw support with the supported link rate post FRL link training
+						if (core_link_read_dpcd(link, DP_PCON_HDMI_POST_FRL_STATUS,
+								&hdmi_encoded_link_bw.raw, sizeof(hdmi_encoded_link_bw)) == DC_OK) {
+							link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps = intersect_frl_link_bw_support(
+									link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps,
+									hdmi_encoded_link_bw);
+						}
+
+						if (link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps > 0)
+							link->dpcd_caps.dongle_caps.extendedCapValid = true;
+					}
+#endif
+
 					if (link->dpcd_caps.dongle_caps.dp_hdmi_max_pixel_clk_in_khz != 0)
 						link->dpcd_caps.dongle_caps.extendedCapValid = true;
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c14e7db3f69d..2d001de42117 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -187,6 +187,7 @@ struct dc_caps {
 	struct dc_color_caps color;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool dp_hpo;
+	bool hdmi_frl_pcon_support;
 #endif
 	bool edp_dsc_support;
 	bool vbios_lttpr_aware;
@@ -1294,6 +1295,11 @@ struct dc_sink_dsc_caps {
 	// 'true' if these are virtual DPCD's DSC caps (immediately upstream of sink in MST topology),
 	// 'false' if they are sink's DSC caps
 	bool is_virtual_dpcd_dsc;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	// 'true' if MST topology supports DSC passthrough for sink
+	// 'false' if MST topology does not support DSC passthrough
+	bool is_dsc_passthrough_supported;
+#endif
 	struct dsc_dec_dpcd_caps dsc_dec_caps;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index e68e9a86a4d9..99d26fb31566 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -378,7 +378,14 @@ enum dpcd_downstream_port_detailed_type {
 union dwnstream_port_caps_byte2 {
 	struct {
 		uint8_t MAX_BITS_PER_COLOR_COMPONENT:2;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		uint8_t MAX_ENCODED_LINK_BW_SUPPORT:3;
+		uint8_t SOURCE_CONTROL_MODE_SUPPORT:1;
+		uint8_t CONCURRENT_LINK_BRING_UP_SEQ_SUPPORT:1;
+		uint8_t RESERVED:1;
+#else
 		uint8_t RESERVED:6;
+#endif
 	} bits;
 	uint8_t raw;
 };
@@ -416,6 +423,30 @@ union dwnstream_port_caps_byte3_hdmi {
 	uint8_t raw;
 };
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+union hdmi_sink_encoded_link_bw_support {
+	struct {
+		uint8_t HDMI_SINK_ENCODED_LINK_BW_SUPPORT:3;
+		uint8_t RESERVED:5;
+	} bits;
+	uint8_t raw;
+};
+
+union hdmi_encoded_link_bw {
+	struct {
+		uint8_t FRL_MODE:1; // Bit 0
+		uint8_t BW_9Gbps:1;
+		uint8_t BW_18Gbps:1;
+		uint8_t BW_24Gbps:1;
+		uint8_t BW_32Gbps:1;
+		uint8_t BW_40Gbps:1;
+		uint8_t BW_48Gbps:1;
+		uint8_t RESERVED:1; // Bit 7
+	} bits;
+	uint8_t raw;
+};
+#endif
+
 /*4-byte structure for detailed capabilities of a down-stream port
 (DP-to-TMDS converter).*/
 union dwnstream_portxcaps {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 52355fe6994c..eac34f591a3f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -741,6 +741,9 @@ struct dc_dsc_config {
 	uint32_t version_minor; /* DSC minor version. Full version is formed as 1.version_minor. */
 	bool ycbcr422_simple; /* Tell DSC engine to convert YCbCr 4:2:2 to 'YCbCr 4:2:2 simple'. */
 	int32_t rc_buffer_size; /* DSC RC buffer block size in bytes */
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	bool is_frl; /* indicate if DSC is applied based on HDMI FRL sink's capability */
+#endif
 	bool is_dp; /* indicate if DSC is applied based on DP's capability */
 };
 struct dc_crtc_timing {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index d449e72a4e2a..d5887d976ef6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -443,6 +443,7 @@ bool dc_link_is_fec_supported(const struct dc_link *link);
 bool dc_link_should_enable_fec(const struct dc_link *link);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw);
 enum dp_link_encoding dc_link_dp_mst_decide_link_encoding_format(const struct dc_link *link);
 #endif
 #endif /* DC_LINK_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 388457ffc0a8..cb26ff8a54c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -430,6 +430,7 @@ struct dc_dongle_caps {
 	uint32_t dp_hdmi_max_bpc;
 	uint32_t dp_hdmi_max_pixel_clk_in_khz;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+	uint32_t dp_hdmi_frl_max_link_bw_in_kbps;
 	struct dc_dongle_dfp_cap_ext dfp_cap_ext;
 #endif
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 3883f918b3bb..40b122a708ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3796,6 +3796,8 @@ static bool dcn20_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.hdmi_frl_pcon_support = true;
+
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV) {
 		dc->debug = debug_defaults_drv;
 	} else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index d452a0d1777e..da6031cef244 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -2028,6 +2028,8 @@ static bool dcn21_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.hdmi_frl_pcon_support = true;
+
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
 	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 79a66e0c4303..77331a45a749 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2639,6 +2639,8 @@ static bool dcn30_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->caps.hdmi_frl_pcon_support = true;
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 6460fab496f6..673e080e1982 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2193,6 +2193,7 @@ static bool dcn31_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
+	dc->caps.hdmi_frl_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
-- 
2.25.1

