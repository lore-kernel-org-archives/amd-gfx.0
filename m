Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC466C47DB3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBE510F9EC;
	Wed, 31 Jan 2024 20:12:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7C910F9EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNztO2U9mYVsVce7v01kdlvjIC30ZBt0gGd0O2R1EkISZgIRFJZpywozq6fomesklsd1w89QeSvexGeZ+8lW8nF+20yrFfsAV0EJFDS1cNLEulez2r52qtmi40pbskKjf3l1MJTi/rL2DeYyTaKwnXMHoRCNTIT7bu72S9PByv8H3BIcqTrNo1oAfEKl2SkroVT+A2D0XXp8dZZVC154eM6mhHkiqhQ8Z0JMcdfsE5SeWtOlVTyCd+vjNNt9oxRdVIWlzjnDAcenISUCSQOxj0JrsYGCE90TgQIaH4xZfm+Q/8Fmrrr3oTbKBe3ToMzIRhFIeCkxuHgODpa9gVyGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scCw7GXn+GjnmzRp5lZ85gn3n1KLN5f/khFPIQOYu00=;
 b=W8gVz/8AoZFgZ9i2sviSxu7Ix5kXCeZ1OIRQcaqTxBmID6juwydKciNr1ULHHrwnAgIbPhhBcSks/v64rbBcgZ/qPACEM0SphJxAnaVgla4WZX4hQfRnsOCW/HZAe9QyzpEGnpi5gfVyMK4pIRZoH057kZu4MaNLjZso9KUM4Pm99jD2WYSJotYrVjyAhyxwhr9VH85HoBLJa/aBkX6O3BJdm/MRx4aPhTtbzvW46QUxbjmCx6OxWgiUIo5fQhuxrghVkxVnUv1GS/yvSdXjHKRohx3zlAN3ptw0Bu6o1Wohg0771R7TStW3E4dqLwDxupbYIvEE1KlDi5gbUdk6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scCw7GXn+GjnmzRp5lZ85gn3n1KLN5f/khFPIQOYu00=;
 b=KZ7S/r0yalFRg3OmsVk2FvSCDpL8EMGP4z6Nd3l0O0OxVWHC7Qjr/at98CrSouutB9zXzqulVHy4uz4y6L0aUjY624VRtErvwneVvbxQQKTnT69akknnddPy+DHGrnuC+nGnFtQgZ3RaW6uQBdBzGu9j7KABMc/1p4bP4Ykdn6Q=
Received: from SA0PR11CA0097.namprd11.prod.outlook.com (2603:10b6:806:d1::12)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:12:40 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::e1) by SA0PR11CA0097.outlook.office365.com
 (2603:10b6:806:d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 20:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:12:39 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:12:37 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/21] drm/amd/display: Remove Legacy FIXED_VS Transparent LT
 Sequence
Date: Wed, 31 Jan 2024 15:11:07 -0500
Message-ID: <20240131201220.19106-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DM6PR12MB5520:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0fcab1-0f8d-4bd6-7b6c-08dc2298f9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8llibgVZhs531AZ74SdYbeIN+m3rmljv9z6Ygysot0raxbPq6AivHg45ciwPQJQ5qgvTSFpktJ+WzME4lYad6eybKV0iEcaq1tWdSopKeRoGd2B3Jlj/05W4LoAdyBB3NlZJ0xg2dWgGG9TZHgg2F8PpQbVQxZsEKUPEdNDcOZvZwnlONKhjWdx8RmXL4DCZW+vt7hUDSx/HYJLjFl0WesxueC4KK2is3ZoMKR8caOId37Kl1Vpe04eCJyjlwA1An3X0txG//hevWbf3YqcH/01mDe9FxWwY0XV6LqGUdduom8+KYFwA3G5fBdFk8Mo/d4LHKJTOHdzH1DKhalrXBYceGLTd23X+H3C0IsgYxYPI3Et/Qku667jv1rz/vKrOO9e6rHCwR2dRKNyUzqhoz5wex4sS8QydMlyJ/FHHH/JL3Jj90u5k1wP3+6wSX9AphD/MF7eC9t+D26+4ZYo1E3aBEEPcTQsuJsccEy+dS/10FjofrWBWxbJLDJjhPUsEEUviOw+T/UoFDc7aDwyEpCoLIQC8Z1rFPJvO5xIXDmsIVS2CfKuxEK1wWJSRS+gs/65stNEPm3FmlBOXttnqjyBBh6v6mSAe41ufl+PcrjDIGRie2rOZI9xxE4/87AkchQVNnu2Yv3yau5rdh0zQQhZ/dM7cwUJoaXtK09Pc2telv91S7o/Jrq5o/Et7njNBPWDZ9Wi6jAJ1g7TtSw1fTPYgRpTG+FKT5WLV9+nsVl+lAzNWVhALOdmBHY2bfzzw+nBDJ17atN8jmHYsCzx3DbDum2dFhIAPPTZmeTzzGk0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(26005)(1076003)(16526019)(2616005)(336012)(426003)(40480700001)(40460700003)(36860700001)(47076005)(36756003)(478600001)(83380400001)(6666004)(82740400003)(81166007)(356005)(316002)(70206006)(86362001)(54906003)(30864003)(5660300002)(2906002)(70586007)(6916009)(8936002)(44832011)(4326008)(8676002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:12:39.8059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0fcab1-0f8d-4bd6-7b6c-08dc2298f9aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

