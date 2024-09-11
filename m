Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F503EE57C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD44910EA4E;
	Wed, 11 Sep 2024 16:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pzTK2Wa3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688ED10EA4E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlUEf9uK3YwE8oreAcII/GRFd5q79QMrBRq8pQSb0H1gui6UFYv4QpiT6SdcbnVTeDt2bmk5UQloANUC+v2KhG11E7WFK1R6utP0+K2SKkubC9/XLyhGVstTebyxSdV9PELIV+o5+RfnspsLiqxu69mAx57QYu00QMlbl+MTQyXdLbevT5ahuP70hgyphroleQ82BXoD732+eINYlo5y7BKYSBErdCypHV99vp20hOCwzZBzzvkk/4SLOv2JvWN4Iz+NNV7Om+hgMNRm4C+WQLCj8mKku/LS4THKmjkP5L7++ywB+n36N149NbPZ5ClHbUiKp6vitSCzRkALCBsXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMoI2f85B8CqfVerMchRzaFEBpDfKwFyrRRj0IRHhXg=;
 b=x155tWBpFNnKbGCKD6H9cmlJYef2+y9dHzEn+VHnALlejuArr6+Ye8d7ltGUYVM7vh2ouLjn6QmhNtny9KDtwdhw9xwd6xElMZcANjJQd8pwHuDbLo0hpWtXIkHMZBcMbYp4eagVMsdnE/F/XV6rwm7hLrut/K45QHmcAyWZ7QTmgAoZI3j8/OpFusPgjHEyqxX5uDPpKXjmR3L0LqkfggVc6GLTy1ho0XcKQwBQJyGvIFJXM7Nbl7wM3lYiPWodIN76LhhIHyuiAjr+scLATA49zJsp3J55wOeigPC7Bg2WpkfmhAjtZ3VYQ0TtDeTu5RRTDhBLEvj9ztarp/eZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMoI2f85B8CqfVerMchRzaFEBpDfKwFyrRRj0IRHhXg=;
 b=pzTK2Wa34tG2n+WViQ186hceZx3XV0Qly3E7d7gBecbWI2kt/b9sakKHNS5tHxvF/OcLB4K27HsfIb18cFJzB+O3v8drYhxX4p36/sRtWqrMpQmm2cwFnoKNMvt0X1Ogfbd94IW3j00i/Q+zCPa+kIngxnGIqAbZWFZmgdpchM0=
Received: from MN2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:208:23b::33)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 16:22:19 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::6f) by MN2PR11CA0028.outlook.office365.com
 (2603:10b6:208:23b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:22:19 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:22:16 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ryan Seto <ryanseto@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 03/23] drm/amd/display: Implement new DPCD register handling
