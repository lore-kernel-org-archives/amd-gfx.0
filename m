Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD83C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 21:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2F22054F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 21:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M1lFLNdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2F22054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C786E99B;
	Wed,  1 Apr 2020 21:00:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334D46E99B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 21:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRaPFVn32wmq7GvswxpFZlINSfZEJ3zhBj0ss5MWP/qEwqonCHI3gF58uoCS65bfbYRcQqgtUWMulbGjPbFxsLxeE6vd+3w3dD3gyOR2lsUJI0+RrV7oHecG0Gubb1E1ZXj4sf4PD/npbiCFkeNELb4LmvcR27k8I6xlBSe/9XcYhTfc76VLqtLxLvnsv5rY8DF4/lSjDAnOIjQF76DkKHFCujpx/ycKmiGkm8gAT4VzqHFV2UpdwzH/fa0qBQqGv3oTJxbG82eGF446SXwUS1ZeHIw0n31vchiE2qb8VQ6qoCRAkz5E0IE9c45wuzwySmQOPuSPRa3llPDIYqytuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfItDAIwU9oXTGKeScv+wtjmlc3bSbUK5jOsjh+q7mg=;
 b=SJg6GoiDQSNX23uHdYsAF5SsELC0vKYvZ6AGKGOidFCjTxcI6nq1s3x5ZnRGPrPrVVzRvZswFGg/3nA7AROLhnKy6liW7Rg1v2n3CKpONd3v4g2Da/jFbhB8o/TQ6EFbhK3fEEZ067M+JQ2Heu5RXQwrCeogdyM4SQ03WlAxG3OpEFSIw/JjD8lCdbqeGexaV4penbsZJLJH3cIWn1ryKDFGyDw6dP880r2c/Td5llTymYa1OlcJtUVxgiu9uYMaDBaQjWWlnSgZJ5YVo6gsmBEtyGidV89M9pF4nYyNEyJ95ijbvtpaz1HFxNkQjS/V/0xngTDOzJE69Gp3ZOllXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfItDAIwU9oXTGKeScv+wtjmlc3bSbUK5jOsjh+q7mg=;
 b=M1lFLNdGMzbRyUdoqHxWR7kknzsLyyHwbrf7YiTu3Pr98DfcjCc9w1MGOHT6UnfhCOZlb3sUx5PBnd2Oi4bTJ9rkTaKCOalbQrO1PLft59TjC0ItgK5I0laMy43fprQBC8VUgwSL3fSJpNe56+SnKCA5M4Nt3wv/O2/wjylkoxo=
