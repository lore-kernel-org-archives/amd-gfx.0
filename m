Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E38C282D9
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D9610E6D9;
	Wed,  5 Mar 2025 05:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ADWvb/AY";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1941D10E6D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPhtAQnVp4xP7rcuDhWhQzCtBpxrTzZe6TQ576FPyFMOnVBOCVf1aTn2YmVv2f3HmN40OKjFB41BmKIKYxrN0rHZUiKMyqZpqQdY8r8F9LNLdSU9nD0xOVH5Z6ytdVQX4xG700e4TuKNL9yWlOYAQJZuf6Ttelcdwmbf/qW5309qpyz/vokRHUAv5vl6WFFjfgS+UGz6uLNbrzEcpc/t6WgDLW4Ws7+w9fHBjAB7bN8WYInH3Q6lC5U08zgYST7WGubbx6aCIuFzZTVnnJdoAPU+4jPoCF7pfY3vIEGLXDr4UXZn03yT/Gjui39ztYdyypQEQo7fzGg3GJAqkL5/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr5yPtugPUzWXC3wvoNBgd+xCvWXu1LHBFHfVrIOio4=;
 b=rhyRzDqiaGf4pljg9slvMLaXOC6tWS+X19yAUawbDkhl+4B3JJzkxZYfmsNV2LUhAZU0kQchn81oS3QEjF6q0bJnPEsV/adVg9/e3bkMyl7fMCYvIuUD+fUGO8DJ5SpGGO0yO3r/rdUpEvp8QtgbqxcaFoOTODv2/pPnSZwxqtPm2rbdQYVA3+t6L6CGElxCtHdO+iP3qrvF93tSD7le/Yam//wrmSvWP/7t9y33pQEsDLL9K3y+kpun+/K+6clgYGiWQb2f8giAFkvWosy4aNLuiGp7YTRspmKg9DFFhM6vCTFw9tWttZyAsCy8N6gH6dcbhFmCXcBguoEZXO7jhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr5yPtugPUzWXC3wvoNBgd+xCvWXu1LHBFHfVrIOio4=;
 b=ADWvb/AYQPp3w/xc8trkZqYiWab5vaomyP/vKSJOQ91sTpJEoCpx7gGgMW8uZ+HWHQ099MzIGb28LqSkvlkN9vjsM53j7HcH/A9J0gmS2mGQYD7F6vEaBN1G6LKTCmNjyVhH1+rQTph/aYf7XanBsJpgK/UqrL+Br4oQMDgo4jo=
Received: from BN9PR03CA0420.namprd03.prod.outlook.com (2603:10b6:408:111::35)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:15:57 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::95) by BN9PR03CA0420.outlook.office365.com
 (2603:10b6:408:111::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:15:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:15:56 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:15:56 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:15:52 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, George Shen <george.shen@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 09/22] drm/amd/display: Implement PCON regulated autonomous
 mode handling
