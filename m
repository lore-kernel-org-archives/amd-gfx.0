Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E2AE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCF310E721;
	Tue,  7 Jan 2025 15:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XhoA7jy4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059B210E721
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVwI1fEWerLKf9BVVVZi61x3k9zr6IFZFXKtqPZB6uAvn/2JWzUDZKSbZpUjAFgwH28zXnivjGYb7d3axD+hUbWi3N/l3w8f1ajU9CvZF3fuXtg57uRfC46YXmDneutQeEOHomKjhSGbzzLJF7OH8k+YqjEnD8arFy503gh0C6iqHsrzT2c9Ua0ouuDcaPgSHiZnM7wRixm+dLjO+B5de1hvMHvTlXMlnbRRgZiyd5b52eMDL5kVQWaHHUUxucdz1wNRi1pxDaA4mqGMl+FPNGmTeQTK1Tspgmgk7ynDajraQgnS92uGenegzl85MsTkMF0MTxPWjIYY2hlIFdnhOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlhZ3hzdJ4S7bD9mrc9onAgBxXf2yeyF4Ol7ZDZYBk4=;
 b=FJmnOpi+UoU7GeGDw6PgWDJ4Q4or+MqfOKjQDdc7RfqB0YsFfy7XWJWzaaoVuwElD4J+0Ov4cKV+2tY3Xf3OzdCo93o1C2EyrfM+CnTYMKhjyR+UIpVnCJkVs5MzNfaqkvgyd98VujfJzXd0d3iGTAP1i6StGEfB41FsKps7deFLhvbRLBo43MlOfqpsqLDwInqICvhplTPHt68cUnQ5EbE7P4yHrvBLjei5FmC/w3PEJIaqZivmtk5MWUX+kFt7rOaRcN5r1gEMhESDZR6tsdgslJZXYCtYhJnuIFytBp96xkwijDVAX9V/i5L0tWRE6b1wgjhexkIayDZeEm+RFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlhZ3hzdJ4S7bD9mrc9onAgBxXf2yeyF4Ol7ZDZYBk4=;
 b=XhoA7jy4XINKrYiGg2VsWk+P7bfQkGwGP5sJYWd5nYcXJaVbPvBafvoW848/F3XM+3m5a72wWYXfW80akGDJ5u/Z9DYjfjXyKQEk+tdqp/Fl00CNmMPZYmMEZiK4ZchQ2P5ldsztiUUDUSqvS11shU7BghpvEdpHpZ+RPhu4iy4=