The New sequence has been in use in DCN314 with no regressions
introduced. Therefore, it is safe to enable this sequence for all
devices using FIXED_VS retimers. So, remove the legacy codepath and its
associated config flag.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 -
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../link_dp_training_fixed_vs_pe_retimer.c    | 350 ------------------
 .../link_dp_training_fixed_vs_pe_retimer.h    |   5 -
 .../dc/resource/dcn31/dcn31_resource.c        |   2 -
 5 files changed, 1 insertion(+), 362 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5d95b1e9dafb..74c871917eaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -429,7 +429,6 @@ struct dc_config {
 	bool force_bios_enable_lttpr;
 	uint8_t force_bios_fixed_vs;
 	int sdpif_request_limit_words_per_umc;
-	bool use_old_fixed_vs_sequence;
 	bool dc_mode_clk_limit_support;
 	bool EnableMinDispClkODM;
 	bool enable_auto_dpm_test_logs;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 5a0b04518956..e06d3c2d8910 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1505,10 +1505,7 @@ enum link_training_result dp_perform_link_training(
 	 * Non-LT AUX transactions inside training mode.
 	 */
 	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) && encoding == DP_8b_10b_ENCODING)
-		if (link->dc->config.use_old_fixed_vs_sequence)
-			status = dp_perform_fixed_vs_pe_training_sequence_legacy(link, link_res, &lt_settings);
-		else
-			status = dp_perform_fixed_vs_pe_training_sequence(link, link_res, &lt_settings);
+		status = dp_perform_fixed_vs_pe_training_sequence(link, link_res, &lt_settings);
 	else if (encoding == DP_8b_10b_ENCODING)
 		status = dp_perform_8b_10b_link_training(link, link_res, &lt_settings);
 	else if (encoding == DP_128b_132b_ENCODING)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index 7087cdc9e977..c36e0e5df447 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -186,356 +186,6 @@ static enum link_training_result perform_fixed_vs_pe_nontransparent_training_seq
 	return status;
 }
 