Date: Wed, 5 Mar 2025 13:13:49 +0800
Message-ID: <20250305051402.1550046-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: b1847757-aab3-4b91-8437-08dd5ba4cf9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D9XYzb//c56x8PtC7GVS2YtdhmiGCZ33QyJnp9VvBo+kKnXrsjVCw2D0LSTO?=
 =?us-ascii?Q?WoN2/N4DmP0K5QeOOrLBTlCfNBcG9hSc7bm0e+f2sErgncSYnUuB6Gellg50?=
 =?us-ascii?Q?Jyk0Qt7bkTjMkgjt4Hl1ho+mpDln7bPOI74qzmFKP3XRcSqTG1VIBnCvSqiW?=
 =?us-ascii?Q?Dcus35nQQlRxwpxpvsIeY9nhladmrefHbp1NzV7BM5JIEa+4DBCIhWeNQZXr?=
 =?us-ascii?Q?cA9jWuqkaEq0DxM13VDbONXDK7I1G0e0xqzn09UsCwf5WCouitGIPGgJUWXR?=
 =?us-ascii?Q?noOHauECItuuJ9jhhph7SWofh5K9lP/rwvMp6PG57cE8JyzkPFiT0z/BSAss?=
 =?us-ascii?Q?/4LLVxLeD0baIvf2xQXWndt99pfh/7VU5CdsTPhOPQq4+B3Wms2cDFKlFjTc?=
 =?us-ascii?Q?WJnnO54aOAKpnF2kYnaxvo6mgmZtwQvNXtck5FeOQsEraU9reWeRuI05ESTW?=
 =?us-ascii?Q?famGXscKQaVvECYBwwwQiWKYJ2kgWOGRZVs62Bno0WV2gQImTRBlaan4Yari?=
 =?us-ascii?Q?MvZ39zjXf0OCur3vXKLqfdcGgocP5S6yv0e5ob1VrQJB6eI68cVA4Kdk6UER?=
 =?us-ascii?Q?SwdAEByczBuirm08LJwZDVjI4PSKlZpVIKfadNTaC/dNOHXbqCn+9AlJNUXn?=
 =?us-ascii?Q?xTjpxiqvyk8H+oiv2SZvtzYlN76whQjdd8NdD8ZLm0xNxzFROq6hctQFLfCV?=
 =?us-ascii?Q?ykYpsafZXtPcMpJvq3un0ySg9yb8rNGqSgj+xVwd+WW8uFibxFsBvznYQuwO?=
 =?us-ascii?Q?SUV00DR+2Cu2ojaFUmPoM9hvZpD8o8v9Pns3TOmKlFDjCtUm7t1gqLexS56V?=
 =?us-ascii?Q?GfQWT41d5vTxbmCP/DZCkQmZa6b43umkLyHaDvQIvHBIHG3UTHFmdyzCqzbh?=
 =?us-ascii?Q?2UDU6HFyA1GvPoG8gLr+Q9Aj25gA3g4Xc0/zPoSFlN3odzc4nousY9Q1Wo+s?=
 =?us-ascii?Q?wxb1YZ83GqiMFI36+L7UZCetOlQLIkq93fuctT56z0Pg3CHxQZbSea2gfT6d?=
 =?us-ascii?Q?IeR980oNyogsZKa0sQxyGX1ahbFkrJ+SD3lUe2PHtqdslALTReX9jpJdyRAW?=
 =?us-ascii?Q?7C8Tfm1UHMu0NL7Ky1AtY8GXLkOWgPNfH0LkFuvqVWOvY38zuif03v+MET/t?=
 =?us-ascii?Q?61/m+cJG9SAHXZGPgJKmknaXmCfrH7P/NM/+jWQGOvnfcN1rboB+RXWRFxaw?=
 =?us-ascii?Q?+p6Jfh7tyY7W21OUoHgfq3b/wfrtqU+sMyCGi+wncmDM9mnLPUfndO4NpbWj?=
 =?us-ascii?Q?7xAOUJh7aXjsaRqoj+QhRZQJDG3wunaGW/gXYgv2eh9hEow9VTlVv8tox2y0?=
 =?us-ascii?Q?r9N6VE3tNig4WrrK8zuRvhszNReaH1K1bwdGeSAwjir93qMrj5PFhQR5P/mf?=
 =?us-ascii?Q?bEuJt4tMYnYVSww6hIlMFqGsBi9Ju2PFzrDWWgD64zZBGpLTd80Yl9hgBm+W?=
 =?us-ascii?Q?IEWmgcTXfzwRfId22xn5c9mVIGihCtD+EZcwCXxI/+kC8BkQSPxidQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:15:57.1940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1847757-aab3-4b91-8437-08dd5ba4cf9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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

[Why/How]
DP spec has been updated recently to make regulated autonomous mode more
well-defined. In case any PCON vendors choose to implement regulated
autonomous mode in the future, pre-emptively add handling for the
regulated autonomous mode based on current spec.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 27 ++++++++-
 .../dc/link/protocols/link_dp_capability.c    | 55 +++++++++++++++----
 2 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 1f4f11adc491..77c87ad57220 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -432,7 +432,28 @@ union hdmi_encoded_link_bw {
 		uint8_t BW_32Gbps:1;
 		uint8_t BW_40Gbps:1;
 		uint8_t BW_48Gbps:1;
-		uint8_t RESERVED:1; // Bit 7
+		uint8_t FRL_LINK_TRAINING_FINISHED:1; // Bit 7
+	} bits;
+	uint8_t raw;
+};
+
+union hdmi_tx_link_status {
+	struct {
+		uint8_t HDMI_TX_LINK_ACTIVE_STATUS:1;
+		uint8_t HDMI_TX_READY_STATUS:1;
+		uint8_t RESERVED:6;
+	} bits;
+	uint8_t raw;
+};
+
+union autonomous_mode_and_frl_link_status {
+	struct {
+		uint8_t FRL_LT_IN_PROGRESS_STATUS:1;
+		uint8_t FRL_LT_LINK_CONFIG_IN_PROGRESS:3;
+		uint8_t RESERVED:1;
+		uint8_t FALLBACK_POLICY:1;
+		uint8_t FALLBACK_POLICY_VALID:1;
+		uint8_t REGULATED_AUTONOMOUS_MODE_SUPPORTED:1;
 	} bits;
 	uint8_t raw;
 };
@@ -1166,6 +1187,7 @@ struct dc_dongle_caps {
 	uint32_t dp_hdmi_max_bpc;
 	uint32_t dp_hdmi_max_pixel_clk_in_khz;
 	uint32_t dp_hdmi_frl_max_link_bw_in_kbps;
+	uint32_t dp_hdmi_regulated_autonomous_mode_support;
 	struct dc_dongle_dfp_cap_ext dfp_cap_ext;
 };
 
