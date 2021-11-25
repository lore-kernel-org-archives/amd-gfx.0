Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586EFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 21:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD586E4D4;
	Thu, 25 Nov 2021 21:22:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B9C6E4D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 21:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF4i78KZuc/J9qy5ZDbVwC1YbOXB/Of1nPALFwNSPO0kbNHaCHstBO8soQUaeyPHxoM+4sTmL+jUGg8q6dkbI0CLG3/yZ2QtSKuA+Z2V1hGjaGf/Ri7nj7JPjrk5v9hw8Gso5siJsr4+pNCZm5D0AzF5dMVJ9NZ9+M11qwQPjVUHM8wvO518CB2qTzxwtbQ7n7kfbSdowaGpvYxYrLWXmY3AdfI3Et94+Ak4di+5jlyZg4ABOJ9txc9EFxRST7/Mqo77owJRjcutv2c/xcyssBNfh8x69zHD5Der995oY/NKZv3DiKMiuRZLguJG9J9R4JZMZ6FfDmTgRh8+cc8b/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV+RRoM3wsv3LZFHhvanu1XRCNFdGwU/b0sXYswqqbU=;
 b=mLbsWH1JUHmxG5Cfr02IUd8u1W/14ROiWH0x21CrWpWNIhTFzAZve3X3ILCk0lGr3FHvHYll4CPh9KKccS5YLpb4XOMrVdbqynSjHsAxphAdO1oHyz+NRPHdjA9jeeOyhkumbCG45qEGFQLKLcNk7A1y4VvSlYpXUwkX9JtsutzdpflG5zQ+akUhKeWF8rLfB+iIDIXPDe9CIq/RdfyMkdyv2FTNahrWmdddtDrh+W8HWDY2o2ONpPZwsUoK9DRE5P/fLUFwqzR6tafdZzS9RtpOHLOJqc61+ZrGf6R+dpnskH5U6u6/E8GdKmdyWhnghSYcYTSXviHu16R0nAbkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV+RRoM3wsv3LZFHhvanu1XRCNFdGwU/b0sXYswqqbU=;
 b=BG8lsVfeqwRRN0mYHR/mP3UUeUQ4hKAH/rak9qNKWcVcrDpNmDlpGTJsUFS7JDlNv7B0PZHrsMNFNEohKzmmq8AnF5obJycqhOC3qJTl04G6JLxcn6O3H43Hrqs3mC5WjolcqUsRIAN5JZmK6FGj0GzOilUeCKVf4pAf8ZFvG58=
Received: from DM5PR06CA0043.namprd06.prod.outlook.com (2603:10b6:3:5d::29) by
 DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Thu, 25 Nov 2021 21:22:52 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::e5) by DM5PR06CA0043.outlook.office365.com
 (2603:10b6:3:5d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 25 Nov 2021 21:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 21:22:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 15:22:50 -0600
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 15:22:49 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH v1] drm/amd/display: Add DP-HDMI PCON Support in DC
Date: Thu, 25 Nov 2021 16:22:41 -0500
Message-ID: <20211125212241.131221-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39cdaf70-4a67-443f-fc2a-08d9b059bce4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2603:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26035A3A60C8A6728DF92398E5629@DM6PR12MB2603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6A4wW9nSGC/e+9lQNXMrq8Z9LqLyWZ5xrzBVLIePd0YVRrRrJDiGAF0b0wDWtTDZ47ayQ0UuvTquiZLppYL06avdM578cBkJGycnK+hvfv9225jkwfDEu8u49fARJCR5bf9BJjkU7DJw9VTA26a3CKAkpTQgfPP7DBuGA67qC3kF5Ubu9+97Wf19CN0x5EZll9CWIBEeNLyEIFEo+SlHop3QjGRV87FIkG+/r8ztNn91OZvc8Mougm/cMv9IFAgr9np2qNErZoHAt12gaBGq8zkv1kGzdbB2n6Svt6g5PFZ/qu0Q03HqTxb/6byzIBW0xekkOmJq6WCKJyH/3rd5M4iJ4J/XlqwZLSz6haTar5AsiFiU8lI1YYeL4KD/KmAlZiKzZ++qRmQYqPoQ8EV6BwCvLlJlNITwhfF2RdTZhpH4TDU2Q8UANlqCAxUKqFSvUygO829cZez7C7HeBxxMMP2bQ145D2Pv8DnkC3UI/XHjG7tLF6U5H3NLyRLKwoWT0DMoTsARCd4lzHG2ulaGrc5FHTh+Mvv2s1x4fTj+5ABNnip7skpWFJu242bY0jdOmFluIrTaRhi13plq599DrA+DqDh4aPYNAl5cucO0f/FxDzaREllliU0fIGj4wER6Kg2dlM5667NvFnlG0PkmIXWzaEvpWjkLNa/MROrPuq0E+jmsuNRiQU1LE9iSwcPWbYRRyYbHR+kLYRltdscS7GbeApFWJTH9HQ+VEaIqGU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(6666004)(54906003)(508600001)(336012)(2906002)(6636002)(36860700001)(70586007)(426003)(8936002)(7696005)(2616005)(186003)(70206006)(356005)(5660300002)(8676002)(30864003)(26005)(83380400001)(4326008)(47076005)(36756003)(1076003)(110136005)(86362001)(82310400004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 21:22:51.6467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cdaf70-4a67-443f-fc2a-08d9b059bce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
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

