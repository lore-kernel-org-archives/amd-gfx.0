Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9236CC761AF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE6F10ED56;
	Thu, 30 Mar 2023 08:59:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6185710ED56
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiecMMOvybV87daiqm33S7p7kEOZ35tw4ZYhJxymUYGYa/oQKhKS+DWdufQFq6wDC2bM3g3mUCq4li1OBx3MVeNGg/1R4N1cfPdJtvoM1ztVnb7U77ygEs8RQPgmpfaWm5luH1uG9ymMIUY9554NlJkSYlGRgINR2anMeo2RbBwShxcB2OM2HEmal+gycBe1oN5N+ehPy8XMGDNnjXgPkgj6EiGrplTzzDwBdSlpfo3hD02d9u6sqIj8V+l2GuiYdVRMw6uykFu9weJSJdteaF22wHtVoUUH3NI37uWHjzdu2Jq9mhgXKK0JaD5zzVDtz1xjBcRZ1tl1h7f4uPiMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awZaYqGlIaxRUZkb+ktv9Wl74gPkTnLF+I9sxvT9vKM=;
 b=FpUcdfMzGCLzJhFDhHdq8W0KgSgInWLcZ7nu6wwZMM9KWeOMb5w8rEYFldt3KkSv+LK+mQ+60/7V5bE1qO9qlsu8gGnD15UQcJSqW+T01nAaMY1lVsJQIdjG3jmvlnGjuIvysYF8FlB1jbnczc6N3A2zGh9Ips/RglPEsj48iycPewogd/Igy8tpVmK0I/GL7VwTtDwx7GTCPrSzuL6VVcmYDsKxrpxbWt5utGEDAt54ecBsaz1d/kGmLaSExDrf4nb779S1Y2eZ/rwTG8uusmQVkfcb2IQCEXVJ2rQ+4l1ouG6ugMH8JshmBHYQl0d1ZY3M4uKsY34Hhnk1R+b4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awZaYqGlIaxRUZkb+ktv9Wl74gPkTnLF+I9sxvT9vKM=;
 b=yr451edG5IGO1jM3qstm8IKhZ/PMWWNo5pXMxUKZ0aht3+N9nCYqpoVFVYgbBMmNcrbQPWQ3PaGL/QCfWsA0fXlKQtloA6VvO/cX5ZhmykWjge91pdQFmCBhwvkGITcJFH96CkEjG2EzbVYwE6pupXIgIgtqxmTttxFD++DEYO4=
Received: from BN9P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::21)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Thu, 30 Mar 2023 08:59:50 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::1) by BN9P222CA0016.outlook.office365.com
 (2603:10b6:408:10c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 08:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 08:59:50 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:59:45 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/10] drm/amd/display: Improve robustness of FIXED_VS link
 training at DP1 rates
Date: Thu, 30 Mar 2023 04:57:18 -0400
Message-ID: <20230330085720.3863-9-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fe611a-2b3a-4fff-6f24-08db30fd1e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mwnJCXzS5edtHr3o5jabf/a97ztHYItJnrO6VAkh1fsue6nwWwQLzsgUgMMWNrb1eBpZU9TiBqoAtOtQ56wETszwyO+QsNpCtwHn2AdLpSTXVzqTufbgtBq0bKPzTM/imAej4wku4FrAlhxelTOoHyyRydDsHGY+uqeKk491xxhgb/iJ4c++wTvCkPlqe+ym0Wh5DzV6a2HKzI7TyuYpOGyCA7PYEidggUT4bs77nPy0TDDVn/dFyfKri6dgz+bDKfkHdLSz1fG7e8QZUzzl2nkMw+ruwboLITKnaTJ+Bmmz3yynM/RSneIZso1JZnNYimNI9jIVmDNg73c+QQ94FBuxyjpeS/l0FBM27+BHrXYXE0rQuEQzhTSiMlpYEtKpGrDdTK+EWb6iDJuahs5YldxXcM4c0aaQ4Ff5EpIIpZ5qnR28axgMKTggoOUlBug8hHh/3pKDWlalmBRZHDI4TUhFPnzoV+qjNl0pAeex+ztkY+CYRK3FHZehEGomyWy5SETbfsPmD0jwzkcgJ4s3BlfTrPVAH9Hq/JYJx/++Dr8r8+1WqahGfgDWnzGfsd2R4/PxxZModlubEo7rbdMlTp2EVpX6uXGRsat0zegNVfY+bHOiXK0brQzXHk7FJBrnoSABcKUnw8I5sFedpRXhKwGHj7b5GgSDi5W5JC0Auc40D6+q6FrbuLbTW2Owi3r3RCkWq1Qk8d7MOeZq3LVoIpb3/ZhN2QHw1JhmDaOunU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(316002)(47076005)(426003)(336012)(2616005)(82310400005)(81166007)(40460700003)(356005)(36756003)(86362001)(82740400003)(83380400001)(40480700001)(36860700001)(2906002)(478600001)(41300700001)(8936002)(30864003)(70586007)(70206006)(5660300002)(4326008)(8676002)(186003)(26005)(6666004)(1076003)(6916009)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:59:50.1081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fe611a-2b3a-4fff-6f24-08db30fd1e9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
New sequence for transparent mode DP1.x link training was provided by LTTPR
vendor