@@ -1394,6 +1416,9 @@ struct dp_trace {
 #ifndef DP_LTTPR_ALPM_CAPABILITIES
 #define DP_LTTPR_ALPM_CAPABILITIES              0xF0009
 #endif
+#ifndef DP_REGULATED_AUTONOMOUS_MODE_SUPPORTED_AND_HDMI_LINK_TRAINING_STATUS
+#define DP_REGULATED_AUTONOMOUS_MODE_SUPPORTED_AND_HDMI_LINK_TRAINING_STATUS	0x303C
+#endif
 #ifndef DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE
 #define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE	0x50
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index a77410122636..21ee0d96c9d4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -265,6 +265,8 @@ static uint32_t intersect_frl_link_bw_support(
 		supported_bw_in_kbps = 18000000;
 	else if (hdmi_encoded_link_bw.bits.BW_9Gbps)
 		supported_bw_in_kbps = 9000000;
+	else if (hdmi_encoded_link_bw.bits.FRL_LINK_TRAINING_FINISHED)
+		supported_bw_in_kbps = 0; /* This case should only get hit in regulated autonomous mode. */
 
 	return supported_bw_in_kbps;
 }
@@ -1075,6 +1077,48 @@ static enum dc_status wake_up_aux_channel(struct dc_link *link)
 	return DC_OK;
 }
 
+static void read_and_intersect_post_frl_lt_status(
+	struct dc_link *link)
+{
+	union autonomous_mode_and_frl_link_status autonomous_mode_caps = {0};
+	union hdmi_tx_link_status hdmi_tx_link_status = {0};
+	union hdmi_encoded_link_bw hdmi_encoded_link_bw = {0};
+
+	/* Check if dongle supports regulated autonomous mode. */
+	core_link_read_dpcd(link, DP_REGULATED_AUTONOMOUS_MODE_SUPPORTED_AND_HDMI_LINK_TRAINING_STATUS,
+		&autonomous_mode_caps.raw, sizeof(autonomous_mode_caps));
+
+	link->dpcd_caps.dongle_caps.dp_hdmi_regulated_autonomous_mode_support =
+			autonomous_mode_caps.bits.REGULATED_AUTONOMOUS_MODE_SUPPORTED;
+
+	if (link->dpcd_caps.dongle_caps.dp_hdmi_regulated_autonomous_mode_support) {
+		DC_LOG_DC("%s: PCON supports regulated autonomous mode.\n", __func__);
+
+		core_link_read_dpcd(link, DP_PCON_HDMI_TX_LINK_STATUS,
+				&hdmi_tx_link_status.raw, sizeof(hdmi_tx_link_status));
+	}
+
+	// Intersect reported max link bw support with the supported link rate post FRL link training
+	if (core_link_read_dpcd(link, DP_PCON_HDMI_POST_FRL_STATUS,
+			&hdmi_encoded_link_bw.raw, sizeof(hdmi_encoded_link_bw)) == DC_OK) {
+
+		if (link->dpcd_caps.dongle_caps.dp_hdmi_regulated_autonomous_mode_support &&
+				(!hdmi_tx_link_status.bits.HDMI_TX_READY_STATUS ||
+						!hdmi_encoded_link_bw.bits.FRL_LINK_TRAINING_FINISHED)) {
+			DC_LOG_WARNING("%s: PCON TX link training has not finished.\n", __func__);
+
+			/* Link training not finished, ignore values from this DPCD reg. */
+			return;
+		}
+
+		link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps = intersect_frl_link_bw_support(
+				link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps,
+				hdmi_encoded_link_bw);
+		DC_LOG_DC("%s: pcon frl link bw = %u\n", __func__,
+			link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps);
+	}
+}
+
 static void get_active_converter_info(
 	uint8_t data, struct dc_link *link)
 {
@@ -1163,21 +1207,12 @@ static void get_active_converter_info(
 							hdmi_color_caps.bits.MAX_BITS_PER_COLOR_COMPONENT);
 
 					if (link->dc->caps.dp_hdmi21_pcon_support) {
-						union hdmi_encoded_link_bw hdmi_encoded_link_bw;
 
 						link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps =
 								link_bw_kbps_from_raw_frl_link_rate_data(
 										hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);
 
-						// Intersect reported max link bw support with the supported link rate post FRL link training
-						if (core_link_read_dpcd(link, DP_PCON_HDMI_POST_FRL_STATUS,
-								&hdmi_encoded_link_bw.raw, sizeof(hdmi_encoded_link_bw)) == DC_OK) {
-							link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps = intersect_frl_link_bw_support(
-									link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps,
-									hdmi_encoded_link_bw);
-							DC_LOG_DC("%s: pcon frl link bw = %u\n", __func__,
-								link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps);
-						}
+						read_and_intersect_post_frl_lt_status(link);
 
 						if (link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps > 0)
 							link->dpcd_caps.dongle_caps.extendedCapValid = true;
-- 
2.34.1