Received: from SN7PR04CA0078.namprd04.prod.outlook.com (2603:10b6:806:121::23)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:29:22 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::76) by SN7PR04CA0078.outlook.office365.com
 (2603:10b6:806:121::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 15:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:29:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:21 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:29:18 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Michael
 Strauss" <michael.strauss@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 05/24] drm/amd/display: Update chip_cap defines and usage
Date: Tue, 7 Jan 2025 23:28:36 +0800
Message-ID: <20250107152855.2953302-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: e08b7a55-f69a-412a-3873-08dd2f300fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kGqWz5PDpntsPFpfPZj9eVCz4lM3qOweGLCIJVXbIUazR7zhX8+XpSFAnHkz?=
 =?us-ascii?Q?QtT7LonUg79StekilQK/ksBlYpIfq96gXLIrtKxeBcW1J8UndCvCvdb3PIff?=
 =?us-ascii?Q?1baRTBmVZ8h+O1y0hOl/FrRRbUbxWFwoyhMnztcEyxAlKj8S6GepLXre68aC?=
 =?us-ascii?Q?TBYV5VoItwdkdR9ZddQF0YYNt+WIMZBMromqHHs9ZSSe7Fz3lWYvh4J0NozT?=
 =?us-ascii?Q?4Y9j9ftLhQ1s5E/Qkv1hBEK5gmBrbcxa8IYMofJqWF/YOP2+CaJ4rdSF2c0k?=
 =?us-ascii?Q?77yd/iwaVnd1dSvFaMUPAGj+mWd82Q0eHvPzG7KYwUytJYGWTFP2xmCGAedF?=
 =?us-ascii?Q?CzI0OVKGCdU1y0cq6LmQbAgSkpCHTrw9BdHgrT80xF7iKTbOamLHTOYsfrGQ?=
 =?us-ascii?Q?kYmNwWg/B80wt8ih5NwZYe2C12l8KZ97rxRY/I2V6TZ6I0fZCvVVdGD4GY02?=
 =?us-ascii?Q?gU0JXZF93+uGR36lOjPtEe4soV22lIMUuefVPIhw4/kQYSP9qVZvl3bpdrdD?=
 =?us-ascii?Q?gMpp1JwazUCxu80iaNUTJVO511OYg8YkrQRCdDXtPfkcwS2uuKxBfasmrG+x?=
 =?us-ascii?Q?e7jQDIF8l48nXxiYiJAquPk2Dyw1OroUL8VWs00t2od5cqaQAZJE7MSGJHGA?=
 =?us-ascii?Q?maCMIDeyJp2XpdbYdaHhNZ9PiDRaSNDQRUMYC3Hg8U5sTHkocmkXh8/OhNP9?=
 =?us-ascii?Q?oMo2jLKejpGxwdWJQspwN7wDhG7S1Jip7YG0daGbw23CsJ1LkT/73KaWbYdb?=
 =?us-ascii?Q?43XsGTL6pfR6qp2vCORmTqCNFrsyAA3LfICOoo9cEhX4zca0quugR8JhDybV?=
 =?us-ascii?Q?9nxcOhY7Q3aqP78i27dRpR8W+/G566BNZaEb3wrqipCsiXwasZYJsEv7+tc6?=
 =?us-ascii?Q?1GMQDsWU9GKU3jQ5tfENdPqW40idB0N7ubj1CfQQrtJz7T4W6flQQID/bKHY?=
 =?us-ascii?Q?KzTZtTBuZfQm6gOw1crKbtke8sq9EuUQgGWaoTw4K+WEwOf3DfpaJXC43vCm?=
 =?us-ascii?Q?2+KTg4pwsedNok0o1a5OY/E51/Mlia6jP2Gc0KkSEiJBikPEeniYdEwdGm1n?=
 =?us-ascii?Q?sVHOFgyaKynPh9aUXGMLceeVWf/st2kbGIXJWJBVrgWZyQp9ZfRSDGLjurSA?=
 =?us-ascii?Q?7P1JJ9d7MKBKx7rrWcM+I0veM63f0S3Zr5JBRAdXE8eNBli2wa6nQRrC2uRr?=
 =?us-ascii?Q?TAtBBspmqKRlx03lSMeqh67/JMT5wZcCpYHOKgXgI+Vd4U6Uzp+61NH7XXg6?=
 =?us-ascii?Q?IcYU6zR+LMK/SlThl9mnBaUMkjBnqbBjQseXZppu+LUZFTDsr80sdQPjOzeB?=
 =?us-ascii?Q?HeuQb8/xNtCm76XpFUz2xL5tFuyVNgvozh5OWbIaI+jjCqJVPzrpOEss1bOm?=
 =?us-ascii?Q?1IXrTwtYP6HCsKdqT/ttwveTXeWY+iKrQXx/3a4AodtlwSUpxafMlU+3L5VG?=
 =?us-ascii?Q?AJbm8IYPxZtHEXUM7oPzkdb1WeMnt4+WUP69CRPZN2T6x4so3yptP7vqFyO3?=
 =?us-ascii?Q?KQMGojz7MOznaVI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:29:22.3577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08b7a55-f69a-412a-3873-08dd2f300fac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
The defines have also been updated with prefix AMD_ and atomfirmware.h
has been temporarily updated with both sets of defines to allow the
transition.
This update is being made to standardize workaround chip_cap flags,
in order to support more workaround flags in the future.

[HOW]
Updated EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN define, the flag is now
an enum masked by EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK. All checks for
DP_FIXED_VS_EN are now performed by masking with EXT_CHIP_MASK and
checking for an exact match rather than the previous bitwise AND check.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  9 +++++----
 .../amd/display/dc/link/accessories/link_dp_cts.c  |  4 ++--
 .../link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    | 14 +++++++-------
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |  2 +-
 .../drm/amd/display/dc/link/protocols/link_ddc.c   |  2 +-
 .../display/dc/link/protocols/link_dp_capability.c |  2 +-
 .../amd/display/dc/link/protocols/link_dp_phy.c    |  2 +-
 .../display/dc/link/protocols/link_dp_training.c   |  4 ++--
 9 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index c9a6de110b74..a62f6c51301c 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3088,11 +3088,12 @@ static enum bp_result construct_integrated_info(
 						info->ext_disp_conn_info.path[i].ext_encoder_obj_id.id,
 						info->ext_disp_conn_info.path[i].caps
 						);
-			if (info->ext_disp_conn_info.path[i].caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN)
-				DC_LOG_BIOS("BIOS EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN on path %d\n", i);
+			if ((info->ext_disp_conn_info.path[i].caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN)
+				DC_LOG_BIOS("BIOS AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN on path %d\n", i);
 			else if (bp->base.ctx->dc->config.force_bios_fixed_vs) {
-				info->ext_disp_conn_info.path[i].caps |= EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN;
-				DC_LOG_BIOS("driver forced EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN on path %d\n", i);
+				info->ext_disp_conn_info.path[i].caps &= ~AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK;
+				info->ext_disp_conn_info.path[i].caps |= AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN;
+				DC_LOG_BIOS("driver forced AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN on path %d\n", i);
 			}
 		}
 		// Log the Checksum and Voltage Swing
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index ff8fe1a94965..96febabf464a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -251,7 +251,7 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 
 	link_training_settings.lttpr_mode = dp_decide_lttpr_mode(link, &link->cur_link_settings);
 
-	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+	if (((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 			link_training_settings.lttpr_mode == LTTPR_MODE_TRANSPARENT)
 		dp_fixed_vs_pe_read_lane_adjust(
 				link,
@@ -646,7 +646,7 @@ bool dp_set_test_pattern(
 	if (IS_DP_PHY_PATTERN(test_pattern)) {
 		/* Set DPCD Lane Settings before running test pattern */
 		if (p_link_settings != NULL) {
-			if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+			if (((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 					p_link_settings->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
 				dp_fixed_vs_pe_set_retimer_lane_settings(
 						link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c
index 348ea4cb832d..a6d1d7641ab4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c
@@ -187,7 +187,7 @@ static const struct link_hwss dio_fixed_vs_pe_retimer_link_hwss = {
 
 bool requires_fixed_vs_pe_retimer_dio_link_hwss(const struct dc_link *link)
 {
-	return (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN);
+	return ((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN);
 }
 
 const struct link_hwss *get_dio_fixed_vs_pe_retimer_link_hwss(void)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index ae79dc213901..b8cfeb98e229 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1974,8 +1974,8 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 
 	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		unsigned short masked_chip_caps = pipe_ctx->stream->link->chip_caps &
-				EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK;
-		if (masked_chip_caps == EXT_DISPLAY_PATH_CAPS__HDMI20_TISN65DP159RSBT) {
+				AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK;
+		if (masked_chip_caps == AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_TISN65DP159RSBT) {
 			/* DP159, Retimer settings */
 			eng_id = pipe_ctx->stream_res.stream_enc->id;
 
@@ -1986,7 +1986,7 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 				write_i2c_default_retimer_setting(pipe_ctx,
 						is_vga_mode, is_over_340mhz);
 			}
-		} else if (masked_chip_caps == EXT_DISPLAY_PATH_CAPS__HDMI20_PI3EQX1204) {
+		} else if (masked_chip_caps == AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_PI3EQX1204) {
 			/* PI3EQX1204, Redriver settings */
 			write_i2c_redriver_setting(pipe_ctx, is_over_340mhz);
 		}
@@ -2042,7 +2042,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	int lt_attempts = LINK_TRAINING_ATTEMPTS;
 
 	// Increase retry count if attempting DP1.x on FIXED_VS link
-	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+	if (((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 			link_dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING)
 		lt_attempts = 10;
 
@@ -2394,13 +2394,13 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		enum engine_id eng_id = pipe_ctx->stream_res.stream_enc->id;
 
 		unsigned short masked_chip_caps = link->chip_caps &
-				EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK;
+				AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK;
 		//Need to inform that sink is going to use legacy HDMI mode.
 		write_scdc_data(
 			link->ddc,
 			165000,//vbios only handles 165Mhz.
 			false);
-		if (masked_chip_caps == EXT_DISPLAY_PATH_CAPS__HDMI20_TISN65DP159RSBT) {
+		if (masked_chip_caps == AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_TISN65DP159RSBT) {
 			/* DP159, Retimer settings */
 			if (get_ext_hdmi_settings(pipe_ctx, eng_id, &settings))
 				write_i2c_retimer_setting(pipe_ctx,
@@ -2408,7 +2408,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 			else
 				write_i2c_default_retimer_setting(pipe_ctx,
 						false, false);
-		} else if (masked_chip_caps == EXT_DISPLAY_PATH_CAPS__HDMI20_PI3EQX1204) {
+		} else if (masked_chip_caps == AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_PI3EQX1204) {
 			/* PI3EQX1204, Redriver settings */
 			write_i2c_redriver_setting(pipe_ctx, false);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 334f985186d2..a7877d57a00f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -699,7 +699,7 @@ static bool construct_phy(struct dc_link *link,
 						  link->chip_caps);
 				}
 
-				if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) {
+				if ((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) {
 					link->bios_forced_drive_settings.VOLTAGE_SWING =
 						(bios->integrated_info->ext_disp_conn_info.fixdpvoltageswing & 0x3);
 					link->bios_forced_drive_settings.PRE_EMPHASIS =
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index d6d5bbf2108c..267180e7bc48 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -505,7 +505,7 @@ bool try_to_configure_aux_timeout(struct ddc_service *ddc,
 	bool result = false;
 	struct ddc *ddc_pin = ddc->ddc_pin;
 
-	if ((ddc->link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+	if (((ddc->link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 			!ddc->link->dc->debug.disable_fixed_vs_aux_timeout_wa &&
 			ddc->ctx->dce_version == DCN_VERSION_3_1) {
 		/* Fixed VS workaround for AUX timeout */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index d1d869cc85c7..d0fbf9c44a29 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1554,7 +1554,7 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 
 	/* If this chip cap is set, at least one retimer must exist in the chain
 	 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
-	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+	if (((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 			(dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == 0)) {
 		/* If you see this message consistently, either the host platform has FIXED_VS flag
 		 * incorrectly configured or the sink device is returning an invalid count.
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index bafa52a0165a..2c73ac87cd66 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -104,7 +104,7 @@ void dp_set_hw_lane_settings(
 	// Don't return here if using FIXED_VS link HWSS and encoding is 128b/132b
 	if ((link_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) &&
 			!is_immediate_downstream(link, offset) &&
-			(!(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) ||
+			(!((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) ||
 			link_dp_get_encoding_format(&link_settings->link_settings) == DP_8b_10b_ENCODING))
 		return;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 754c895e1bfb..88d4288cde0f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -739,7 +739,7 @@ void override_training_settings(
 	if (overrides->ffe_preset != NULL)
 		lt_settings->ffe_preset = overrides->ffe_preset;
 	/* Override HW lane settings with BIOS forced values if present */
-	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+	if ((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 			lt_settings->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
 		lt_settings->voltage_swing = &link->bios_forced_drive_settings.VOLTAGE_SWING;
 		lt_settings->pre_emphasis = &link->bios_forced_drive_settings.PRE_EMPHASIS;
@@ -1574,7 +1574,7 @@ enum link_training_result dp_perform_link_training(
 	 * Per DP specs starting from here, DPTX device shall not issue
 	 * Non-LT AUX transactions inside training mode.
 	 */
-	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) && encoding == DP_8b_10b_ENCODING)
+	if (((link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) == AMD_EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) && encoding == DP_8b_10b_ENCODING)
 		status = dp_perform_fixed_vs_pe_training_sequence(link, link_res, &lt_settings);
 	else if (encoding == DP_8b_10b_ENCODING)
 		status = dp_perform_8b_10b_link_training(link, link_res, &lt_settings);
-- 
2.34.1