[HOW]
Implement new FIXED_VS sequence, increase LT retry count to minimize
any potential intermittent lightup failures

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   8 +-
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../link_dp_training_fixed_vs_pe_retimer.c    | 378 +++++++++++++++++-
 .../link_dp_training_fixed_vs_pe_retimer.h    |   5 +
 6 files changed, 396 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f51b9c265b51..190e6a2e1334 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -405,6 +405,7 @@ struct dc_config {
 	bool force_bios_enable_lttpr;
 	uint8_t force_bios_fixed_vs;
 	int sdpif_request_limit_words_per_umc;
+	bool use_old_fixed_vs_sequence;
 	bool disable_subvp_drr;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index eaaa2e01f6d0..ff8cd5076434 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1965,6 +1965,8 @@ static bool dcn31_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
+	dc->config.use_old_fixed_vs_sequence = true;
+
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index f6c5ee2d639b..027ad1f0144d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2035,6 +2035,12 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	uint32_t post_oui_delay = 30; // 30ms
 	/* Reduce link bandwidth between failed link training attempts. */
 	bool do_fallback = false;
+	int lt_attempts = LINK_TRAINING_ATTEMPTS;
+
+	// Increase retry count if attempting DP1.x on FIXED_VS link
+	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
+			link_dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING)
+		lt_attempts = 10;
 
 	// check for seamless boot
 	for (i = 0; i < state->stream_count; i++) {
@@ -2099,7 +2105,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 
 	if (perform_link_training_with_retries(link_settings,
 					       skip_video_pattern,
-					       LINK_TRAINING_ATTEMPTS,
+					       lt_attempts,
 					       pipe_ctx,
 					       pipe_ctx->stream->signal,
 					       do_fallback)) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index f301c9eaf2f9..70fc0ddf2d7e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1496,7 +1496,10 @@ enum link_training_result dp_perform_link_training(
 	 * Non-LT AUX transactions inside training mode.
 	 */
 	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) && encoding == DP_8b_10b_ENCODING)
-		status = dp_perform_fixed_vs_pe_training_sequence(link, link_res, &lt_settings);
+		if (link->dc->config.use_old_fixed_vs_sequence)
+			status = dp_perform_fixed_vs_pe_training_sequence_legacy(link, link_res, &lt_settings);
+		else
+			status = dp_perform_fixed_vs_pe_training_sequence(link, link_res, &lt_settings);
 	else if (encoding == DP_8b_10b_ENCODING)
 		status = dp_perform_8b_10b_link_training(link, link_res, &lt_settings);
 	else if (encoding == DP_128b_132b_ENCODING)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index a4071d2959a0..5731c4b61f9f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -223,7 +223,7 @@ static enum link_training_result perform_fixed_vs_pe_nontransparent_training_seq
 }
 
 
-enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
+enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	struct dc_link *link,
 	const struct link_resource *link_res,
 	struct link_training_settings *lt_settings)
@@ -577,3 +577,379 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 
 	return status;
 }