Received: from BN6PR03CA0103.namprd03.prod.outlook.com (2603:10b6:404:10::17)
 by MN2PR12MB3327.namprd12.prod.outlook.com (2603:10b6:208:cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 21:00:39 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10:cafe::6b) by BN6PR03CA0103.outlook.office365.com
 (2603:10b6:404:10::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 21:00:39 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 21:00:39 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 16:00:38 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Apr 2020 16:00:38 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: query hdcp capability during link detect
Date: Wed, 1 Apr 2020 17:00:30 -0400
Message-ID: <20200401210031.23220-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(428003)(46966005)(54906003)(26005)(8936002)(1076003)(81166006)(2906002)(5660300002)(6666004)(6916009)(186003)(81156014)(47076004)(426003)(8676002)(36756003)(356004)(82740400003)(2616005)(478600001)(86362001)(4326008)(316002)(336012)(7696005)(70206006)(70586007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02543c2f-ddf5-49eb-068f-08d7d67fbb89
X-MS-TrafficTypeDiagnostic: MN2PR12MB3327:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33279440004485FE46441B52F9C90@MN2PR12MB3327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03607C04F0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBtQbTBjhrIUNl7Ual+F0s9rotP/vN4LmJi2UN342TLXYywM9w7ytkCizO2/5R+VexuLH9qkRYZHjq2Dr3ysB6hVD6PG+/CbmHk6dkTyt9cHBYlycHVreYq6hzhH/e+1l9s9KtuiiU6yf7HwtQlYatb5judU16CATJ4By1KJr+DCNfxWsOpx0+WVyvyU/UpKg24iCwrTmVwbxnc7AVsALpqbgx4TFubP+mDOMwpw5RBo2pbWsAsbiiYRdTLGS4PVj7Y6T0ls9E1DDO7bsOKDS0+8Xu8CZotol+2V2BADmd5ZdAzJYAmF4RKLzACsk4t5WtdE1qUKKmaktB166zVKDoB/hNAGN9rzZBqBTrlD+XCxLBHi2of+0B/9LI4gprzFlaTCGHl4vUXI4oyINGbwLJBP8suvz8Yt47krwnpSfCY7aND+hAfrMZ4pjF5RLTDIIlh3u3U6vJwkW4FHjrbNnX1zyw6zHcqxNaRoRISB3A/qCUxCouSeLA7e/YASLB06x0QQyF/EDEQ5VfeJLcGhKQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 21:00:39.1284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02543c2f-ddf5-49eb-068f-08d7d67fbb89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3327
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Query the hdcp caps of a link, it is useful and can be reported to the user

[How]
Create a query function and call it during link detect

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 56 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 41 +++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    | 89 +++++++++++++++++++
 .../gpu/drm/amd/display/include/hdcp_types.h  |  7 ++
 5 files changed, 196 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a93997ff0419..49c63e27dfe9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -514,6 +514,50 @@ static void link_disconnect_remap(struct dc_sink *prev_sink, struct dc_link *lin
 	link->local_sink = prev_sink;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_HDCP)
+static void query_hdcp_capability(enum signal_type signal, struct dc_link *link)
+{
+	struct hdcp_protection_message msg22;
+	struct hdcp_protection_message msg14;
+
+	memset(&msg22, 0, sizeof(struct hdcp_protection_message));
+	memset(&msg14, 0, sizeof(struct hdcp_protection_message));
+	memset(link->hdcp_caps.rx_caps.raw, 0,
+		sizeof(link->hdcp_caps.rx_caps.raw));
+
+	if ((link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
+			link->ddc->transaction_type ==
+			DDC_TRANSACTION_TYPE_I2C_OVER_AUX) ||
+			link->connector_signal == SIGNAL_TYPE_EDP) {
+		msg22.data = link->hdcp_caps.rx_caps.raw;
+		msg22.length = sizeof(link->hdcp_caps.rx_caps.raw);
+		msg22.msg_id = HDCP_MESSAGE_ID_RX_CAPS;
+	} else {
+		msg22.data = &link->hdcp_caps.rx_caps.fields.version;
+		msg22.length = sizeof(link->hdcp_caps.rx_caps.fields.version);
+		msg22.msg_id = HDCP_MESSAGE_ID_HDCP2VERSION;
+	}
+	msg22.version = HDCP_VERSION_22;
+	msg22.link = HDCP_LINK_PRIMARY;
+	msg22.max_retries = 5;
+	dc_process_hdcp_msg(signal, link, &msg22);
+
+	if (signal == SIGNAL_TYPE_DISPLAY_PORT || signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+		enum hdcp_message_status status = HDCP_MESSAGE_UNSUPPORTED;
+
+		msg14.data = &link->hdcp_caps.bcaps.raw;
+		msg14.length = sizeof(link->hdcp_caps.bcaps.raw);
+		msg14.msg_id = HDCP_MESSAGE_ID_READ_BCAPS;
+		msg14.version = HDCP_VERSION_14;
+		msg14.link = HDCP_LINK_PRIMARY;
+		msg14.max_retries = 5;
+
+		status = dc_process_hdcp_msg(signal, link, &msg14);
+	}
+
+}
+#endif
+
 static void read_current_link_settings_on_detect(struct dc_link *link)
 {
 	union lane_count_set lane_count_set = { {0} };
@@ -606,6 +650,12 @@ static bool detect_dp(struct dc_link *link,
 			dal_ddc_service_set_transaction_type(link->ddc,
 							     sink_caps->transaction_type);
 
+#if defined(CONFIG_DRM_AMD_DC_HDCP)
+			/* In case of fallback to SST when topology discovery below fails
+			 * HDCP caps will be querried again later by the upper layer (caller
+			 * of this function). */
+			query_hdcp_capability(SIGNAL_TYPE_DISPLAY_PORT_MST, link);
+#endif
 			/*
 			 * This call will initiate MST topology discovery. Which
 			 * will detect MST ports and add new DRM connector DRM
@@ -975,6 +1025,9 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			 * TODO debug why Dell 2413 doesn't like
 			 *  two link trainings
 			 */
+#if defined(CONFIG_DRM_AMD_DC_HDCP)
+			query_hdcp_capability(sink->sink_signal, link);
+#endif
 
 			// verify link cap for SST non-seamless boot
 			if (!perform_dp_seamless_boot)
@@ -988,6 +1041,9 @@ static bool dc_link_detect_helper(struct dc_link *link,
 				sink = prev_sink;
 				prev_sink = NULL;
 			}
+#if defined(CONFIG_DRM_AMD_DC_HDCP)
+			query_hdcp_capability(sink->sink_signal, link);
+#endif
 		}
 
 		/* HDMI-DVI Dongle */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 92123b0d1196..9235d04c32dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -29,6 +29,9 @@
 #include "dc_types.h"
 #include "grph_object_defs.h"
 #include "logger_types.h"
+#if defined(CONFIG_DRM_AMD_DC_HDCP)
+#include "hdcp_types.h"
+#endif
 #include "gpio_types.h"
 #include "link_service_types.h"
 #include "grph_object_ctrl_defs.h"
@@ -1004,6 +1007,35 @@ union dpcd_sink_ext_caps {
 	uint8_t raw;
 };
 
+#if defined(CONFIG_DRM_AMD_DC_HDCP)
+union hdcp_rx_caps {
+	struct {
+		uint8_t version;
+		uint8_t reserved;
+		struct {
+			uint8_t repeater	: 1;
+			uint8_t hdcp_capable	: 1;
+			uint8_t reserved	: 6;
+		} byte0;
+	} fields;
+	uint8_t raw[3];
+};
+
+union hdcp_bcaps {
+	struct {
+		uint8_t HDCP_CAPABLE:1;
+		uint8_t REPEATER:1;
+		uint8_t RESERVED:6;
+	} bits;
+	uint8_t raw;
+};
+
+struct hdcp_caps {
+	union hdcp_rx_caps rx_caps;
+	union hdcp_bcaps bcaps;
+};
+#endif
+
 #include "dc_link.h"
 
 /*******************************************************************************
@@ -1107,6 +1139,15 @@ void dc_resume(struct dc *dc);
 unsigned int dc_get_current_backlight_pwm(struct dc *dc);
 unsigned int dc_get_target_backlight_pwm(struct dc *dc);
 
+#if defined(CONFIG_DRM_AMD_DC_HDCP)
+/*
+ * HDCP Interfaces
+ */
+enum hdcp_message_status dc_process_hdcp_msg(
+		enum signal_type signal,
+		struct dc_link *link,
+		struct hdcp_protection_message *message_info);
+#endif
 bool dc_is_dmcu_initialized(struct dc *dc);
 
 enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type, uint32_t clk_khz, uint32_t stepping);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 00ff5e98278c..0077f9dcd07c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -126,6 +126,9 @@ struct dc_link {
 	uint32_t dongle_max_pix_clk;
 	unsigned short chip_caps;
 	unsigned int dpcd_sink_count;
+#if defined(CONFIG_DRM_AMD_DC_HDCP)
+	struct hdcp_caps hdcp_caps;
+#endif
 	enum edp_revision edp_revision;
 	bool psr_feature_enabled;
 	bool psr_allow_active;
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 6f730b5bfe42..5e384a8a83dc 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -322,3 +322,92 @@ static const struct protection_properties dp_11_protection = {
 	.process_transaction = dp_11_process_transaction
 };
 
+static const struct protection_properties *get_protection_properties_by_signal(
+	struct dc_link *link,
+	enum signal_type st,
+	enum hdcp_version version)
+{
+	switch (version) {
+	case HDCP_VERSION_14:
+		switch (st) {
+		case SIGNAL_TYPE_DVI_SINGLE_LINK:
+		case SIGNAL_TYPE_DVI_DUAL_LINK:
+		case SIGNAL_TYPE_HDMI_TYPE_A:
+			return &hdmi_14_protection;
+		case SIGNAL_TYPE_DISPLAY_PORT:
+			if (link &&
+				(link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_VGA_CONVERTER ||
+				link->dpcd_caps.dongle_caps.dongle_type == DISPLAY_DONGLE_DP_VGA_CONVERTER)) {
+				return &non_supported_protection;
+			}
+			return &dp_11_protection;
+		case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		case SIGNAL_TYPE_EDP:
+			return &dp_11_protection;
+		default:
+			return &non_supported_protection;
+		}
+		break;
+	case HDCP_VERSION_22:
+		switch (st) {
+		case SIGNAL_TYPE_DVI_SINGLE_LINK:
+		case SIGNAL_TYPE_DVI_DUAL_LINK:
+		case SIGNAL_TYPE_HDMI_TYPE_A:
+			return &hdmi_14_protection; //todo version2.2
+		case SIGNAL_TYPE_DISPLAY_PORT:
+		case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		case SIGNAL_TYPE_EDP:
+			return &dp_11_protection;  //todo version2.2
+		default:
+			return &non_supported_protection;
+		}
+		break;
+	default:
+		return &non_supported_protection;
+	}
+}
+
+enum hdcp_message_status dc_process_hdcp_msg(
+	enum signal_type signal,
+	struct dc_link *link,
+	struct hdcp_protection_message *message_info)
+{
+	enum hdcp_message_status status = HDCP_MESSAGE_FAILURE;
+	uint32_t i = 0;
+
+	const struct protection_properties *protection_props;
+
+	if (!message_info)
+		return HDCP_MESSAGE_UNSUPPORTED;
+
+	if (message_info->msg_id < HDCP_MESSAGE_ID_READ_BKSV ||
+		message_info->msg_id >= HDCP_MESSAGE_ID_MAX)
+		return HDCP_MESSAGE_UNSUPPORTED;
+
+	protection_props =
+		get_protection_properties_by_signal(
+			link,
+			signal,
+			message_info->version);
+
+	if (!protection_props->supported)
+		return HDCP_MESSAGE_UNSUPPORTED;
+
+	if (protection_props->process_transaction(
+		link,
+		message_info)) {
+		status = HDCP_MESSAGE_SUCCESS;
+	} else {
+		for (i = 0; i < message_info->max_retries; i++) {
+			if (protection_props->process_transaction(
+						link,
+						message_info)) {
+				status = HDCP_MESSAGE_SUCCESS;
+				break;
+			}
+		}
+	}
+
+	return status;
+}
+
diff --git a/drivers/gpu/drm/amd/display/include/hdcp_types.h b/drivers/gpu/drm/amd/display/include/hdcp_types.h
index f31e6befc8d6..42229b4effdc 100644
--- a/drivers/gpu/drm/amd/display/include/hdcp_types.h
+++ b/drivers/gpu/drm/amd/display/include/hdcp_types.h
@@ -83,6 +83,12 @@ enum hdcp_link {
 	HDCP_LINK_SECONDARY
 };
 
+enum hdcp_message_status {
+	HDCP_MESSAGE_SUCCESS,
+	HDCP_MESSAGE_FAILURE,
+	HDCP_MESSAGE_UNSUPPORTED
+};
+
 struct hdcp_protection_message {
 	enum hdcp_version version;
 	/* relevant only for DVI */
@@ -91,6 +97,7 @@ struct hdcp_protection_message {
 	uint32_t length;
 	uint8_t max_retries;
 	uint8_t *data;
+	enum hdcp_message_status status;
 };
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