Date: Wed, 11 Sep 2024 10:20:45 -0600
Message-ID: <20240911162105.3567133-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1b6e08-4fef-49c7-4a11-08dcd27de87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OwuIvSYFHpkfwqflhnerABM0JjhXlByzOu+PhGe/JBrrWWmu686Unrw2Uylt?=
 =?us-ascii?Q?jSdYZd0a9N1ZsozxNsj2f3Sp/7e7HBTXXfcDrNnhWzwCj7orBXb2XTnf0+yd?=
 =?us-ascii?Q?Q3+Evn3348ZJ+kzj7Nsf0CiPRRi17DfeZ9+gCeGv7RhOfrGbeYtCw1LC4QZg?=
 =?us-ascii?Q?OYyhCaak3SCY2rhKs2WLF5DFw8SPi2ouQJEHvcXjHpLH7eWdMZU/Xmg34WPy?=
 =?us-ascii?Q?7NAAmhhOsO9mfYVNmAemBX/li9Mym2TzeEeNk4wb3mebZ6UNbcXilF0Mq+ql?=
 =?us-ascii?Q?uu55DqPR4mvQpEBEZ3qXohpcPD7t2kSCLjgkayCa1NoHwaHE7KGrFHzjTO2l?=
 =?us-ascii?Q?cUtSN/pFZvj+zGTZml3lzRQn/oxrPcH1sYEVZYH9z9tZmg7B0MM3WtuX+BiQ?=
 =?us-ascii?Q?JmAFbj/pN2H5OufEZt+DhH0nwtV8arTix37lXke1IYxrYQDiXC5z6DJKQ+Xf?=
 =?us-ascii?Q?os2jp3lzhLeVeBeioIVnQySlIftDa9iS/F+GxHFDxVljJb/UoluLVXQf5iys?=
 =?us-ascii?Q?Ky9DWsrbNT471/eeZdRCU4InuD5k6hTNLMMc1sVKFZX9lJBEbjp88s/IguXC?=
 =?us-ascii?Q?r0HlzGrJorumUJMoNcbYRIgR9MdWB5F3keLNrhY8HUMswuXjDNxvkaHzMhHb?=
 =?us-ascii?Q?Yin3zwx9V9+XlxeRMEC9mB3fPsmq9w2pUzGtdPM7/ebGl5X53Tt3sunMG5fj?=
 =?us-ascii?Q?4V/gcrI/GNuVbYoS/mQwtyu2KlYawa9BhTogs2BjIpj4qIWmsMAOl43fKX/+?=
 =?us-ascii?Q?4cOjgGlhcywkiv14UZoETkk8WVJ/VSqTU4ypCsjvr10rsmySR/AC5Yt20DxE?=
 =?us-ascii?Q?fO8nxoEY8NT057yaCTZU3BrUx6mh4tbhWhx8M4S/QuHE3hEWgQOK9njPGWtf?=
 =?us-ascii?Q?u2DCEGRfthYmfX2VsfmTC/jk7axIg5Dn8kLvcc2Bp1Veoxvvj/iKA4YyqOQ2?=
 =?us-ascii?Q?SzPH2UHCSaH4unsTbRfCQjzaPnYz/QIjBOPZDuvOsFb01yvGKsxe008FCPio?=
 =?us-ascii?Q?IspjMTfS2yJSaOvn8B5aSzO2LeEvwMf07bl3gMtKzs9NFJZK7bOt5m71WU6U?=
 =?us-ascii?Q?XMFvPtiOTsCm33YIcaY/NodJ3c7mL+YeJ9kH0Rldub7TBLBeToQO3tn40all?=
 =?us-ascii?Q?xQmIxRlbeVe+/nb/IG8duZU4NJY630NDJXEGPryLkglqzoFjs2RuHI7RlNgV?=
 =?us-ascii?Q?lEFNFryJBmwlGCtY4qZSNDQbkVfpzUdrVYU8L1xS/UFec16jnOtSreoJTDRx?=
 =?us-ascii?Q?kfFdBWTkNAIUTJ/oybOeQZUlQNLPiSdRrXQkMxMPkEbcamLsVaKPVQcblD0E?=
 =?us-ascii?Q?Ec3mDjIN+yf+QF1eeiN+7aff0hbItOG/RoktqAX/7sE8JwAD/uDpa6rp4zkj?=
 =?us-ascii?Q?6GcM+fh8MHuZdOvqSJ3OIGuFBwg9EEmCgRKPGf1dxPfRhUp4i0Xv0GL5Er/w?=
 =?us-ascii?Q?8es2LEV/b+IqzejlavniJbq46SL0K46k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:22:19.2059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1b6e08-4fef-49c7-4a11-08dcd27de87a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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

From: Ryan Seto <ryanseto@amd.com>

[WHY]
There are some monitor timings that seem to be supported without
DSC but actually require DSC to be displayed. A VESA SCR introduced
a new max uncompressed pixel rate cap register that we can use to
handle these edge cases.

[HOW]
SST: Read caps from link and invalidate timings that exceed the
max limit but do not support DSC. Then check for options override
when determining BPP.

MST: Read caps from virtual DPCD peer device or daisy chained SST
monitor and set validation set BPPs to max if pixel rate exceeds
uncompressed limit. Validation set optimization continues as normal.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h         | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dsc.h              |  1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c          | 10 +++++-----
 .../gpu/drm/amd/display/dc/link/link_validation.c    |  7 +++++++
 .../display/dc/link/protocols/link_dp_capability.c   |  5 +++++
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 519c3df78ee5..41bd95e9177a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -969,6 +969,14 @@ union dp_sink_video_fallback_formats {
 	uint8_t raw;
 };
 