+
+enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	struct link_training_settings *lt_settings)
+{
+	const uint8_t vendor_lttpr_write_data_reset[4] = {0x1, 0x50, 0x63, 0xFF};
+	const uint8_t offset = dp_parse_lttpr_repeater_count(
+			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+	const uint8_t vendor_lttpr_write_data_intercept_en[4] = {0x1, 0x55, 0x63, 0x0};
+	const uint8_t vendor_lttpr_write_data_intercept_dis[4] = {0x1, 0x55, 0x63, 0x6E};
+	const uint8_t vendor_lttpr_write_data_adicora_eq1[4] = {0x1, 0x55, 0x63, 0x2E};
+	const uint8_t vendor_lttpr_write_data_adicora_eq2[4] = {0x1, 0x55, 0x63, 0x01};
+	const uint8_t vendor_lttpr_write_data_adicora_eq3[4] = {0x1, 0x55, 0x63, 0x68};
+	uint32_t pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa;
+	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
+	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
+
+	uint32_t vendor_lttpr_write_address = 0xF004F;
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
+	uint8_t lane = 0;
+	union down_spread_ctrl downspread = {0};
+	union lane_count_set lane_count_set = {0};
+	uint8_t toggle_rate;
+	uint8_t rate;
+
+	/* Only 8b/10b is supported */
+	ASSERT(link_dp_get_encoding_format(&lt_settings->link_settings) ==
+			DP_8b_10b_ENCODING);
+
+	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
+		status = perform_fixed_vs_pe_nontransparent_training_sequence(link, link_res, lt_settings);
+		return status;
+	}
+
+	if (offset != 0xFF) {
+		vendor_lttpr_write_address +=
+				((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (offset - 1));
+
+		/* Certain display and cable configuration require extra delay */
+		if (offset > 2)
+			pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa * 2;
+	}
+
+	/* Vendor specific: Reset lane settings */
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data_reset[0],
+			sizeof(vendor_lttpr_write_data_reset));
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data_vs[0],
+			sizeof(vendor_lttpr_write_data_vs));
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data_pe[0],
+			sizeof(vendor_lttpr_write_data_pe));
+
+	/* Vendor specific: Enable intercept */
+	core_link_write_dpcd(
+			link,
+			vendor_lttpr_write_address,
+			&vendor_lttpr_write_data_intercept_en[0],
+			sizeof(vendor_lttpr_write_data_intercept_en));
+
+	/* 1. set link rate, lane count and spread. */
+
+	downspread.raw = (uint8_t)(lt_settings->link_settings.link_spread);
+
+	lane_count_set.bits.LANE_COUNT_SET =
+	lt_settings->link_settings.lane_count;
+
+	lane_count_set.bits.ENHANCED_FRAMING = lt_settings->enhanced_framing;
+	lane_count_set.bits.POST_LT_ADJ_REQ_GRANTED = 0;
+
+
+	if (lt_settings->pattern_for_eq < DP_TRAINING_PATTERN_SEQUENCE_4) {
+		lane_count_set.bits.POST_LT_ADJ_REQ_GRANTED =
+				link->dpcd_caps.max_ln_count.bits.POST_LT_ADJ_REQ_SUPPORTED;
+	}
+
+	core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
+		&downspread.raw, sizeof(downspread));
+
+	core_link_write_dpcd(link, DP_LANE_COUNT_SET,
+		&lane_count_set.raw, 1);
+
+	rate = get_dpcd_link_rate(&lt_settings->link_settings);
+
+	/* Vendor specific: Toggle link rate */
+	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
+
+	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+		core_link_write_dpcd(
+				link,
+				DP_LINK_BW_SET,
+				&toggle_rate,
+				1);
+	}
+
+	link->vendor_specific_lttpr_link_rate_wa = rate;
+
+	core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
+
+	DC_LOG_HW_LINK_TRAINING("%s\n %x rate = %x\n %x lane = %x framing = %x\n %x spread = %x\n",
+		__func__,
+		DP_LINK_BW_SET,
+		lt_settings->link_settings.link_rate,
+		DP_LANE_COUNT_SET,
+		lt_settings->link_settings.lane_count,
+		lt_settings->enhanced_framing,
+		DP_DOWNSPREAD_CTRL,
+		lt_settings->link_settings.link_spread);
+
+	/* 2. Perform link training */
+
+	/* Perform Clock Recovery Sequence */
+	if (status == LINK_TRAINING_SUCCESS) {
+		const uint8_t max_vendor_dpcd_retries = 10;
+		uint32_t retries_cr;
+		uint32_t retry_count;
+		uint32_t wait_time_microsec;
+		enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
+		union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
+		union lane_align_status_updated dpcd_lane_status_updated;
+		union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
+		enum dc_status dpcd_status = DC_OK;
+		uint8_t i = 0;
+
+		retries_cr = 0;
+		retry_count = 0;
+
+		memset(&dpcd_lane_status, '\0', sizeof(dpcd_lane_status));
+		memset(&dpcd_lane_status_updated, '\0',
+		sizeof(dpcd_lane_status_updated));
+
+		while ((retries_cr < LINK_TRAINING_MAX_RETRY_COUNT) &&
+			(retry_count < LINK_TRAINING_MAX_CR_RETRY)) {
+
+
+			/* 1. call HWSS to set lane settings */
+			dp_set_hw_lane_settings(
+					link,
+					link_res,
+					lt_settings,
+					0);
+
+			/* 2. update DPCD of the receiver */
+			if (!retry_count) {
+				/* EPR #361076 - write as a 5-byte burst,
+				 * but only for the 1-st iteration.
+				 */
+				dpcd_set_lt_pattern_and_lane_settings(
+						link,
+						lt_settings,
+						lt_settings->pattern_for_cr,
+						0);
+				/* Vendor specific: Disable intercept */
+				for (i = 0; i < max_vendor_dpcd_retries; i++) {
+					msleep(pre_disable_intercept_delay_ms);
+					dpcd_status = core_link_write_dpcd(
+							link,
+							vendor_lttpr_write_address,
+							&vendor_lttpr_write_data_intercept_dis[0],
+							sizeof(vendor_lttpr_write_data_intercept_dis));
+
+					if (dpcd_status == DC_OK)
+						break;
+
+					core_link_write_dpcd(
+							link,
+							vendor_lttpr_write_address,
+							&vendor_lttpr_write_data_intercept_en[0],
+							sizeof(vendor_lttpr_write_data_intercept_en));
+				}
+			} else {
+				vendor_lttpr_write_data_vs[3] = 0;
+				vendor_lttpr_write_data_pe[3] = 0;
+
+				for (lane = 0; lane < lane_count; lane++) {
+					vendor_lttpr_write_data_vs[3] |=
+							lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET << (2 * lane);
+					vendor_lttpr_write_data_pe[3] |=
+							lt_settings->dpcd_lane_settings[lane].bits.PRE_EMPHASIS_SET << (2 * lane);
+				}
+
+				/* Vendor specific: Update VS and PE to DPRX requested value */
+				core_link_write_dpcd(
+						link,
+						vendor_lttpr_write_address,
+						&vendor_lttpr_write_data_vs[0],
+						sizeof(vendor_lttpr_write_data_vs));
+				core_link_write_dpcd(
+						link,
+						vendor_lttpr_write_address,
+						&vendor_lttpr_write_data_pe[0],
+						sizeof(vendor_lttpr_write_data_pe));
+
+				dpcd_set_lane_settings(
+						link,
+						lt_settings,
+						0);
+			}
+
+			/* 3. wait receiver to lock-on*/
+			wait_time_microsec = lt_settings->cr_pattern_time;
+
+			dp_wait_for_training_aux_rd_interval(
+					link,
+					wait_time_microsec);
+
+			/* 4. Read lane status and requested drive
+			 * settings as set by the sink
+			 */
+			dp_get_lane_status_and_lane_adjust(
+					link,
+					lt_settings,
+					dpcd_lane_status,
+					&dpcd_lane_status_updated,
+					dpcd_lane_adjust,
+					0);
+
+			/* 5. check CR done*/
+			if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
+				status = LINK_TRAINING_SUCCESS;
+				break;
+			}
+
+			/* 6. max VS reached*/
+			if (dp_is_max_vs_reached(lt_settings))
+				break;
+
+			/* 7. same lane settings */
+			/* Note: settings are the same for all lanes,
+			 * so comparing first lane is sufficient
+			 */
+			if (lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET ==
+					dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
+				retries_cr++;
+			else
+				retries_cr = 0;
+
+			/* 8. update VS/PE/PC2 in lt_settings*/
+			dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+					lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
+			retry_count++;
+		}
+
+		if (retry_count >= LINK_TRAINING_MAX_CR_RETRY) {
+			ASSERT(0);
+			DC_LOG_ERROR("%s: Link Training Error, could not get CR after %d tries. Possibly voltage swing issue",
+				__func__,
+				LINK_TRAINING_MAX_CR_RETRY);
+
+		}
+
+		status = dp_get_cr_failure(lane_count, dpcd_lane_status);
+	}
+
+	/* Perform Channel EQ Sequence */
+	if (status == LINK_TRAINING_SUCCESS) {
+		enum dc_dp_training_pattern tr_pattern;
+		uint32_t retries_ch_eq;
+		uint32_t wait_time_microsec;
+		enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
+		union lane_align_status_updated dpcd_lane_status_updated = {0};
+		union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
+		union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
+
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_adicora_eq1[0],
+				sizeof(vendor_lttpr_write_data_adicora_eq1));
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_adicora_eq2[0],
+				sizeof(vendor_lttpr_write_data_adicora_eq2));
+
+		/* Note: also check that TPS4 is a supported feature*/
+		tr_pattern = lt_settings->pattern_for_eq;
+
+		dp_set_hw_training_pattern(link, link_res, tr_pattern, 0);
+
+		status = LINK_TRAINING_EQ_FAIL_EQ;
+
+		for (retries_ch_eq = 0; retries_ch_eq <= LINK_TRAINING_MAX_RETRY_COUNT;
+			retries_ch_eq++) {
+
+			dp_set_hw_lane_settings(link, link_res, lt_settings, 0);
+
+			vendor_lttpr_write_data_vs[3] = 0;
+			vendor_lttpr_write_data_pe[3] = 0;
+
+			for (lane = 0; lane < lane_count; lane++) {
+				vendor_lttpr_write_data_vs[3] |=
+						lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET << (2 * lane);
+				vendor_lttpr_write_data_pe[3] |=
+						lt_settings->dpcd_lane_settings[lane].bits.PRE_EMPHASIS_SET << (2 * lane);
+			}
+
+			/* Vendor specific: Update VS and PE to DPRX requested value */
+			core_link_write_dpcd(
+					link,
+					vendor_lttpr_write_address,
+					&vendor_lttpr_write_data_vs[0],
+					sizeof(vendor_lttpr_write_data_vs));
+			core_link_write_dpcd(
+					link,
+					vendor_lttpr_write_address,
+					&vendor_lttpr_write_data_pe[0],
+					sizeof(vendor_lttpr_write_data_pe));
+
+			/* 2. update DPCD*/
+			if (!retries_ch_eq) {
+				/* EPR #361076 - write as a 5-byte burst,
+				 * but only for the 1-st iteration
+				 */
+
+				dpcd_set_lt_pattern_and_lane_settings(
+					link,
+					lt_settings,
+					tr_pattern, 0);
+
+				core_link_write_dpcd(
+					link,
+					vendor_lttpr_write_address,
+					&vendor_lttpr_write_data_adicora_eq3[0],
+					sizeof(vendor_lttpr_write_data_adicora_eq3));
+			} else
+				dpcd_set_lane_settings(link, lt_settings, 0);
+
+			/* 3. wait for receiver to lock-on*/
+			wait_time_microsec = lt_settings->eq_pattern_time;
+
+			dp_wait_for_training_aux_rd_interval(
+					link,
+					wait_time_microsec);
+
+			/* 4. Read lane status and requested
+			 * drive settings as set by the sink
+			 */
+			dp_get_lane_status_and_lane_adjust(
+				link,
+				lt_settings,
+				dpcd_lane_status,
+				&dpcd_lane_status_updated,
+				dpcd_lane_adjust,
+				0);
+
+			/* 5. check CR done*/
+			if (!dp_is_cr_done(lane_count, dpcd_lane_status)) {
+				status = LINK_TRAINING_EQ_FAIL_CR;
+				break;
+			}
+
+			/* 6. check CHEQ done*/
+			if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
+					dp_is_symbol_locked(lane_count, dpcd_lane_status) &&
+					dp_is_interlane_aligned(dpcd_lane_status_updated)) {
+				status = LINK_TRAINING_SUCCESS;
+				break;
+			}
+
+			/* 7. update VS/PE/PC2 in lt_settings*/
+			dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
+					lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
+		}
+	}
+
+	return status;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.h
index e61970e27661..c0d6ea329504 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.h
@@ -28,6 +28,11 @@
 #define __DC_LINK_DP_FIXED_VS_PE_RETIMER_H__
 #include "link_dp_training.h"
 
+enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	struct link_training_settings *lt_settings);
+
 enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	struct dc_link *link,
 	const struct link_resource *link_res,
-- 
2.34.1