-
-enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	struct link_training_settings *lt_settings)
-{
-	const uint8_t vendor_lttpr_write_data_reset[4] = {0x1, 0x50, 0x63, 0xFF};
-	const uint8_t offset = dp_parse_lttpr_repeater_count(
-			link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
-	const uint8_t vendor_lttpr_write_data_intercept_en[4] = {0x1, 0x55, 0x63, 0x0};
-	const uint8_t vendor_lttpr_write_data_intercept_dis[4] = {0x1, 0x55, 0x63, 0x68};
-	uint32_t pre_disable_intercept_delay_ms = 0;
-	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
-	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
-	const uint8_t vendor_lttpr_write_data_4lane_1[4] = {0x1, 0x6E, 0xF2, 0x19};
-	const uint8_t vendor_lttpr_write_data_4lane_2[4] = {0x1, 0x6B, 0xF2, 0x01};
-	const uint8_t vendor_lttpr_write_data_4lane_3[4] = {0x1, 0x6D, 0xF2, 0x18};
-	const uint8_t vendor_lttpr_write_data_4lane_4[4] = {0x1, 0x6C, 0xF2, 0x03};
-	const uint8_t vendor_lttpr_write_data_4lane_5[4] = {0x1, 0x03, 0xF3, 0x06};
-	const uint8_t vendor_lttpr_write_data_dpmf[4] = {0x1, 0x6, 0x70, 0x87};
-	enum link_training_result status = LINK_TRAINING_SUCCESS;
-	uint8_t lane = 0;
-	union down_spread_ctrl downspread = {0};
-	union lane_count_set lane_count_set = {0};
-	uint8_t toggle_rate;
-	uint8_t rate;
-
-	/* Only 8b/10b is supported */
-	ASSERT(link_dp_get_encoding_format(&lt_settings->link_settings) ==
-			DP_8b_10b_ENCODING);
-
-	if (lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) {
-		status = perform_fixed_vs_pe_nontransparent_training_sequence(link, link_res, lt_settings);
-		return status;
-	}
-
-	if (offset != 0xFF) {
-		if (offset == 2) {
-			pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa;
-
-		/* Certain display and cable configuration require extra delay */
-		} else if (offset > 2) {
-			pre_disable_intercept_delay_ms = link->dc->debug.fixed_vs_aux_delay_config_wa * 2;
-		}
-	}
-
-	/* Vendor specific: Reset lane settings */
-	link_configure_fixed_vs_pe_retimer(link->ddc,
-			&vendor_lttpr_write_data_reset[0], sizeof(vendor_lttpr_write_data_reset));
-	link_configure_fixed_vs_pe_retimer(link->ddc,
-			&vendor_lttpr_write_data_vs[0], sizeof(vendor_lttpr_write_data_vs));
-	link_configure_fixed_vs_pe_retimer(link->ddc,
-			&vendor_lttpr_write_data_pe[0], sizeof(vendor_lttpr_write_data_pe));
-
-	/* Vendor specific: Enable intercept */
-	link_configure_fixed_vs_pe_retimer(link->ddc,
-			&vendor_lttpr_write_data_intercept_en[0], sizeof(vendor_lttpr_write_data_intercept_en));
-
-
-	/* 1. set link rate, lane count and spread. */
-
-	downspread.raw = (uint8_t)(lt_settings->link_settings.link_spread);
-
-	lane_count_set.bits.LANE_COUNT_SET =
-	lt_settings->link_settings.lane_count;
-
-	lane_count_set.bits.ENHANCED_FRAMING = lt_settings->enhanced_framing;
-	lane_count_set.bits.POST_LT_ADJ_REQ_GRANTED = 0;
-
-
-	if (lt_settings->pattern_for_eq < DP_TRAINING_PATTERN_SEQUENCE_4) {
-		lane_count_set.bits.POST_LT_ADJ_REQ_GRANTED =
-				link->dpcd_caps.max_ln_count.bits.POST_LT_ADJ_REQ_SUPPORTED;
-	}
-
-	core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
-		&downspread.raw, sizeof(downspread));
-
-	core_link_write_dpcd(link, DP_LANE_COUNT_SET,
-		&lane_count_set.raw, 1);
-
-	rate = get_dpcd_link_rate(&lt_settings->link_settings);
-
-	/* Vendor specific: Toggle link rate */
-	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
-
-	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
-		core_link_write_dpcd(
-				link,
-				DP_LINK_BW_SET,
-				&toggle_rate,
-				1);
-	}
-
-	link->vendor_specific_lttpr_link_rate_wa = rate;
-
-	core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
-
-	DC_LOG_HW_LINK_TRAINING("%s\n %x rate = %x\n %x lane = %x framing = %x\n %x spread = %x\n",
-		__func__,
-		DP_LINK_BW_SET,
-		lt_settings->link_settings.link_rate,
-		DP_LANE_COUNT_SET,
-		lt_settings->link_settings.lane_count,
-		lt_settings->enhanced_framing,
-		DP_DOWNSPREAD_CTRL,
-		lt_settings->link_settings.link_spread);
-
-	link_configure_fixed_vs_pe_retimer(link->ddc,
-			&vendor_lttpr_write_data_dpmf[0],
-			sizeof(vendor_lttpr_write_data_dpmf));
-
-	if (lt_settings->link_settings.lane_count == LANE_COUNT_FOUR) {
-		link_configure_fixed_vs_pe_retimer(link->ddc,
-				&vendor_lttpr_write_data_4lane_1[0], sizeof(vendor_lttpr_write_data_4lane_1));
-		link_configure_fixed_vs_pe_retimer(link->ddc,
-				&vendor_lttpr_write_data_4lane_2[0], sizeof(vendor_lttpr_write_data_4lane_2));
-		link_configure_fixed_vs_pe_retimer(link->ddc,
-				&vendor_lttpr_write_data_4lane_3[0], sizeof(vendor_lttpr_write_data_4lane_3));
-		link_configure_fixed_vs_pe_retimer(link->ddc,
-				&vendor_lttpr_write_data_4lane_4[0], sizeof(vendor_lttpr_write_data_4lane_4));
-		link_configure_fixed_vs_pe_retimer(link->ddc,
-				&vendor_lttpr_write_data_4lane_5[0], sizeof(vendor_lttpr_write_data_4lane_5));
-	}
-
-	/* 2. Perform link training */
-
-	/* Perform Clock Recovery Sequence */
-	if (status == LINK_TRAINING_SUCCESS) {
-		const uint8_t max_vendor_dpcd_retries = 10;
-		uint32_t retries_cr;
-		uint32_t retry_count;
-		uint32_t wait_time_microsec;
-		enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
-		union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
-		union lane_align_status_updated dpcd_lane_status_updated;
-		union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
-		uint8_t i = 0;
-
-		retries_cr = 0;
-		retry_count = 0;
-
-		memset(&dpcd_lane_status, '\0', sizeof(dpcd_lane_status));
-		memset(&dpcd_lane_status_updated, '\0',
-		sizeof(dpcd_lane_status_updated));
-
-		while ((retries_cr < LINK_TRAINING_MAX_RETRY_COUNT) &&
-			(retry_count < LINK_TRAINING_MAX_CR_RETRY)) {
-
-
-			/* 1. call HWSS to set lane settings */
-			dp_set_hw_lane_settings(
-					link,
-					link_res,
-					lt_settings,
-					0);
-
-			/* 2. update DPCD of the receiver */
-			if (!retry_count) {
-				/* EPR #361076 - write as a 5-byte burst,
-				 * but only for the 1-st iteration.
-				 */
-				dpcd_set_lt_pattern_and_lane_settings(
-						link,
-						lt_settings,
-						lt_settings->pattern_for_cr,
-						0);
-				/* Vendor specific: Disable intercept */
-				for (i = 0; i < max_vendor_dpcd_retries; i++) {
-					if (pre_disable_intercept_delay_ms != 0)
-						msleep(pre_disable_intercept_delay_ms);
-					if (link_configure_fixed_vs_pe_retimer(link->ddc,
-							&vendor_lttpr_write_data_intercept_dis[0],
-							sizeof(vendor_lttpr_write_data_intercept_dis)))
-						break;
-
-					link_configure_fixed_vs_pe_retimer(link->ddc,
-							&vendor_lttpr_write_data_intercept_en[0],
-							sizeof(vendor_lttpr_write_data_intercept_en));
-				}
-			} else {
-				vendor_lttpr_write_data_vs[3] = 0;
-				vendor_lttpr_write_data_pe[3] = 0;
-
-				for (lane = 0; lane < lane_count; lane++) {
-					vendor_lttpr_write_data_vs[3] |=
-							lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET << (2 * lane);
-					vendor_lttpr_write_data_pe[3] |=
-							lt_settings->dpcd_lane_settings[lane].bits.PRE_EMPHASIS_SET << (2 * lane);
-				}
-
-				/* Vendor specific: Update VS and PE to DPRX requested value */
-				link_configure_fixed_vs_pe_retimer(link->ddc,
-						&vendor_lttpr_write_data_vs[0], sizeof(vendor_lttpr_write_data_vs));
-				link_configure_fixed_vs_pe_retimer(link->ddc,
-						&vendor_lttpr_write_data_pe[0], sizeof(vendor_lttpr_write_data_pe));
-
-				dpcd_set_lane_settings(
-						link,
-						lt_settings,
-						0);
-			}
-
-			/* 3. wait receiver to lock-on*/
-			wait_time_microsec = lt_settings->cr_pattern_time;
-
-			dp_wait_for_training_aux_rd_interval(
-					link,
-					wait_time_microsec);
-
-			/* 4. Read lane status and requested drive
-			 * settings as set by the sink
-			 */
-			dp_get_lane_status_and_lane_adjust(
-					link,
-					lt_settings,
-					dpcd_lane_status,
-					&dpcd_lane_status_updated,
-					dpcd_lane_adjust,
-					0);
-
-			/* 5. check CR done*/
-			if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
-				status = LINK_TRAINING_SUCCESS;
-				break;
-			}
-
-			/* 6. max VS reached*/
-			if (dp_is_max_vs_reached(lt_settings))
-				break;
-
-			/* 7. same lane settings */
-			/* Note: settings are the same for all lanes,
-			 * so comparing first lane is sufficient
-			 */
-			if (lt_settings->dpcd_lane_settings[0].bits.VOLTAGE_SWING_SET ==
-					dpcd_lane_adjust[0].bits.VOLTAGE_SWING_LANE)
-				retries_cr++;
-			else
-				retries_cr = 0;
-
-			/* 8. update VS/PE/PC2 in lt_settings*/
-			dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-					lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
-			retry_count++;
-		}
-
-		if (retry_count >= LINK_TRAINING_MAX_CR_RETRY) {
-			ASSERT(0);
-			DC_LOG_ERROR("%s: Link Training Error, could not get CR after %d tries. Possibly voltage swing issue",
-				__func__,
-				LINK_TRAINING_MAX_CR_RETRY);
-
-		}
-
-		status = dp_get_cr_failure(lane_count, dpcd_lane_status);
-	}
-
-	/* Perform Channel EQ Sequence */
-	if (status == LINK_TRAINING_SUCCESS) {
-		enum dc_dp_training_pattern tr_pattern;
-		uint32_t retries_ch_eq;
-		uint32_t wait_time_microsec;
-		enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
-		union lane_align_status_updated dpcd_lane_status_updated = {0};
-		union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
-		union lane_adjust dpcd_lane_adjust[LANE_COUNT_DP_MAX] = {0};
-
-		/* Note: also check that TPS4 is a supported feature*/
-		tr_pattern = lt_settings->pattern_for_eq;
-
-		dp_set_hw_training_pattern(link, link_res, tr_pattern, 0);
-
-		status = LINK_TRAINING_EQ_FAIL_EQ;
-
-		for (retries_ch_eq = 0; retries_ch_eq <= LINK_TRAINING_MAX_RETRY_COUNT;
-			retries_ch_eq++) {
-
-			dp_set_hw_lane_settings(link, link_res, lt_settings, 0);
-
-			vendor_lttpr_write_data_vs[3] = 0;
-			vendor_lttpr_write_data_pe[3] = 0;
-
-			for (lane = 0; lane < lane_count; lane++) {
-				vendor_lttpr_write_data_vs[3] |=
-						lt_settings->dpcd_lane_settings[lane].bits.VOLTAGE_SWING_SET << (2 * lane);
-				vendor_lttpr_write_data_pe[3] |=
-						lt_settings->dpcd_lane_settings[lane].bits.PRE_EMPHASIS_SET << (2 * lane);
-			}
-
-			/* Vendor specific: Update VS and PE to DPRX requested value */
-			link_configure_fixed_vs_pe_retimer(link->ddc,
-					&vendor_lttpr_write_data_vs[0], sizeof(vendor_lttpr_write_data_vs));
-			link_configure_fixed_vs_pe_retimer(link->ddc,
-					&vendor_lttpr_write_data_pe[0], sizeof(vendor_lttpr_write_data_pe));
-
-			/* 2. update DPCD*/
-			if (!retries_ch_eq)
-				/* EPR #361076 - write as a 5-byte burst,
-				 * but only for the 1-st iteration
-				 */
-
-				dpcd_set_lt_pattern_and_lane_settings(
-					link,
-					lt_settings,
-					tr_pattern, 0);
-			else
-				dpcd_set_lane_settings(link, lt_settings, 0);
-
-			/* 3. wait for receiver to lock-on*/
-			wait_time_microsec = lt_settings->eq_pattern_time;
-
-			dp_wait_for_training_aux_rd_interval(
-					link,
-					wait_time_microsec);
-
-			/* 4. Read lane status and requested
-			 * drive settings as set by the sink
-			 */
-			dp_get_lane_status_and_lane_adjust(
-				link,
-				lt_settings,
-				dpcd_lane_status,
-				&dpcd_lane_status_updated,
-				dpcd_lane_adjust,
-				0);
-
-			/* 5. check CR done*/
-			if (!dp_is_cr_done(lane_count, dpcd_lane_status)) {
-				status = LINK_TRAINING_EQ_FAIL_CR;
-				break;
-			}
-
-			/* 6. check CHEQ done*/
-			if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
-					dp_is_symbol_locked(lane_count, dpcd_lane_status) &&
-					dp_is_interlane_aligned(dpcd_lane_status_updated)) {
-				status = LINK_TRAINING_SUCCESS;
-				break;
-			}
-
-			/* 7. update VS/PE/PC2 in lt_settings*/
-			dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
-					lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
-		}
-	}
-
-	return status;
-}
-
 enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	struct dc_link *link,
 	const struct link_resource *link_res,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.h
index c0d6ea329504..e61970e27661 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.h
@@ -28,11 +28,6 @@
 #define __DC_LINK_DP_FIXED_VS_PE_RETIMER_H__
 #include "link_dp_training.h"
 
-enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	struct link_training_settings *lt_settings);
-
 enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	struct dc_link *link,
 	const struct link_resource *link_res,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 31035fc3d868..04d142f97474 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1941,8 +1941,6 @@ static bool dcn31_resource_construct(
 	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
 	dc->caps.color.mpc.ocsc = 1;
 
-	dc->config.use_old_fixed_vs_sequence = true;
-
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
-- 
2.43.0