+union dpcd_max_uncompressed_pixel_rate_cap {
+	struct {
+		uint16_t max_uncompressed_pixel_rate_cap	:15;
+		uint16_t valid			:1;
+	} bits;
+	uint8_t raw[2];
+};
+
 union dp_fec_capability1 {
 	struct {
 		uint8_t AGGREGATED_ERROR_COUNTERS_CAPABLE	:1;
@@ -1170,6 +1178,7 @@ struct dpcd_caps {
 	struct dc_lttpr_caps lttpr_caps;
 	struct adaptive_sync_caps adaptive_sync_caps;
 	struct dpcd_usb4_dp_tunneling_info usb4_dp_tun_info;
+	union dpcd_max_uncompressed_pixel_rate_cap max_uncompressed_pixel_rate_cap;
 
 	union dp_128b_132b_supported_link_rates dp_128b_132b_supported_link_rates;
 	union dp_main_line_channel_coding_cap channel_coding_cap;
@@ -1340,6 +1349,9 @@ struct dp_trace {
 #ifndef DP_CABLE_ATTRIBUTES_UPDATED_BY_DPTX
 #define DP_CABLE_ATTRIBUTES_UPDATED_BY_DPTX		0x110
 #endif
+#ifndef DPCD_MAX_UNCOMPRESSED_PIXEL_RATE_CAP
+#define DPCD_MAX_UNCOMPRESSED_PIXEL_RATE_CAP    0x221c
+#endif
 #ifndef DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE
 #define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE	0x50
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index fe3078b8789e..2a5120ecf48b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -59,6 +59,7 @@ struct dc_dsc_config_options {
 	uint32_t max_target_bpp_limit_override_x16;
 	uint32_t slice_height_granularity;
 	uint32_t dsc_force_odm_hslice_override;
+	bool force_dsc_when_not_needed;
 };
 
 bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index a1727e5bf024..79c426425911 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -668,6 +668,7 @@ static bool decide_dsc_bandwidth_range(
  */
 static bool decide_dsc_target_bpp_x16(
 		const struct dc_dsc_policy *policy,
+		const struct dc_dsc_config_options *options,
 		const struct dsc_enc_caps *dsc_common_caps,
 		const int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
@@ -682,7 +683,7 @@ static bool decide_dsc_target_bpp_x16(
 	if (decide_dsc_bandwidth_range(policy->min_target_bpp * 16, policy->max_target_bpp * 16,
 			num_slices_h, dsc_common_caps, timing, link_encoding, &range)) {
 		if (target_bandwidth_kbps >= range.stream_kbps) {
-			if (policy->enable_dsc_when_not_needed)
+			if (policy->enable_dsc_when_not_needed || options->force_dsc_when_not_needed)
 				/* enable max bpp even dsc is not needed */
 				*target_bpp_x16 = range.max_target_bpp_x16;
 		} else if (target_bandwidth_kbps >= range.max_kbps) {
@@ -1080,6 +1081,7 @@ static bool setup_dsc_config(
 	if (target_bandwidth_kbps > 0) {
 		is_dsc_possible = decide_dsc_target_bpp_x16(
 				&policy,
+				options,
 				&dsc_common_caps,
 				target_bandwidth_kbps,
 				timing,
@@ -1235,10 +1237,7 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
 		policy->max_target_bpp = max_target_bpp_limit_override_x16 / 16;
 
 	/* enable DSC when not needed, default false */
-	if (dsc_policy_enable_dsc_when_not_needed)
-		policy->enable_dsc_when_not_needed = dsc_policy_enable_dsc_when_not_needed;
-	else
-		policy->enable_dsc_when_not_needed = false;
+	policy->enable_dsc_when_not_needed = dsc_policy_enable_dsc_when_not_needed;
 }
 
 void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit)
@@ -1267,4 +1266,5 @@ void dc_dsc_get_default_config_option(const struct dc *dc, struct dc_dsc_config_
 	options->dsc_force_odm_hslice_override = dc->debug.force_odm_combine;
 	options->max_target_bpp_limit_override_x16 = 0;
 	options->slice_height_granularity = 1;
+	options->force_dsc_when_not_needed = false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index 1aed55b0ab6a..60f15a9ba7a5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -287,6 +287,13 @@ static bool dp_validate_mode_timing(
 	req_bw = dc_bandwidth_in_kbps_from_timing(timing, dc_link_get_highest_encoding_format(link));
 	max_bw = dp_link_bandwidth_kbps(link, link_setting);
 
+	bool is_max_uncompressed_pixel_rate_exceeded = link->dpcd_caps.max_uncompressed_pixel_rate_cap.bits.valid &&
+			timing->pix_clk_100hz > link->dpcd_caps.max_uncompressed_pixel_rate_cap.bits.max_uncompressed_pixel_rate_cap * 10000;
+
+	if (is_max_uncompressed_pixel_rate_exceeded && !timing->flags.DSC) {
+		return false;
+	}
+
 	if (req_bw <= max_bw) {
 		/* remember the biggest mode here, during
 		 * initial link training (to get
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 34a618a7278b..d78c8ec4de79 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1942,6 +1942,11 @@ static bool retrieve_link_cap(struct dc_link *link)
 			DC_LOG_DP2("\tFEC aggregated error counters are supported");
 	}
 
+	core_link_read_dpcd(link,
+			DPCD_MAX_UNCOMPRESSED_PIXEL_RATE_CAP,
+			link->dpcd_caps.max_uncompressed_pixel_rate_cap.raw,
+			sizeof(link->dpcd_caps.max_uncompressed_pixel_rate_cap.raw));
+
 	retrieve_cable_id(link);
 	dpcd_write_cable_id_to_dprx(link);
 
-- 
2.34.1

